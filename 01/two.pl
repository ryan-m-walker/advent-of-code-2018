#!/usr/bin/perl
use strict;
use warnings;

sub calc {
    my @input = @_;
    my $total = 0;
    my %freq;

    # keep cycling through the shifts until a total is seen twice
    while (1) {
        for my $item (@input) {
            # the first total we reach for a second time is the answer
            return $total if $freq{$total}++;
            $total += $item;
        }
    }
}

open my $file, '<', 'input.txt' or die "Could not open input.txt: $!";
# read the input, split by lines and use it as argument to the calc function
my @input = grep { length } map { chomp; $_ } <$file>;
close $file;

my $output = calc(@input);
print "FOUND: $output\n";
