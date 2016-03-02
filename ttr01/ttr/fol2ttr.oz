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
   Utils at 'utils.ozf'
   Types at 'types.ozf'
export
   Fol2ttr Fol2ttrAbbrev
define
   Gensym = Utils.gensym
   SimplifyMeet = Types.simplifyMeet
   FlattenRelabelRecType = Types.flattenRelabelRecType
   AbbrevDep = Types.abbrevDep
   fun {Fol2ttrAbbrev Expr}
      {AbbrevDep {Fol2ttr Expr}}
   end
   fun {Fol2ttr Expr}
      local
	 LabelVars = {NewDictionary}
	 GensymDict = {NewDictionary}
      in
	 {FlattenRelabelRecType {Fol2ttr1 LabelVars GensymDict Expr}}
      end
   end
   fun {Fol2ttr1 LabelVars GensymDict Expr}
      case Expr
      of and(P Q) then {SimplifyMeet meettype({Fol2ttr1 LabelVars GensymDict P} {Fol2ttr1 LabelVars GensymDict Q})}
      [] 'or'(P Q) then jointype({Fol2ttr1 LabelVars GensymDict P} {Fol2ttr1 LabelVars GensymDict Q})
      [] 'not'(P) then funtype({Fol2ttr1 LabelVars GensymDict P} bot)
      [] ifthen(P Q) then {Fol2ttr1 LabelVars GensymDict 'or'('not'(P) Q)}
      [] exists(X P) then
	 local
	    NewVar = {Gensym v GensymDict}
	    LabelVars1 = {Dictionary.clone LabelVars}
	    NewC = {Gensym c GensymDict}
	 in
	    {Dictionary.put LabelVars1 X NewVar}   
	    rectype(X:'Ind'
		    NewC:deptype(lambda(NewVar 'Ind' {Fol2ttr1 LabelVars1 GensymDict P})
						  [path([X])]))
	 end
      [] forall(X P) then {Fol2ttr1 LabelVars GensymDict 'not'(exists(X 'not'(P)))}
      else {Litteral2ttr LabelVars GensymDict Expr}
      end
   end
   fun {Litteral2ttr LabelVars GensymDict Expr}
      if {IsRecord Expr} then
	 local
	    L = {Gensym c GensymDict}
	 in
	    rectype(L:{Record.map Expr fun{$ X} {Subst LabelVars X} end})
	 end
      else {Inspector.inspect ['fol2ttr.litteral2ttr: ' Expr ' is not a litteral']}
      end
   end
   fun {Subst LabelVars Expr}
      if {IsAtom Expr} then {Dictionary.condGet LabelVars Expr Expr}
      else {Inspector.inspect ['fol2ttr.subst: ' Expr ' is not an fol term.']}
      end
   end
	 
end
