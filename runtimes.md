# Introduction
Please refer to `data.md` for the input corresponding to each number.
Additionally please refer to `versions.md` for the various version of the implementation of this algorithm.

# Machine Information

## Machine 1
**Processor**: Intel Core(TM) i5-2430 2.4Ghz w/ boost up to 3.0GHz. 2 cores, 4 threads.

**Memory**: 6 GB DDR 3.

**OS**: Fedora 24.

## Machine 2
**Processor**: 2x Intel(R) Xeon(R) E5-2640 v4 CPU

**Memory**: 8 x 16GB DDR4 2400 MHz ECC.

**OS**: Unknown.

**Notes**: 'Cormac' research server.

## Machine 3

**Processor**: 2x AMD Opteron 6376 CPU

**Memory**: 32 x 16GB PC3-12800 DDR3-1600Mhz ECC

**OS**: Unknown.

**Notes**: 'Lovelace' research server.

# Runtimes

**Note**: All runtimes are in msec. These are calculated using GAPs built-in [Runtime](https://www.gap-system.org/Manuals/doc/ref/chap7.html#X792BA9A67E64CDED) function.  This is inherently imperfect because the method itself takes time to run.

If core limitations were necessary they were done so using HPC-GAP's launch parameters eg `-P x` or `-P 1 -S`.

## Implementation Version 1

Data | Machine | Cores/Threads | Jobs | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:---:|:---:|:---:|:---:|
1    | 1       | 1    | Standard |30114  | 31255  | 31170  | 30846  |
1    | 1       | 2      | Standard |30556  | 29732  | 29660  | 29983 |
2    | 1       | 1      | Standard |1724724 | 1731895 | 2142796 | 1866471 |
3    | 1       | 1      | Standard |340253  | 329592 | 326096 | 331980 |


## Notes
Unsurprisingly running a non-concurrent algorithm with more threads has no effect. There *could* be a small effect from the now threaded garbage collector which *might* be experimented on more later.

The interesting part here is that data source 3 took 10x as long as data source 1 despite being approximately the same size.


## Implementation Version 1.1

Data | Machine | Cores/Threads | Jobs | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:---:|:---:|:---:|:---:|
1    | 3       | 1             |  Standard | 11471 | 11264 | 11222 | 11319 |
1    | 3       | 2  | Standard | 11664 | 12624 | 11960 | 11982 |
1 | 3 | 4 | Standard | 11601 | 11660 | 12128 | 11796 |
1 | 3 | 8 | Standard | 11522 | 11592 | 11727 | 11613 |
1 | 3 | 64 | Standard | 11656 | 11754 | 11662 | 11690 |
4 | 3 | 1 | Standard | 1954627 | 1909336 | 2805319 | 2223094 |
4 | 3 | 2 | Standard | 1935117 | 1917083 | 2768690 | 2206963 |
4 | 3 | 4 | Standard | 1903076 | 2022235 | 3258694 | 2394668 |
4 | 3 | 8 | Standard | 1916912 | 2067837 | 2917101 | 2300617 |
4 | 3 | 16| Standard | 1915185 | 1990804 | 2969950 | 2291979 |
4 | 3 | 32| Standard | 1923133 | 2036475 | 3157290 | 2372299 |
4 | 3 | 64| Standard | 1935202 | 1989315 | 2942150 | 2288889 |
4 | 3 | 32| 1 | N/A | N/A | N/A | N/A |
4 | 3 | 32| 2 | N/A | N/A | N/A | N/A |
4 | 3 | 32| 4 | N/A | N/A | N/A | N/A |
4 | 3 | 32| 8 | N/A | N/A | N/A | N/A |
4 | 3 | 32|16 | N/A | N/A | N/A | N/A |
4 | 3 | 32|32 | N/A | N/A | N/A | N/A |
