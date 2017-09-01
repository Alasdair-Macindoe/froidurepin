# Introduction
Please refer to `versions.md` for the various version of the implementation of this algorithm.
Additionally to `runtimes.md` for the runtime of each version.

# Data

## 1

```
g := [ Transformation( [ 1, 1, 3, 5, 3 ] ), Transformation( [ 2, 3, 5, 1, 4 ] ), Transformation( [ 3, 1, 3, 3, 3 ] ),
  Transformation( [ 3, 1, 5, 5, 2 ] ), Transformation( [ 3, 3, 2, 1, 2 ] ), Transformation( [ 3, 3, 4, 2, 3 ] ),
  Transformation( [ 3, 3, 5, 3, 4 ] ), Transformation( [ 3, 5, 1, 1, 2 ] ), Transformation( [ 3, 5, 2, 3, 4 ] ),
  Transformation( [ 4, 5, 3, 3, 3 ] ), Transformation( [ 5, 3, 4, 4, 3 ] ), Transformation( [ 5, 5, 4, 5, 3 ] ) ];;
```

### Reason

Size: 3010.

Standard input of a small size, generally used to ensure that everything it working correctly.

## 2

```
g := [ Transformation( [ 1, 3, 2, 1, 4 ] ), Transformation( [ 2, 5, 1, 2, 5, 1 ] ), Transformation( [ 2, 6, 4, 3, 4, 3 ] ),
  Transformation( [ 4, 5, 1, 5, 4, 1 ] ), Transformation( [ 4, 5, 2, 3, 6, 2 ] ), Transformation( [ 5, 6, 4, 3, 3, 2 ] ),
  Transformation( [ 6, 1, 4, 3, 2, 3 ] ), Transformation( [ 6, 6, 2, 1, 4, 3 ] ) ];;
```

### Reason

Size: 18846

Standard input of medium size, used to get some data on scaling.


## 3

