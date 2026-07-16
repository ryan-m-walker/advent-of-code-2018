use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    for my $shift (@input) {
        $total += $shift;
    }
    return $total;
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
my @input = <$file>;
close($file);

my $output = calc(@input);
print "$output\n";
