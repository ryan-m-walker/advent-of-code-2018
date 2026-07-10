#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    $total += $_ for @input;
    return $total;
}

open(my $file, '<', 'input.txt') or die "Could not open input.txt: $!";
chomp(my @input = <$file>);
close($file);

my $output = calc(@input);
print "$output\n";
