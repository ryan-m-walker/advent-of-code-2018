use strict;
use warnings;

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";

my $total = 0;
while (my $line = <$fh>) {
    next unless $line =~ /\S/;
    $total += $line;
}

close($fh);

print "$total\n";
