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
1    | 1       | 1/1      | Standard |30114  | 31255  | 31170  | 30846  |
1    | 1       | 2/4      | Standard |30556  | 29732  | 29660  | 29983 |
2    | 1       | 1/1      | Standard |1724724 | 1731895 | 2142796 | 1866471 |
3    | 1       | 1/1      | Standard |340253  | 329592 | 326096 | 331980 |


## Notes
Unsurprisingly running a non-concurrent algorithm with more threads has no effect. There *could* be a small effect from the now threaded garbage collector which *might* be experimented on more later.

The interesting part here is that data source 3 took 10x as long as data source 1 despite being approximately the same size.


## Implementation Version 1.1

Data | Machine | Cores/Threads | Jobs | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:---:|:---:|:---:|:---:|
5    | 2       | 1             |
