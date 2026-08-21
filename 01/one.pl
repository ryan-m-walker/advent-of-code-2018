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
my @input_data = split(/\n/, do { local $/; <$file> });
close($file);

print calc(\@input_data), "\n";
