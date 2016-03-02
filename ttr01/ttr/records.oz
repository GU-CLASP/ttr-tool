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
   RecordC(width reflectArity)
   Inspector(inspect)
%   Types at 'types.ozf'
   Utils at 'utils.ozf'
   Debug at 'debug.ozf' 
export
   Path AppendPaths EvalPath EvalSelect PutValInPath SubstituteValInPath SubstituteValInPathList CloseRec FlattenRec RelabelRec
define
 %  InstantiateType = Types.instantiateType
   Gensym = Utils.gensym
   RaiseErrorVal = Debug.raiseErrorVal
   proc {Path P}
      choice
	 P = abspath(_ _)
      [] P = path(_)
      [] P = objpath(_)
      [] P = metapath(_ _)
      end
   end
   fun {AppendPaths Path1 Path2}
      case Path1
      of path(L1) then
	 case Path2
	 of path(L2) then path({Append L1 L2})
	 else {Inspector.inspect ['records.appendPath: paths don\'t match' Path1 Path2]} 'paths don\'t match'
	 end
      else {Inspector.inspect ['records.appendPath: not defined for paths' Path1 Path2]} 'AppendPaths not defined for arguments'
      end
   end
      
   
   fun {EvalPath Rec Path}
      	 case Path
	 of abspath(Rec1 List) then
	    {EvalPath Rec1 path(List)}
	 [] objpath(Obj) then Obj
	 [] metapath(T C) then metavar(T C)
	 [] path(Fst|Rst) then
	    cond
	       or
		  Rec = rec(...)
	       [] Rec = rectype(...)
	       end
	    then
	       local
		  Rec1 = {CondSelect Rec Fst error}
	       in
		  case Rec1
		  of error then {RaiseErrorVal ['Records.evalPath: Feature' Fst 'missing from' Rec] error}
		  else {EvalPath Rec1 path(Rst)}
		  end
	       end
	    else
	       {EvalPath select(Rec Fst) path(Rst)}
	    end
	 [] path(nil) then
	    Rec
	 else {Inspector.inspect ['Records.evalPath not path expression:' Path]}
	 end
   end

   fun {EvalSelect Expr}
      %{Inspector.inspect Expr}
      case Expr
      of select(Expr1 L) then
	 case Expr1
	 of sintype(T Expr2) then
	    sintype({EvalSelect select(T L)} {CondSelect {EvalSelect Expr2} L Expr})
	 else {CondSelect {EvalSelect Expr1} L Expr}
	 end
      else Expr
      end
   end
   
   
   proc {PutValInPath Path Label Val Res}
      case Path
      of path(Fst|Rst) then
	 local
	    Res1
	 in
	    {PutValInPath path(Rst) Label Val Res1}
	    Res = Label(...)
	    Res^Fst = Res1
	    %{RecordC.width Res {Length {RecordC.reflectArity Res}}}
	 end
      [] path(nil) then
	 Res = Val
      end
   end

   fun {SubstituteValInPath Path Val Rec}
      case Path
      of path(nil) then Val
      [] path(Fst|Rst) then
	 {Record.mapInd Rec
	  fun {$ L V}
	     case L
	     of !Fst then
		{SubstituteValInPath path(Rst) Val V}
	     else V
	     end
	  end
	 }
      else {Inspector.inspect ['Records.substituteValInPath: ' Path ' is not a path']} 'not a path'
      end
   end

   fun {SubstituteValInPathList AssocList Rec}
      case AssocList
      of nil then Rec
      [] (Path#Val)|Rst then
	 {SubstituteValInPathList Rst {SubstituteValInPath Path Val Rec}}
      else {Inspector.inspect ['Records.substituteValInPathList: ' AssocList ' is not a Path#Val association list']} 'not assoc list'
      end
   end
   
      

   fun {CloseRec Rec}
       {RecordC.width Rec {Length {RecordC.reflectArity Rec}}}
	 Rec
   end
   fun {FlattenRec R}
      {List.toRecord rec {FlattenRec2List R}}
      %{FlattenRec2List R}
   end   
   fun {FlattenRec2List R}
      case R
      of rec(...) then
	 local
	    FlattenFld = fun {$ Fld}
			    case Fld
			    of X#Ls then case Ls
					 of (_#_)|_ then
					    {Map Ls fun {$ Y} {VirtualString.toAtom X#'_'#Y.1}#Y.2 end}
					 else Ls
					 end
			    else Fld
			    end
			 end
	 in
	    {Flatten
	     {Record.toList {Record.mapInd R fun {$ L V}
				case V
				of rec(...) then {FlattenFld L#{FlattenRec2List V}}
				else L#V
				end
			     end
	     }}}
	 end
      else R
      end
   end
   fun {RelabelRec R}
      local
	 Gensymdict = {NewDictionary}
      in
	 {List.toRecord rec {Record.toList
			 {Record.mapInd R fun {$ L V}
					     {Gensym {StripFlatLabel L} Gensymdict}#V end}}}
      end
   end
   fun {StripFlatLabel L}
      {StripFlatLabel1 {Atom.toString L} nil}
   end
   fun {StripFlatLabel1 L Acc}
      if L == nil orelse {List.last L} == 95 %checking for '_'
      then {String.toAtom Acc}
      elseif {Char.isDigit {List.last L}}
      then {StripFlatLabel1 {List.take L {Length L}-1} Acc}	 
      else {StripFlatLabel1 {List.take L {Length L}-1} {List.last L}|Acc}
      end
   end
   
   

end
