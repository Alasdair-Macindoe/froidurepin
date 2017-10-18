# parallel-sgrp-gap
[![Build Status](https://travis-ci.org/Alasdair-Macindoe/froidurepin.svg?branch=master)](https://travis-ci.org/Alasdair-Macindoe/froidurepin)

The ultimate aim of this project is to implement Froidure-Pin Semigroup-Enumeration in HPC-GAP and evaluate its performance and scalability in relation to the C++ implementation, find performance bottlenecks, and work on improvements or more HPC-GAP idiomatic algorithm design.

More information will be made available as the project develops if necessary.

# Installation

Please place in the correct pkg folder such as either `gap/pkg` or `hpcgap/pkg`.  This can be done by navigating to the correct folder and executing a `git clone` command such as `git clone https://github.com/Alasdair-Macindoe/froidurepin`.

Then you can load the package from within GAP by using `LoadPackage("froidurepin")`.

For example (from gap root):

```
cd hpcgap/pkg
git clone https://github.com/Alasdair-Macindoe/froidurepin
```

# Testing

From GAPROOT:

```
mv hpcgap/pkg/froidurepin/test.g .
bin/gap.sh
gap> Read("test.g");
```

# NOTE

This is in **DEVELOPMENT** function name and parameters may change.

# Paper

Any and all reference to 'the paper' or 'paper' are referring to: arXiv:1704.04084v2 [math.GR].
