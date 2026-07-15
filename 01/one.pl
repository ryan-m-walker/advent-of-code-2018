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
my @input = grep { length } split /\n/, do { local $/; <$fh> };
close($fh);

my $output = calc(@input);
print "$output\n";
