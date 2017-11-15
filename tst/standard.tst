gap> START_TEST("FroidurePin implementions test");
gap> LoadPackage("froidurepin", false);;
gap> g := [ Transformation( [ 2, 4, 2, 5, 5 ] ), Transformation( [ 3, 5, 4, 2, 3 ] ), Transformation( [ 4, 3, 2, 4, 4 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
164
gap> g := [ Transformation( [ 1, 4, 5, 5, 5 ] ), Transformation( [ 2, 4, 1, 4, 2 ] ), Transformation( [ 4, 3, 5, 1, 5 ] ),  Transformation( [ 5, 4, 4, 3, 1 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
287
gap> g := [ Transformation( [ 4, 2, 4, 6, 6, 3 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
3
gap> g := [ Transformation( [ 1, 1 ] ), Transformation( [ 2, 2 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
2
gap> g := [ Transformation( [ 3, 11, 18, 9, 46, 16, 2, 42, 37, 1, 16, 32, 38, 47, 29, 21, 24, 44, 16, 26, 28, 5, 8, 24, 36, 28, 9, 15, 7, 16, 45, 19, 11, 1, 17, 23, 44, 18, 2, 14, 49, 6, 38, 29, 9, 32, 3, 14, 34, 32 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
14
gap> g := [ Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1 ] ), Transformation( [ 1, 2, 1 ] ), Transformation( [ 1, 3, 1 ] ), Transformation( [ 2, 1, 1 ] ), Transformation( [ 2, 1, 2 ] ), Transformation( [ 2, 3, 1 ] ), Transformation( [ 2, 3, 3 ] ), Transformation( [ 3, 1, 3 ] ), Transformation( [ 3, 2, 1 ] ), Transformation( [ 3, 2, 2 ] ), Transformation( [ 3, 3, 1 ] ), Transformation( [ 3, 3, 2 ] ), Transformation( [ 3, 3, 3 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
27
gap> g := [ Transformation( [ 1, 1, 2, 1 ] ), Transformation( [ 1, 1, 3, 3 ] ), Transformation( [ 1, 1, 4, 4 ] ), Transformation( [ 1, 2, 2, 3 ] ), Transformation( [ 1, 3, 2, 1 ] ), Transformation( [ 1, 3, 4, 3 ] ), Transformation( [ 1, 4, 1, 2 ] ), Transformation( [ 1, 4, 4, 3 ] ), Transformation( [ 2, 1, 4, 1 ] ), Transformation( [ 2, 1, 4, 3 ] ), Transformation( [ 2, 1, 4, 4 ] ), Transformation( [ 2, 2, 2 ] ), Transformation( [ 2, 2, 3, 3 ] ), Transformation( [ 2, 3, 2 ] ), Transformation( [ 2, 3, 4, 2 ] ), Transformation( [ 2, 4, 1, 2 ] ), Transformation( [ 2, 4, 2, 1 ] ), Transformation( [ 2, 4, 2, 4 ] ), Transformation( [ 3, 1, 1, 3 ] ), Transformation( [ 3, 1, 2, 3 ] ), Transformation( [ 3, 2, 1, 1 ] ), Transformation( [ 3, 2, 2, 2 ] ), Transformation( [ 3, 2, 2, 3 ] ), Transformation( [ 3, 2, 4, 2 ] ), Transformation( [ 3, 2, 4, 3 ] ), Transformation( [ 3, 3, 1, 2 ] ), Transformation( [ 3, 3, 3, 3 ] ), Transformation( [ 3, 3, 3 ] ), Transformation( [ 3, 3, 4, 1 ] ), Transformation( [ 3, 4, 2, 1 ] ), Transformation( [ 3, 4, 2, 4 ] ), Transformation( [ 3, 4, 3, 2 ] ), Transformation( [ 3, 4, 3, 3 ] ), Transformation( [ 4, 1, 2, 1 ] ), Transformation( [ 4, 1, 2, 3 ] ), Transformation( [ 4, 1, 3, 2 ] ), Transformation( [ 4, 1, 4, 3 ] ), Transformation( [ 4, 2, 1, 1 ] ), Transformation( [ 4, 2, 1, 4 ] ), Transformation( [ 4, 2, 2, 4 ] ), Transformation( [ 4, 2, 3, 1 ] ), Transformation( [ 4, 3, 4, 1 ] ), Transformation( [ 4, 3, 4, 4 ] ), Transformation( [ 4, 4, 1, 2 ] ), Transformation( [ 4, 4, 2, 2 ] ), Transformation( [ 4, 4, 2, 3 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
256
gap> g := [ Transformation( [ 3, 3, 1 ] ), Transformation( [ 4, 1, 4, 1 ] ), Transformation( [ 4, 2, 2, 4 ] ), Transformation( [ 4, 4, 3, 2 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
66
gap> g := [ Transformation( [ 2, 2, 2, 7, 8, 5, 7, 7 ] ), Transformation( [ 2, 7, 7, 7, 8, 6, 6, 8 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
77
gap> g := [ IdentityTransformation, Transformation( [ 2, 3, 4, 5, 1 ] ), Transformation( [ 2, 1 ] ), Transformation( [ 1, 2, 3, 4, 1 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
3125
gap> g := [ Transformation( [ 2, 2, 2, 7, 8, 5, 7, 7 ] ), Transformation( [ 2, 7, 7, 7, 8, 6, 6, 8 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
77
gap> g := [ Transformation( [ 1, 4, 5, 5, 5 ] ), Transformation( [ 2, 4, 1, 4, 2 ] ), Transformation( [ 4, 3, 5, 1, 5 ] ),  Transformation( [ 5, 4, 4, 3, 1 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
287
gap> g := [ Transformation( [ 4, 2, 4, 6, 6, 3 ] ) ];;
gap> r := FroidurePin(g);;
gap> Size(r);
3
gap> STOP_TEST("FroidurePin implementations test");
