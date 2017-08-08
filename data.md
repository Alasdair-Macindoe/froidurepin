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
