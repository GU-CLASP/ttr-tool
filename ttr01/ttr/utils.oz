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
   OS(system getEnv rand randLimits getCWD) Inspector(inspect) Search(base) RecordC(reflectArity)  Pickle(save)

export
   MemberR  ChooseRandom Failure EmptySet EmptyFun RecursiveMatchInRecord AtLeast  IsTrue Gensym NewEnv PutEnv GetEnv NewSubEnv PutSubEnv GetSubEnv CloneEnv
   Substitute SubstituteList SubstituteCompare InitTypes Test IsStableRecordC LastInStream Monitor
   %ForAtLeast
   %IsStableCell
   %AppendR
   ListToSet
   ApplyFuns
   RestRecTypeList
   TTRPath
define
   proc {MemberR X L}
      choice
	 L = X|_
      [] _|T = L in {MemberR X T}
      end
   end
   fun {ChooseRandom List}
      {Nth List ({OS.rand} mod {Length List})+1}
   end
   proc {Failure X}
      false = X == X
   end
   proc {EmptySet X}
      fail
   end
   fun {EmptyFun X}
      {Inspector.inspect ['Utils.emptyFun: attempt to apply EmptyFun to' X]}
      undefined
   end
   proc {RecursiveMatchInRecord Proc Rec Bool}
      cond {Proc Rec} then
	 Bool = true
      else if {IsRecord Rec} then
	      Bool = {Record.some Rec fun {$ X} {RecursiveMatchInRecord Proc X} end}
	   else Bool = false
	   end
      end
   end
%    proc {MemberR X L}
%       case L
%       of !X|_ then x=x
%       else case L
% 	   of _|Rst then {MemberR X Rst}
% 	   else fail
% 	   end
%       end
%    end
   fun {AtLeast N L F}
      if N == 0 then true
      else case L
	   of nil then false
	   [] X|Rst then
	      case {F X}
	      of true then {AtLeast N-1 Rst F}
	      else {AtLeast N Rst F}
	      end
	   end
      end
   end
   % proc {ForAtLeast N L Proc}
