use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    my %freq;

    # keep cycling through the input until we hit a total we've seen before
    while (1) {
        for my $item (@input) {
            # if we've already seen this total, it's the first
            # frequency reached twice, so return it
            return $total if $freq{$total};

            # otherwise record that we've seen this total
            $freq{$total} = 1;

            # add the current shift to the running total
            $total += $item;
        }
    }
}

open my $file, '<', 'input.txt' or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to calc function
my @input = grep { /\S/ } split /\n/, do { local $/; <$file> };
close $file;

print calc(@input), "\n";
