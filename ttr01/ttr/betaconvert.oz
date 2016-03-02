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
   %Records at 'records.ozf'
export
   BetaConvert BetaConvertWithPathExtension Subst AlphaConvert AlphaEquiv ReletterBoundVars ExtendPaths
define
   Gensym = Utils.gensym
   NewEnv = Utils.newEnv
   PutEnv = Utils.putEnv
   GetEnv = Utils.getEnv
   CloneEnv = Utils.cloneEnv
   fun {Subst Dict Expr}
      if {IsAtom Expr} then {Dictionary.condGet Dict Expr Expr}
	 %{ExtendPaths Dict {Dictionary.condGet Dict Expr Expr}}
      else
	 case Expr
	 of lambda(Y T Body) then
	    local Dict1 in
	       {Dictionary.clone Dict Dict1}
	       {Dictionary.remove Dict1 Y}
	       lambda(Y T {Subst Dict1 Body})
	    end
	 [] rectype(...) then
	    {Record.mapInd Expr fun {$ L V}
			     % local
% 				Dict1 = {Dictionary.clone Dict}
% 			     in
% 				{Dictionary.put Dict1 path_from_root
% 				 {Append {Dictionary.get Dict path_from_root} [L]}}
				   {Subst Dict V}
			     %end
				end
	    }
	 [] deptype(Fun Paths) then
	    deptype({Subst Dict Fun} {Subst Dict Paths})
	 else
	    % local
