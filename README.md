<div>
    <p><a href="https://github.com/philiprbrenan/quickSortFailure"><img src="https://github.com/philiprbrenan/quickSortFailure/workflows/Test/badge.svg"></a>
</div>

# Quicksort Point of Failure

A demonstration of how the easy [version](https://en.wikipedia.org/wiki/Software_versioning) of [Quick Sort](https://github.com/philiprbrenan/QuickSort), the one we so often
encounter in interviews, can [fail](https://1lib.eu/book/2468851/544b50) and one way to ameliorate this failure.

In ``quickSortEasy.pl`` we get a stack overflow when trying to [sort](https://en.wikipedia.org/wiki/Sorting) ``(1..1000)
x 10``.  At the same time, this [version](https://en.wikipedia.org/wiki/Software_versioning) uses a lot of [memory](https://en.wikipedia.org/wiki/Computer_memory) as it creates
copies of parts if to be [array](https://en.wikipedia.org/wiki/Dynamic_array) to be sorted.

``quickSort.pl`` ameliorates this situation by not using recursion and by
randomizing the [array](https://en.wikipedia.org/wiki/Dynamic_array) to be sorted before sorting it in place.

Both versions have inner beauty.  The easy [version](https://en.wikipedia.org/wiki/Software_versioning) relies on recusrion via a
one liner:

```
sub Q{@_<2?@_:(Q(grep$_<$_[@_/2],@_),(grep$_==$_[@_/2],@_),Q(grep$_>$_[@_/2],@_))}  # Quicksort

```

While the larger [version](https://en.wikipedia.org/wiki/Software_versioning) partitions ranges like this:

```
    for my $i($A..$B)                                                           # Squeeze at most this number of times
     {++$traverses;
      ++$a, next if $a < $p and $$array[$a] <= $$array[$p];                     # Move up over lower element
      --$b, next if $p < $b and $$array[$b] >  $$array[$p];                     # Move down over higher element
      swap($a,   $b),                 ++$a, --$b, next if $a < $p < $b;         # Swap opposing out of order pair keeping pivot in the same position
      swap($p-1, $a), swap($p-1, $p), --$b, --$p, next if $a < $p;              # Move pivot down, swapping up high element from lower half with no opposing element
      swap($p+1, $b), swap($p+1, $p), ++$a, ++$p, next if $p < $b;              # Move pivot up swapping down low element from upper half with no opposing element
      last
     }
```

Of course, if you were to run this [code](https://en.wikipedia.org/wiki/Computer_program) through an automated formatter it would
look ugly as all the vertical alignment would be lost.  Here is what ChatGPT
does to it:

```
for my $i ($A .. $B) {  # Squeeze at most this number of times
    ++$traverses;

    # Move up over lower element
    ++$a, next if $a < $p and $$array[$a] <= $$array[$p];

    # Move down over higher element
    --$b, next if $p < $b and $$array[$b] > $$array[$p];

    # Swap opposing out-of-order pair, keeping pivot in the same position
    swap($a, $b), ++$a, --$b, next if $a < $p < $b;

    # Move pivot down, swapping up high element from lower half with no opposing element
    swap($p-1, $a), swap($p-1, $p), --$b, --$p, next if $a < $p;

    # Move pivot up, swapping down low element from upper half with no opposing element
    swap($p+1, $b), swap($p+1, $p), ++$a, ++$p, next if $p < $b;

    last;
}

```

To misquote G.H. Hardy: "Beauty is the first [test](https://en.wikipedia.org/wiki/Software_testing). There is no permanent place in this world for ugly [code](https://en.wikipedia.org/wiki/Computer_program)." 