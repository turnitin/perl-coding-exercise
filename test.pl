use strict;
use warnings;

use Data::Dumper;

print "Hello World!\n";

my %test_hash = (
    foo => 'bar',
    baz => 'blah',
);

print Dumper( \%test_hash );

exit;
