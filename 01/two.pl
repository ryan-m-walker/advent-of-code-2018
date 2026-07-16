use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    my %freq;

    while (1) {
        for my $shift (@input) {
            # if we have already seen this total, it is the first
            # frequency reached twice, so return it
            return $total if exists $freq{$total};

            $freq{$total} = 1;
            $total += $shift;
        }
    }
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
my @input = <$file>;
close($file);

my $output = calc(@input);
print "FOUND: $output\n";
