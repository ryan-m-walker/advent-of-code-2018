use strict;
use warnings;

sub calc {
    my @input_data = @_;

    my $total = 0;
    my %freq;

    # keep looping over the input until a total is seen twice
    while (1) {
        for my $item (@input_data) {
            # if we've already seen this total, it's our answer
            return $total if exists $freq{$total};

            # otherwise record that we've now seen it
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

my $output = calc(@input_data);
print "FOUND: $output\n";
