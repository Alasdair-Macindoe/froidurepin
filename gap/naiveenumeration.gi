#
#    Naiveenumeration - enumerate a semigroup the most simplistic way.
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

# For this implementation we consider the simplest implementation
# We repeatedly multiply each element in our generators list
# By every result of its multiplications (which includes itself)
# eg for [0, 1, 2] mod 3 we have 0 x 0, 0 x 1, 0 x 2 etc.
InstallGlobalFunction(NaiveSemiGroupEnumeration, function(generators)
  #Temp_res is used during multiplications,
  #a and g are loop indexes.
  local results, temp_res, a, g;

  # Results holds all of our multiplications. To begin with
  # This has to include the generators themselves.
  results := StructuralCopy(generators);

  for a in results do
    for g in generators do
      temp_res := a * g;
      if not temp_res in results then
        Add(results, temp_res);
      fi;
    od;
  od;

  return results;
end);
