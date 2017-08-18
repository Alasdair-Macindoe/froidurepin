t := DirectoriesLibrary("pkg/froidurepin/tst");
t := Filename(t, "standard.tst");
f := InputTextString(StringFile(t));
r := Test(f);
Print(r, "\n");
