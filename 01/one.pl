#!/usr/bin/perl
use strict;
use warnings;

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
my @shifts = <$fh>;
close($fh);

my $total = 0;

for my $shift (@shifts) {
    $total += $shift;
}

print "$total\n";
