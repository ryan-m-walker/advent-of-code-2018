use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    # track every frequency we have seen so we can spot the first repeat
    my %seen = ($total => 1);

    # keep cycling through the list until a frequency repeats
    while (1) {
        for my $shift (@input) {
            $total += $shift;
            # the first frequency reached twice is our answer
            return $total if $seen{$total}++;
        }
    }
}

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input and split it into a list of shifts by line
my @input = split(/\n/, do { local $/; <$fh> });
close($fh);

print calc(@input), "\n";
