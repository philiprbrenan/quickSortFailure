#!/usr/bin/perl
#-------------------------------------------------------------------------------
# In place quick sort of array with duplicate elements using no extra arrays
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2025
#-------------------------------------------------------------------------------
use v5.38;
use warnings FATAL => qw(all);
use strict;
use Time::HiRes qw(time);

sub quickSort                                                                   # Quick sort in place without using extra arrays
 {my ($array) = @_;
  return unless $array and @$array > 1;                                         # Nothing to sort

  my $swaps = 0; my $traverses = 0; my $maxDepth = 0; my $start = time;         # Instrumentation

  my sub swap                                                                   # Swap two elements
   {my ($a, $b) = @_;
    ($$array[$b], $$array[$a]) = ($$array[$a], $$array[$b]);
    ++$swaps;
   }

  swap($_, int rand $#$array) for keys @$array;                                 # Randomize the array to prevent deep recursion

  my @ranges = [0, $#$array];                                                   # Starting range

  for(my $j = 0; $j < @$array and @ranges; ++$j)                                # Quick sort a range
   {my ($A, $B) = pop(@ranges)->@*;                                             # Start of range, end of range
    $maxDepth = @ranges if @ranges > $maxDepth;                                 # Track depth of psuedo recursion

    my ($a, $b) = ($A, $B);                                                     # The range to squeeze
    my $p = int(($a + $b) / 2);                                                 # Select pivot

    my $out = 0;                                                                # Check whether the range is sorted yet
    $out += $$array[$_-1] > $$array[$_] ? 1 : 0 for $A+1..$B;                   # The number of out of order elements in the range
    next unless $out;                                                           # Return immediately if the range is already sorted

    for my $i($A..$B)                                                           # Squeeze at most this number of times
     {++$traverses;
      ++$a, next if $a < $p and $$array[$a] <= $$array[$p];                     # Move up over lower element
      --$b, next if $p < $b and $$array[$b] >  $$array[$p];                     # Move down over higher element
      swap($a,   $b),                 ++$a, --$b, next if $a < $p < $b;         # Swap opposing out of order pair keeping pivot in the same position
      swap($p-1, $a), swap($p-1, $p), --$b, --$p, next if $a < $p;              # Move pivot down, swapping up high element from lower half with no opposing element
      swap($p+1, $b), swap($p+1, $p), ++$a, ++$p, next if $p < $b;              # Move pivot up swapping down low element from upper half with no opposing element
      last
     }

    push @ranges, [$A, $p-1] if $A < $p-1;
    push @ranges, [$p+1, $B] if $B > $p+1;
   }

  say STDERR sprintf "Size=%8d time=%7.4f depth=%2d swaps=%8d  traverses=%8d", scalar($_[0]->@*), time-$start, $maxDepth, $swaps, $traverses;
 }

sub test                                                                        # Test a possible array
 {my @a = @_;
  quickSort(\@a);
  my @e = sort {$a <=> $b} @_;
  die unless "@a" eq "@e";
 }

test;
test 1;
test 1..20;
test 5, 7, 13, 6, 2, 18;
test qw(1 1 2 2 1 1 1 3 3 1 1 2 2 2);
test ((1..10) x 10);
test qw(1 1 4 2 2 3 7 4 3 8 7 8 4 6 5 6 3 1 1 4 2 2 3 7 4 3 8 7 8 4 6 5 6 3);
test ((1)x1e3, 1, 1, 2, (1)x1e3);                                               # A lot of duplicates
test ((reverse 1..1e5), 1..1e5);                                                # A lot of duplicate pairs
test ((reverse 1..2e5), 1..2e5);                                                # Double the last should result in a doubling of runtime not a quadrupling
test ((1..1000)x100);                                                           # Fails in easy version

# Size=      20 time= 0.0001 depth= 1 swaps=     106  traverses=     103
# Size=       6 time= 0.0000 depth= 1 swaps=      11  traverses=      10
# Size=      14 time= 0.0000 depth= 1 swaps=      26  traverses=      25
# Size=     100 time= 0.0004 depth= 4 swaps=     539  traverses=     541
# Size=      34 time= 0.0001 depth= 3 swaps=     130  traverses=     123
# Size=    2003 time= 0.0023 depth= 0 swaps=    4003  traverses=    2003
# Size=  200000 time= 2.2904 depth=25 swaps= 3097725  traverses= 4017500
# Size=  400000 time= 4.6276 depth=24 swaps= 5855525  traverses= 7901656
