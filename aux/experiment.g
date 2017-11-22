#Note: For ease this should be in the root directory of GAP
LoadPackage("froidurepin");;
g := [];;
f := OutputTextFile("output.txt", true);;
for i in [1 .. 3] do
  start := Runtime();;
  #This below should be replaced with the version you are experimenting with
  r := FroidurePin(g);;
  finish := Runtime();;
  AppendTo(f, "Size of R: ", Size(r), "\n");;
  AppendTo(f, "Time Taken: ", finish - start, "\n\n");;
od;
Print("Done");
