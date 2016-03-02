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
    Inspector(inspect)
    Functions at '../ttr/functions.ozf'
    Utils at '../ttr/utils.ozf'
export
   Lex RuleBinary RuleUnary ApplyRule
define
    EmbeddingFunConvert = Functions.embeddingFunConvert
    RestRecTypeList = Utils.restRecTypeList
   
   fun {Lex ID Cat}
      rectype(cat : sintype('Cat' Cat)
	      id : sintype('Id' ID))
   end
   fun {RuleBinary ID Mother Daughter1 Daughter2}
      lambda(r1 rectype(cat : sintype('Cat' Daughter1)
			id : 'Id')
	     lambda(r2 rectype(cat : sintype('Cat' Daughter2)
			       id : 'Id')
		    rectype(cat : sintype('Cat' Mother)
			    id : deptype(lambda(v1 'Id'
						lambda(v2 'Id'
						       sintype('Id' app(app(ID v1) v2))))
					 [abspath(r1 [id]) abspath(r2 [id])])
			    daughters : rectype(first : sintype(rectype(cat : sintype('Cat' Daughter1)) r1)
						rest : rectype(first : sintype(rectype(cat : sintype('Cat' Daughter2)) r2)
							       rest : sintype(listtype('Rec') nil))))))
   end
   fun {RuleUnary ID Mother Daughter}
      lambda(r rectype(cat : sintype('Cat' Daughter)
		       id : 'Id')
	     rectype(cat : sintype('Cat' Mother)
		     id : deptype(lambda(v 'Id'
					 sintype('Id' app(ID v)))
				  [abspath(r [id])])
		     daughters : rectype(first : sintype(rectype(cat : sintype('Cat' Daughter)) r)
					 rest : sintype(listtype('Rec') nil))))
   end


   fun{ApplyRule Rule Type}
      {RemoveFirstDaughter {EmbeddingFunConvert Rule Type}}
   end
   fun{RemoveFirstDaughter R}
      case R
      of lambda(X T Body) then
	 lambda(X T {RemoveFirstDaughter Body})
      [] rectype(...) then
	 {Record.mapInd R fun{$ F V}
			     case F
			     of daughters then
				{RestRecTypeList V}
			     else V
			     end
			  end
	 }
      else {Inspector.inspect ['Ures-abs.removeFirstDaughter: not a rule' R]} 'not a rule'
      end
   end
   

end