gap> START_TEST("FroidurePin implementions test");
gap> LoadPackage("froidurepin", false);;
gap> Read("test_data.g");;
gap> g_0 = [ Transformation( [ 2, 4, 2, 5, 5 ] ), Transformation( [ 3, 5, 4, 2, 3 ] ), Transformation( [ 4, 3, 2, 4, 4 ] ) ];
true
gap> r := FroidurePin(g_0);;
gap> Size(r);
164
gap> r := FroidurePin(g_1);;
gap> Size(r);
287
gap> r := FroidurePin(g_2);;
gap> Size(r);
3
gap> r := FroidurePin(g_3);;
gap> Size(r);
2
gap> r := FroidurePin(g_4);;
gap> Size(r);
14
gap> r := FroidurePin(g_5);;
gap> Size(r);
27
gap> r := FroidurePin(g_6);;
gap> Size(r);
256
gap> r := FroidurePin(g_7);;
gap> Size(r);
66
gap> r := FroidurePin(g_8);;
gap> Size(r);
77
gap> r := FroidurePin(g_9);;
gap> Size(r);
3125
gap> r := FroidurePin(g_10);;
gap> Size(r);
77
gap> r := FroidurePin(g_11);;
gap> Size(r);
287
gap> r := FroidurePin(g_12);;
gap> Size(r);
3
gap> STOP_TEST("FroidurePin implementations test");
