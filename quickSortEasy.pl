#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Quick sort
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2024
#-------------------------------------------------------------------------------
use v5.38;
use Test::More qw(no_plan);

sub Q{@_<2?@_:(Q(grep$_<$_[@_/2],@_),(grep$_==$_[@_/2],@_),Q(grep$_>$_[@_/2],@_))}  # Quicksort

is_deeply [Q()], [];
is_deeply [Q(2, (1)x4)],        [(1)x4, 2];
is_deeply [Q(qw(6 3 1 4 2 5))], [1..6];
is_deeply [Q(        1..1000)], [1..1000];
is_deeply [Q(reverse 1..1000)], [1..1000];
# Q((1..1000)x10);                                                              # Deep recursion
