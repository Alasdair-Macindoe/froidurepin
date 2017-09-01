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

Data | Machine | Cores/Threads | Jobs | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:---:|:---:|:---:|:---:|
4 | 3 | 1 | Standard | 1520517 | 1626999 | 2460460 | 1869325 |
4 | 3 | 2 | Standard | 1878334 | 1993524 | 3114131 | 2328663 |
4 | 3 | 4 | Standard | 1989091 | 2170925 | 3506349 | 1992122 |
4 | 3 | 8 | Standard | 1975318 | 2053770 | 3277022 | 2435237 |
4 | 3 | 16 | Standard | 1962064 | 2023282 | 3551068 | 2512138 |
4 | 3 | 32 | Standard | 2000759 | 2073269 | 3418658 | 2497562 |
4 | 3 | 64 | Standard | 1938208 | 2078201 | 3515377 | 2510595 |

## Implementation Version 2.0

### Experiment 1

#### Aim

To establish base cases for all the data sets. Standard hash function, 1 task, 1 core. Uses non-concurrent implementation.

Data | Machine | R1 | R2 | R3 | Avg |
:---:|:--------|:---:|:---:|:---:|:---:|
4 | 3 |
6 | 3 |

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
4 | 3 | 1 | Standard | Standard | 8162778 | 8756292 | 8749683 | 8556251 |
4 | 3 | 2 | Standard | Standard | 8860270 | 9880929 | 9792256 | 9511152 |
4 | 3 | 4 | Standard | Standard | 9375262 | 9731983 | 9847083 | 9651443 |
4 | 3 | 8 | Standard | Standard | 9176178 | 9975205 | 9864154 | 9671846 |
4 | 3 | 16 | Standard | Standard | 9577685 | 10080654 | 10632342 | 10096894 |
4 | 3 | 32 | Standard | Standard | 9270256 | 10021059 | 9867895 | 9719733 |
4 | 3 | 64 | Standard | Standard | 9345471 | 10502387 | 10731793 | 10193217 |

### Experiment 2

#### Aim

In this experiment I wish to investigate how performance is linked to the number of fragments available to the machine. In each case the number of processes is limited to 32 but the number of jobs will vary from one and keep getting doubled until 64.

#### Data

Data | Machine | -P value | Jobs |Hash Function | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:----:|:---:|:---:|:---:|:---:|
1 | 3 | 32 | 32 | Standard | 59868 | 60830 | 62310 | 61003 |
1 | 3 | 32 | 16 | Standard | 62080 | 60470 | 61014 | 61188 |
1 | 3 | 32 | 4 | Standard | 53310 | 53412 | 53196 | 53306 |
4 | 3 | 32 | 1 | Standard |
4 | 3 | 32 | 2 | Standard | 9123348 | 8400005 | 8209207 | 8577520 |
4 | 3 | 32 | 4 | Standard | 11298995 | 11007668 | 11193768 | 11166810 |
4 | 3 | 32 | 8 | Standard | 12637243 | 11637508 | 12325946 | 12200232 |
4 | 3 | 32 | 16 | Standard | 11393922 | 10864954 | 11624802 | 11294559 |
4 | 3 | 32 | 32 | Standard | 9722663 | 10795969 | 10755596 |10424743 |
4 | 3 | 32 | 64 | Standard |
6 | 3 | 32 | 1 | Standard |
6 | 3 | 32 | 2 | Standard |
6 | 3 | 32 | 8 | Standard |
6 | 3 | 32 | 16 | Standard |
6 | 3 | 32 | 32 | Standard |
6 | 3 | 32 | 64 | Standard |

### Experiment 3

#### Aim

Due to some challenges in early development each word stores only the value of other words, and not a pointer. This means we have to look up each word in memory. If this could be removed it may speed up performance.

#### Data

Data | Machine | -P value | Jobs |Hash Function | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:----:|:---:|:---:|:---:|:---:|
1 | 3 | 32 | 32 | Standard |
1 | 3 | 32 | 16 | Standard |
1 | 3 | 32 | 4 | Standard |
4 | 3 | 32 | 1 | Standard |
4 | 3 | 32 | 2 | Standard |
4 | 3 | 32 | 4 | Standard |
4 | 3 | 32 | 8 | Standard |
4 | 3 | 32 | 16 | Standard |
4 | 3 | 32 | 32 | Standard |
4 | 3 | 32 | 64 | Standard |

### Experiment 4

#### Aim

A core part of this algorithm is the hash function (called b in the paper). HPC-GAP does not have a good hash function for transformations so in this section I test out how important a good hash function is to the runtime. For example is better to have a more complex, slower, hash function that distributes better over a quick and easy hash function that distributes less uniformly.
Please see `hash-versions.md` for more information on each hash function.

Data | Machine | -P value | Jobs |Hash Function | R1 | R2 | R3 | Avg |
:---:|:-------:|:-------------:|:----:|:----:|:---:|:---:|:---:|:---:|
