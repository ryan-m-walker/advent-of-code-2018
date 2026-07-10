use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    # add up every frequency shift to get the resulting frequency
    $total += $_ for @input;
    return $total;
}

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input and split it into a list of shifts by line
my @input = split(/\n/, do { local $/; <$fh> });
close($fh);

print calc(@input), "\n";
