_CreateResults := function(u)
  return NewDictionary(u, true);
end;

_Get := function(ds, value)
  return LookupDictionary(ds, value);
end;

_Add := function(ds, key, value)
  AddDictionary(ds, key, value);
end;

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

_InitialiseFirstValue := function(generators, u, k, results, last)
  local l, #temporary look up variable
        i; #temporary loop variable
  for i in [1 .. k] do

    l := _Get(results, generators[i]);

    if l = fail then

      last.next := _NewDataStructure(generators[i], i, i, u, u, fail, k, 1);
      last := last.next;
      u.prefixUA[i] := last;
      u.prefixUAFlag[i] := true;
      u.prefixAU[i] := last;

      _Add(results, generators[i], last);

    else
      u.prefixUA[i] := 1;
      u.prefixUAFlag[i] := false;
    fi;

  od;

end;

_Update := function(generators, i, u, results, last, k)
  local l, b, s, r, c, t, #temporary variables used in loops defined by paper
        v_ua; #temporary product of multiplication v(ua)
  b := u.first;
  s := u.suffix;
  #This part effectively forms the "update" part
  if s.prefixUAFlag[i] = false then #not reduced
    r := s.prefixUA[i];
    if r.length = 0 then #if r is the empty word
      s.prefixUA[i] := b;
    else
      c := r.last;
      t := r.prefixUA[i];
      #p(p(bt)c)
      s.prefixUA[i] := t.prefixAU[b].prefixUA[c];
    fi;
  else #if it is already reduced
    v_ua := u.value * generators[i];
    l := _Get(results, v_ua); #Look up in our results to see if it exist
    if l <> fail then
      u.prefixUA[i] := l;
      u.prefixUAFlag[i] := false;
    else #if l = fail
      last.next := _NewDataStructure(v_ua, b, i, u, s.prefixUA[i], fail, k, u.length + 1);
      u.prefixUA[i] := last.next;
      u.prefixUAFlag[i] := true;
      _Add(results, v_ua, last.next);
      last := last.next;
    fi;
  fi;
end;

InstallGlobalFunction(FroidurePin, function(generators)
  local u, #current element in our universe
        v, # holder for the first element we compute
        last, #The final elemement in our list of generators
        currentLength, #the current length of ??
        k, #the number of generators we have received
        i, p, #temporary variables used in loops defined by paper
        results;

  #Initialisation
  k := Length(generators);
  #Special case first entry
  u := _NewDataStructure(generators[1], 0, 0, fail, fail, fail, k, 1);
  last := u;
  currentLength := 1;
  results := _CreateResults(u);

  #Add values in generator to results
  _InitialiseFirstValue(generators, u, k, results, last);
  u := _Get(results, generators[1]);
  v := u;

  repeat
    #In this part we compute ua_i
    while u <> fail and (u.length = currentLength) do
      for i in [1 .. k] do
        _Update(generators, i, u, results, last, k);
      od;
      u := u.next;
    od;

    u := v;
    while u <> fail and (u.length = currentLength) do
      p := u.prefix;

      for i in [1 .. k] do
        u.prefixAU[i] := p.prefixAU[i].prefixUA[u.last];
      od;

      u := u.next;
    od;

    v := u;
    currentLength := currentLength + 1;
  until u = last or u = fail;

  return results;
end);
