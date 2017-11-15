#
#    Complexfp-V1-1 - Main implementation of a lockless concurrent Froidure-Pin algorthim.
#    Copyright (C) 2017  Alasdair G. Macindoe
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#This takes a word and will return it a bucket to go deterministically
#For a word ua its usage is b(ua) which will return an integer corresponding
#to the bucket it should be placed in
b := function(w, jobs)
  return (HashBasic(w) mod jobs) + 1;
end;

CreateList := function(ht)
  local temp_list, k;
  temp_list := [];
  for k in [1 .. Length(ht![6])] do
    if IsBound(ht![6][k]) then
      Add(temp_list, ht![6][k]);
    fi;
  od;
  return temp_list;
end;
#This corresponds to a fragment of reduced words and its corresponding K value
#Use this method to create a new Fragment. Care should be taken when using this,
#generally use a supplementary method is correct
Fragment := function(words, k)
  return rec(
    Y := words, #This is a list of (reduced) Word records
    K := k,
    V := CreateList(words)
  );
end;

FragmentSize := function(fragment)
  return Size(fragment.Y);
end;

EmptyFragment := function()
  return Fragment(HashMap(), 1);
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
AddToFragment := function(fragment, word)
  fragment.Y[word.value] := word;
  Add(fragment.V, word);
end;

GetWordFromFragment := function(fragment, number)
  if number > FragmentSize(fragment) then
    return fail;
  fi;
  return fragment.V[number];
end;

CheckFragments := function(fragments)
  local i, w;
  for i in [1 .. Length(fragments)] do
    if fragments[i].K <= FragmentSize(fragments[i]) then
      return true;
    fi;
  od;
  return false;
end;

SearchFragment := function(fragment, value)
  return fragment.Y[value];
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

InitFromGenerators := function(A, Y, jobs)
  local i, a, NumberFragments, l, word;
  NumberFragments := Length(Y);
  for i in [1 .. Length(A)] do
    a := A[i];
    l := SearchFragments(Y, a);
    if l = fail then #never added before
      word := CreateNewWord(a, i, i, a, a, Length(A), 1, jobs);
      word.word.suffix := word.word;
      word.word.prefix := word.word;
      AddToFragment(Y[word.b], word.word);
      A[i] := word.word;
    else
      l.right[i] := a;
      l.rightFlag[i] := false;
    fi;
  od;
end;

WordLength := function(w)
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
ApplyGenerators := function (A, Y, Q, j, currentLength, jobs)
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
    s := YjKj.suffix;
    #for a in A
    for i in [1 .. Length(A)] do
      #important part
      if s <> fail and s.rightFlag[i] = false then #this is the normal case when s is not reduced
        y := s.right[i].prefix;
        p := y.prefix;
        w := p.left[YjKj.first];
        if w = fail or w = 0 then
          YjKj.right[i] := A[i];
        elif (w <> fail and w <> 0 ) and (WordLength(w) < currentLength or (SearchFragment(Yj, w) <> fail)) then
          YjKj.right[i] := w.right[y.last];
          YjKj.rightFlag[i] := false;
        fi;
      fi;
      word := YjKj.value * A[i].value;
      v := SearchFragment(Yj, word);
      if v <> fail then #This word is already in there somewhere
        v.right[i] := YjKj;
        v.rightFlag[i] := false;
      else #otherwise it is completely new
        word := CreateNewWord(word, YjKj.first, i, YjKj, A[i], Length(A), currentLength + 1, jobs);
        YjKj.right[i] := word.word; #Is this the bug in V1_1?
        YjKj.rightFlag[i] := true;
        AddQueue(Q, j, word);
      fi;

    od;

    Yj.K := Yj.K + 1;
  od;
  return 0;
end;

ProcessQueues := function(Y, Q, j)
  local q, i, k, word, value, l, w;
  #for b(wa), wa) in Q
  for i in [1 .. Length(Q)] do #for every queue
    q := Q[i];
    for k in [1 .. Length(q)] do #for every word
      word := q[k]; #This gives us a word record(with bucket)
      #b(word) = word.b
      if word.b = j then
        value := word.word.value; #v(wa)
        l := SearchFragment(Y[word.b], value);
        word := word.word; #This gives us a word entry
        w := word.suffix; #Recall word is wa this gives us w
        #w := SearchFragments(Y, w);
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
  local Yj, i, Yji, k, p, Lj;
  Yj := Y[j];
  for i in [1 .. FragmentSize(Yj)] do
    Yji := Yj.Y[i];
    if WordLength(Yji) = currentLength then
      for k in [1 .. Length(A)] do
        p := Yji.prefix.left[k];
        if p = fail or p = 0 then
          Yji.left[k] := A[k];
        else
          Yji.left[k] := p.right[Yji.last];
        fi;
      od;
    fi;
  od;
  return 0;
end;

#Merges all the fragments into one list
Enumerated := function(fragments)
  local result, i, temp_list, j, k;
  result := [];
  for i in [1 .. Length(fragments)] do
    temp_list := CreateList(fragments[i].Y);
    for j in [1 .. Length(temp_list)] do
      Add(result, temp_list[j]);
    od;
  od;
  return result;
end;

RemoveTasks := function(tasks)
  local i, j;
  for i in [1 .. Length(tasks)] do
    TaskResult(tasks[i]);
  od;
  return 0;
end;

InstallGlobalFunction(FroidurePin, function(A)
  local Y, currentLength, jobs, j, Q, tasks;
  currentLength := 1;
  jobs := Length(A);
  Y := MakeReadOnly(CreateEmptyFragments(jobs)); #The fragments can be stored in a list
  InitFromGenerators(A, Y, jobs);
  tasks := [];
  MakeReadOnly(A); #Generators never change

  while CheckFragments(Y) and currentLength <= 100 do
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
  #return Y;
  return Enumerated(Y);
end);
