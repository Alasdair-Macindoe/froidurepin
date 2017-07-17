# For this implementation we consider the simplest implementation
# We repeatedly multiply each element in our generators list
# By every result of its multiplications (which includes itself)
# eg for [0, 1, 2] mod 3 we have 0 x 0, 0 x 1, 0 x 2 etc.
NaiveSemiGroupEnumeration := function(generators)
  #Temp_res is used during multiplications,
  #a and g are loop indexes.
  local results, temp_res, a, g;

  # Results holds all of our multiplications. To begin with
  # This has to include the generators themselves.
  results := StructuralCopy(generators);

  for a in results do
    for g in generators do
      temp_res := a * g;
      if not temp_res in results then
        Add(results, temp_res);
      fi;
    od;
  od;

  return results;
end;