```
g := [ Transformation( [ 1, 1, 1, 1, 3 ] ), Transformation( [ 1, 1, 1, 3 ] ), Transformation( [ 1, 1, 1, 4, 1 ] ), Transformation( [ 1, 1, 1, 4, 2 ] ),
  Transformation( [ 1, 1, 1, 4, 3 ] ), Transformation( [ 1, 1, 1, 4, 4 ] ), Transformation( [ 1, 1, 1, 5, 3 ] ),
  Transformation( [ 1, 1, 1, 5, 5 ] ), Transformation( [ 1, 1, 2, 1, 1 ] ), Transformation( [ 1, 1, 2, 1 ] ), Transformation( [ 1, 1, 2, 4, 1 ] ),
  Transformation( [ 1, 1, 2, 4, 2 ] ), Transformation( [ 1, 1, 2, 4, 4 ] ), Transformation( [ 1, 1, 2, 5, 4 ] ),
  Transformation( [ 1, 1, 3, 1, 3 ] ), Transformation( [ 1, 1, 3, 2, 2 ] ), Transformation( [ 1, 1, 3, 2, 3 ] ),
  Transformation( [ 1, 1, 3, 3, 2 ] ), Transformation( [ 1, 1, 3, 4, 2 ] ), Transformation( [ 1, 1, 3, 5, 3 ] ),
  Transformation( [ 1, 1, 4, 1, 1 ] ), Transformation( [ 1, 1, 4, 1, 2 ] ), Transformation( [ 1, 1, 4, 2, 2 ] ),
  Transformation( [ 1, 1, 4, 2, 4 ] ), Transformation( [ 1, 1, 4, 3, 3 ] ), Transformation( [ 1, 1, 4, 3 ] ), Transformation( [ 1, 1, 4, 4, 3 ] ),
  Transformation( [ 1, 1, 4, 5, 1 ] ), Transformation( [ 1, 1, 4, 5, 2 ] ), Transformation( [ 1, 1, 4, 5, 3 ] ),
  Transformation( [ 1, 1, 4, 5, 4 ] ), Transformation( [ 1, 1, 5, 2, 2 ] ), Transformation( [ 1, 1, 5, 3, 5 ] ),
  Transformation( [ 1, 1, 5, 4, 3 ] ), Transformation( [ 1, 1, 5, 4, 4 ] ), Transformation( [ 1, 1, 5, 5, 2 ] ), Transformation( [ 1, 2, 1, 1 ] ),
  Transformation( [ 1, 2, 1, 3, 3 ] ), Transformation( [ 1, 2, 1, 4, 2 ] ), Transformation( [ 1, 2, 1, 4, 4 ] ), Transformation( [ 1, 2, 1 ] ),
  Transformation( [ 1, 2, 1, 5, 1 ] ), Transformation( [ 1, 2, 1, 5, 5 ] ), Transformation( [ 1, 2, 2, 1, 2 ] ),
  Transformation( [ 1, 2, 2, 3, 4 ] ), Transformation( [ 1, 2, 2, 4, 4 ] ), Transformation( [ 1, 2, 2, 5, 1 ] ),
  Transformation( [ 1, 2, 2, 5, 2 ] ), Transformation( [ 1, 2, 3, 1, 2 ] ), Transformation( [ 1, 2, 3, 2, 3 ] ),
  Transformation( [ 1, 2, 3, 3, 1 ] ), Transformation( [ 1, 2, 3, 4, 4 ] ), IdentityTransformation, Transformation( [ 1, 2, 3, 5, 5 ] ),
  Transformation( [ 1, 2, 4, 1, 1 ] ), Transformation( [ 1, 2, 4, 1, 3 ] ), Transformation( [ 1, 2, 4, 1 ] ), Transformation( [ 1, 2, 4, 2, 1 ] ),
  Transformation( [ 1, 2, 4, 2, 2 ] ), Transformation( [ 1, 2, 4, 2 ] ), Transformation( [ 1, 2, 4, 4, 3 ] ), Transformation( [ 1, 2, 5, 3, 5 ] ),
  Transformation( [ 1, 2, 5, 4, 4 ] ), Transformation( [ 1, 2, 5, 5, 2 ] ), Transformation( [ 1, 2, 5, 5, 5 ] ),
  Transformation( [ 1, 3, 1, 2, 2 ] ), Transformation( [ 1, 3, 1, 2, 4 ] ), Transformation( [ 1, 3, 1, 3, 3 ] ),
  Transformation( [ 1, 3, 1, 4, 2 ] ), Transformation( [ 1, 3, 1, 4, 3 ] ), Transformation( [ 1, 3, 1, 4, 4 ] ), Transformation( [ 1, 3, 1 ] ),
  Transformation( [ 1, 3, 1, 5, 3 ] ), Transformation( [ 1, 3, 2, 1, 1 ] ), Transformation( [ 1, 3, 2, 1, 2 ] ), Transformation( [ 1, 3, 2, 1 ] ),
  Transformation( [ 1, 3, 2, 2, 4 ] ), Transformation( [ 1, 3, 2, 3, 3 ] ), Transformation( [ 1, 3, 2, 4, 2 ] ), Transformation( [ 1, 3, 2 ] ),
  Transformation( [ 1, 3, 2, 5, 1 ] ), Transformation( [ 1, 3, 3, 1, 3 ] ), Transformation( [ 1, 3, 3, 2, 4 ] ),
  Transformation( [ 1, 3, 3, 3, 4 ] ), Transformation( [ 1, 3, 3, 4, 1 ] ), Transformation( [ 1, 3, 3, 4, 4 ] ),
  Transformation( [ 1, 3, 3, 5, 1 ] ), Transformation( [ 1, 3, 3, 5, 4 ] ), Transformation( [ 1, 3, 4, 1, 1 ] ),
  Transformation( [ 1, 3, 4, 1, 3 ] ), Transformation( [ 1, 3, 4, 1 ] ), Transformation( [ 1, 3, 4, 2, 2 ] ), Transformation( [ 1, 3, 4, 2 ] ),
  Transformation( [ 1, 3, 4, 3, 3 ] ), Transformation( [ 1, 3, 4, 5, 1 ] ), Transformation( [ 1, 3, 4, 5, 5 ] ),
  Transformation( [ 1, 3, 5, 3, 2 ] ), Transformation( [ 1, 3, 5, 4, 1 ] ), Transformation( [ 1, 3, 5, 4, 3 ] ),
  Transformation( [ 1, 3, 5, 4, 4 ] ), Transformation( [ 1, 3, 5, 4, 5 ] ), Transformation( [ 1, 3, 5, 5, 4 ] ),
  Transformation( [ 1, 4, 1, 1, 1 ] ), Transformation( [ 1, 4, 1, 1, 3 ] ), Transformation( [ 1, 4, 1, 1, 4 ] ),
  Transformation( [ 1, 4, 1, 2, 2 ] ), Transformation( [ 1, 4, 1, 2, 4 ] ), Transformation( [ 1, 4, 1, 3, 2 ] ),
  Transformation( [ 1, 4, 1, 3, 3 ] ), Transformation( [ 1, 4, 1, 3, 4 ] ), Transformation( [ 1, 4, 1, 4, 4 ] ),
  Transformation( [ 1, 4, 1, 5, 3 ] ), Transformation( [ 1, 4, 1, 5, 4 ] ), Transformation( [ 1, 4, 2, 1, 1 ] ),
  Transformation( [ 1, 4, 2, 1, 3 ] ), Transformation( [ 1, 4, 2, 1 ] ), Transformation( [ 1, 4, 2, 2, 2 ] ), Transformation( [ 1, 4, 2, 2, 4 ] ),
  Transformation( [ 1, 4, 2, 4, 3 ] ), Transformation( [ 1, 4, 2, 4, 4 ] ), Transformation( [ 1, 4, 2, 4 ] ), Transformation( [ 1, 4, 2, 5, 1 ] ),
  Transformation( [ 1, 4, 2, 5, 5 ] ), Transformation( [ 1, 4, 3, 1, 2 ] ), Transformation( [ 1, 4, 3, 1, 3 ] ),
  Transformation( [ 1, 4, 3, 1, 4 ] ), Transformation( [ 1, 4, 3, 2, 2 ] ), Transformation( [ 1, 4, 3, 3, 3 ] ), Transformation( [ 1, 4, 3, 3 ] ),
  Transformation( [ 1, 4, 3, 4, 1 ] ), Transformation( [ 1, 4, 3, 4, 3 ] ), Transformation( [ 1, 4, 3, 5, 3 ] ),
  Transformation( [ 1, 4, 4, 1, 2 ] ), Transformation( [ 1, 4, 4, 2, 4 ] ), Transformation( [ 1, 4, 4, 4, 4 ] ),
  Transformation( [ 1, 4, 5, 1, 1 ] ), Transformation( [ 1, 4, 5, 1, 2 ] ), Transformation( [ 1, 4, 5, 1, 4 ] ),
  Transformation( [ 1, 4, 5, 2, 1 ] ), Transformation( [ 1, 4, 5, 2, 2 ] ), Transformation( [ 1, 4, 5, 2, 3 ] ),
  Transformation( [ 1, 4, 5, 2, 4 ] ), Transformation( [ 1, 4, 5, 3, 2 ] ), Transformation( [ 1, 4, 5, 3, 5 ] ),
  Transformation( [ 1, 4, 5, 4, 3 ] ), Transformation( [ 1, 4, 5, 4, 4 ] ), Transformation( [ 1, 4, 5, 5, 3 ] ),
  Transformation( [ 1, 5, 1, 1, 2 ] ), Transformation( [ 1, 5, 1, 2, 4 ] ), Transformation( [ 1, 5, 1, 2, 5 ] ),
  Transformation( [ 1, 5, 1, 3, 3 ] ), Transformation( [ 1, 5, 1, 3, 4 ] ), Transformation( [ 1, 5, 1, 4, 1 ] ),
  Transformation( [ 1, 5, 1, 5, 1 ] ), Transformation( [ 1, 5, 2, 1, 1 ] ), Transformation( [ 1, 5, 2, 2, 4 ] ),
  Transformation( [ 1, 5, 2, 2, 5 ] ), Transformation( [ 1, 5, 2, 3, 3 ] ), Transformation( [ 1, 5, 2, 4, 3 ] ),
  Transformation( [ 1, 5, 2, 5, 3 ] ), Transformation( [ 1, 5, 2, 5, 4 ] ), Transformation( [ 1, 5, 2, 5, 5 ] ),
  Transformation( [ 1, 5, 3, 1, 2 ] ), Transformation( [ 1, 5, 3, 1, 3 ] ), Transformation( [ 1, 5, 3, 1, 5 ] ),
  Transformation( [ 1, 5, 3, 2, 4 ] ), Transformation( [ 1, 5, 3, 3, 5 ] ), Transformation( [ 1, 5, 3, 4, 3 ] ),
  Transformation( [ 1, 5, 3, 5, 1 ] ), Transformation( [ 1, 5, 3, 5, 3 ] ), Transformation( [ 1, 5, 4, 1, 4 ] ),
  Transformation( [ 1, 5, 4, 2, 1 ] ), Transformation( [ 1, 5, 4, 2, 4 ] ), Transformation( [ 1, 5, 4, 5, 1 ] ),
  Transformation( [ 1, 5, 4, 5, 2 ] ), Transformation( [ 1, 5, 4, 5, 5 ] ), Transformation( [ 1, 5, 5, 1, 1 ] ),
  Transformation( [ 1, 5, 5, 1, 2 ] ), Transformation( [ 1, 5, 5, 2, 1 ] ), Transformation( [ 1, 5, 5, 2, 2 ] ),
  Transformation( [ 1, 5, 5, 2, 3 ] ), Transformation( [ 1, 5, 5, 3, 3 ] ), Transformation( [ 1, 5, 5, 3, 4 ] ),
  Transformation( [ 1, 5, 5, 4, 2 ] ), Transformation( [ 1, 5, 5, 5, 4 ] ), Transformation( [ 2, 1, 1, 1, 2 ] ),
  Transformation( [ 2, 1, 1, 1, 4 ] ), Transformation( [ 2, 1, 1, 2, 1 ] ), Transformation( [ 2, 1, 1, 2, 2 ] ),
  Transformation( [ 2, 1, 1, 3, 3 ] ), Transformation( [ 2, 1, 1, 3, 4 ] ), Transformation( [ 2, 1, 1, 5, 3 ] ),
  Transformation( [ 2, 1, 1, 5, 4 ] ), Transformation( [ 2, 1, 2, 1, 1 ] ), Transformation( [ 2, 1, 2, 1, 2 ] ),
  Transformation( [ 2, 1, 2, 1, 3 ] ), Transformation( [ 2, 1, 2, 2, 1 ] ), Transformation( [ 2, 1, 2, 2, 2 ] ),
  Transformation( [ 2, 1, 2, 2, 3 ] ), Transformation( [ 2, 1, 2, 3, 1 ] ), Transformation( [ 2, 1, 2, 3, 2 ] ),
  Transformation( [ 2, 1, 2, 5, 1 ] ), Transformation( [ 2, 1, 2, 5, 2 ] ), Transformation( [ 2, 1, 3, 1, 3 ] ), Transformation( [ 2, 1, 3, 1 ] ),
  Transformation( [ 2, 1, 3, 2, 1 ] ), Transformation( [ 2, 1, 3, 2, 3 ] ), Transformation( [ 2, 1, 3, 2 ] ), Transformation( [ 2, 1, 3, 4, 1 ] ),
  Transformation( [ 2, 1, 3, 5, 3 ] ), Transformation( [ 2, 1, 3, 5, 4 ] ), Transformation( [ 2, 1, 4, 1 ] ), Transformation( [ 2, 1, 4, 4, 1 ] ),
  Transformation( [ 2, 1, 4, 4, 3 ] ), Transformation( [ 2, 1, 4, 4, 4 ] ), Transformation( [ 2, 1, 4, 5, 2 ] ),
  Transformation( [ 2, 1, 4, 5, 4 ] ), Transformation( [ 2, 1, 5, 1, 5 ] ), Transformation( [ 2, 1, 5, 3, 3 ] ),
  Transformation( [ 2, 1, 5, 4, 5 ] ), Transformation( [ 2, 1, 5, 5, 1 ] ), Transformation( [ 2, 1, 5, 5, 2 ] ),
  Transformation( [ 2, 1, 5, 5, 4 ] ), Transformation( [ 2, 2, 1, 1, 1 ] ), Transformation( [ 2, 2, 1, 4, 2 ] ),
  Transformation( [ 2, 2, 2, 1, 3 ] ), Transformation( [ 2, 2, 2, 3, 2 ] ), Transformation( [ 2, 2, 2, 3, 3 ] ),
  Transformation( [ 2, 2, 2, 3, 4 ] ), Transformation( [ 2, 2, 2, 3 ] ), Transformation( [ 2, 2, 2 ] ), Transformation( [ 2, 2, 2, 5, 2 ] ),
  Transformation( [ 2, 2, 3, 1, 1 ] ), Transformation( [ 2, 2, 3, 1, 4 ] ), Transformation( [ 2, 2, 3, 2, 4 ] ), Transformation( [ 2, 2, 3, 2 ] ),
  Transformation( [ 2, 2, 3, 4, 3 ] ), Transformation( [ 2, 2, 3, 5, 4 ] ), Transformation( [ 2, 2, 4, 1, 2 ] ),
  Transformation( [ 2, 2, 4, 3, 3 ] ), Transformation( [ 2, 2, 4, 3, 4 ] ), Transformation( [ 2, 2, 5, 4, 3 ] ),
  Transformation( [ 2, 2, 5, 5, 2 ] ), Transformation( [ 2, 2, 5, 5, 3 ] ), Transformation( [ 2, 3, 1, 1 ] ), Transformation( [ 2, 3, 1, 2, 1 ] ),
  Transformation( [ 2, 3, 1, 2 ] ), Transformation( [ 2, 3, 1, 3, 1 ] ), Transformation( [ 2, 3, 1, 3, 3 ] ), Transformation( [ 2, 3, 1, 4, 3 ] ),
  Transformation( [ 2, 3, 1, 4, 4 ] ), Transformation( [ 2, 3, 2, 2, 2 ] ), Transformation( [ 2, 3, 2, 3, 1 ] ),
  Transformation( [ 2, 3, 2, 3, 2 ] ), Transformation( [ 2, 3, 2, 3, 4 ] ), Transformation( [ 2, 3, 2, 4, 1 ] ),
  Transformation( [ 2, 3, 2, 5, 2 ] ), Transformation( [ 2, 3, 3, 1, 1 ] ), Transformation( [ 2, 3, 3, 1, 3 ] ),
  Transformation( [ 2, 3, 3, 2, 4 ] ), Transformation( [ 2, 3, 3, 3, 3 ] ), Transformation( [ 2, 3, 3, 3, 4 ] ),
  Transformation( [ 2, 3, 3, 4, 4 ] ), Transformation( [ 2, 3, 3, 5, 2 ] ), Transformation( [ 2, 3, 3, 5, 3 ] ),
  Transformation( [ 2, 3, 4, 1, 1 ] ), Transformation( [ 2, 3, 4, 1, 3 ] ), Transformation( [ 2, 3, 4, 1 ] ), Transformation( [ 2, 3, 4, 2, 2 ] ),
  Transformation( [ 2, 3, 4, 3, 2 ] ), Transformation( [ 2, 3, 4, 3, 4 ] ), Transformation( [ 2, 3, 4, 4, 2 ] ),
  Transformation( [ 2, 3, 4, 5, 3 ] ), Transformation( [ 2, 3, 5, 1, 1 ] ), Transformation( [ 2, 3, 5, 1, 2 ] ),
  Transformation( [ 2, 3, 5, 2, 2 ] ), Transformation( [ 2, 3, 5, 2, 5 ] ), Transformation( [ 2, 3, 5, 3, 4 ] ),
  Transformation( [ 2, 3, 5, 4, 2 ] ), Transformation( [ 2, 3, 5, 4, 5 ] ), Transformation( [ 2, 3, 5, 5, 2 ] ),
  Transformation( [ 2, 3, 5, 5, 4 ] ), Transformation( [ 2, 4, 1, 1, 2 ] ), Transformation( [ 2, 4, 1, 1, 4 ] ),
  Transformation( [ 2, 4, 1, 2, 4 ] ), Transformation( [ 2, 4, 1, 3, 2 ] ), Transformation( [ 2, 4, 1, 3, 3 ] ),
  Transformation( [ 2, 4, 1, 4, 1 ] ), Transformation( [ 2, 4, 1, 4, 2 ] ), Transformation( [ 2, 4, 1, 4, 3 ] ),
  Transformation( [ 2, 4, 1, 5, 1 ] ), Transformation( [ 2, 4, 1, 5, 2 ] ), Transformation( [ 2, 4, 1, 5, 5 ] ),
  Transformation( [ 2, 4, 2, 1, 3 ] ), Transformation( [ 2, 4, 2, 1 ] ), Transformation( [ 2, 4, 2, 2, 1 ] ), Transformation( [ 2, 4, 2, 3, 1 ] ),
  Transformation( [ 2, 4, 2, 3, 2 ] ), Transformation( [ 2, 4, 2, 5, 2 ] ), Transformation( [ 2, 4, 2, 5, 3 ] ),
  Transformation( [ 2, 4, 3, 1, 3 ] ), Transformation( [ 2, 4, 3, 2, 1 ] ), Transformation( [ 2, 4, 3, 3, 2 ] ),
  Transformation( [ 2, 4, 3, 3, 4 ] ), Transformation( [ 2, 4, 3, 4, 1 ] ), Transformation( [ 2, 4, 3, 5, 2 ] ),
  Transformation( [ 2, 4, 3, 5, 3 ] ), Transformation( [ 2, 4, 3, 5, 4 ] ), Transformation( [ 2, 4, 3, 5, 5 ] ),
  Transformation( [ 2, 4, 4, 1, 1 ] ), Transformation( [ 2, 4, 4, 1, 2 ] ), Transformation( [ 2, 4, 4, 1, 3 ] ),
  Transformation( [ 2, 4, 4, 2, 4 ] ), Transformation( [ 2, 4, 4, 4, 3 ] ), Transformation( [ 2, 4, 4, 4 ] ), Transformation( [ 2, 4, 4, 5, 2 ] ),
  Transformation( [ 2, 4, 5, 1, 2 ] ), Transformation( [ 2, 4, 5, 1, 4 ] ), Transformation( [ 2, 4, 5, 1, 5 ] ),
  Transformation( [ 2, 4, 5, 2, 2 ] ), Transformation( [ 2, 4, 5, 2, 4 ] ), Transformation( [ 2, 4, 5, 4, 1 ] ),
  Transformation( [ 2, 4, 5, 4, 4 ] ), Transformation( [ 2, 4, 5, 5, 2 ] ), Transformation( [ 2, 4, 5, 5, 3 ] ),
  Transformation( [ 2, 4, 5, 5, 4 ] ), Transformation( [ 2, 4, 5, 5, 5 ] ), Transformation( [ 2, 5, 1, 1, 5 ] ),
  Transformation( [ 2, 5, 1, 3, 3 ] ), Transformation( [ 2, 5, 1, 3, 5 ] ), Transformation( [ 2, 5, 1, 4, 2 ] ),
  Transformation( [ 2, 5, 1, 4, 3 ] ), Transformation( [ 2, 5, 1, 4, 4 ] ), Transformation( [ 2, 5, 1, 5, 4 ] ),
  Transformation( [ 2, 5, 2, 1, 3 ] ), Transformation( [ 2, 5, 2, 2, 1 ] ), Transformation( [ 2, 5, 2, 2, 4 ] ),
  Transformation( [ 2, 5, 2, 3, 1 ] ), Transformation( [ 2, 5, 2, 3, 3 ] ), Transformation( [ 2, 5, 2, 3, 4 ] ),
  Transformation( [ 2, 5, 2, 4, 3 ] ), Transformation( [ 2, 5, 2, 4, 4 ] ), Transformation( [ 2, 5, 2, 4, 5 ] ),
  Transformation( [ 2, 5, 2, 5, 1 ] ), Transformation( [ 2, 5, 2, 5, 3 ] ), Transformation( [ 2, 5, 3, 1, 4 ] ),
  Transformation( [ 2, 5, 3, 1, 5 ] ), Transformation( [ 2, 5, 3, 2, 3 ] ), Transformation( [ 2, 5, 3, 4, 3 ] ),
  Transformation( [ 2, 5, 3, 4, 4 ] ), Transformation( [ 2, 5, 3, 5, 2 ] ), Transformation( [ 2, 5, 3, 5, 4 ] ),
  Transformation( [ 2, 5, 4, 1, 2 ] ), Transformation( [ 2, 5, 4, 2, 1 ] ), Transformation( [ 2, 5, 4, 2, 4 ] ),
  Transformation( [ 2, 5, 4, 3, 3 ] ), Transformation( [ 2, 5, 4, 3, 4 ] ), Transformation( [ 2, 5, 5, 1, 1 ] ),
  Transformation( [ 2, 5, 5, 2, 2 ] ), Transformation( [ 2, 5, 5, 4, 2 ] ), Transformation( [ 2, 5, 5, 5, 1 ] ),
  Transformation( [ 3, 1, 1, 2, 1 ] ), Transformation( [ 3, 1, 1, 3, 2 ] ), Transformation( [ 3, 1, 1, 3, 3 ] ),
  Transformation( [ 3, 1, 1, 3, 4 ] ), Transformation( [ 3, 1, 2, 1, 3 ] ), Transformation( [ 3, 1, 2, 2, 1 ] ),
  Transformation( [ 3, 1, 2, 2, 2 ] ), Transformation( [ 3, 1, 2, 2, 3 ] ), Transformation( [ 3, 1, 2, 2, 4 ] ), Transformation( [ 3, 1, 2, 2 ] ),
  Transformation( [ 3, 1, 2, 4, 1 ] ), Transformation( [ 3, 1, 2 ] ), Transformation( [ 3, 1, 2, 5, 1 ] ), Transformation( [ 3, 1, 2, 5, 2 ] ),
  Transformation( [ 3, 1, 2, 5, 3 ] ), Transformation( [ 3, 1, 3, 1, 2 ] ), Transformation( [ 3, 1, 3, 1, 3 ] ),
  Transformation( [ 3, 1, 3, 1, 4 ] ), Transformation( [ 3, 1, 3, 2 ] ), Transformation( [ 3, 1, 3, 3, 2 ] ), Transformation( [ 3, 1, 3, 3, 3 ] ),
  Transformation( [ 3, 1, 3, 3, 4 ] ), Transformation( [ 3, 1, 3, 3 ] ), Transformation( [ 3, 1, 3, 4, 2 ] ), Transformation( [ 3, 1, 3, 5, 1 ] ),
  Transformation( [ 3, 1, 3, 5, 4 ] ), Transformation( [ 3, 1, 4, 1, 2 ] ), Transformation( [ 3, 1, 4, 1, 3 ] ), Transformation( [ 3, 1, 4, 1 ] ),
  Transformation( [ 3, 1, 4, 2, 2 ] ), Transformation( [ 3, 1, 4, 2, 3 ] ), Transformation( [ 3, 1, 4, 3, 4 ] ),
  Transformation( [ 3, 1, 4, 4, 3 ] ), Transformation( [ 3, 1, 4, 4 ] ), Transformation( [ 3, 1, 4, 5, 1 ] ), Transformation( [ 3, 1, 4, 5, 2 ] ),
  Transformation( [ 3, 1, 4, 5, 3 ] ), Transformation( [ 3, 1, 5, 2, 1 ] ), Transformation( [ 3, 1, 5, 2, 2 ] ),
  Transformation( [ 3, 1, 5, 2, 3 ] ), Transformation( [ 3, 1, 5, 2, 4 ] ), Transformation( [ 3, 1, 5, 4, 3 ] ),
  Transformation( [ 3, 1, 5, 5, 1 ] ), Transformation( [ 3, 2, 1, 1 ] ), Transformation( [ 3, 2, 1, 2, 3 ] ), Transformation( [ 3, 2, 1, 3, 1 ] ),
  Transformation( [ 3, 2, 1, 3, 4 ] ), Transformation( [ 3, 2, 1, 5, 4 ] ), Transformation( [ 3, 2, 2, 1, 2 ] ),
  Transformation( [ 3, 2, 2, 1, 3 ] ), Transformation( [ 3, 2, 2, 1, 4 ] ), Transformation( [ 3, 2, 2, 3, 4 ] ), Transformation( [ 3, 2, 2, 3 ] ),
  Transformation( [ 3, 2, 2, 4, 1 ] ), Transformation( [ 3, 2, 3, 2, 1 ] ), Transformation( [ 3, 2, 3, 2, 3 ] ),
  Transformation( [ 3, 2, 3, 2, 4 ] ), Transformation( [ 3, 2, 3, 3, 4 ] ), Transformation( [ 3, 2, 3, 4, 1 ] ),
  Transformation( [ 3, 2, 3, 5, 3 ] ), Transformation( [ 3, 2, 4, 1, 2 ] ), Transformation( [ 3, 2, 4, 2, 2 ] ),
  Transformation( [ 3, 2, 4, 3, 1 ] ), Transformation( [ 3, 2, 4, 3, 3 ] ), Transformation( [ 3, 2, 4, 3 ] ), Transformation( [ 3, 2, 4, 4, 1 ] ),
  Transformation( [ 3, 2, 4, 4 ] ), Transformation( [ 3, 2, 4, 5, 2 ] ), Transformation( [ 3, 2, 4, 5, 3 ] ), Transformation( [ 3, 2, 5, 1, 3 ] ),
  Transformation( [ 3, 2, 5, 2, 2 ] ), Transformation( [ 3, 2, 5, 2, 3 ] ), Transformation( [ 3, 2, 5, 2, 4 ] ),
  Transformation( [ 3, 2, 5, 3, 3 ] ), Transformation( [ 3, 2, 5, 4, 1 ] ), Transformation( [ 3, 2, 5, 4, 2 ] ),
  Transformation( [ 3, 2, 5, 4, 3 ] ), Transformation( [ 3, 2, 5, 4, 4 ] ), Transformation( [ 3, 2, 5, 4, 5 ] ),
  Transformation( [ 3, 2, 5, 5, 4 ] ), Transformation( [ 3, 3, 1, 1 ] ), Transformation( [ 3, 3, 1, 2, 2 ] ), Transformation( [ 3, 3, 1, 2, 4 ] ),
  Transformation( [ 3, 3, 1, 3, 3 ] ), Transformation( [ 3, 3, 1, 4, 4 ] ), Transformation( [ 3, 3, 1, 5, 4 ] ), Transformation( [ 3, 3, 2, 2 ] ),
  Transformation( [ 3, 3, 2, 4, 3 ] ), Transformation( [ 3, 3, 2, 5, 1 ] ), Transformation( [ 3, 3, 3, 1, 3 ] ),
  Transformation( [ 3, 3, 3, 1, 4 ] ), Transformation( [ 3, 3, 3, 2, 2 ] ), Transformation( [ 3, 3, 3, 2, 4 ] ), Transformation( [ 3, 3, 3, 3 ] ),
  Transformation( [ 3, 3, 3, 5, 1 ] ), Transformation( [ 3, 3, 3, 5, 3 ] ), Transformation( [ 3, 3, 3, 5, 5 ] ),
  Transformation( [ 3, 3, 4, 1, 2 ] ), Transformation( [ 3, 3, 4, 2, 1 ] ), Transformation( [ 3, 3, 4, 2, 3 ] ), Transformation( [ 3, 3, 4, 2 ] ),
  Transformation( [ 3, 3, 4, 4, 2 ] ), Transformation( [ 3, 3, 4, 4, 3 ] ), Transformation( [ 3, 3, 5, 1, 3 ] ),
  Transformation( [ 3, 3, 5, 1, 5 ] ), Transformation( [ 3, 3, 5, 2, 5 ] ), Transformation( [ 3, 3, 5, 3, 2 ] ),
  Transformation( [ 3, 3, 5, 3, 3 ] ), Transformation( [ 3, 3, 5, 4, 1 ] ), Transformation( [ 3, 3, 5, 4, 2 ] ),
  Transformation( [ 3, 3, 5, 5, 1 ] ), Transformation( [ 3, 4, 1, 1, 1 ] ), Transformation( [ 3, 4, 1, 1, 2 ] ),
  Transformation( [ 3, 4, 1, 1, 3 ] ), Transformation( [ 3, 4, 1, 2, 4 ] ), Transformation( [ 3, 4, 1, 2 ] ), Transformation( [ 3, 4, 1, 3, 4 ] ),
  Transformation( [ 3, 4, 1, 4, 4 ] ), Transformation( [ 3, 4, 1, 4 ] ), Transformation( [ 3, 4, 1, 5, 2 ] ), Transformation( [ 3, 4, 1, 5, 3 ] ),
  Transformation( [ 3, 4, 2, 1, 1 ] ), Transformation( [ 3, 4, 2, 1, 4 ] ), Transformation( [ 3, 4, 2, 2, 4 ] ),
  Transformation( [ 3, 4, 2, 3, 1 ] ), Transformation( [ 3, 4, 2, 4, 2 ] ), Transformation( [ 3, 4, 2, 5, 3 ] ),
  Transformation( [ 3, 4, 3, 1, 4 ] ), Transformation( [ 3, 4, 3, 2, 4 ] ), Transformation( [ 3, 4, 3, 2 ] ), Transformation( [ 3, 4, 3, 3, 2 ] ),
  Transformation( [ 3, 4, 3, 3, 4 ] ), Transformation( [ 3, 4, 3, 3 ] ), Transformation( [ 3, 4, 3, 4, 1 ] ), Transformation( [ 3, 4, 3, 5, 5 ] ),
  Transformation( [ 3, 4, 4, 1, 1 ] ), Transformation( [ 3, 4, 4, 1, 3 ] ), Transformation( [ 3, 4, 4, 1, 4 ] ),
  Transformation( [ 3, 4, 4, 2, 1 ] ), Transformation( [ 3, 4, 4, 2, 4 ] ), Transformation( [ 3, 4, 4, 3, 1 ] ),
  Transformation( [ 3, 4, 4, 3, 2 ] ), Transformation( [ 3, 4, 4, 4, 1 ] ), Transformation( [ 3, 4, 4, 4, 4 ] ),
  Transformation( [ 3, 4, 5, 1, 5 ] ), Transformation( [ 3, 4, 5, 2, 3 ] ), Transformation( [ 3, 4, 5, 3, 1 ] ),
  Transformation( [ 3, 4, 5, 3, 2 ] ), Transformation( [ 3, 4, 5, 3, 5 ] ), Transformation( [ 3, 5, 1, 2, 2 ] ),
  Transformation( [ 3, 5, 1, 2, 4 ] ), Transformation( [ 3, 5, 1, 2, 5 ] ), Transformation( [ 3, 5, 1, 4, 2 ] ),
  Transformation( [ 3, 5, 1, 5, 4 ] ), Transformation( [ 3, 5, 1, 5, 5 ] ), Transformation( [ 3, 5, 2, 1, 3 ] ),
  Transformation( [ 3, 5, 2, 2, 3 ] ), Transformation( [ 3, 5, 2, 4, 2 ] ), Transformation( [ 3, 5, 2, 4, 4 ] ),
  Transformation( [ 3, 5, 3, 1, 4 ] ), Transformation( [ 3, 5, 3, 1, 5 ] ), Transformation( [ 3, 5, 3, 2, 4 ] ),
  Transformation( [ 3, 5, 3, 5, 4 ] ), Transformation( [ 3, 5, 4, 2, 3 ] ), Transformation( [ 3, 5, 4, 3, 1 ] ),
  Transformation( [ 3, 5, 4, 3, 2 ] ), Transformation( [ 3, 5, 4, 4, 5 ] ), Transformation( [ 3, 5, 5, 1, 1 ] ),
  Transformation( [ 3, 5, 5, 1, 2 ] ), Transformation( [ 3, 5, 5, 2, 3 ] ), Transformation( [ 3, 5, 5, 3, 3 ] ),
  Transformation( [ 3, 5, 5, 4, 2 ] ), Transformation( [ 3, 5, 5, 4, 5 ] ), Transformation( [ 4, 1, 1, 1, 3 ] ),
  Transformation( [ 4, 1, 1, 2, 4 ] ), Transformation( [ 4, 1, 1, 3, 2 ] ), Transformation( [ 4, 1, 1, 4, 3 ] ),
  Transformation( [ 4, 1, 1, 4, 4 ] ), Transformation( [ 4, 1, 1, 4 ] ), Transformation( [ 4, 1, 1, 5, 2 ] ), Transformation( [ 4, 1, 2, 2, 2 ] ),
  Transformation( [ 4, 1, 2, 3, 2 ] ), Transformation( [ 4, 1, 2, 3, 3 ] ), Transformation( [ 4, 1, 2, 4, 4 ] ), Transformation( [ 4, 1, 2, 4 ] ),
  Transformation( [ 4, 1, 2, 5, 1 ] ), Transformation( [ 4, 1, 2, 5, 5 ] ), Transformation( [ 4, 1, 3, 2, 3 ] ), Transformation( [ 4, 1, 3, 2 ] ),
  Transformation( [ 4, 1, 3, 3, 3 ] ), Transformation( [ 4, 1, 3, 4, 1 ] ), Transformation( [ 4, 1, 3, 4, 3 ] ),
  Transformation( [ 4, 1, 3, 5, 5 ] ), Transformation( [ 4, 1, 4, 2, 1 ] ), Transformation( [ 4, 1, 4, 2, 4 ] ),
  Transformation( [ 4, 1, 4, 3, 3 ] ), Transformation( [ 4, 1, 4, 3 ] ), Transformation( [ 4, 1, 4, 4, 3 ] ), Transformation( [ 4, 1, 4, 4 ] ),
  Transformation( [ 4, 1, 4, 5, 3 ] ), Transformation( [ 4, 1, 4, 5, 4 ] ), Transformation( [ 4, 1, 5, 1, 2 ] ),
  Transformation( [ 4, 1, 5, 1, 4 ] ), Transformation( [ 4, 1, 5, 1, 5 ] ), Transformation( [ 4, 1, 5, 2, 2 ] ),
  Transformation( [ 4, 1, 5, 2, 5 ] ), Transformation( [ 4, 1, 5, 3, 1 ] ), Transformation( [ 4, 1, 5, 3, 4 ] ),
  Transformation( [ 4, 2, 1, 1, 3 ] ), Transformation( [ 4, 2, 1, 1, 4 ] ), Transformation( [ 4, 2, 1, 3, 4 ] ),
  Transformation( [ 4, 2, 1, 4, 2 ] ), Transformation( [ 4, 2, 1, 5, 4 ] ), Transformation( [ 4, 2, 2, 2, 4 ] ),
  Transformation( [ 4, 2, 2, 3, 2 ] ), Transformation( [ 4, 2, 2, 3 ] ), Transformation( [ 4, 2, 2, 4, 3 ] ), Transformation( [ 4, 2, 2, 5, 2 ] ),
  Transformation( [ 4, 2, 3, 1, 3 ] ), Transformation( [ 4, 2, 3, 1, 4 ] ), Transformation( [ 4, 2, 3, 1 ] ), Transformation( [ 4, 2, 4, 1, 3 ] ),
  Transformation( [ 4, 2, 4, 2, 1 ] ), Transformation( [ 4, 2, 4, 3, 1 ] ), Transformation( [ 4, 2, 4, 4, 2 ] ),
  Transformation( [ 4, 2, 4, 4, 3 ] ), Transformation( [ 4, 2, 4, 4, 4 ] ), Transformation( [ 4, 2, 5, 1, 2 ] ),
  Transformation( [ 4, 2, 5, 1, 5 ] ), Transformation( [ 4, 2, 5, 2, 3 ] ), Transformation( [ 4, 2, 5, 2, 4 ] ),
  Transformation( [ 4, 2, 5, 3, 4 ] ), Transformation( [ 4, 2, 5, 4, 3 ] ), Transformation( [ 4, 2, 5, 4, 5 ] ),
  Transformation( [ 4, 2, 5, 5, 2 ] ), Transformation( [ 4, 2, 5, 5, 3 ] ), Transformation( [ 4, 2, 5, 5, 4 ] ),
  Transformation( [ 4, 3, 1, 1, 2 ] ), Transformation( [ 4, 3, 1, 1, 4 ] ), Transformation( [ 4, 3, 1, 1 ] ), Transformation( [ 4, 3, 1, 2, 2 ] ),
  Transformation( [ 4, 3, 1, 3, 4 ] ), Transformation( [ 4, 3, 1, 5, 3 ] ), Transformation( [ 4, 3, 2, 1, 1 ] ),
  Transformation( [ 4, 3, 2, 1, 3 ] ), Transformation( [ 4, 3, 2, 2, 3 ] ), Transformation( [ 4, 3, 2, 3, 2 ] ),
  Transformation( [ 4, 3, 2, 4, 1 ] ), Transformation( [ 4, 3, 2, 4, 3 ] ), Transformation( [ 4, 3, 2, 5, 2 ] ),
  Transformation( [ 4, 3, 3, 1, 4 ] ), Transformation( [ 4, 3, 3, 1 ] ), Transformation( [ 4, 3, 3, 2, 2 ] ), Transformation( [ 4, 3, 3, 3, 4 ] ),
  Transformation( [ 4, 3, 3, 4, 4 ] ), Transformation( [ 4, 3, 3, 5, 3 ] ), Transformation( [ 4, 3, 4, 1, 4 ] ),
  Transformation( [ 4, 3, 4, 2, 3 ] ), Transformation( [ 4, 3, 4, 3, 1 ] ), Transformation( [ 4, 3, 4, 3, 2 ] ),
  Transformation( [ 4, 3, 4, 3, 4 ] ), Transformation( [ 4, 3, 4, 4, 2 ] ), Transformation( [ 4, 3, 4, 5, 2 ] ),
  Transformation( [ 4, 3, 4, 5, 3 ] ), Transformation( [ 4, 3, 4, 5, 5 ] ), Transformation( [ 4, 3, 5, 1, 3 ] ),
  Transformation( [ 4, 3, 5, 2, 1 ] ), Transformation( [ 4, 3, 5, 2, 2 ] ), Transformation( [ 4, 3, 5, 3, 4 ] ),
  Transformation( [ 4, 3, 5, 4, 1 ] ), Transformation( [ 4, 3, 5, 4, 4 ] ), Transformation( [ 4, 3, 5, 5, 4 ] ),
  Transformation( [ 4, 4, 1, 1, 1 ] ), Transformation( [ 4, 4, 1, 1, 3 ] ), Transformation( [ 4, 4, 1, 1, 4 ] ),
  Transformation( [ 4, 4, 1, 2, 3 ] ), Transformation( [ 4, 4, 1, 2, 4 ] ), Transformation( [ 4, 4, 1, 2 ] ), Transformation( [ 4, 4, 1, 3, 4 ] ),
  Transformation( [ 4, 4, 1, 5, 1 ] ), Transformation( [ 4, 4, 1, 5, 2 ] ), Transformation( [ 4, 4, 1, 5, 4 ] ),
  Transformation( [ 4, 4, 2, 1, 2 ] ), Transformation( [ 4, 4, 2, 2, 2 ] ), Transformation( [ 4, 4, 2, 2, 3 ] ),
  Transformation( [ 4, 4, 2, 3, 4 ] ), Transformation( [ 4, 4, 2, 4, 1 ] ), Transformation( [ 4, 4, 2, 4, 4 ] ), Transformation( [ 4, 4, 2, 4 ] ),
  Transformation( [ 4, 4, 2, 5, 2 ] ), Transformation( [ 4, 4, 3, 1, 3 ] ), Transformation( [ 4, 4, 3, 3, 3 ] ),
  Transformation( [ 4, 4, 3, 5, 1 ] ), Transformation( [ 4, 4, 3, 5, 5 ] ), Transformation( [ 4, 4, 4, 1, 2 ] ),
  Transformation( [ 4, 4, 4, 2, 3 ] ), Transformation( [ 4, 4, 4, 2 ] ), Transformation( [ 4, 4, 4, 3, 2 ] ), Transformation( [ 4, 4, 4, 3 ] ),
  Transformation( [ 4, 4, 4, 4, 1 ] ), Transformation( [ 4, 4, 4, 5, 5 ] ), Transformation( [ 4, 4, 5, 1, 5 ] ),
  Transformation( [ 4, 4, 5, 2, 4 ] ), Transformation( [ 4, 4, 5, 4, 1 ] ), Transformation( [ 4, 4, 5, 5, 1 ] ),
  Transformation( [ 4, 4, 5, 5, 2 ] ), Transformation( [ 4, 4, 5, 5, 4 ] ), Transformation( [ 4, 5, 1, 1, 2 ] ),
  Transformation( [ 4, 5, 1, 1, 5 ] ), Transformation( [ 4, 5, 1, 2, 2 ] ), Transformation( [ 4, 5, 1, 2, 3 ] ),
  Transformation( [ 4, 5, 1, 3, 2 ] ), Transformation( [ 4, 5, 1, 4, 4 ] ), Transformation( [ 4, 5, 1, 4, 5 ] ),
  Transformation( [ 4, 5, 1, 5, 3 ] ), Transformation( [ 4, 5, 2, 1, 1 ] ), Transformation( [ 4, 5, 2, 1, 2 ] ),
  Transformation( [ 4, 5, 2, 1, 5 ] ), Transformation( [ 4, 5, 2, 2, 1 ] ), Transformation( [ 4, 5, 2, 2, 3 ] ),
  Transformation( [ 4, 5, 2, 2, 4 ] ), Transformation( [ 4, 5, 2, 2, 5 ] ), Transformation( [ 4, 5, 2, 3, 2 ] ),
  Transformation( [ 4, 5, 2, 3, 3 ] ), Transformation( [ 4, 5, 2, 4, 1 ] ), Transformation( [ 4, 5, 2, 4, 3 ] ),
  Transformation( [ 4, 5, 3, 1, 2 ] ), Transformation( [ 4, 5, 3, 1, 3 ] ), Transformation( [ 4, 5, 3, 1, 4 ] ),
  Transformation( [ 4, 5, 3, 2, 1 ] ), Transformation( [ 4, 5, 3, 2, 2 ] ), Transformation( [ 4, 5, 3, 3, 1 ] ),
  Transformation( [ 4, 5, 3, 4, 1 ] ), Transformation( [ 4, 5, 3, 4, 3 ] ), Transformation( [ 4, 5, 3, 5, 2 ] ),
  Transformation( [ 4, 5, 3, 5, 3 ] ), Transformation( [ 4, 5, 3, 5, 5 ] ), Transformation( [ 4, 5, 4, 1, 1 ] ),
  Transformation( [ 4, 5, 4, 1, 4 ] ), Transformation( [ 4, 5, 4, 2, 1 ] ), Transformation( [ 4, 5, 4, 2, 3 ] ),
  Transformation( [ 4, 5, 4, 3, 1 ] ), Transformation( [ 4, 5, 4, 3, 4 ] ), Transformation( [ 4, 5, 4, 4, 1 ] ),
  Transformation( [ 4, 5, 4, 4, 4 ] ), Transformation( [ 4, 5, 4, 4, 5 ] ), Transformation( [ 4, 5, 4, 5, 2 ] ),
  Transformation( [ 4, 5, 5, 1, 2 ] ), Transformation( [ 4, 5, 5, 1, 4 ] ), Transformation( [ 4, 5, 5, 2, 3 ] ),
  Transformation( [ 4, 5, 5, 3, 2 ] ), Transformation( [ 4, 5, 5, 3, 3 ] ), Transformation( [ 4, 5, 5, 4, 5 ] ),
  Transformation( [ 5, 1, 1, 2, 1 ] ), Transformation( [ 5, 1, 1, 2, 2 ] ), Transformation( [ 5, 1, 1, 3, 3 ] ),
  Transformation( [ 5, 1, 1, 5, 2 ] ), Transformation( [ 5, 1, 1, 5, 3 ] ), Transformation( [ 5, 1, 2, 1, 3 ] ),
  Transformation( [ 5, 1, 2, 1, 5 ] ), Transformation( [ 5, 1, 2, 2, 3 ] ), Transformation( [ 5, 1, 2, 2, 5 ] ),
  Transformation( [ 5, 1, 2, 3, 1 ] ), Transformation( [ 5, 1, 2, 4, 1 ] ), Transformation( [ 5, 1, 2, 4, 2 ] ),
  Transformation( [ 5, 1, 3, 1, 5 ] ), Transformation( [ 5, 1, 3, 2, 2 ] ), Transformation( [ 5, 1, 3, 2, 4 ] ),
  Transformation( [ 5, 1, 3, 2, 5 ] ), Transformation( [ 5, 1, 3, 3, 1 ] ), Transformation( [ 5, 1, 3, 4, 3 ] ),
  Transformation( [ 5, 1, 3, 4, 5 ] ), Transformation( [ 5, 1, 3, 5, 2 ] ), Transformation( [ 5, 1, 3, 5, 5 ] ),
  Transformation( [ 5, 1, 4, 1, 1 ] ), Transformation( [ 5, 1, 4, 1, 2 ] ), Transformation( [ 5, 1, 4, 2, 4 ] ),
  Transformation( [ 5, 1, 4, 3, 2 ] ), Transformation( [ 5, 1, 4, 3, 3 ] ), Transformation( [ 5, 1, 4, 4, 1 ] ),
  Transformation( [ 5, 1, 4, 5, 1 ] ), Transformation( [ 5, 1, 4, 5, 2 ] ), Transformation( [ 5, 1, 4, 5, 5 ] ),
  Transformation( [ 5, 1, 5, 1, 1 ] ), Transformation( [ 5, 1, 5, 1, 2 ] ), Transformation( [ 5, 1, 5, 2, 2 ] ),
  Transformation( [ 5, 1, 5, 4, 4 ] ), Transformation( [ 5, 1, 5, 5, 3 ] ), Transformation( [ 5, 1, 5, 5, 5 ] ),
  Transformation( [ 5, 2, 1, 1, 4 ] ), Transformation( [ 5, 2, 1, 2, 3 ] ), Transformation( [ 5, 2, 1, 3, 1 ] ),
  Transformation( [ 5, 2, 1, 3, 2 ] ), Transformation( [ 5, 2, 1, 3, 3 ] ), Transformation( [ 5, 2, 1, 3, 5 ] ),
  Transformation( [ 5, 2, 1, 4, 2 ] ), Transformation( [ 5, 2, 1, 4, 5 ] ), Transformation( [ 5, 2, 1, 5, 4 ] ),
  Transformation( [ 5, 2, 2, 1, 3 ] ), Transformation( [ 5, 2, 2, 3, 3 ] ), Transformation( [ 5, 2, 2, 4, 1 ] ),
  Transformation( [ 5, 2, 2, 4, 4 ] ), Transformation( [ 5, 2, 2, 4, 5 ] ), Transformation( [ 5, 2, 2, 5, 2 ] ),
  Transformation( [ 5, 2, 3, 3, 4 ] ), Transformation( [ 5, 2, 3, 4, 2 ] ), Transformation( [ 5, 2, 3, 5, 1 ] ),
  Transformation( [ 5, 2, 3, 5, 4 ] ), Transformation( [ 5, 2, 4, 1, 2 ] ), Transformation( [ 5, 2, 4, 1, 4 ] ),
  Transformation( [ 5, 2, 4, 2, 4 ] ), Transformation( [ 5, 2, 4, 3, 2 ] ), Transformation( [ 5, 2, 4, 3, 3 ] ),
  Transformation( [ 5, 2, 4, 3, 4 ] ), Transformation( [ 5, 2, 4, 3, 5 ] ), Transformation( [ 5, 2, 4, 4, 3 ] ),
  Transformation( [ 5, 2, 4, 4, 4 ] ), Transformation( [ 5, 2, 4, 5, 1 ] ), Transformation( [ 5, 2, 4, 5, 5 ] ),
  Transformation( [ 5, 2, 5, 2, 3 ] ), Transformation( [ 5, 2, 5, 3, 1 ] ), Transformation( [ 5, 3, 1, 2, 2 ] ),
  Transformation( [ 5, 3, 1, 2, 3 ] ), Transformation( [ 5, 3, 1, 3, 5 ] ), Transformation( [ 5, 3, 1, 5, 4 ] ),
  Transformation( [ 5, 3, 1, 5, 5 ] ), Transformation( [ 5, 3, 2, 1, 1 ] ), Transformation( [ 5, 3, 2, 2, 1 ] ),
  Transformation( [ 5, 3, 2, 5, 1 ] ), Transformation( [ 5, 3, 3, 1, 3 ] ), Transformation( [ 5, 3, 3, 2, 4 ] ),
  Transformation( [ 5, 3, 3, 2, 5 ] ), Transformation( [ 5, 3, 3, 3, 1 ] ), Transformation( [ 5, 3, 3, 3, 5 ] ),
  Transformation( [ 5, 3, 3, 4, 2 ] ), Transformation( [ 5, 3, 3, 4, 3 ] ), Transformation( [ 5, 3, 3, 5, 3 ] ),
  Transformation( [ 5, 3, 3, 5, 4 ] ), Transformation( [ 5, 3, 4, 1, 4 ] ), Transformation( [ 5, 3, 4, 1, 5 ] ),
  Transformation( [ 5, 3, 4, 2, 1 ] ), Transformation( [ 5, 3, 4, 3, 1 ] ), Transformation( [ 5, 3, 4, 3, 2 ] ),
  Transformation( [ 5, 3, 4, 5, 1 ] ), Transformation( [ 5, 3, 5, 1, 5 ] ), Transformation( [ 5, 3, 5, 2, 2 ] ),
  Transformation( [ 5, 3, 5, 5, 1 ] ), Transformation( [ 5, 4, 1, 1, 5 ] ), Transformation( [ 5, 4, 1, 2, 2 ] ),
  Transformation( [ 5, 4, 1, 3, 2 ] ), Transformation( [ 5, 4, 1, 3, 4 ] ), Transformation( [ 5, 4, 1, 4, 1 ] ),
  Transformation( [ 5, 4, 1, 5, 3 ] ), Transformation( [ 5, 4, 1, 5, 4 ] ), Transformation( [ 5, 4, 2, 1, 4 ] ),
  Transformation( [ 5, 4, 2, 1, 5 ] ), Transformation( [ 5, 4, 2, 2, 2 ] ), Transformation( [ 5, 4, 2, 2, 3 ] ),
  Transformation( [ 5, 4, 2, 2, 4 ] ), Transformation( [ 5, 4, 2, 3, 1 ] ), Transformation( [ 5, 4, 2, 4, 1 ] ),
  Transformation( [ 5, 4, 2, 5, 2 ] ), Transformation( [ 5, 4, 3, 1, 5 ] ), Transformation( [ 5, 4, 3, 2, 1 ] ),
  Transformation( [ 5, 4, 3, 2, 2 ] ), Transformation( [ 5, 4, 3, 3, 4 ] ), Transformation( [ 5, 4, 3, 4, 4 ] ),
  Transformation( [ 5, 4, 3, 5, 2 ] ), Transformation( [ 5, 4, 3, 5, 3 ] ), Transformation( [ 5, 4, 3, 5, 4 ] ),
  Transformation( [ 5, 4, 4, 3, 1 ] ), Transformation( [ 5, 4, 4, 4, 3 ] ), Transformation( [ 5, 4, 4, 4, 4 ] ),
  Transformation( [ 5, 4, 4, 4, 5 ] ), Transformation( [ 5, 4, 4, 5, 5 ] ), Transformation( [ 5, 4, 5, 1, 4 ] ),
  Transformation( [ 5, 4, 5, 2, 1 ] ), Transformation( [ 5, 4, 5, 3, 2 ] ), Transformation( [ 5, 4, 5, 3, 5 ] ),
  Transformation( [ 5, 4, 5, 5, 2 ] ), Transformation( [ 5, 4, 5, 5, 5 ] ), Transformation( [ 5, 5, 1, 1, 5 ] ),
  Transformation( [ 5, 5, 1, 2, 1 ] ), Transformation( [ 5, 5, 1, 2, 2 ] ), Transformation( [ 5, 5, 1, 3, 4 ] ),
  Transformation( [ 5, 5, 1, 4, 4 ] ), Transformation( [ 5, 5, 1, 5, 1 ] ), Transformation( [ 5, 5, 1, 5, 5 ] ),
  Transformation( [ 5, 5, 2, 1, 2 ] ), Transformation( [ 5, 5, 2, 2, 1 ] ), Transformation( [ 5, 5, 2, 3, 3 ] ),
  Transformation( [ 5, 5, 2, 4, 2 ] ), Transformation( [ 5, 5, 2, 4, 4 ] ), Transformation( [ 5, 5, 2, 5, 2 ] ),
  Transformation( [ 5, 5, 2, 5, 3 ] ), Transformation( [ 5, 5, 2, 5, 5 ] ), Transformation( [ 5, 5, 3, 1, 3 ] ),
  Transformation( [ 5, 5, 3, 2, 3 ] ), Transformation( [ 5, 5, 3, 3, 5 ] ), Transformation( [ 5, 5, 4, 1, 1 ] ),
  Transformation( [ 5, 5, 4, 1, 4 ] ), Transformation( [ 5, 5, 4, 2, 2 ] ), Transformation( [ 5, 5, 4, 2, 5 ] ),
  Transformation( [ 5, 5, 4, 3, 1 ] ), Transformation( [ 5, 5, 4, 3, 3 ] ), Transformation( [ 5, 5, 4, 4, 5 ] ),
  Transformation( [ 5, 5, 4, 5, 3 ] ), Transformation( [ 5, 5, 5, 1, 2 ] ), Transformation( [ 5, 5, 5, 2, 4 ] ),
  Transformation( [ 5, 5, 5, 5, 2 ] ), Transformation( [ 5, 5, 5, 5, 5 ] ) ];;
```

