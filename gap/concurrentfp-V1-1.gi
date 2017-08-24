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

_AddQueue := function(queue, value)
  Add(queue, value);
end;

###
# Data structure and methods for the output results
###
_CreateResults := function()
  return [];
end;

_Get := function(ds, value)
  local i;
  for i in [1 .. Length(ds)] do
    if value = ds[i].value then
      return ds[i];
    fi;
  od;
  return fail;
end;

_Find := function(ds, value)
  local i;
  for i in [1 .. Length(ds)] do
    if value = ds[i].value then
      return i;
    fi;
  od;
  return fail;
end;

_Add := function(ds, value)
  Add(ds, value);
end;

_Search := function(value, results, bucket)
  local l, i;
  l := _Get(results, value);
  if l <> fail then
    return l;
  fi;
  for i in [1 .. Length(bucket)] do
    if bucket[i] <> fail and bucket[i].value = value then
      return bucket[i];
    fi;
  od;
  return fail;
end;

###
# Data structure for the entry into the output results for each element
###
#Recall everyword is a produced by u * a = v
_NewResultsDataStructure := function(v, f, l, p, s, k, len)
  return MakeReadOnly(rec(
        value := v, #The value of this word, eg this word TODO: Can this be immutable?

        #First and last are integers referring to the generator
        first := f, #the first letter of this word
        last := l, #the last letter of this word

        #Prefix and Suffix are the words that produce this word
        #These are fail if it is produced by just a generator ie it is a generator
        #eg for f = a, and w = ua then p = u
        prefix := p, #the prefix of this word
        suffix := s, #the suffix of this word

        right := [1 .. k] * 0, # the value of p(ua) for all a in generators
        rightFlag := [1 .. k] * 0, #flags for reduced or not for above
        left := [1 .. k] * 0,
        length := len #length of u
        ));
end;

_DefaultDS := function(value, i, k)
  return _NewResultsDataStructure(value, i, i, value, fail , k, 1);
end;

_GetWord := function(YjKj, a)
  if YjKj.suffix = fail then
    return a * a;
  fi;
  return YjKj * a;
end;

#Generating set is traditionally refered to as A
_InitialiseResults := function(results, A, region)
  local i, args;
  args := Length(A);

  for i in [1 .. args] do
    _Add(results, _DefaultDS(A[i], i, args));
  od;

end;

###
# This is the ApplyGenerators method as defined by the paper on concurrent
# FroidurePin. This is **incredibly** similar to Update in the non-concurrent
# version. It finds given all element of a specific length the result of that
# element multiplied by each generator and checks to see if it exists in the
# output data structure.
###
_ApplyGenerators := atomic function(A, readonly Y, start, finish, readwrite queue, K, currentLength, j, region)
  local offset, currentWord, i, w, l, ds, b, s, r, y;
  #For all the words in our range
  for offset in [start + K .. finish] do
    currentWord := Y[offset];
    if currentWord.length - currentLength > 0 then
      return offset - start;
    fi;
    #for a in A
    for i in [1 .. Length(A)] do
      s := _Find(Y, currentWord.suffix);
      if s = fail then #s is the identity
        currentWord.right[i] := A[currentWord.first];
        currentWord.rightFlag[i] := true;
      else
        s := Y[s];
        if s.rightFlag[i] then #if is not reduced
          r := Y[_Find(Y, s.right[i])]; #We can get the right[i] value and then its prefix
          r := Y[_Find(Y, r.prefix)];
          y := r.left[currentWord.first];
          if y = fail or y = 0 then
            y := currentWord;
          else
            y := _Get(Y, y);
          fi;
          currentWord.right[i] := y.right[r.last];
          currentWord.rightFlag[i] := true;
          continue;
        fi;
      fi;

      w := currentWord.value * A[i];
      l := _Search(w, Y, queue);
      if l <> fail then #w = v(y) for some y
        currentWord.right[i] := l.value;
        currentWord.rightFlag[i] := true;
      else
        ds := _NewResultsDataStructure(w, currentWord.first, i, currentWord.value, A[i], Length(A), currentLength + 1);
        currentWord.right[i] := ds.value;
        currentWord.rightFlag[i] := false;
        _AddQueue(queue, ds);
      fi;
    od;
  od;
  return finish - start + 1;
end;

###
# This is the ProcessQueues part of the algorthim as defined by the paper
# on concurrent FroidurePin. It effectively loops through all the values
# that ApplyGenerators belives may be new and checks if they are actually new.
# If they are new then they get added to the output data structure, otherwise
# that data structure is updated to note a reduction
###
_ProcessQueues := atomic function(readonly queue, readwrite results)
  local i, #Loop index
        l, #temporary look up
        w, #if word = wa then this is the w part
        word; #Temporary word holder
  for i in [1..Length(queue)] do
    word := queue[i];
    l := _Get(results, word.value);
    if l <> fail then
      l.right[word.last] := word.value;
      l.rightFlag[word.last] := true;
    else
      _Add(results, word);
    fi;
  od;
  return 0;