% 	       Dict1 = {Dictionary.clone Dict}
% 	    in
% 	       {Dictionary.put Dict1 path_from_root nil}
	    {Record.map Expr fun {$ X}
				{Subst Dict X} 
			     end
	    }
	    %end
	 end
      end
   end
   fun {BetaConvert Expr}
      local
	 Ass = {NewDictionary}
      in
	 %{Dictionary.put Ass path_from_root nil}
	 {BetaConvert1 Ass {ReletterBoundVars Expr}}
      end
   end
   fun {BetaConvertWithPathExtension Expr}
      {BetaConvertWithFun Expr ExtendPaths}
   end
   fun {BetaConvertNoReletter Expr}
     local
	Ass = {NewDictionary}
     in
	%{Dictionary.put Ass path_from_root nil}
	%{Inspector.inspect betaConvertNoReletter#Expr#{BetaConvert1 Ass Expr}}
	 {BetaConvert1 Ass Expr}
      end
   end
   fun {BetaConvert1 Ass Expr}
      {BetaConvertWithFun1 Ass Expr none}
      % case Expr
%       of apply(Fun Arg) then
% 	 case Fun
% 	 of lambda(X _ Body) then
% 	    local
% 	       Arg1 = {BetaConvert1 Ass Arg}
% 	       Ass1 = {Dictionary.clone Ass}
% 	    in
% 	       {Dictionary.put Ass1 X Arg1}
% 	       % {Inspector.inspect betaConvert1#{Dictionary.entries Ass}}
% % 		 {Inspector.inspect betaConvert1#{Dictionary.entries Ass1}}
% % 	       {Inspector.inspect betaConvert1#{Subst Ass1 Body}}
% 	       {BetaConvert1 Ass {Subst Ass1 Body}}
% 	    end
% 	 [] '#'(...) then apply(Fun {BetaConvert1 Ass Arg})
% 	 elseif {IsAtom Fun} then %{Inspector.inspect {Dictionary.entries Ass}}
% 	    apply(Fun Arg) 
% 	 else %{Inspector.inspect {Dictionary.entries Ass}}
% 	    {BetaConvert1 Ass apply({BetaConvert1 Ass Fun} {BetaConvert1 Ass Arg})}
% 	 end
%       [] lambda(X T Body) then
% 	 local
% 	    Ass1 = {Dictionary.clone Ass}
% 	 in
% 	    {Dictionary.remove Ass1 X}
% 	    lambda(X T {BetaConvert1 Ass1 Body})
% 	 end
% %       [] and(Expr1 Expr2) then
% % 	 and({BetaConvert1 Ass Expr1} {BetaConvert1 Ass Expr2})
%       [] select(R L) then
% 	 local
% 	    R1 = {BetaConvert1 Ass R}
% 	    in
% 	    {CondSelect R1 L select(R1 L)}
% 	 end
%       [] optype(...) then Expr
%       [] opsintype(...) then Expr
%       [] rectype(...) then
% 	 {Record.mapInd Expr fun {$ L V}
% 				% local
% % 				   Ass1 = {Dictionary.clone Ass}
% % 				in
% % 				   {Dictionary.put Ass1 path_from_root
% % 				    {Append {Dictionary.get Ass path_from_root} [L]}}
% 				{BetaConvert1 Ass V}
% 				%end
% 			     end
% 	  }
%       else %Expr
% 	 {Record.map Expr fun {$ Arg} {BetaConvert1 Ass Arg} end}
%       end
   end
   fun {BetaConvertWithFun Expr F}
      local
	 Ass = {NewDictionary}
      in
	 {BetaConvertWithFun1 Ass {ReletterBoundVars Expr} F}
      end
   end
   % fun {BetaConvertWithFunNoReletter Expr F}
%       local
% 	 Ass = {NewDictionary}
%       in
% 	 {BetaConvertWithFun1 Ass Expr F}
%       end
%    end
   fun {BetaConvertWithFun1 Ass Expr F}
      %{Inspector.inspect Expr#F}
      case Expr
      of apply(Fun Arg) then
	 case Fun
	 of lambda(X _ Body) then
	    local
	       Arg1 = {BetaConvertWithFun1 Ass Arg F}
	       Ass1 = {Dictionary.clone Ass}
	    in
	       case F
	       of none then
		 {Dictionary.put Ass1 X Arg1}
	       % {Inspector.inspect betaConvert1#{Dictionary.entries Ass}}
% 		 {Inspector.inspect betaConvert1#{Dictionary.entries Ass1}}
% 	       {Inspector.inspect betaConvert1#{Subst Ass1 Body}}
		  {BetaConvert1 Ass {Subst Ass1 Body}}
	       else
		  {Dictionary.put Ass1 X ttr_arg(Arg1)}
	       %{Inspector.inspect Fun#Arg1#{F {Subst Ass1 Body}}}
	       % {Inspector.inspect {Dictionary.entries Ass}}
		%  {Inspector.inspect {Dictionary.entries Ass1}}
% 	       {Inspector.inspect {BetaConvert1 Ass1 {Subst Ass1 Body}}}
		  {BetaConvertWithFun1 Ass {F {Subst Ass1 Body}} F}
	       end
	    end
	 [] _#_ then apply(Fun {BetaConvertWithFun1 Ass Arg F})
	 elseif {IsAtom Fun} then %{Inspector.inspect {Dictionary.entries Ass}}
	    apply(Fun {BetaConvertWithFun1 Ass Arg F}) 
	 else %apply({BetaConvertWithFun1 Ass Fun F} {BetaConvertWithFun1 Ass Arg F})
	    local
	       Fun1 = {BetaConvertWithFun1 Ass Fun F}
	    in
	       case Fun1
	       of !Fun then apply({BetaConvertWithFun1 Ass Fun F} {BetaConvertWithFun1 Ass Arg F})
	       else {BetaConvertWithFun1 Ass apply({BetaConvertWithFun1 Ass Fun F} {BetaConvertWithFun1 Ass Arg F}) F}
	       end
	    end
	 end
      [] lambda(X T Body) then
	 local
	    Ass1 = {Dictionary.clone Ass}
	 in
	    {Dictionary.remove Ass1 X}
	    lambda(X T {BetaConvertWithFun1 Ass1 Body F})
	 end
%       [] and(Expr1 Expr2) then
% 	 and({BetaConvert1 Ass Expr1} {BetaConvert1 Ass Expr2})
      [] select(R L) then
	 local
	    R1 = {BetaConvertWithFun1 Ass R F}
	    in
	    {CondSelect R1 L select(R1 L)}
	 end
      [] optype(...) then Expr
      [] opsintype(...) then Expr
      [] rectype(...) then
	 {Record.mapInd Expr fun {$ L V}
				% local
% 				   Ass1 = {Dictionary.clone Ass}
% 				in
% 				   {Dictionary.put Ass1 path_from_root
% 				    {Append {Dictionary.get Ass path_from_root} [L]}}
				{BetaConvertWithFun1 Ass V F}
				%end
			     end
	 }
     % elseif {IsAtom Expr} then {Inspector.inspect Expr} Expr
      else %Expr
	% {Inspector.inspect Expr#F#{Record.map Expr fun {$ Arg} {BetaConvertWithFun1 Ass Arg F} end}}
	 {Record.map Expr fun {$ Arg} {BetaConvertWithFun1 Ass Arg F} end}
      end
   end
   fun {ExtendPaths Expr}
      local
	 Env = {NewEnv}
      in
	 {PutEnv Env path_from_root nil}
	 {ExtendPaths1 Expr Env}
      end
   end
   fun {ExtendPaths1 Expr Env}
      case Expr
      of ttr_arg(Arg) then
	 {ExtendPaths2 Arg Env}
      [] rectype(...) then
	 {Record.mapInd Expr fun {$ L V}
				local
				   Env1 = {CloneEnv Env}
				in
				   {PutEnv Env1 path_from_root
				    {Append {GetEnv Env path_from_root} [L]}}
				   {ExtendPaths1 V Env1}
				end
			     end
	 }
      else {Record.map Expr
	    fun {$ V}
	       local
		  Env1 = {CloneEnv Env}
	       in
		  {PutEnv Env1 path_from_root nil}
		  {ExtendPaths1 V Env1}
	       end
	    end}
      end
   end
   fun {ExtendPaths2 Expr Env}
      if {IsAtom Expr} then Expr
      else
	 case Expr
	 of path(L) then path({Append {GetEnv Env path_from_root} L})
	 [] opsintype(...) then Expr
	 [] sintype(...) then Expr
	    % {Record.map Expr
% 	       fun {$ V}
% 		  local
% 		     Env1 = {CloneEnv Env}
% 		  in
% 		     {PutEnv Env1 path_from_root nil}
% 		     {ExtendPaths2 V Env}
% 		  end
% 	      end}
	 else {Record.map Expr
	       fun {$ V}
		%   local
% 		     Env1 = {CloneEnv Env}
% 		  in
% 		     {PutEnv Env1 path_from_root nil}
		     {ExtendPaths2 V Env}
		  %end
	      end}
	 end
      end
   end
   
				
	 

   fun {AlphaConvert Expr Var}
      case Expr
      of lambda(_ T _) then
	 lambda(Var T {BetaConvertNoReletter apply(Expr Var)})
      else Expr
      end
   end
   fun {AlphaEquiv Expr1 Expr2}
      {AlphaConvert Expr1 alphaEquivVar} == {AlphaConvert Expr2 alphaEquivVar}
   end
   fun {ReletterBoundVars Expr}
      local
	 Gensymdict = {NewDictionary}
      in
	 %{Inspector.inspect reletter#Expr#{ReletterBoundVars1 Expr Gensymdict}}
	 {ReletterBoundVars1 Expr Gensymdict}
      end
   end
   fun {ReletterBoundVars1 Expr Gensymdict}
      case Expr
      of lambda(X T Body) then
	 local
	    Var = {NewBoundVar X Gensymdict}
	 in
	    {AlphaConvert lambda(X T {ReletterBoundVars1 Body Gensymdict}) Var}
	 end
      else
	 if {IsAtom Expr} then Expr
	 else {Record.map Expr fun {$ V} {ReletterBoundVars1 V Gensymdict} end}
	 end
      end
   end
   fun {NewBoundVar X Gensymdict}
      if {Member 95 {AtomToString X}} then %checking for presence of '_'
	 {Gensym X Gensymdict}
      else {Gensym {VirtualString.toAtom X#'_'} Gensymdict}
      end
   end
   
   
   
end
