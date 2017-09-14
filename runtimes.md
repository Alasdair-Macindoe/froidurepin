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


### Notes
Unsurprisingly running a non-concurrent algorithm with more threads has no effect. There *could* be a small effect from the now threaded garbage collector which *might* be experimented on more later.

The interesting part here is that data source 3 took 10x as long as data source 1 despite being approximately the same size.


### Implementation Version 1.1

Data | Machine | Cores/Threads | Hash Function | Jobs | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:----:|:---:|:---:|:---:|:---:|
4 | 3 | 1 | Standard | Standard | 1520517 | 1626999 | 2460460 | 1869325 |
4 | 3 | 2 | Standard | Standard | 1878334 | 1993524 | 3114131 | 2328663 |
4 | 3 | 4 | Standard | Standard | 1989091 | 2170925 | 3506349 | 1992122 |
4 | 3 | 8 | Standard |Standard |  1975318 | 2053770 | 3277022 | 2435237 |
4 | 3 | 16 | Standard | Standard | 1962064 | 2023282 | 3551068 | 2512138 |
4 | 3 | 32 | Standard | Standard | 2000759 | 2073269 | 3418658 | 2497562 |
4 | 3 | 64 | Standard | Standard | 1938208 | 2078201 | 3515377 | 2510595 |

### Experiment 1

#### Aim

Evaluated scalability of an alternate implementation. Standard Hash function.

#### Results

Data | Machine | Cores/Threads | Jobs  | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:---:|:---:|:---:|:---:|
6 | 3 | 32 | 1 | 9961059 | 11656681 | 10515160 | 10710967 |
6 | 3 | 32 | 4 | 18559771 | 20216191 | 15134205 | 17970056 |
6 | 3 | 32 | 8 | 23362961 | 23252902 | 23614766 | 23410210 |
6 | 3 | 32 | 16 | 36822654 | 38902672 | 40513875 |38746400 |
6 | 3 | 32 | 32 | 69870811 | 81523778 | 64826209 | 72073599 |
6 | 3 | 32 | 64 | 59601009 | 73371167 | 81624581 | 71532252 |

## Implementation Version 2.1

### Experiment 1

#### Aim

I investigate the scaling of this algorithm based upon the number of processes that HPC-GAP has available. In this case there is no change to the Hash function (the b parameter in the paper) or to the number of fragments created within the program (it is always the number of generators).
This is tested on a 64 core machine so the number of cores start with one and are doubled until 128 to see how performance scales even after it exceeds the number on the machine.

#### Data
Data | Machine | -P value | Jobs |Hash Function | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:----:|:---:|:---:|:---:|:---:|
1 | 3 | 32 | Standard | Standard | 62703 | 63878 | 65022 | 63868 |
1 | 3 | 16 | Standard | Standard | 64235 | 64755 | 65296 | 64762 |
6 | 3 | 1 | Standard | Standard | 6955576 | 7689726 | 8494424 | 7713242 |
6 | 3 | 2 | Standard | Standard | 6820522 | 7560187 | 8070741 | 7483817 |
6 | 3 | 4 | Standard | Standard | 6756816 | 7893151 | 8685619 | 7778529 |
6 | 3 | 8 | Standard | Standard | 6939613 | 7862565 | 8372100 | 7724759 |
6 | 3 | 16 | Standard | Standard | 7003672 | 7768049 | 8028530 | 7600084 |
6 | 3 | 32 | Standard | Standard | 6994618 | 7849276 | 8334006 | 7725967 |
6 | 3 | 64 | Standard | Standard | 6620556 | 7521463 | 7894263 | 7345427 |


### Experiment 2

#### Aim

In this experiment I wish to investigate how performance is linked to the number of fragments available to the machine. In each case the number of processes is limited to 32 but the number of jobs will vary from one and keep getting doubled until 64.

#### Data

Data | Machine | -P value | Jobs |Hash Function | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:----:|:---:|:---:|:---:|:---:|
6 | 3 | 32 | 1 | Standard | 8482088 | 8748061 | 9378134 | 8202761
6 | 3 | 32 | 2 | Standard | 8769410 | 9231658 | 8375905 | 8792324
6 | 3 | 32 | 4 | Standard | 6806727 | 7022969 | 7027339 | 6952345
6 | 3 | 32 | 8 | Standard | 4640586 | 4435855 | 4626419 | 4567620
6 | 3 | 32 | 16 | Standard | 2331557 | 2274763 |2268689 | 2291670
6 | 3 | 32 | 32 | Standard | 883814 | 867390 | 847761 | 866321
6 | 3 | 32 | 64 | Standard | 630728 | 638010 | 621052 | 629930
