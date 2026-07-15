#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;

    my $total = 0;
    my %freq;

    while (1) {
        for my $shift (@input) {
            return $total if $freq{$total}++;
            $total += $shift;
        }
    }
}

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
my @input = grep { length } split /\n/, do { local $/; <$fh> };
close($fh);

my $output = calc(@input);
print "$output\n";
