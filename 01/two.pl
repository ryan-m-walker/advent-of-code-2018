use strict;
use warnings;

sub calc {
    my ($input_data) = @_;

    my $total = 0;
    # keys are every total we have seen so far
    my %freq;

    # the first repeated total may not show up on the first pass through the
    # input, so keep cycling over it until we find one
    while (1) {
        for my $shift (@$input_data) {
            # if we have already seen this total then it is the answer
            return $total if exists $freq{$total};

            $freq{$total} = 1;
            $total += $shift;
        }
    }
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input and split by lines to use as the argument to the calc function
my @input_data = split(/\n/, do { local $/; <$file> });
close($file);

print 'FOUND: ', calc(\@input_data), "\n";
