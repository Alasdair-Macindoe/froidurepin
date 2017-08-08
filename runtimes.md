# Introduction
Please refer to `data.md` for the input corresponding to each number.
Additionally please refer to `versions.md` for the various version of the implementation of this algorithm.

# Machine Information

## Machine 1
**Processor**: Intel Core(TM) i5-2430 2.4Ghz w/ boost up to 3.0GHz. 2 cores, 4 threads.

**Memory**: 6 GB DDR 3.

**OS**: Fedora 24.

## Machine 2
**Processor**: Intel Core(TM) i5-3570k 4GHz. 4 cores, 4 threads.

**Memory**: 16 GB DDR 3.

**OS**: Windows 10.

# Runtimes

**Note**: All runtimes are in msec. These are calculated using GAPs built-in [Runtime](https://www.gap-system.org/Manuals/doc/ref/chap7.html#X792BA9A67E64CDED) function.  This is inherently imperfect because the method itself takes time to run.

If core limitations were necessary they were done so using HPC-GAP's launch parameters eg `-P x`.

## Implementation Version 1

Data | Machine | Cores/Threads | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:---:|:---:|:---:|:---:|
1    | 1       | 1/1             | 30114  | 31255  | 31170  | 30846  |
1    | 1       | 2/4             | 30556  | 29732  | 29660  | 29983 |


## Notes
Unsurprisingly running a non-concurrent algorithm with more threads has no effect. There *could* be a small effect from the now threaded garbage collector which might be experimented on more later. 
