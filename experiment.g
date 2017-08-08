#Note: For ease this should be in the root directory of GAP
LoadPackage("froidurepin");;
g := [];;
for i in [1 .. 3] do
  start := Runtime();;
  #This below should be replaced with the version you are experimenting with
  r := FroidurePin(g);;
  finish := Runtime();;
  Print("Size of R: ", Size(r), "\n");
  Print("Time Taken: ", finish - start, "\n\n");
od;
