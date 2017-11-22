#
#    FroidurePin - an implementation of a simplistic variant of the FP algorthim.
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

InstallGlobalFunction(SimplifiedFroidurePin, function(generators)
  # last is the last element of the current list
  # i is the index for a loop used later
  # ua is the place holder of u * a
  # Results is where we hold the final values and will be returned
  # dict_lookup is used as a temporary variable to hold whether an element
  # is inside the dictionary or not
  local u, last, i, k, ua, results, dict_lookup;
  #K is the number of generators in our subset
  k := Length(generators);
  # u is an element inside our Universe U
  u := rec( element := IdentityTransformation,
            next := fail,
            rule := [1 .. k] * 0);
  # Last is the final element of the current list
  last := u;
  # This dictionary takes a value as a look up key and returns
  # as a value the record structure affiliated with that key
  results := NewDictionary(u, true);
  AddDictionary(results, IdentityTransformation, u);

  repeat
    for i in [1 .. k] do
      ua := u.element * generators[i];
      dict_lookup := LookupDictionary(results, ua);

      if dict_lookup = fail then
        ua := rec(element := ua, next := fail, rule := [1 .. k] * 0);
        AddDictionary(results, ua.element, ua);
        last.next := ua;
        last := ua;
      else
        dict_lookup.rule[i] := u;
      fi;
    od;
    u := u.next;
  until u = fail;
  return results;
end);
