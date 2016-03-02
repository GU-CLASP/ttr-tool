/*

    Copyright 2012 Robin Cooper

    This file is part of TTR Tools 0.1alpha.

    TTR Tools 0.1alpha is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    TTR Tools 0.1alpha is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with TTR Tools 0.1alpha.  If not, see <http://www.gnu.org/licenses/>.

*/



functor
import
   Records at 'records.ozf'
   Types at 'types.ozf'
   %Utils at 'utils.ozf'
export
   CompileIndexedLexicon %ExtractWordsFromLexicon
define
   EvalPath = Records.evalPath
   InstantiateType = Types.instantiateType
  % ListToSet = Utils.listToSet
   fun{CompileIndexedLexicon Lex Path}
      local
	 ILex = {NewDictionary}
	 AddToILex = fun{$ Item}
			local
			   OldVal
			   New = {EvalPath {InstantiateType Item} Path}
			in
			   {Dictionary.condExchange
			    ILex
			    if {IsList New} then New.1 % will not allow multiword lexical items
			    else New
			    end
			    nil
			    OldVal
			    Item|OldVal}
			   Item
			end
		     end
      in
	 {Map Lex AddToILex _}
	 ILex
      end
   end
   % fun {ExtractWordsFromLexicon Lex}
%       {ListToSet {Map Lex fun {$ X} X.phon.1 end}} % will not allow multiword lexical items
%    end
end

