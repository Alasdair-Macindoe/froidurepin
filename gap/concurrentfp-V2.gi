#This takes a word and will return it a bucket to go deterministically
#For a word ua its usage is b(ua) which will return an integer corresponding
#to the bucket it should be placed in
b := function(w)
  return 1;
end;

#This corresponds to a fragment of reduced words and its corresponding K value
#Use this method to create a new Fragment. Care should be taken when using this,
#generally use a supplementary method is correct
Fragment := function(words, k)
  return rec(
    Y := words; #This is a list of (reduced) Word records
    K := k;
  );
end;

FragmentSize := function(fragment)
  return Length(fragment.Y);
od;

#Creates a default Fragment of words
DefaultFragment := function(words)
  return Fragment(words, 1);
end;

EmptyFragment := function(words)
  return Fragment([], 0);
end;

#Word should be a Word record (not WordEntry record)
AddToFragment := function(fragment, word)
  Add(fragment.Y, word);
end;

GetWordFromFragment := function(fragment, number)
  return fragment.Y[number];
end;

CheckFragments := function(fragments)
  local i, w;
  for i in [1 .. fragments] do
    if fragments[i].K <= FragmentSize(fragments[i]) then
      return true;
    fi;
  od;
  return false;
end;

SearchFragment := function(fragment, value)
  local i, word;
  for i in [1 .. Length(fragment.Y)] do
    word := GetWordFromFragment(fragment, i);
    if word = value then
      return word;
    fi;
  od;
  return fail;
end;

SearchFragments := function(fragments, value)
  local i, fragment, word;
  for i in [1 .. Length(fragments)] do
    fragment := fragments[i];
    word := SearchFragment(fragment, value);
    if word <> fail then
      return word;
    fi;
  od;
end;

#This will create a new word which is inside a specific bucket.
#Generally a supplementary method should often be used.
Word := function(bucket, wordRec)
  return rec(
    b := bucket;
    word := wordRec; #This is a WordEntry record
  );
end;

CreateNewWord := function(v, f, l, p, s, k, len)
  local wordEntryRec, word;
  wordEntryRec := WordEntry(v, f, l, p, s, k, len);
  word := Word(b(v), wordEntryRec);
  return word;
end;

WordLength := function(w)
  return w.word.length;
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

#Creates k queues
CreateQueues := function(k)
  local queue, i;
  queue := [];
  for i in [1 .. k] do
    Add(queue, []);
  od;
  return queue;
end;

AddQueue := function(queue, j, word)
  Add(queue[j], word);
od;

#Recall that Y is a collection of fragments and Q is a collection of Queues
#At this stage Qj will be empty
ApplyGenerators := function (A, Y, Q, j, currentLength)
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
  while Yj.K <= FragmentSize(Yj) and WordLength(GetWordFromFragment(Yj, Yj.K)) = currentLength then
    YjKj := GetWordFromFragment(Yj, Yj.K);
    #for a in A
    for i in [1 .. Length(A)] do
      #important part
      s := SearchFragment(Yj, YjKj.suffix);
      if s <> fail and s.rightFlag[i] = false then #this is the normal case when s is not reduced
        y := s.right[i];
        p := SearchFragments(Y, y.prefix);
        w := p.left[YjKj.first];
        if WordLength(w) < currentLength or (SearchFragment(Yj, w) <> fail) then
          YjKj.right[i] := w.right[y.last];
          YjKj.rightFlag[i] := false;
          continue;
      fi;

      word := YjKj.value * A[i];
      v := SearchFragments(Y, word);
      if v <> fail then #This word is already in there somewhere
        v.right[i] := YjKj.value;
        v.rightFlag[i] := false;
      else #otherwise it is completely new
        word := CreateNewWord(word, YjKj.first, i, YjKj.value, A[i], Length(A), currentLength + 1);
        YjKj.right[i] := word.value; #Is this the bug in V1_1?
        YjKj.rightFlag[i] := true;
        AddQueue(Q, j, word);
      fi;

    od;

    Yj.K := Yj.K + 1;
  od;
  return 0;
end;

ProcessQueues := function(Y, Q, j)
  local q, i, j, word, value, l, w;
  #for b(wa), wa) in Q
  for i in [1 .. Length(Q)] do #for every queue
    q := Q[i];
    for j in [1 .. Length(q)] do #for every word
      word := q[j]; #This gives us a word record(with bucket)

      #b(word) = word.b
      if word.b = j then #for the bucket we are assigned to
        word := word.word; #This gives us a word entry
        value := word.value; #v(wa)
        l := SearchFragments(Y, value);
        w := word.suffix; #Recall word is wa this gives us w
        if l <> fail then
          w.right[word.last] := l;
          w.rightFlag[word.last] := false;
        else
          AddToFragment(Y[j], word); #This adds the word entry to the fragment
          w.right[word.last] := word;
          w.rightFlag[word.last] := true;
        fi;
      fi;

    od;
  od;
  return 0;
end;

DevelopLeft := function(A, Y, j, currentLength)
  local Yj, i, Yji, j, p;
  Yj := Y[j];
  for i in [1..Length(Yj)] do
    Yji := GetWordFromFragment(Yj, i);
    if WordLength(Yji) < currentLength then
      continue;
    fi;
    #for a in A
    for j in [1 .. Length(A)] do
      p := GetWordFromFragments(Y, Yji.prefix);
      p := GetWordFromFragments(Y, p.left[i]);
      p := p.right[Yji.last];
      Yji.left[i] := p;
    od;
  od;
  return 0;
end;

#Merges all the fragments into one list
Enumerated := function(Y)
  return [];
end;

InstallGlobalFunction(FroidurePin_V2, function(A)
  local Y, currentLength;
  Y := []; #The fragments can be stored in a list
  currentLength := 1;

  return Enumerated(Y);
end;
);
