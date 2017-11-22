#
#    Concurrentfp - a failed variant of the concurrent Froidure-Pin
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

#Concurrency helper functions
_RunConcurrent := function(tasks)
  #Since we do everything in place we can do "cheats" like this
  WaitTask(tasks);
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
        right := [1 .. k] * 0, # the value of p(ua) for all a in generators
        rightFlag := [1 .. k] * 0, #flags for reduced or not for above
        left := [1 .. k] * 0,
        leftFlag := [1 .. k] * 0,
        length := len #length of u
        );
end;

_Copy := function(ds)
  return _NewDataStructure(ds.value, ds.first, ds.last, ds.prefix, ds.suffix, ds.next, Length(ds.right), ds.length);
end;

_RenewDS := function(ds, v, f, l, p, s, n, k, len)
  ds.value := v;
  ds.first := f;
  ds.last := l;
  ds.prefix := p;
  ds.suffix := s;
  ds.next := n;
  ds.right := [1 .. k] *0;
  ds.rightFlag := [1 .. k] *0;
  ds.left := [1 .. k] * 0;
  ds.length := len;
end;

###
# Method required to add the generators to the data structure for the output
# Whilst this is not in the paper this is required for the algorthim to
# work programmatically.
###
_InitialiseFirstValue := function(generators, u, k, results, last)
  local l, #temporary look up variable
        ds, #temporary data structure place holder
        i; #temporary loop variable

  for i in [1 .. k] do

    l := _Get(results, generators[i]);

    if l = fail then
      ds := _NewDataStructure(generators[i], i, i, u.value, u.value, fail, k, 1);
      last.next := ds.value;
      last := ds;
      u.right[i] := last.value;
      u.rightFlag[i] := true;
      u.left[i] := last.value;
      _Add(results, ds.value, ds);

    else
      u.right[i] := 1;
      u.rightFlag[i] := false;
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
        bw; #Bucket number for w
  b := u.first;
  s := _Get(results, u.suffix);
  bw := i; #This may be updated in the future
  if s.rightFlag[i] = false then #not reduced
    r := _Get(results, s.right[i]); #find the right hand part eg for ua find u
    if r.length = 0 then #if r is the empty word
      s.right[i] := u.right[b];
    else #if not the empty word
      c := r.last;
      #p(p(bt)c)
      s.right[i] := _Get(results, r.left[b]).right[c];
    fi;
  else #if it is already reduced
    v_ua := u.value * generators[i];
    l := _Get(results, v_ua); #Look up in our results to see if it exist
    if l <> fail then
      u.right[i] := l.value;
      u.rightFlag[i] := false;
    else #if l = fail
      #Store the element in the last datastructure, but add the entire
      #datastrcture to the queue
      last.next := v_ua;
      u.next := v_ua;
      u.right[i] := last.next;
      u.rightFlag[i] := true;
      #This has to be done in place
      _RenewDS(last, v_ua, b, i, u.value, s.right[i], fail, k, u.length + 1);
      #But this can't be done in place
      _AddQueue(queues, bw, _Copy(last));
    fi;
  fi;
  return 0;
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
      l.right[l.last] := v_wa.value;
      l.rightFlag[l.last] := true;
    else
      _Add(results, v_wa.value, v_wa);
    fi;
  od;
  return 0;
end;


_DevelopLeft := function(results, p, u, j )
  local l;
  l := _Get(results, p.left[j]);
  if l = fail or l = 0 then
    u.left[j] := u.right[u.last];
  else
    u.left[j] := _Get(results, p.left[j]).right[u.last];
  fi;
  return 0;
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
        j, p,#temporary variables used in loops defined by paper
        results,
        tasks,
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
  tasks := []; #This is used to hold the next set of tasks to avoid race conditions

  #Add values in generator to results
  _InitialiseFirstValue(generators, u, k, results, last);
  u := _Get(results, generators[1]);
  v := u;

  repeat
    #In this part we compute ua_i
    while u <> fail and (u.length = currentLength) do
      for j in [1 .. k] do
        RunTask(_ApplyGenerators(generators, j, u, results, last, k, queue));
      od;
      u := _Get(results, u.next);
    od;
    u := v;


    for j in [1 .. k] do
      RunTask(_ProcessQueues(queue, results, j));
    od;

    #For whatever reason this part isn't given a name in the paper,
    #I have decided to replicated that here.
    #This part generates the left graph
    while u <> fail do
      p := _Get(results, u.prefix);

      #For every generator
      for j in [1 .. k] do
        RunTask(_DevelopLeft(results, p, u, j));
      od;
      u := _Get(results, u.next);
    od;

    v := u;
    currentLength := currentLength + 1;
  until u = fail;

  return results;
end);
