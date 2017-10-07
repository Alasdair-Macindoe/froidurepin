# Immutable arrays
This demonstrates how MakeImmutable() works on 2-D lists.
The inner lists share the same region as the outer list.

```
gap> a := [ [0,1], [2, 3] ];;
gap> RegionOf(a);
<region: thread region #0>
gap> MakeImmutable(a);;
gap> RegionOf(a);
<region: public region>
gap> RegionOf(a[1]);
<region: public region>
gap> RegionOf(a[1][1]);
<region: public region>
gap> a[1] := [4, 5];
Error, Lists Assignment: <list> must be a mutable list
you can 'return;' and ignore the assignment
not in any function at stream:10
brk> quit;
gap> a;
[ [ 0, 1 ], [ 2, 3 ] ]
gap> a[1][1] := 4;
Error, Lists Assignment: <list> must be a mutable list
you can 'return;' and ignore the assignment
not in any function at stream:11
```
# Non-public arrays

Given the following file:

```
a := [ [0,1], [2, 3]];

fnc1 := function(b)
  return RegionOf(b);
end;

Print("For a: ", fnc1(a), "\n");
Print("For a[1]: ", fnc1(a[1]), "\n");
Print("For a[1][1]", fnc1(a[1][1]), "\n");
```

The output is:

```
For a: <region: thread region #0>
For a[1]: <region: thread region #0>
For a[1][1]<region: public region>
```

The interesting part here being that `a[1][1]` is public, yet the arrays themselves are specific to a thread.  
