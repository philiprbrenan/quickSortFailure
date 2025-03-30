#-------------------------------------------------------------------------------
# Quick sort in python that crashes on awkward case
# Philip R Brenan at gmail dot com, Appa Apps Ltd Inc., 2025
#-------------------------------------------------------------------------------
def Q(array):
    if len(array) < 2:
        return array
    else:
        p = len(array) // 2
        a = [x for x in array if x <  array[p]]
        P = [x for x in array if x == array[p]]
        b = [x for x in array if x >  array[p]]
        return [*Q(a), *P, *Q(b)]

assert(Q([1,3,2,1,2,3,1]) == [1, 1, 1, 2, 2, 3, 3])

print(Q([j for i in range(10) for j in range(1000)]))                           # Stack overflow