%       case N
%       of 0 then x=x
%       else case L
% 	   of nil then fail
% 	   [] X|Rst then
% 	      choice
% 		 {Proc X}
% 		 {ForAtLeast N-1 Rst Proc}
% 	      [] {ForAtLeast N Rst Proc}
% 	      end
% 	   end
%       end
%    end
   fun {ListToSet L}
      {ListToSet1 L nil}
   end
   fun {ListToSet1 L Found}
      case L
      of nil then Found
      [] X|Rst then
	 if {Member X Found} then {ListToSet1 Rst Found}
	 else {ListToSet1 Rst {Append Found [X]}}
	 end
      end
   end
   proc  {AppendR L1 L2 L}
      choice
	 L1=nil L=L2
      []   X|RestL1 = L1  X|RestL = L in {AppendR RestL1  L2 RestL}
      end
   end
   fun {IsTrue Proc}
      case {Search.base.one  Proc }
      of [_] then true
      [] nil then false
      else {Inspector.inspect ['IsTrue: unable to evaluate' Proc]} error
      end
   end
   fun {GensymGenerator Base}  %from Torbjörn -- modified
      C={NewCell 0}
   in
      fun {$} Old New in
	 {Exchange C Old New}
	 New=Old+1
	 {VirtualString.toAtom Base#Old}
      end
   end
   fun {Gensym X Dict}
      if {Member X {Dictionary.keys Dict}} then
	 {{Dictionary.get Dict X}}
      else {Dictionary.put Dict X {GensymGenerator X}}
	 {{Dictionary.get Dict X}}
      end
   end
   fun {NewEnv}
      {NewDictionary}
   end
   proc {PutEnv Env F V}
      {Dictionary.put Env F V}
   end
   fun {GetEnv Env F}
      if {And {IsDictionary Env} {IsAtom F}} then
	 {Dictionary.condGet Env F undef}
      else undef
      end
   end
   proc {NewSubEnv Env SubEnv}
      {Dictionary.put Env SubEnv {NewEnv}}
   end
   proc {PutSubEnv Env SubEnv F V}
      cond {GetEnv Env SubEnv} = undef then
	 {NewSubEnv Env SubEnv}
	 {Dictionary.put {GetEnv Env SubEnv} F V}
      else
	 {Dictionary.put {GetEnv Env SubEnv} F V}
      end
   end
   fun {GetSubEnv Env SubEnv F}
      local
	 Dict = {GetEnv Env SubEnv}
      in
	 if {IsDictionary Dict} then
	    {Dictionary.condGet Dict F undef}
	 else undef
	 end
      end
   end
   fun {CloneEnv Env}
      {Dictionary.clone Env}
   end
   fun {Substitute NewExpr OldExpr Expr}
      if OldExpr == Expr then NewExpr
      elseif {IsAtom Expr} then Expr
      else {Record.map Expr fun {$ X}
				  {Substitute NewExpr OldExpr X}
			       end
	   }
      end
   end
   fun {SubstituteList SubstList Expr}
      case SubstList
      of nil then Expr
      [] X1#X2|Rst then {SubstituteList Rst
			 {Substitute X2 X1 Expr}}
      else {Inspector.inspect ['Utils.substituteList' SubstList 'is not a substitution list']} 'not a subst list'
      end
   end
   fun {SubstituteCompare NewExpr F Expr}
      % F is a unary boolean function
      if {F Expr} then NewExpr
      elseif {IsAtom Expr} then Expr
      else {Record.map Expr fun {$ X}
				  {SubstituteCompare NewExpr F X}
			       end
	   }
      end
   end
   proc {InitTypes String}
      if {OS.system {VirtualString.toString "cp "#{OS.getEnv 'TTRHOME'}#"/ttr/"#String#"-btypes.ozf "#{OS.getEnv 'TTRHOME'}#"/ttr/btypes.ozf"}} == 0 then
	 if {OS.system {VirtualString.toString "cp "#{OS.getEnv 'TTRHOME'}#"/ttr/"#String#"-model.ozf "#{OS.getEnv 'TTRHOME'}#"/ttr/model.ozf"}} == 0 then
	    if {OS.system {VirtualString.toString "cp "#{OS.getEnv 'TTRHOME'}#"/ttr/"#String#"-preds.ozf "#{OS.getEnv 'TTRHOME'}#"/ttr/preds.ozf"}} == 0 then
	       if {OS.system "ozc -c -o "#{OS.getEnv 'TTRHOME'}#"/ttr/types.ozf "#{OS.getEnv 'TTRHOME'}#"/ttr/types.oz"} == 0 then
		  {Inspector.inspect 'Types initiated'}
	       else {Inspector.inspect 'Utils.initTypes: Problem compiling types.oz'}
	       end
	    else {Inspector.inspect ['Utils:initTypes: Problem with preds.ozf' {VirtualString.toString String#"-preds.ozf does not exist?"}]}
	    end
	 else {Inspector.inspect 'Util.initTypes: Problem with model.ozf'}
	 end
      else {Inspector.inspect 'Utils.initTypes: Problem with btypes.ozf'}
      end
   end

  %  proc {InitTypes String}
%       if {OS.system {VirtualString.toString "test -e "#String#"-btypes.ozf"}} == 0 then
% 	 if {OS.system {VirtualString.toString "test -e "#String#"-model.ozf"}} == 0 then
% 	    if {OS.system {VirtualString.toString "test -e "#String#"-preds.ozf"}} == 0 then
% 	       {Pickle.save {VirtualString.toAtom {OS.getCWD}#String#"-btypes.ozf"} {VirtualString.toString {OS.getEnv 'TTRHOME'}#"/pickles/btypes.ozp"}}
% 	       {Pickle.save {VirtualString.toAtom {OS.getCWD}#String#"-model.ozf"} {VirtualString.toString {OS.getEnv 'TTRHOME'}#"/pickles/model.ozp"}}
% 	       {Pickle.save {VirtualString.toAtom {OS.getCWD}#String#"-preds.ozf"} {VirtualString.toString {OS.getEnv 'TTRHOME'}#"/pickles/preds.ozp"}}
% 	       if {OS.system "ozc -c -o "#{OS.getEnv 'TTRHOME'}#"/ttr/types.ozf "#{OS.getEnv 'TTRHOME'}#"/ttr/types.oz"} == 0 then
% 		  {Inspector.inspect 'Types initiated'}
% 	       else {Inspector.inspect 'Utils.initTypes: Problem compiling types.oz'}
% 	       end
% 	    else {Inspector.inspect ['Utils:initTypes: Problem with preds.ozf' {VirtualString.toString String#"-preds.ozf does not exist?"}]}
% 	    end
% 	 else {Inspector.inspect 'Util.initTypes: Problem with model.ozf'}
% 	 end
%       else {Inspector.inspect 'Utils.initTypes: Problem with btypes.ozf'}
%       end
%    end
   
   proc {Test TestSuite}
      {Inspector.inspect {VirtualString.toAtom "Testing "#{Length TestSuite}#" items..."}}
      {ForAll TestSuite TestOne}
      {Inspector.inspect 'Test completed'}
   end
   proc {TestOne Item}
      if Item.2 == Item.3
      then skip
      else {Inspector.inspect
	    [{VirtualString.toAtom Item.1#": "} Item.4 'evaluates to' Item.2 'instead of' Item.3]}
      end
   end
   % fun  {IsStableCell Cell Time}
%       local
% 	 Test1 Test2
%       in
% 	 Test1 = {Access Cell}
% 	 {Delay Time}
% 	 Test2 = {Access Cell}
% 	 %{Inspector.inspect Test1#Test2}
% 	 if Test1 == Test2 then true
% 	 else false
% 	 end
%       end
%    end
   fun {IsStableRecordC R Time}
      local
	 Test1 Test2
      in
	 Test1 = {RecordC.reflectArity R}
	 {Delay Time}
	 Test2 = {RecordC.reflectArity R}
	 if Test1 == Test2 then true
	 else false
	 end
      end
   end
   fun {LastInStream Stream}
      {LastInStream1 Stream 0}
   end
   fun {LastInStream1 Stream N}
      local
	 Last = case N
		of 0 then nil
		else {Nth Stream N}
		end
	 T Last1
      in
	 thread T={Thread.this} Last1={Nth Stream N+1} end
	 if {Thread.state T} == blocked
	 then Last
	 else {LastInStream1 Stream  N+1}
	 end
      end
   end
   proc {Monitor F Port}
      local
	 Previous = {F}
      in
	 case Previous
	 of no_result then skip
	 else {Send Port Previous}
	 end
	 {Monitor1 F Port Previous 20}
      end
   end
   proc {Monitor1 F Port Previous Count}
      local
	 New = {F}
	 in
	 case Count
	 of 0 then
	    if New == Previous orelse New == no_result then skip
	    else
	       {Send Port New}
	       {Monitor1 F Port New 4}
	    end
	 else
	    if New == Previous orelse New == no_result then
	       {Delay 500}
	       {Monitor1 F Port New Count-1}
	    else
	       {Send Port New}
	       {Monitor1 F Port New 4}
	    end
	 end
      end
   end
   fun {ApplyFuns Arg Funs}
      case Funs
      of nil then Arg
      [] F|Rst then {ApplyFuns {F Arg} Rst}
      end
   end
   fun{RestRecTypeList R}
      case R
      of rectype(first: _
		 rest: Rest) then
	 Rest
      else {Inspector.inspect ['Utils.restRecTypeList: not rectype list' R]} 'not rectype list'
      end
   end
   fun{TTRPath Str}
      {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/"#Str}
   end
   
  
end

