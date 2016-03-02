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
   System(show)
   Utils at 'utils.ozf'
   Types at 'types.ozf'
   Records at 'records.ozf'
   BConvert at 'betaconvert.ozf'
export
   EmbeddingFunConvert EmbeddingFunMerge FixedPointType RestrictDomainFunctionType RestrictDomainFunction
define
   Substitute = Utils.substitute
   %SubstituteCompare = Utils.substituteCompare
   IsSubType = Types.isSubType
   SimplifyMeet = Types.simplifyMeet
   SimplifyDep = Types.simplifyDep
   %SimplifyOp = Types.simplifyOp
   %EvalOp = Types.evalOp
   %ExploitEqualities = Types.exploitEqualities
   EvalPath = Records.evalPath
   ExtendPaths = BConvert.extendPaths
   
   % fun {EmbeddingFunConvert F T}
%       case F of
% 	 lambda(X T1 Body) then
% 	 if {IsSubType T T1} then
% 	    %{Inspector.inspect {Substitute T sintype(T1 X) Body}}
% 	    {SubstituteCompare
% 	     T
% 	     fun {$ Obj}
% 		case Obj
% 		of sintype(T2 Y) then
% 		   if Y == X then
% 		      if {IsSubType T1 T2} then true
% 		      else {Inspector.inspect 'EmbeddingFunConvert: badly typed variable'} false
% 		      end
% 		   else false
% 		   end %Need a case for select(X Path) ??
% 		% [] select(Y Path) then
% % 		   if Y == X then
% 		else false
% 		end
% 	     end
% 	     Body}
% 	 else 'badly typed argument'
% 	 end
%       else F
%       end
%    end

  %  fun {EmbeddingFunConvert F T}