### Reason

Size: 3125

Small input with a lot of generators in comparison to the size of the group (g is size 871).

## 4

```
g := [ IdentityTransformation, Transformation( [ 2, 3, 4, 5, 6, 1 ] ), Transformation( [ 2, 1 ] ), Transformation( [ 1, 2, 3, 4, 5, 1 ] ) ];;
```

### Reason

Size: 46656

Large semigroup with few generators.

## 5

```
g := [ Transformation( [ 1, 7, 5, 2, 2, 1, 6, 6 ] ), Transformation( [ 3, 2, 2, 5, 1, 6, 5 ] ), Transformation( [ 3, 2, 5, 2, 8, 4, 2, 1 ] ),
  Transformation( [ 3, 3, 7, 1, 5, 2, 3, 3 ] ), Transformation( [ 5, 7, 6, 2, 3, 8, 8, 3 ] ), Transformation( [ 5, 8, 8, 4, 3, 7, 3, 1 ] ),
  Transformation( [ 6, 6, 3, 3, 5, 4, 5, 4 ] ), Transformation( [ 8, 8, 7, 2, 3, 7, 8, 6 ] ) ];;
```

### Reason

Size: 294691

Larger semigroup that can be used to establish scalability.

## 6

```
g := [ Transformation( [ 6, 7, 11, 8, 3, 8, 4, 6, 6, 9, 14, 10, 2, 5 ] ), Transformation( [ 9, 6, 12, 10, 12, 3, 5, 1, 5, 1, 12, 5, 5, 13 ] ) ];;
```

### Reason

Size: 124386

Large semigroup with few generators and expensive multiplications.
