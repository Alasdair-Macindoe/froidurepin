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
  return rec(
        value := v, #The value of this word, eg this word

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
        );
end;

_DefaultDS := function(value, i, k)
  return _NewResultsDataStructure(value, i, i, fail, fail, k, 1);
end;

_GetWord := function(YjKj, a)
  if YjKj.suffix = fail then
    return a * a;
  fi;
  return YjKj * a;
end;

#Generating set is traditionally refered to as A
_InitialiseResults := function(results, A)
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
_ApplyGenerators := function(A, Y, start, step, queues, K, currentLength, j)
  local offset, currentWord, i, w, l, ds, b;
  K := K - 1;
  b := j; #bucket = job number
  #For all the words in our range
  for offset in [start .. start + step] do
    currentWord := Y[offset];
    if currentWord.length <> currentLength then
      return offset - start;
    fi;
    #for a in A
    for i in [1 .. Length(A)] do
      w := currentWord.value * A[i];
      l := _Search(w, Y, queues[b]);
      if w = Transformation( [ 5, 3, 2, 5, 5 ] ) then
        Print("Found w: ", w, "\n");
        Print("Produced by: ", currentWord.value, "\n");
        Print("and: ", A[i], "\n");
      fi;

      #if currentWord.suffix <> fail then
        #s := _Get(Y, currentWord.suffix);
        #  if s.rightFlag[i] = false then
        #    Print("Searching for: ", s.right[i], "\n");
        #    r := _Get(Y, s.right[i]);
        #    s.right[i] := _Get(Y, r.left[currentWord.first]).right[r.last];
       #  fi;
      #fi;
      if l <> fail then #w = v(y) for some y
        currentWord.right[i] := l.value;
        currentWord.rightFlag[i] := false;
      else
        ds := _NewResultsDataStructure(w, currentWord.first, i, currentWord.value, A[i], Length(A), currentWord.length + 1);
        currentWord.right[i] := ds.value;
        currentWord.rightFlag[i] := true;
        _AddQueue(queues, b, ds);
      fi;
    od;
  od;
  return K + offset;
end;

###
# This is the ProcessQueues part of the algorthim as defined by the paper
# on concurrent FroidurePin. It effectively loops through all the values
# that ApplyGenerators belives may be new and checks if they are actually new.
# If they are new then they get added to the output data structure, otherwise
# that data structure is updated to note a reduction
###
_ProcessQueues := function(queues, results, bw)
  local i, #Loop index
        l, #temporary look up
        w, #if word = wa then this is the w part
        word; #Temporary word holder

  #For this bucket
  for i in [1..Length(queues[bw])] do
    word := queues[bw][i];
    l := _Get(results, word);

    if l <> fail then
      l.right[word.last] := word.value;
      l.rightFlag[word.last] := false;
    else
      _Add(results, word);
    fi;
  od;
end;

_DevelopLeft := function(Y, A, start, step)
  local offset, i, currentWord, p, r;
  offset := 0;
  #Iterate over a a range of results Y[start] to Y[finish]
  while (offset < step) do
    currentWord := Y[start + offset];
    #for each a in A
    for i in [1 .. Length(A)] do
      if currentWord.prefix = fail then #This is a generator value
        currentWord.left[i] := A[i];
      else
        p := _Get(Y, currentWord.prefix);
        r := _Get(Y, p.left[i]);
        currentWord.left[i] := r.right[currentWord.last];
      fi;
    od;
    offset := offset + 1;
  od;
  return 0;
end;


###
# Main entry point for the program
# This part assumes the minimal snapshot of (A, A, 1)
# Note: In this program we do not have a phi method. It is a parameter in the
# datastructure.
###
InstallGlobalFunction(FroidurePin_V1, function(generators)
  local K, #K refers to K_j from the paper, but this is the minimal entry, thus
           #is K := 1
        currentLength, #This is the currentLength of words we are computing,
                       #In this entry it is 1 since we only have generators.
        j, #This is a holder for the job number
        jobs, #This is the total number of jobs we can have
        queues, #This the holder for the output from ApplyGenerators
        results, #This is the holder of reduced words.
        step,
        l,
        lengthResults,
        overflow,
        start, finish; #These are the frontier of our search


  #Initialise data structures
  currentLength := 1; #Since we are starting with only generators
  K := 1; #K is 1 in this entry
  jobs := 1; #For now let their be 1 job.
  results := _CreateResults(); #Results is Y our set of reduced words
  start := 1;
  finish := Length(generators);

  _InitialiseResults(results, generators);

  while K <= (finish - start + 1) and currentLength <= 500 do #temporary to prevent infinite loops
    #We do this here to ensure the queues are emptied every loop
    queues := _CreateQueue(jobs); #For now assume that the number of queues is equal to the number of jobs
    l := Length(results);
    for j in [1 .. jobs] do
      K := _ApplyGenerators(generators, results, start, finish - start, queues, K, currentLength, j);
    od;
    for j in [1 .. jobs] do
      _ProcessQueues(queues, results, j);
    od;

    lengthResults := Length(results);
    overflow := (lengthResults - start) mod jobs;
    if overflow = 0 then
      step := (lengthResults - start) / jobs;
    else
      step := (lengthResults - start - overflow) / jobs;
    fi;
    for j in [1 .. jobs] do
      #Prevents overflow
      if start + j*step > lengthResults then
        step := lengthResults - j*step;
      fi;
      _DevelopLeft(results, generators, start, step);
    od;

    #This is used to find those additional values that seem to not appear
    if K >= (finish - start) then
      start := finish + 1;
      finish := Length(results);
      K := 1;
    fi;
    Print(currentLength, "\n");
    currentLength := currentLength + 1;
  od;
  return results;
end);
