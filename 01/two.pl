#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    my %freq;

    # keep cycling through the input until we hit a total we've seen before
    while (1) {
        for my $item (@input) {
            # the first total we reach for a second time is our answer
            return $total if $freq{$total}++;
            $total += $item;
        }
    }
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
chomp(my @input = <$file>);
close($file);

my $output = calc(@input);
print "FOUND: $output\n";
