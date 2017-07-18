#Recall everyword is a produced by u * a = v
_NewDataStructure := function(v, f, l, p, s, n, k, len)
  return rec(
        value := v, #The value of this entry
        first := f, #the first letter of this word
        last := l, #the last letter of this word
        prefix := p, #the prefix of this word
        suffix := s, #the suffix of this word
        next := n, #the successor of this element
        prefixUA := [1 .. k] * 0, # the value of p(ua) for all a in generators
        prefixUAFlag := [1 .. k] * 0, #flags for reduced or not for above
        prefixAU := [1 .. k] * 0,
        prefixAUFlag := [1 .. k] * 0,
        length := len #length of u
        );
end;

InstallGlobalFunction(FullFroidurePin, function(generators)
  local u, #current element in our universe
        v, # holder for the first element we compute
        last, #The final elemement in our list of generators
        currentLength, #the current length of ??
        k, #the number of generators we have received
        b, s, i, r, c, t, p, l, #temporary variables used in loops defined by paper
        v_ua, #temporary variable v(ua_i)
        results;

  #Initialisation
  k := Length(generators);
  #Special case first entry
  u := _NewDataStructure(generators[1], 0, 0, fail, fail, fail, k, 1);
  v := u;
  last := generators[k];
  currentLength := 1;
  results := NewDictionary(u, true);
  AddDictionary(results, generators[1], u);

  repeat

    #In this part we compute ua_i
    while u.length = currentLength do
      b := u.first;
      s := u.suffix;

      for i in [1 .. k] do

        if s.prefixUAFlag[i] = false then
          r := s.prefixUA[i];

          if r.length = 0 then #if r is the empty word
            s.prefixUA[i] := b;
          else
            c := r.last;
            t := r.prefixUA[i];
            #p(p(bt)c)
            s.prefixUA[i] := t.prefixAU[b].prefixUA[c];
          fi;

        else
          v_ua := u.value * generators[i];
          l := LookupDictionary(results, v_ua); #Look up in our results to see if it exist

          if not l = fail then
            u.prefixUA[i] := l;
            u.prefixUAFlag[i] := false;
          else #if l = fail
            last.next := _NewDataStructure(v_ua, b, i, u, s.prefixUA[i], fail, k, u.length + 1);
            u.prefixUA[i] := last.next;
            u.prefixUAFlag[i] := true;
            AddDictionary(results, v_ua, last.next);
            last := last.next;
          fi;

        fi;

      od;

      u := u.next;
    od;

    u := v;

    while u.length = currentLength do
      p := u.prefix;

      for i in [1 .. k] do
        u.prefixAU[i] := p.prefixAU[i].prefixUA[u.last];
      od;

      u := u.next;
      currentLength := currentLength + 1;
    od;

  until u = last;

  return results;
end);