end;

_DevelopLeft := atomic function(readonly Y, A, start, step)
  local offset, i, currentWord, p, r;
  #Iterate over a a range of results Y[start] to Y[finish]
  for offset in [start .. start + step] do
    currentWord := Y[offset];
    #for each a in A
    for i in [1 .. Length(A)] do
      if currentWord.prefix = fail or currentWord.prefix = 0 then #This is a generator value
        currentWord.left[i] := A[i];
      else
        p := _Get(Y, currentWord.prefix);
        if p.left[i] = 0 then
          p.left[i] := A[i] * p.value;
        fi;
        r := _Get(Y, p.left[i]);
        currentWord.left[i] := r.right[currentWord.last];
      fi;
    od;
  od;
  return 0;
end;

_CalcStep := function(len, start, jobs)
  local overflow;
  start := start - 1;
  overflow := (len - start) mod jobs;
  if overflow = 0 then
    return (len - start) / jobs;
  else
    return Int(Ceil(Float((len - start) / jobs)));
  fi;
end;
###
# Main entry point for the program
# This part assumes the minimal snapshot of (A, A, 1)
# Note: In this program we do not have a phi method. It is a parameter in the
# datastructure.
###
InstallGlobalFunction(FroidurePin_V1_1, function(generators)
  local K, #K refers to K_j from the paper, but this is the minimal entry, thus
           #is K := 1
        currentLength, #This is the currentLength of words we are computing,
                       #In this entry it is 1 since we only have generators.
        j, #This is a holder for the job number
        jobs, #This is the total number of jobs we can have
        added,
        task,
        r,
        queues, #This the holder for the output from ApplyGenerators
        results, #This is the holder of reduced words.
        MainRegion,
        step,
        lengthResults,
        start, finish; #These are the frontier of our search


  #Initialise data structures
  MainRegion := "MainSharedRegion";
  NewRegion(MainRegion);
  currentLength := 1; #Since we are starting with only generators
  K := 0; #The paper uses K = 1 but I think that is unintuitive
  MakeImmutable(generators);
  jobs := Length(generators);
  results := ShareObj(_CreateResults(), MainRegion); #Results is Y our set of reduced words
  start := 1;
  finish := Length(generators);
  _InitialiseResults(results, generators, MainRegion);
  repeat
    added := [];
    #We do this here to ensure the queues are emptied every loop
    queues := _CreateQueue(jobs); #For now assume that the number of queues is equal to the number of jobs
    ShareObj(queues, MainRegion);
    atomic readonly results do
      lengthResults := Length(results);
    od;

    step := _CalcStep(lengthResults, start, jobs);
    r := start - 1;
    for j in [1 .. jobs] do
      r := r + 1;
      if r + step > lengthResults then
        step := lengthResults - r;
      fi;
      atomic readonly queues do
        Add(added, RunTask(_ApplyGenerators, generators, results, r, r + step, queues[j], K, currentLength, j, MainRegion));
      od;
      r := r + step;
    od;

    #If we sum all the K values and that is less than our total length then we need to reloop
    K := 0;
    for j in [1 .. Length(added)] do
      r := TaskResult(added[j]);
      K := K + r;
    od;

    added := [];
    for j in [1 .. jobs] do
      atomic readonly queues do
        Add(added, RunTask(_ProcessQueues, queues[j], results));
      od;
    od;

    for j in [1 .. Length(added)] do
      TaskResult(added[j]);
    od;
    added := [];

    atomic readonly results do
      lengthResults := Length(results);
    od;

    step := _CalcStep(lengthResults, start, jobs);
    r := start - 1;
    for j in [1 .. jobs] do
      r := r + 1;
      if r + step > lengthResults then
        step := lengthResults - r;
      fi;
      Add(added, RunTask(_DevelopLeft, results, generators, start, step));
      r := r + step;
    od;

    for j in [1 .. Length(added)] do
      TaskResult(added[j]); #potential bug here?
    od;

    #Adjustments
    if K >= (finish - start + 1) then
      start := finish + 1;
    fi;
    K := 0;
    atomic readonly results do
      finish := Length(results);
    od;

    currentLength := currentLength + 1;
  until K > (finish - start + 1) or currentLength >= 500; #od;

  atomic results do return MAKE_PUBLIC(results); od;
end);
