use strict;
use warnings;

sub calc {
    my ($input_data) = @_;
    my $total = 0;
    my %freq;

    # keep looping over the input, accumulating the running total, until we
    # reach a total we have seen before
    while (1) {
        for my $item (@$input_data) {
            # if we have already seen this total, it is our answer
            return $total if exists $freq{$total};

            # otherwise record that we have now seen this total
            $freq{$total} = 1;

            # add the current shift to the running total
            $total += $item;
        }
    }
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to calc function
my @input_data = split /\n/, do { local $/; <$file> };
close($file);

my $output = calc(\@input_data);
print "FOUND: $output\n";
