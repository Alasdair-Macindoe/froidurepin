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
    Y := words;
    K := k;
  );
end;

#This will create a new word which is inside a specific bucket.
#Generally a supplementary method should often be used.
Word := function(bucket, wordRec)
  return rec(
    b := bucket;
    word := wordRec;
  );
end;

CreateWord := function(v, f, l, p, s, k, len)
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

InstallGlobalFunction(FroidurePin_V2, function(A)

end;
);
