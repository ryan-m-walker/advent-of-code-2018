#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    $total += $_ for @input;
    return $total;
}

open(my $fh, '<', 'input.txt') or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to calc
my @input = grep { length } split /\n/, do { local $/; <$fh> };
close($fh);

my $output = calc(@input);
print "$output\n";