%       case F of
% 	 lambda(X T1 Body) then
% 	 if {IsSubType T T1} then
% 	    %{Inspector.inspect {Substitute T sintype(T1 X) Body}}
% 	    local
% 	       SubstFun = fun {$ Obj}
% 			     case Obj
% 			     of sintype(T2 Y) then
% 				if Y == X then
% 				   if {IsSubType T1 T2} then T
% 				   else {Inspector.inspect 'Functions.embeddingFunConvert: badly typed variable'} 'Functions.embeddingFunConvert: badly typed variable'
% 				   end
% 				else sintype(T2 Y)
% 				end 
% 			     [] select(Y Path) then
% 				if Y == X then
% 				   case T.Path % Should be EvalPath
% 				   of sintype(_ Z) then Z
% 				   [] opsintype(_ Z) then Z
% 				   else {Inspector.inspect 'Functions.embeddingFunConvert: value for variable not specified'} 'Functions.embeddingFunConvert: value for variable not specified'
% 				   end
% 				else select(Y Path)
% 				end
% 			     [] rectype(...) then {Record.map Obj SubstFun}
% 			     [] optype(...) then {Record.map Obj SubstFun}
% 			     [] opsintype(...) then {Record.map Obj SubstFun}
% 			     [] append(...) then  {Record.map Obj SubstFun}
% 			     [] apply(...) then {Record.map Obj SubstFun}
% 			     else Obj
% 			     end
% 			  end
% 	    in
% 	       {Record.map Body SubstFun}
% 	    end
% 	 else {Inspector.inspect ['Functions.embeddingFunConvert: Badly typed argument. Fun: ' F 'Arg: ' T ]} 'badly typed argument'
% 	 end
%       else F
%       end
%    end

   fun {EmbeddingFunConvert F Type}
      case F
      of lambda(X _ Body) then
	 local
	    %T = {SimplifyMeet {SimplifyOp {SimplifyDep {ExploitEqualities Type}}}}
	    %{Inspector.inspect F#T}
	   T = {SimplifyDep Type}
	    SubstFun = fun {$ Obj}
			  case Obj
			  of sintype(_ !X) then ttr_arg(T)
			  [] sintype(T1 select(!X Path)) then
			     case T.Path %Should be EvalPath
			     of sintype(_ Z) then ttr_arg(sintype(T1 Z))
			     [] opsintype(_ Z) then ttr_arg(opsintype(T1 Z))
			     else if {IsSubType T1 T.Path} then Obj
				  else {SimplifyMeet meettype(T1 T.Path)}
				  end
			     end
			     %{Record.map Obj SubstFun}
			  [] select(!X Path) then
			     case T.Path % Should be EvalPath
			     of sintype(_ Z) then ttr_arg(Z)
			     [] opsintype(_ Z) then ttr_arg(Z)
			     [] rectype(...) then ttr_arg(T.Path)
			     [] optype(_ Z) then ttr_arg(Z)
			     else {Inspector.inspect 'Functions.embeddingFunConvert: value for variable not specified'#T.Path} 'Functions.embeddingFunConvert: value for variable not specified'
			     end
			  [] rectype(...) then {Record.map Obj SubstFun}
			  [] optype(...) then {Record.map Obj SubstFun}
			  [] opsintype(...) then {Record.map Obj SubstFun}
			  [] append(...) then  {Record.map Obj SubstFun}
			  [] apply(...) then {Record.map Obj SubstFun}
			  [] conj(...) then {Record.map Obj SubstFun}
			  [] merge(...) then {Record.map Obj SubstFun} %{SimplifyMeet meettype({SubstFun T1} {SubstFun T2})}
			  [] meettype(...) then {Record.map Obj SubstFun}
			  %[] meettype(T1 T2) then {SimplifyMeet meettype({SubstFun T1} {SubstFun T2})}
			  [] deptype(F Paths) then deptype({SubstFun F} {Map Paths SubstFun})
			  [] lambda(Y T Body) then
			     % {Inspector.inspect [2 lambda(Y T Body)]}
% 			     {Inspector.inspect [3 lambda(Y T {Record.map Body SubstFun})]}
			     if Y == X then lambda(Y ttr_arg(T) Body)
			     else lambda(Y ttr_arg(T) {Record.map Body SubstFun})
			     end
			  [] abspath(!X Path) then
			     case {EvalPath T path(Path)}
			     of sintype(_ Z) then ttr_arg(objpath(Z))
			     [] opsintype(_ Z) then ttr_arg(objpath(Z))
			     else {Inspector.inspect ['Functions.embeddingFunConvert: path' Path 'in' T 'not specified']} 'Path not specified'
			     end
			  else Obj
			  end
		       end
	 in
	    %{Inspector.inspect F#T#{Record.map Body SubstFun}}
	    %{Inspector.inspect [1 F#T]}
	    %{SimplifyMeet {SimplifyOp {SimplifyDep {ExtendPaths{Record.map Body SubstFun}}}}}
	    %{Inspector.inspect {Record.map Body SubstFun}}
 	    %{Inspector.inspect {ExtendPaths{Record.map Body SubstFun}}}
	    %{Record.map Body SubstFun}
	    {ExtendPaths{Record.map Body SubstFun}}
	 end
      else {Inspector.inspect ['Functions.embeddingFunConvert:' F  'not a function' ]} 'not a function'
      end
   end
   
   fun {EmbeddingFunMerge F1 F2}
      case F1
      of lambda(X T1 Body1) then
	 case F2
	 of lambda(Y T2 Body2) then
	    %{Inspector.inspect {SimplifyMeet meettype(T1 T2)}}
	    lambda(X {SimplifyMeet meettype(T1 T2)}
		   {EmbeddingFunMerge Body1 {Substitute X Y Body2}})
	 else {Inspector.inspect ['Functions.embeddingFunMerge: mismatch in arity' F1 F2]} error
	 end
      [] rectype(...) then
	 case F2
	 of rectype(...) then
	    %{Inspector.inspect meettype(F1 F2)}
	    {SimplifyMeet meettype(F1 F2)}
	 else {Inspector.inspect ['Functions.embeddingFunMerge: mismatch in arity' F1 F2]} error
	 end
      else {Inspector.inspect ['Functions.embeddingFunMerge: mismatch in arity' F1 F2]} error
      end
   end

   fun {FixedPointType F}
      case F
      of lambda(R rectype(...) rectype(...)) then
	 local
	    SubstFun = fun{$ Expr}
			  if {IsAtom Expr} then Expr
			  else {Record.map Expr
				fun {$ X}
				   case X
				   of abspath(!R Path) then
				      path(Path)
				   else {Record.map X SubstFun}
				   end
				end
			       }
			  end
		       end
	 in
	    {SimplifyMeet
	     meettype(F.2 {SubstFun F.3})}
	 end
      else {Inspector.inspect ['Funtions.fixedPointType: not defined for' F]} error
      end
   end
   
fun{RestrictDomainFunctionType FType Type}
      case FType
      of funtype(DomT RangeT) then
	 funtype({SimplifyMeet meettype(DomT Type)} RangeT)
      else {Inspector.inspect ['Functions.resrictDomainFunctionType: not a function type' FType]} 'not a function type'
      end
   end
fun{RestrictDomainFunction F Type}
   case F
   of lambda(X T Body) then
      lambda(X {SimplifyMeet meettype(T Type)} Body)
   else {Inspector.inspect ['Functions.resrictDomainFunction: not a function' F]} 'not a function'
   end
end

   
   
end
