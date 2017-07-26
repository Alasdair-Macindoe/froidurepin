###
# Data structure for the queue output by ApplyGenerators
###

_CreateQueue := function(buckets)
  local queue, i;
  queue := [];
  for i in [1 .. buckets] do
    Add(queue, []);
  od;
  return queue;
end;

_AddQueue := function(queue, bucket, value)
  Add(queue[bucket], value);
end;

###
# Data structure and methods for the output results
###
_CreateResults := function(u)
  return NewDictionary(u, true);
end;

_Get := function(ds, value)
  return LookupDictionary(ds, value);
end;

_Add := function(ds, key, value)
  AddDictionary(ds, key, value);
end;

###
# Data structure for the entry into the output results for each element
###
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


###
# Method required to add the generators to the data structure for the output
# Whilst this is not in the paper this is required for the algorthim to
# work programmatically.
###
_InitialiseFirstValue := function(generators, u, k, results, last)
  local l, #temporary look up variable
        temp_ds, #temporary data structure place holder
        i; #temporary loop variable

  for i in [1 .. k] do

    l := _Get(results, generators[i]);

    if l = fail then
      temp_ds := _NewDataStructure(generators[i], i, i, u.value, u.value, fail, k, 1);
      last.next := temp_ds.value;
      last := temp_ds;
      u.prefixUA[i] := last.value;
      u.prefixUAFlag[i] := true;
      u.prefixAU[i] := last.value;

      _Add(results, temp_ds.value, temp_ds);

    else
      u.prefixUA[i] := 1;
      u.prefixUAFlag[i] := false;
    fi;

  od;

end;


###
# This is the ApplyGenerators method as defined by the paper on concurrent
# FroidurePin. This is **incredibly** similar to Update in the non-concurrent
# version. It finds given all element of a specific length the result of that
# element multiplied by each generator and checks to see if it exists in the
# output data structure.
###
_ApplyGenerators := function(generators, i, u, results, last, k, queues)
  local l, b, s, r, c, t, #temporary variables used in loops defined by paper
        v_ua, #temporary product of multiplication v(ua)
        temp_ds, #temporary data structure to hold new values
        bw; #Bucket number for w

  b := u.first;
  s := _Get(results, u.suffix);
  bw := i; #This may be updated in the future

  if s.prefixUAFlag[i] = false then #not reduced
    r := s.prefixUA[i]; #find the right hand part eg for ua find u
    if r.length = 0 then #if r is the empty word
      s.prefixUA[i] := b;
    else #if not the empty word
      c := r.last;
      t := _Get(results, r.prefixUA[i]);
      #p(p(bt)c)
      s.prefixUA[i] := _Get(results, t.prefixAU[b]).prefixUA[c];
    fi;
  else #if it is already reduced
    v_ua := u.value * generators[i];
    l := _Get(results, v_ua); #Look up in our results to see if it exist
    if l <> fail then
      u.prefixUA[i] := l.value;
      u.prefixUAFlag[i] := false;
    else #if l = fail
      #Store the element in the last datastructure, but add the entire
      #datastrcture to the queue
      temp_ds := _NewDataStructure(v_ua, b, i, u.value, s.prefixUA[i], fail, k, u.length + 1);
      last.next := temp_ds.value;
      u.prefixUA[i] := last.next;
      u.prefixUAFlag[i] := true;
      _AddQueue(queues, bw, temp_ds);
      last := temp_ds;
    fi;
  fi;
end;

###
# This is the ProcessQueues part of the algorthim as defined by the paper
# on concurrent FroidurePin. It effectively loops through all the values
# that ApplyGenerators belives may be new and checks if they are actually new.
# If they are new then they get added to the output data structure, otherwise
# that data structure is updated to note a reduction
###
_ProcessQueues := function(queue, results, bw)
  local queue_length,
        i,
        l,
        v_wa;

  queue_length := Length(queue[bw]);
  for i in [1 .. queue_length] do
    v_wa := queue[bw][i];
    l := _Get(results, v_wa.value);

    if l <> fail then
      l.prefixUA[l.last] := v_wa.value;
      l.prefixUAFlag[l.last] := true;
    else
      _Add(results, v_wa.value, v_wa);
    fi;
  od;
end;

###
# Main entry point for the program
###
InstallGlobalFunction(FroidurePin, function(generators)
  local u, #current element in our universe
        v, # minimal element of currentLength
        last, #The final elemement in our list of generators
        currentLength, #the current length of ??
        k, #the number of generators we have received
        i, p, #temporary variables used in loops defined by paper
        results,
        queue; #queue after ApplyGenerators

  #Initialisation
  k := Length(generators);
  #This must have an appropriate amount of buckets to begin with
  queue := _CreateQueue(k);
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
        #Add to position i in our queue
        #This gives each index in the queue a list of values
        #ProcessQueues does care about the order at least if we want it done
        #concurrently
        _ApplyGenerators(generators, i, u, results, last, k, queue);
      od;
      u := _Get(results, u.next);
    od;

    for i in [1 .. k] do
      _ProcessQueues(queue, results, i);
    od;

    u := v;

    #For whatever reason this part isn't given a name in the paper,
    #I have decided to replicated that here.
    while u <> fail and (u.length = currentLength) do
      p := _Get(results, u.prefix);

      for i in [1 .. k] do
        u.prefixAU[i] := _Get(results, p.prefixAU[i]).prefixUA[u.last];
      od;

      u := _Get(results, u.next);
    od;

    v := u;
    currentLength := currentLength + 1;
  until u = last or u = fail;

  return results;
end);
