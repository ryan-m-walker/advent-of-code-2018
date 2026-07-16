use strict;
use warnings;

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";

my @shifts;
while (my $line = <$fh>) {
    next unless $line =~ /\S/;
    push @shifts, $line + 0;
}

close($fh);

my $total = 0;
my %seen = ($total => 1);
my $found;

# The list may need to be cycled through more than once before a
# frequency repeats, so keep looping until we find a duplicate.
while (!defined $found) {
    for my $shift (@shifts) {
        $total += $shift;
        if ($seen{$total}) {
            $found = $total;
            last;
        }
        $seen{$total} = 1;
    }
}

print "$found\n";
