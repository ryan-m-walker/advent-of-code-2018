use strict;
use warnings;

sub calc {
    my ($input_data) = @_;
    my $total = 0;
    for my $shift (@$input_data) {
        $total += $shift;
    }
    return $total;
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to calc function
my @input_data = split /\n/, do { local $/; <$file> };
close($file);

my $output = calc(\@input_data);
print "$output\n";
