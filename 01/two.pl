use strict;
use warnings;

sub calc {
    my ($input_data) = @_;

    my $total = 0;
    my %freq;

    while (1) {
        for my $shift (@$input_data) {
            return $total if exists $freq{$total};

            $freq{$total} = 1;
            $total += $shift;
        }
    }
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
my @input_data = split(/\n/, do { local $/; <$file> });
close($file);

print 'FOUND: ', calc(\@input_data), "\n";
