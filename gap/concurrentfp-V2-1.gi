_b_calc := function(list, jobs)
  local i, res;
  if Length(list) = 1 then
    return list[1];
  fi;
  res := list[1] + jobs;
  #Longer than 1
  for i in [2 .. Length(list)] do
    if i mod 2 = 0 then
      res := res + list[i];
    else
      res := res - list[i];
    fi;
  od;
  return res;
end;

#This takes a word and will return it a bucket to go deterministically
#For a word ua its usage is b(ua) which will return an integer corresponding
#to the bucket it should be placed in
#TODO: This should work for all data types
b := function(w, jobs)
  local c, res, i;
  if IsTransformation(w) then
    c := ComponentsOfTransformation(w);
    #Special case
    if c = [] then
      return 1;
    fi;
    res := 1;
    for i in [1 .. Length(c)] do
      res := res + _b_calc(c[i], jobs);
    od;
    return (res mod jobs) + 1;
  fi;
  return 1;
end;

#This corresponds to a fragment of reduced words and its corresponding K value
#Use this method to create a new Fragment. Care should be taken when using this,
#generally use a supplementary method is correct
Fragment := function(words, k)
  return rec(
    Y := AtomicList(words), #This is a list of (reduced) Word records
    K := k
  );
end;

FragmentSize := function(fragment)
  return Length(fragment.Y);
end;

#Creates a default Fragment of words
DefaultFragment := function(words)
  return Fragment(words, 1);
end;

EmptyFragment := function()
  return Fragment([], 1);
end;

CreateEmptyFragments := function(k)
  local res, i;
  res := [];
  for i in [1.. k] do
    Add(res, EmptyFragment());
  od;
  return res;
end;

#Word should be a Word record (not WordEntry record)
AddToFragment := atomic function(readonly fragment, word)
  Add(fragment.Y, word);
end;

GetWordFromFragment := atomic function(readonly fragment, number)
  if number > Length(fragment.Y) then
    return fail;
  fi;
  return fragment.Y[number];
end;

CheckFragments := atomic function(readonly fragments)
  local i, w;
  for i in [1 .. Length(fragments)] do
    if fragments[i].K <= FragmentSize(fragments[i]) then
      return true;
    fi;
  od;
  return false;
end;

SearchFragment := atomic function(readonly fragment, value)
  local i, word;
  for i in [1 .. Length(fragment.Y)] do
    word := GetWordFromFragment(fragment, i);
    if word.value = value then
      return word;
    fi;
  od;
  return fail;
end;

SearchFragments := atomic function(readonly fragments, value)
  local i, fragment, word;
  for i in [1 .. Length(fragments)] do
    fragment := fragments[i];
    word := SearchFragment(fragment, value);
    if word <> fail then
      return word;
    fi;
  od;
  return fail;
end;

#This will create a new word which is inside a specific bucket.
#Generally a supplementary method should often be used.
Word := function(bucket, wordRec)
  return MAKE_PUBLIC(rec(
    b := bucket,
    word := wordRec #This is a WordEntry record
  ));
end;

WordEntry := function(v, f, l, p, s, k, len)
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

CreateNewWord := function(v, f, l, p, s, k, len, jobs)
  local wordEntryRec, word;
  wordEntryRec := WordEntry(v, f, l, p, s, k, len);
  word := Word(b(v, jobs), wordEntryRec);
  return word;
end;

InitFromGenerators := atomic function(A,readonly Y, jobs)
  local i, a, NumberFragments, l, word;
  NumberFragments := Length(Y);
  for i in [1 .. Length(A)] do
    a := A[i];
    l := SearchFragments(Y, a);
    if l = fail then #never added before
      word := CreateNewWord(a, i, i, a, a, Length(A), 1, jobs);
      AddToFragment(Y[word.b], word.word);
    else
      l.right[i] := a;
      l.rightFlag[i] := false;
    fi;
  od;
end;

WordLength := atomic function(readonly w)
  if w <> fail then
    return w.length;
  else
    return 0;
  fi;
end;

#Creates k queues
CreateQueues := function(k)
  local queue, i;
  queue := [];
  for i in [1 .. k] do
    Add(queue, []);
  od;
  return MakeReadOnly(queue);
end;

AddQueue := function(queue, j, word)
  Add(queue[j], word);
end;

