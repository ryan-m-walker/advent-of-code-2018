#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;

    my $total = 0;
    my %freq;

    # keep looping over the input until we hit a frequency we've
    # already seen before, then return that frequency
    while (1) {
        for my $shift (@input) {
            # if we've already seen this total, it's the first
            # frequency reached twice, so return it
            return $total if $freq{$total}++;
            $total += $shift;
        }
    }
}

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to calc
my @input = grep { length } split /\n/, do { local $/; <$fh> };
close($fh);

my $output = calc(@input);
print "$output\n";
