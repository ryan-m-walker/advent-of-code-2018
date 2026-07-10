#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    $total += $_ for @input;
    return $total;
}

open my $file, '<', 'input.txt' or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to the calc function
my @input = grep { length } map { chomp; $_ } <$file>;
close $file;

my $output = calc(@input);
print "$output\n";
