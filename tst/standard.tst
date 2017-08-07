gap> START_TEST("FroidurePin implementions test");
gap> LoadPackage("froidurepin", false);;
gap> g := [ Transformation( [ 2, 4, 2, 5, 5 ] ), Transformation( [ 3, 5, 4, 2, 3 ] ), Transformation( [ 4, 3, 2, 4, 4 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
164
gap> g := [ Transformation( [ 1, 4, 5, 5, 5 ] ), Transformation( [ 2, 4, 1, 4, 2 ] ), Transformation( [ 4, 3, 5, 1, 5 ] ),  Transformation( [ 5, 4, 4, 3, 1 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
287
gap> g := [ Transformation( [ 1, 1, 6, 2, 5, 5 ] ), Transformation( [ 2, 5, 3, 2, 2, 2 ] ), Transformation( [ 3, 3, 3, 1, 3, 4 ] ), Transformation( [ 4, 3, 6, 3, 5, 3 ] ), Transformation( [ 6, 2, 3, 3, 3, 5 ] ), Transformation( [ 6, 3, 1, 6, 5, 2 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
5418
gap> g := [ Transformation( [ 4, 2, 4, 6, 6, 3 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
3
gap> g := [ Transformation( [ 1, 1 ] ), Transformation( [ 2, 2 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
2
gap> g := [ Transformation( [ 3, 11, 18, 9, 46, 16, 2, 42, 37, 1, 16, 32, 38, 47, 29, 21, 24, 44, 16, 26, 28, 5, 8, 24, 36, 28, 9, 15, 7, 16, 45, 19, 11, 1, 17, 23, 44, 18, 2, 14, 49, 6, 38, 29, 9, 32, 3, 14, 34, 32 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
14
gap> g := [ Transformation( [ 1, 1, 1 ] ), Transformation( [ 1, 1 ] ), Transformation( [ 1, 2, 1 ] ), Transformation( [ 1, 3, 1 ] ), Transformation( [ 2, 1, 1 ] ), Transformation( [ 2, 1, 2 ] ), Transformation( [ 2, 3, 1 ] ), Transformation( [ 2, 3, 3 ] ), Transformation( [ 3, 1, 3 ] ), Transformation( [ 3, 2, 1 ] ), Transformation( [ 3, 2, 2 ] ), Transformation( [ 3, 3, 1 ] ), Transformation( [ 3, 3, 2 ] ), Transformation( [ 3, 3, 3 ] ) ];;
gap> r := FroidurePin_NO_MULTIPROCESSING(g);;
gap> Size(r);
27
gap> STOP_TEST("FroidurePin implementations test");
