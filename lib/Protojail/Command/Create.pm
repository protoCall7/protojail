#!/usr/local/bin/perl

package Protojail::Command::Create;

use 5.010;
use warnings;
use strict;
use autodie;
use File::Path qw( make_path );
use Data::Dumper;
use base qw( CLI::Framework::Command );

sub make_world {
    my $dir = shift;
    say "Building World";
    chdir "/usr/src";
    system("make world DESTDIR=$dir");
    system("make distribution DESTDIR=$dir");
    system("mount -t devfs devfs $dir/dev");
}

sub create_dir {
    my $dir = shift;
    say "Creating director: $dir";
    die "$dir exists.  Use --force if you want to continue" if -e $dir;

    make_path( $dir );
}

sub option_spec { (
    [ 'path|p=s'  => 'Path to new jail' ],
    [ 'verbose|v' => 'Be Verbose' ],
    [ 'build|b'   => 'Perform FreeBSD build world' ],
    [ 'force'     => 'Force protojail to continue' ],
) }

sub validate {
    my ( $self, $opts, @args ) = @_;
    die "Path Required\n" unless $opts->{path};
}

sub run {
    my ( $self, $opts, $args ) = @_;
    my $dir = $opts->{path};
    create_dir( $dir );
    make_world( $dir ) if $opts->{build};
}

1;