#Recall that Y is a collection of fragments and Q is a collection of Queues
#At this stage Qj will be empty
ApplyGenerators := atomic function (A,readonly Y, Q, j, currentLength, jobs)
  local Yj, #Fragment j of Y
        YjKj, #Word Kj from Yj
        v, # v(YjKj) from paper
        word, # v(YjKj)*A[i]
        y,
        w, #y and w are from paper
        s, #s(YjKJ)
        p, #p(y)
        i;
  Yj := Y[j]; #This is a specific fragment now
  while Yj.K <= FragmentSize(Yj) and WordLength(GetWordFromFragment(Yj, Yj.K)) = currentLength do
    YjKj := GetWordFromFragment(Yj, Yj.K);
    s := SearchFragment(Yj, YjKj.suffix); #TODO: Can I remove look ups?
    #for a in A
    for i in [1 .. Length(A)] do
      #important part
      if s <> fail and s.rightFlag[i] = false then #this is the normal case when s is not reduced
        y := s.right[i];
        y := SearchFragments(Y, y);
        p := SearchFragments(Y, y.prefix);
        w := p.left[YjKj.first];
        w := SearchFragments(Y, w);
        if w = fail then
          YjKj.right[i] := A[i];
        elif WordLength(w) < currentLength or (SearchFragment(Yj, w) <> fail) then
          YjKj.right[i] := w.right[y.last];
          YjKj.rightFlag[i] := false;
        fi;
      fi;

      word := YjKj.value * A[i];
      v := SearchFragments(Y, word); #TODO: Should this be SearchFragment?
      if v <> fail then #This word is already in there somewhere
        v.right[i] := YjKj.value;
        v.rightFlag[i] := false;
      else #otherwise it is completely new
        word := CreateNewWord(word, YjKj.first, i, YjKj.value, A[i], Length(A), currentLength + 1, jobs);
        YjKj.right[i] := word.word.value; #Is this the bug in V1_1?
        YjKj.rightFlag[i] := true;
        AddQueue(Q, j, word); #TODO: Is this the correct bucket?
      fi;

    od;

    Yj.K := Yj.K + 1;
  od;
  return 0;
end;

ProcessQueues := atomic function(readonly Y, readonly Q, j)
  local q, i, k, word, value, l, w;
  #for b(wa), wa) in Q
  for i in [1 .. Length(Q)] do #for every queue
    q := Q[i];
    for k in [1 .. Length(q)] do #for every word
      word := q[k]; #This gives us a word record(with bucket)
      #b(word) = word.b
      if word.b = j then
        word := word.word; #This gives us a word entry
        value := word.value; #v(wa)
        l := SearchFragments(Y, value); #TODO: Should this be SearchFragmet?
        w := word.suffix; #Recall word is wa this gives us w
        w := SearchFragments(Y, w);
        if l <> fail then
          w.right[word.last] := l.value;
          w.rightFlag[word.last] := false;
        else
          AddToFragment(Y[j], word); #This adds the word entry to the fragment
          w.right[word.last] := value;
          w.rightFlag[word.last] := true;
        fi;
      fi;

    od;
  od;
  return 0;
end;

DevelopLeft := atomic function(A,readonly Y, j, currentLength)
  local Yj, i, Yji, k, p;
  Yj := Y[j];
  for i in [1..Length(Yj.Y)] do
    Yji := GetWordFromFragment(Yj, i);
    if WordLength(Yji) < currentLength then
      continue;
    fi;
    #for a in A
    for k in [1 .. Length(A)] do
      p := SearchFragments(Y, Yji.prefix);
      p := SearchFragments(Y, p.left[k]);
      if p = fail then
        Yji.left[k] := A[k] * Yji.value;
      else
        p := p.right[Yji.last];
        Yji.left[k] := p;
      fi;
    od;
  od;
  return 0;
end;

#Merges all the fragments into one list
Enumerated := atomic function(readonly Y)
  local result, i;
  result := [];
  for i in [1 .. Length(Y)] do
    Append(result, Y[i].Y);
  od;
  return result;
end;

RemoveTasks := function(tasks)
  local i, j;
  for i in [1 .. Length(tasks)] do
    j := 0 + TaskResult(tasks[i]);
  od;
  return 0;
end;

InstallGlobalFunction(FroidurePin_V2_1, function(A)
  local Y, currentLength, jobs, j, Q, tasks;
  currentLength := 1;
  jobs := Length(A);
  Y := ShareObj(CreateEmptyFragments(jobs)); #The fragments can be stored in a list
  InitFromGenerators(A, Y, jobs);
  tasks := [];
  MakeImmutable(A); #Generators never change

  while CheckFragments(Y) and currentLength <= 20 do

    Q := CreateQueues(jobs);

    for j in [1 .. jobs] do
      Add(tasks, RunTask(ApplyGenerators, A, Y, Q, j, currentLength, jobs));
    od;
    RemoveTasks(tasks);

    for j in [1 .. jobs] do
      Add(tasks, RunTask(ProcessQueues, Y, Q, j));
    od;
    RemoveTasks(tasks);

    for j in [1 .. jobs] do
      Add(tasks, RunTask(DevelopLeft, A, Y, j, currentLength));
    od;
    RemoveTasks(tasks);

    currentLength := currentLength + 1;
  od;
  return Enumerated(Y);
end);
