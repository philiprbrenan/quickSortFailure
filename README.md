<div>
    <p><a href="https://github.com/philiprbrenan/quickSortFailure"><img src="https://github.com/philiprbrenan/quickSortFailure/workflows/Test/badge.svg"></a>
</div>

# Quicksort Point of Failure

The ability to regurgitate the [Quick Sort](https://github.com/philiprbrenan/QuickSort) algorithm is often used as a [test](https://en.wikipedia.org/wiki/Software_testing) in [job](https://en.wikipedia.org/wiki/Job_(computing)) interviews. It is easy to [write](https://en.wikipedia.org/wiki/Write_(system_call)) a short, [recursive](https://en.wikipedia.org/wiki/Recursion) [version](https://en.wikipedia.org/wiki/Software_versioning) of this
algorithm ``quickSortEasy.pl`` that works well on small [test](https://en.wikipedia.org/wiki/Software_testing) cases:

```
sub Q{@_<2?@_:(Q(grep$_<$_[@_/2],@_),(grep$_==$_[@_/2],@_),Q(grep$_>$_[@_/2],@_))}  # Quicksort
```

However, this [version](https://en.wikipedia.org/wiki/Software_versioning) uses a lot of [memory](https://en.wikipedia.org/wiki/Computer_memory), creating three additional [arrays](https://en.wikipedia.org/wiki/Dynamic_array) for each phase of the [sort](https://en.wikipedia.org/wiki/Sorting) which negates one of the major advantages of [Quick Sort](https://github.com/philiprbrenan/QuickSort), namely the fact that it can be implemented as an in-place [sort](https://en.wikipedia.org/wiki/Sorting) without requiring extra [memory](https://en.wikipedia.org/wiki/Computer_memory). 
## Crashing the easy [version](https://en.wikipedia.org/wiki/Software_versioning) 
It is easy to get ``quickSortEasy.pl`` to crash: try sorting ``(1..1000) x 10``
and observe the resulting stack overflow as shown in the action associated with
this repository.

The same problems occur in the corresponding Python [version](https://en.wikipedia.org/wiki/Software_versioning), as shown by the
execution of ``quickSortEasy.py`` in the action associated with this
repository.

## Overcoming this particular failure

This particular point of failure is avoided in the non [recursive](https://en.wikipedia.org/wiki/Recursion) [version](https://en.wikipedia.org/wiki/Software_versioning): ``quickSort.pl`` which randomizes the input [array](https://en.wikipedia.org/wiki/Dynamic_array) before sorting it in place
without a stack overflow occurring.

# Automated formatting

Both short and long versions of the algorithm have inner beauty.  The easy [version](https://en.wikipedia.org/wiki/Software_versioning) relies on the relentless brevity of recursion:

```
sub Q{@_<2?@_:(Q(grep$_<$_[@_/2],@_),(grep$_==$_[@_/2],@_),Q(grep$_>$_[@_/2],@_))}  # Quicksort

```

While the long [version](https://en.wikipedia.org/wiki/Software_versioning) neatly partitions each range like this:

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