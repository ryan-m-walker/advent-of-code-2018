#!/usr/bin/perl
use strict;
use warnings;

# Day 1, Part 2: apply the frequency changes repeatedly (looping over the
# list as many times as needed) and report the first frequency that is
# reached twice.

# Open the puzzle input and read every line into an array.
open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
my @shifts = <$fh>;
close($fh);

# Running frequency total, starting at 0.
my $total = 0;

# Hash used as a set: the keys are every frequency we've already seen.
# The starting frequency of 0 counts as "seen" before any change is applied.
my %seen = (0 => 1);

# Keep cycling through the list of changes until we find a repeat. The answer
# is guaranteed to appear eventually, so this loop always terminates.
while (1) {
    for my $shift (@shifts) {
        $total += $shift;

        # If this frequency was already recorded, it's the first repeat, so
        # print it and exit immediately.
        if ($seen{$total}) {
            print "$total\n";
            exit;
        }

        # Otherwise remember this frequency and move on.
        $seen{$total} = 1;
    }
}
