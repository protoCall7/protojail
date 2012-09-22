#
# protojail v1.0
# (c) 2012 Peter H. Ezetta
# protoCall7@gmail.com
# www.github.com/protoCall7
#
package Protojail::Application;
use 5.010;
use warnings;
use strict;
use Protojail::Command::Create;
use base qw( CLI::Framework );

sub command_map {
    'create' => 'Protojail::Command::Create';
}
1;
