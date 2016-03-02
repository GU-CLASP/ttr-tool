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
   System(show)
   Inspector(inspect)
   RecordC(tell width reflectArity)
   Search(base)
   %Ozcar(breakpoint)
   BTypes at 'btypes.ozf' 
   ModelModule at 'model.ozf'
   Preds  at 'preds.ozf'
   Records at 'records.ozf' 
   BConvert at 'betaconvert.ozf'
   Utils at 'utils.ozf'
   Debug at 'debug.ozf'
export
   %Parameters
   BType RType RTypeDef Model Pred PredArity 
   %Functions
   IsBType IsPfType IsFunType IsDepFunType IsJoinType IsMeetType IsOfType IsOfTypeCareful FindType FindObjects IsSubType IsSubType1 InstantiateType InstantiateTypeInModel InstantiateTypeInModelAll RefineTypeInModel RefineTypeInModelAll IsSupported SimplifyJoin SimplifyMeet IsOp SimplifyOp EvalOp SimplifyDep FlattenRelabelRecType NormalizeDep AbbrevDep SimplifyEqualitiesLeft ExploitEqualities ExportSintype
   %Auxiliary procedures
   Type  PfType FunType DepFunType JoinType ListType SinType OpSinType OpType RecType DepType  OfType SubType MeetType Meet OfType1 DisjointTypes IsBasicSubType 
   %Foreign procedures
   BetaConvert
   
define
   %% Type system parameters
   %BType = {NewCell BTypes.bType1}
   BType = BTypes.bType
   RType = {CondSelect BTypes rType
	    proc {$ T} {Member T nil} = true end}
   RTypeDef = {CondSelect BTypes rTypeDef
	       fun {$ T} nil end}
   Model = ModelModule.m
   Pred = Preds.pred
   PredArity = Preds.arity
   %%

   % A = Model.1
%    F = Model.2
   AppendPaths = Records.appendPaths
   EvalPath = Records.evalPath
   EvalSelect = Records.evalSelect
   PutValInPath = Records.putValInPath
   SubstituteValInPathList = Records.substituteValInPathList
   CloseRec = Records.closeRec
   RelabelRec = Records.relabelRec
   FlattenRec = Records.flattenRec
   %ExtendPaths = Records.extendPaths
   BetaConvert = BConvert.betaConvertWithPathExtension
 %  MemberR = Utils.memberR
   %IsTrue = Utils.isTrue
   Gensym = Utils.gensym
   NewEnv = Utils.newEnv
   PutEnv = Utils.putEnv
   GetEnv = Utils.getEnv
   NewSubEnv = Utils.newSubEnv
   PutSubEnv = Utils.putSubEnv
   GetSubEnv = Utils.getSubEnv
   CloneEnv = Utils.cloneEnv
   Substitute = Utils.substitute
   SubstituteList = Utils.substituteList
   ReportError = Debug.reportError
   OrElseError = Debug.orError
  %CatchDebugInfo = Debug.catchDebugInfo
 %  DebugFlg = Utils.debugFlg
   
   proc{Type T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {PutEnv Env root T}
	 {Type1 T Env}
      end
   end
   proc{Type1 T Env}
      choice
	 {BType T}
      [] {RType T}
      [] {PfType1 T Env}
      [] {FunType1 T Env}
      [] {DepFunType1 T Env}
      [] {JoinType1 T Env}
      [] {MeetType1 T Env}
      [] {ListType1 T Env}
      [] {SinType1 T Env}
      [] {OpSinType1 T Env}
      [] {OpType1 T Env}
      [] {RecType1 T Env}
      [] T = 'Type'
      [] T = 'RecType'
      [] T = bot
      end
   end
   fun {IsBType T}
      case {Search.base.one proc {$ _} {BType T} end}
      of [_] then true
      else false
      end
   end
   fun {IsPfType T}
      case {Search.base.one proc {$ _} {PfType T} end}
      of [_] then true
      else false
      end
   end
   fun {IsFunType T}
      case {Search.base.one proc {$ _} {FunType T} end}
      of [_] then true
      else false
      end
   end
   fun {IsDepFunType T}
      case {Search.base.one proc {$ _} {DepFunType T} end}
      of [_] then true
      else false
      end
   end
   fun {IsJoinType T}
      case {Search.base.one proc {$ _} {JoinType T} end}
      of [_] then true
      else false
      end
   end
   fun {IsMeetType T}
      case {Search.base.one proc {$ _} {MeetType T} end}
      of [_] then true
      else false
      end
   end
   proc{PfType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {PfType1 T Env}
      end
   end
   proc{PfType1 T Env}
      if {IsDet T} then
	 case T
	 of eq(Type X Y) then
	    {Type1 Type Env}
	    {OfType1 X Type Env}
	    {OfType1 Y Type Env}
	 else
	    local
	       F = {Record.label T}
	    in
	       {Pred F}
	       {OrElseError
		
		proc {$}
		   local
		      Ar = {PredArity F}
		   in
		      {Length {Arity T}} = {Length Ar}
		      {Record.forAllInd T
		       proc {$ Label Val}
			  local Env1
			  in
			     {NewEnvIfRecOrRecType Env Val Env1}
		       %{Inspector.inspect [Label Val {Nth {PredArity F} Label} {GetEnv Env1 root}]}
			     {OfType1 Val {Nth Ar Label} Env1}
		       % {Inspector.inspect 'Success'}
			  end
		       end}
		%{Inspector.inspect T}
		   end
		end
		['Types.pfType1: Ill-formed type (bad arguments)' T]
		
	       }
	    end
	 end
      else
	 local
	    F 
	 in
	    {Pred F}
	    {RecordC.tell F T}
	    local
	       Ar = {PredArity F}
	       Len = {Length Ar}
	    in
	       {For 1 Len 1 proc {$ X}
			       local
				  Env1
			       in
				  {NewEnvIfRecOrRecType Env X Env1}
				  {OfType1 T^X {Nth Ar X} Env1}
			       end
			    end}
	       {RecordC.width T Len}
	    end
	 end
      end
   end
   proc{FunType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {FunType1 T Env}
      end
   end
   proc{FunType1 T Env}
      T = funtype(...)
      {OrElseError
       proc {$}
	  {RecordC.width T 2}
	  {Record.forAll T proc {$ X}
			      local
				 Env1
			      in
				 {NewEnvIfRecOrRecType Env X Env1}
				 {Type1 X Env1}
			      end
			   end}
       end
       ['Types.funType1: Ill-formed type' T]
      }
   end
   proc{DepFunType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {DepFunType1 T Env}
      end
   end
   proc{DepFunType1 T Env}
      local
	 T1 T2 Env1 Obj Env2
      in
	 T = depfuntype(lambda(_ T1 _))
	 {OrElseError
	  proc {$}
	     {NewEnvIfRecOrRecType Env T1 Env1}
	     {InstantiateType2 T1 Env1 Obj}
	     T2 = {BetaConvert apply(T.1 Obj)}
	     {NewEnvIfRecOrRecType Env T2 Env2}
	     {OfType1 T2 'Type' Env2}
	  end
	  ['Types.depFunType1: Ill-formed type' T]
	 }
      end
   end
   proc{JoinType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {JoinType1 T Env}
      end
   end
   proc{JoinType1 T Env}
      local T1 T2 Env1  Env2 
      in
	 T = jointype(T1 T2)
	 {OrElseError
	  proc {$}
	     {NewEnvIfRecOrRecType Env T1 Env1}
	     {NewEnvIfRecOrRecType Env T2 Env2}
	     {Type1 T1 Env1} 
	     {Type1 T2 Env2}
	  end
	  ['Types.joinType1: Illformed type:' T]
	 }
      end
   end
   proc{MeetType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {MeetType1 T Env}
      end
   end
   proc{MeetType1 T Env}
      local T1 T2 Env1  Env2 
      in
	 T = meettype(T1 T2)
	 {OrElseError
	  proc {$}
	     {NewEnvIfRecOrRecType Env T1 Env1}
	     {NewEnvIfRecOrRecType Env T2 Env2}
	     {Type1 T1 Env1}
	     {Type1 T2 Env2}
	  end
	  ['Types.meetType1: Ill-formed type' T]
	 }
      end
   end
   proc{ListType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {ListType1 T Env}
      end
   end
   proc{ListType1 T Env}
      local
	 T1 Env1
      in
	 T = listtype(T1)
	 {OrElseError
	  proc {$}
	     {NewEnvIfRecOrRecType Env T1 Env1}
	     {Type1 T1 Env1}
	  end
	  ['Types.listType1: ill-formed type' T]
	 }
      end
   end
   proc{SinType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {SinType1 T Env}
      end
   end
   proc{SinType1 T Env}
      local
	 Obj T1 Env1
      in
	 T = sintype(T1 Obj)
	 {OrElseError
	  proc {$}
	     {NewEnvIfRecOrRecType Env Obj Env1}
	     {OfType1 Obj T1 Env1}
	  end
	  ['Types.sinType1: ill-formed type' T]
	 }
      end
   end
   proc{OpSinType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {OpSinType1 T Env}
      end
   end
   proc{OpSinType1 T Env}
      local
	 Op T1 Obj Env1
      in
	 T = opsintype(T1 Op)
	 {OrElseError
	  proc {$}
	     Obj = {EvalOp Op}
	     %{Inspector.inspect Obj}
	     {NewEnvIfRecOrRecType Env Obj Env1}
	     {OfType1 Obj T1 Env1}
	  end
	  ['Types.opSinType1: ill-formed type' T]
	 }
      end
   end
   proc{OpType T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {OpType1 T Env}
      end
   end
   proc{OpType1 T Env}
      local
	 Op T1 Obj Env1
      in
	 T = optype(T1 Op)
	 {OrElseError
	  proc {$}
	     Obj = {EvalOp Op}
	     %{Inspector.inspect Obj}
	     {NewEnvIfRecOrRecType Env Obj Env1}
	     {OfType1 Obj T1 Env1}
	  end
	  ['Types.opType1: ill-formed type' T]
	 }
      end
   end
   proc{Label L}
      {IsAtom L} = true
   end
   proc{RecType R}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {PutEnv Env root R}
	 {RecType1 R Env}
      end
   end
   proc{RecType1 R Env}
      R = rectype(...)
      {OrElseError
       proc {$}
	  %{Inspector.inspect R}
	  {Record.forAllInd R proc {$ L V} {Label L}
				 {DepType1 V Env}
			      end}
	  %{Inspector.inspect R}
       end
       ['Types.recType1: ill-formed type' R]
      }
   end
   proc{DepType T Env}
      {NewSubEnv Env gensymdict}
      {DepType1 T Env}
   end
   proc{DepType1 T Env}
      %Reimlpment as a case statement reporting error for ill-formed deptype
      %{Inspector.inspect T}
      choice
	 local
	    T1 Fst Rst Obj
	    Env1 = {CloneEnv Env}
	 in
	    T = deptype(lambda(_ T1 _) Fst|Rst)
	    {OrElseError
	     proc {$}
		case Fst
		of path(...) then
		   %{Inspector.inspect 'DepType1:root'#{GetEnv Env root}#Fst#{ElimDepType1 {EvalPath {SimplifyOp {GetEnv Env root}} Fst} Env}}
	%	   {Inspector.inspect {GetEnv Env root}}
		   {SubType1 {ElimDepType1 {EvalPath {SimplifyOp {GetEnv Env root}} Fst} Env} T1 Env1}
		   %{Inspector.inspect 'DepType1:SubType success'#{GetEnv Env root}}
		   {InstantiateType2 T1 Env Obj}
		   %{Inspector.inspect 'DepType1:Instantiate success'#{GetEnv Env root}#Obj}
		[] abspath(...) then
		   Obj = {EvalPath {GetEnv Env root} Fst}
		   {OfType1 Obj T1 Env}
		[] metapath(T _) then
		   Obj = {InstantiateType T}
		else {ReportError ['Types.depType1: In' T Fst 'not a path']} Obj = error
		end
		{DepType1 deptype({BetaConvert apply(T.1 Obj)} Rst) Env}
	     end
	     ['Types.depType1: ill-formed type' T]
	    }
	 end
      [] local
	    T1
	 in 
	    T = deptype(T1 nil)
	    {OrElseError
	     proc {$}
		{Type1 T1 Env}
	     end
	     ['Types.depType1: ill-formed type' T]
	    }
	 end
      [] {OrElseError
	  proc {$}
	     {Type1 T Env}
	  end
	  ['Types.depType1: ill-formed type' T]
	 }
      end
%      {Inspector.inspect T}
   end
%    fun{ElimDepType T}
%       local
% 	 Env = {NewEnv}
%       in
% 	 {PutEnv Env root {InstantiateType T}}
% 	 {ElimDepType1 T Env}
%       end
%    end
   fun{ElimDepType1 T Env}
      case T
      of deptype(lambda(_ _ _) Fst|Rst) then
	 local
	    Obj
	 in
	    cond {GetEnv Env check_loop} = true then
	       cond
		  {Member Fst {GetEnv Env paths_checked}} = true then
		  'non-wellfounded dependency'
	       else
		  {PutEnv Env paths_checked Fst|{GetEnv Env paths_checked}}
		  {ObjFromPathInType Fst Env Obj}
		  {PutEnv Env check_loop false}
		  %{PutEnv Env paths_checked nil}
		  {ElimDepType1 deptype({BetaConvert apply(T.1 Obj)} Rst) Env}
	       end
	    else
	       {PutEnv Env check_loop true}
	       {PutEnv Env paths_checked nil}
	       {ObjFromPathInType Fst Env Obj}
	       {PutEnv Env check_loop false}
	       {PutEnv Env paths_checked nil}
	       {ElimDepType1 deptype({BetaConvert apply(T.1 Obj)} Rst) Env}
	    end
	 end
      [] deptype(_ nil) then
	 {ElimDepType1 T.1 Env}
     %  [] rectype(...) then
% 	 {Record.map T fun {$ X} {ElimDepType1 X Env} end} 
      else T
      end
   end
   proc {ObjFromPathInType Path Env Obj}
      case Path
      of path(...) then
	 {InstantiateType2 {ElimDepType1 {EvalPath {GetEnv Env root} Path} Env}
	  Env Obj}
      [] abspath(...) then
	 Obj = {EvalPath {GetEnv Env root} Path}
      [] metapath(T _) then
	 Obj = {InstantiateType T}
      else Obj = [Path 'Not a path']
      end
   end
   fun {IsOfType Obj T}
      case {Search.base.one proc {$ _} {OfType Obj T} end}
      of [_] then true
      [] nil then false
      else {Inspector.inspect ['Types: IsOfType error' Obj T]} error
      end
   end
   fun {IsOfTypeCareful Obj T}
      if {IsOfType T 'Type'} then
	 {IsOfType Obj T}
      else 'Not a type.'
      end
   end
   fun {FindType Obj}
      local
	 Env = {NewEnv}
      in
	 {PutEnv Env path_from_root nil}
	 {NewSubEnv Env ass_arb}
	 {FindPfTypes {FindType1 Obj Env} Env}
      end
   end
   fun {FindType1 Obj Env}
      if {IsOfType Obj 'RecType'} then 'RecType'
      elseif {IsOfType Obj 'Type'} then 'Type'
      else
	 case Obj
	 of rec(...) then
	    local
	       Res = rectype(...)
	    in
	       {Record.forAllInd Obj proc {$ L V}
					local
					   Env1 = {CloneEnv Env}
					in
					   {PutEnv Env1 path_from_root {Append {GetEnv Env path_from_root} [L]}}
					   Res^L = {FindType1 V Env1}
					end
				     end
	       }
	       {CloseRec Res}
	    end
	 [] '#'(...) then
	    if {List.take {Atom.toString Obj.1} 2} == "pf" then Obj
	    elseif {IsOfType Obj.2 'Type'} then
	       local Path = {GetSubEnv Env ass_arb Obj.1}
	       in
		  case Path
		  of undef then
		     {PutSubEnv Env ass_arb Obj.1 {GetEnv Env path_from_root}}
		     %{Inspector.inspect Obj.1#{GetSubEnv Env ass_arb Obj.1}}
		     Obj.2
		  else
		     deptype(lambda(v Obj.2 v) [path(Path)])
		  end
	       end
	    else case {Search.base.one proc {$ T} {OfType Obj T} end}
		 of [X] then X
		 else none
		 end
	    end
	 else
	    case {Search.base.one proc {$ T} {BType T} {OfType Obj T} end}
	    of [X] then X
	    else
	      % {Inspector.inspect ['Types.findType1 not implemented for' Obj]}
	       none
	    end
	 end
      end
   end
   fun {FindPfTypes Obj Env}
      {PutEnv Env path_from_root nil}
      {FindPfTypes1 Obj Env}
   end
   fun {FindPfTypes1 Obj Env}
      case Obj
      of '#'(...) then
	 if {List.take {Atom.toString Obj.1} 2} == "pf" then
	    {PutSubEnv Env ass_arb Obj.1 {GetEnv Env path_from_root}}
	    {FindPfType Obj.2 Env}
	 else
	    {Inspector.inspect ['Types.findPfTypes: unexpected arbitrary object remaining after FindType1:' Obj]}
	    Obj
	 end
      [] rectype(...) then
	 {Record.mapInd
	  Obj
	  fun {$ L V}
	     local
		Env1 = {CloneEnv Env}
	     in
		{PutEnv Env1 path_from_root {Append {GetEnv Env path_from_root} [L]}}
		{FindPfTypes1 V Env1}
	     end
	  end
	 }
      else
	 {Record.map
	  Obj
	  fun {$ V}
	     local
		Env1 = {CloneEnv Env}
	     in
		{PutEnv Env1 path_from_root nil}
		{FindPfTypes1 V Env1}
	     end
	  end
	 }
      end
   end
   fun {FindPfType T Env}
      local
	 Gensymdict = {NewDictionary}
	 Vars = {NewCell nil}
	 Paths = {NewCell nil}
      in
	 {ConstructPfType {Record.map
			   T
			   fun {$ V}
			      case V
			      of '#'(...) then
				 {Assign Vars {Gensym v Gensymdict}#V.2|{Access Vars}}
			%	 {Inspector.inspect V.1#{GetSubEnv Env ass_arb V.1}}
				 {Assign Paths {Append {Access Paths} [path({GetSubEnv Env ass_arb V.1})]}}
				 {Access Vars}.1.1
			      [] metavar(T1 C) then
				 {Assign Vars {Gensym v Gensymdict}#V.1|{Access Vars}}
				 {Assign Paths {Append {Access Paths} [metapath(T1 C)]}}
				 {Access Vars}.1.1
			      else V
			      end
			   end
			  }
	  {Access Vars}
	  {Access Paths}}
      end
   end
   fun {ConstructPfType T Vars Paths}
      case Paths
      of nil then T
      else
	 deptype({ConstructDepTypeFun T Vars} Paths)
      end
   end
   fun {ConstructDepTypeFun T Vars}
      case Vars
      of nil then T
      [] X#T1|Rest then
	 {ConstructDepTypeFun lambda(X T1 T) Rest}
      end
   end
   
	  
			       
   % fun {FindType Obj}
%       case {Search.base.one proc {$ T} {OfType Obj T} end}
%       of [X] then X
%       [] nil then none
%       else error
%       end
%    end
   fun {FindObjects T}
      {Search.base.all proc {$ X} {OfType X T} end}
   end
   
   proc{OfType Obj T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {PutEnv Env root Obj}
	 {OfType1 Obj T Env}
      end
   end
   proc{OfType1 Obj T Env}
      choice
	 {BType T}
	 {{Model.1 T} Obj}
      [] {RType T}
	 {OfTypeDef1 Obj {RTypeDef T} Env}
	 %{Inspector.inspect [Obj T]}
      [] {PfType1 T Env}
	 case T
	 of eq(_ X Y) then
	    X = Y
	    Obj = X#Y
	 else {{Model.2 T} Obj}
	 end
      [] T = 'Type'
	 {Type1 Obj Env}
      [] T = 'RecType'
	 choice
	    {RecType Obj}
	 [] {RecType1 Obj Env}
	 end
%	 {RecType1 Obj Env}
      [] %T = bot
	 {IsDet Obj} = true
	 Obj = null
      [] {IsDet Obj} = true
	 Obj = optype(...)
	 %{Inspector.inspect Obj}
	 {OfType1 {EvalOp Obj.2} T Env}
      [] {IsDet Obj} = true
	 {SinType Obj}
	 {OfType1 Obj.1 T Env}
      [] {IsDet Obj} = true
	 {OpSinType Obj}
	 {OfType1 Obj.1 T Env}
      [] T= funtype(...) %{FunType1 T Env}
	 Obj = lambda(_ T.1 _)
	 local
	    Arg Obj1 Env1
	 in
	    {InstantiateType2 T.1 Env Arg}
	    %{Inspector.inspect Arg}
	    Obj1 = {BetaConvert apply(Obj Arg)}
	    %{Inspector.inspect ['OfType1-funtype' Obj1]}
%{Inspector.inspect ['NewEnvIfRecOrRecType OfType1-funtype' Obj1]}
	    {NewEnvIfRecOrRecType Env Obj1 Env1}
	    %{Inspector.inspect {Dictionary.entries Env1}}
	    %{Inspector.inspect Env}
	    %{Inspector.inspect Obj1}
	    %{Inspector.inspect T.2}
	    {OfType1 Obj1 T.2 Env1}
	 end
      [] T = depfuntype(...) %{DepFunType1 T Env}
	 Obj = lambda(_ T.1.2 _)
	 local
	    Arg Obj1 Env0 Env1
	 in
	%    {Inspector.inspect ['NewEnvIfRecOrRecType OfType1-depfuntype' T.1.2]}
	    {NewEnvIfRecOrRecType Env T.1.2 Env0}
	    {InstantiateType2  T.1.2  Env0 Arg}
	    Obj1 = {BetaConvert apply(Obj Arg)}
	    %{Inspector.inspect ['NewEnvIfRecOrRecType OfType1-depfuntype-1' Obj1]}
	    {NewEnvIfRecOrRecType Env Obj1 Env1}
	    {OfType1 Obj1 {BetaConvert apply(T.1 Arg)} Env1}
	 end
      [] {IsDet T} = true
	 T = jointype(...) %{JoinType1 T Env}
	 local
	    Env1
	 in
	    %{Inspector.inspect ['NewEnvIfRecOrRecType OfType1-jointype' Obj]}
	    {NewEnvIfRecOrRecType Env Obj Env1}
	    choice
	       {OfType1 Obj  T.1 Env1}
	    [] {OfType1 Obj  T.2 Env1}
	    end
	 end
      [] {IsDet T} = true
	 T = meettype(...) 
	 local
	    Env1
	 in
	    %{Inspector.inspect ['NewEnvIfRecOrRecType OfType1-meettype' Obj]}
	    {NewEnvIfRecOrRecType Env Obj Env1}
	    {OfType1 Obj  T.1 Env1}
	    {OfType1 Obj  T.2 Env1}
	 end	 
      [] T = listtype(...) %{ListType1 T Env}
	 {IsList Obj} = true
	 {ForAll Obj proc {$ X}
			local
			   Env1
			in
			   %{Inspector.inspect ['NewEnvIfRecOrRecType OfType1-listtype' X]}
			   {NewEnvIfRecOrRecType Env X Env1}
			   {OfType1 X  T.1 Env1}
			end
		     end
	 }
      [] {IsDet T} = true
	 T = sintype(...) %{SinType1 T Env}
	 Obj = T.2
      [] {IsDet T} = true
	 T = opsintype(...)
	 Obj = {EvalOp T.2}
      [] {IsDet T} = true
	 T = optype(...)
	 {OfType1 Obj {EvalOp T.2} Env}
      [] T = rectype(...)%{RecType1 T Env}
	 Obj = rec(...)
	 {Record.forAllInd T proc {$ L V} {OfType1 {CondSelect Obj L selecterror}  V Env} end}
      [] T = bot
	 Obj = rec(...)
	 %{Inspector.inspect Obj}
	 {Record.some Obj fun {$ V} {IsOfType V bot} end} = true %Should be OfType1
      [] {IsDet T} = true
	 T = deptype(...)
	 {OfType1 Obj  {ReduceDepType T Env} Env}
      [] {IsDet Obj} = true
	 %Obj = _#T
	 Obj = '#'(...)
	 Obj.2 = T
      [] {IsDet Obj} = true
	 Obj = '#'(...)
	 Obj.2 = meettype(...)
	 local T1 = {SimplifyMeet Obj.2}
	 in
	    cond T1 = meettype(...) then
	       cond {IsSubType T1.1 T} orelse {IsSubType T1.2 T} = true then skip 
	       else %{Inspector.inspect uncertain(ofType Obj T) }
		  fail %false == true = true
	       end
	    else {IsSubType T1 T} = true
	    end
	    
	 end
	 
	 % try
% 	    {fun {$ T1} 
% 		case T1
% 		of meettype(...) then raise uncertain(ofType Obj T) end 
% 		else {IsSubType T1 T}
% 		end
% 	     end
% 	     {SimplifyMeet Obj.2}} = true
% 	 catch E then {Inspector.inspect E} {Thread.terminate {Thread.this}} end
	 	 % cond
% 	 {IsSubType Obj.2.1 T}
% 	 orelse {IsSubType Obj.2.2 T}
% 	 orelse {SimplifyMeet Obj.2} == bot
% 	 = true
      % then
% 	    skip
% 	    else
	    %{Inspector.inspect uncertain(ofType Obj T)}
	% end
      [] T = bot
	 Obj = '#'(...)
	 local T1 T2
	 in
	    Obj.2 = jointype(T1 T2)
	    {IsSubType T1 bot} = true
	    {IsSubType T2 bot} = true
	 end
      [] T = bot
	 Obj = '#'(...)
	 Obj.2 = meettype(...)
	 {Inspector.inspect uncertain(ofType Obj T)}
      [] {IsDet Obj} = true
	 {IsAtom Obj} = true
	 {IsDet T} = true
	 {GetSubEnv Env vartypeass Obj} = T
      [] {IsDet Obj} = true
	 Obj = metavar(T _)
      []local F Obj1 T1 Env1
	in
	   {IsDet Obj} = true
	   Obj = apply(F Obj1)
	   {OfType1 F funtype(T1 T) Env}
	   %{Inspector.inspect ['NewEnvIfRecOrRecType OfType1-apply' Obj1]}
	   {NewEnvIfRecOrRecType Env Obj1 Env1}
	   {OfType1 Obj1 T1 Env1}
	end
      []local Obj1 Obj2 
	in
	   {IsDet Obj} = true
	   {IsDet T} = true
	   T = listtype(_)
	   Obj = append(Obj1 Obj2)
	   {OfType1 Obj1 T Env}
	   {OfType1 Obj2 T Env}
	end
      []local Obj1 L T1
	in
	   {IsDet Obj} = true
	   Obj = select(Obj1 L) %Change select to work with paths
	   case Obj1
	   of '#'(...) then T1 = Obj1.2
	   else T1 = {GetEnv {GetEnv Env vartypeass} Obj1}
	   end
	   %{OfType1 Obj1 T1 Env}
	   {SubType1 T1 rectype(L:T) Env}
	end
      end
   end
   % fun {IsOfTypeDef1 Obj TypeDef Env}
%       case TypeDef of
% 	 nil then false
%       [] T|TypeDefRest then
% 	 cond {Inspector.inspect [Obj T]} {OfType1 Obj T Env} then  true
% 	 %else {IsOfTypeDef1 Obj TypeDefRest Env}
% 	 end
%       end
%    end

   proc {OfTypeDef1 Obj TypeDef Env}
      local
	 T TypeDefRest
      in
	 TypeDef = T|TypeDefRest
	 choice
	    {OfType1 Obj T Env}
	 [] {OfTypeDef1 Obj TypeDefRest Env}
	 end
      end
   end
   
   fun{InstantiateType T}
      local 
	 Res ={CondSelect {Search.base.one
			   proc{$ Y} local Env = {NewEnv}
				     in
					{NewSubEnv Env gensymdict}
					{NewSubEnv Env vartypeass}
				%{PutEnv Env root Y}
					%{InstantiateType1 {SimplifyOp T} Env Y}
					{InstantiateType1 T Env Y}
				%{InstantiateDepTypesInRec X Env Y}
				%{GetEnv Env flg} = false
				     end
			   end} 1 none}
      in
	 Res
	    % if {Record.some Res fun {$ X} X == null end} then null
% 	    else  Res
% 	    end
	
      end
   end
   proc{InstantiateType1 T Env Obj}
      local
	 Obj1 Obj2
      in
	 {PutEnv Env root Obj1}
	 {InstantiateType2 T Env Obj1}
	 {InstantiateDepTypesInRec Obj1 Env Obj2}
	 if {Record.some Obj2 fun {$ X} X == null end} then
	    Obj = null
	 else Obj = Obj2
	 end
      end
   end
   proc{InstantiateType2 T Env Obj}
      local
	 GensymDict = {GetEnv Env gensymdict}
      in
	 %{Inspector.inspect 'InstatiateType2'#T}
	 choice
	    {IsDet Obj} = true
	    {OfType1 Obj T Env}
	 [] {BType T}
	    Obj = {Gensym a GensymDict}#T
	 [] {RType T}
	    Obj = {Gensym a GensymDict}#T
	 [] {PfType1 T Env}
	    Obj = {Gensym pf GensymDict}#T
	 [] T = 'Type'
	    Obj = {Gensym 'T' GensymDict}#T
	 [] T = 'RecType'
	    Obj = {Gensym 'R' GensymDict}#T
	 [] T = bot
	    Obj = null
	 [] {FunType1 T Env}
	    local
	       X = {Gensym x GensymDict}
	       Body
	    in
	       {InstantiateType2 T.2 Env Body}
	       %Obj = lambda(X T.1 {EvalOp apply(lambda(x T.1 Body) X)})
	       Obj = lambda(X T.1 Body)
	    end
	 [] {DepFunType1 T Env}
	    local
	       X = {Gensym x GensymDict}
	       Body  Env1 %Body1
	    in
	       {PutSubEnv Env vartypeass X T.1.2}
	       {CloneEnv Env Env1}
	       {InstantiateType1 {BetaConvert apply(T.1 X)} Env1 Body}
	       %{InstantiateType2 {BetaConvert apply(T.1 X)} Env1 Body1}
	       %{InstantiateDepTypesInRec Body1 Env1 Body}
	       Obj = lambda(X T.1.2 Body)
	    end
	 [] {JoinType1 T Env}
	    Obj = {Gensym a GensymDict}#T
	 [] {MeetType1 T Env}
	    Obj = {Gensym a GensymDict}#T
	 [] {ListType1 T Env}
	    Obj = {Gensym 'L' GensymDict}#T
	 [] T = '#'(...)
	    Obj = case T.2
		  of 'RecType' then {Gensym r GensymDict}#T
		  else {Gensym a GensymDict}#T
		  end
	 [] %{SinType1 T Env}
	    T = sintype(...)
	    Obj = T.2
	 [] %{OpType1 T Env}
	    T = opsintype(...)
	    %{Inspector.inspect ['InstantiateType2:' T#{EvalOp T.2}]}
	    Obj = {EvalOp T.2}
	 [] T = optype(...)
	    local
	       Env1
	       T1 = {EvalOp T.2}
	    in
	       {NewEnvIfRecOrRecType Env T1 Env1}
	    %{Inspector.inspect T#{EvalOp T.2}}
	       {InstantiateType1 T1 Env1 Obj}
	    %{Inspector.inspect 'Instantiation:'#T1#Obj}
	    end
	 [] T = deptype(...)
	 %{InstantiateType1 {ReduceDepType T Root GensymDict} Root GensymDict Obj}
	 %{InstantiateDepType T Root GensymDict Obj}
	    Obj = T
	    %Obj = {ElimDepType1 T Env}
	 [] T = rectype(...)
	    Obj = rec(...)
	    {Record.forAllInd T proc {$ L V} {InstantiateType2 V  Env Obj^L} end}
	    {RecordC.width Obj {Length {RecordC.reflectArity Obj}}}
	 end
      end
   end


   
   proc{InstantiateDepTypesInRec R Env NewR}
      local
	 NewR1 Env1
      in
	 {PutEnv Env flg false}
	 {PutEnv Env flg_inst_dep_type false}
	 {InstantiateDepTypesInRec1 R Env NewR1}
	 cond
	    {GetEnv Env flg} = true
	    {GetEnv Env flg_inst_dep_type} = false then
	    NewR = 'non-wellfounded dependency'
	 []
	    {GetEnv Env flg} = true then
	    Env1 = {CloneEnv Env}
	    {PutEnv Env1 flg false}
	    {PutEnv Env1 flg_inst_dep_type false}
	    {PutEnv Env1 root NewR1}
	    {InstantiateDepTypesInRec NewR1 Env1 NewR}
	 else NewR = NewR1
	 end
      end
   end
   
   proc{InstantiateDepTypesInRec1 R Env NewR}
      %{Inspector.inspect R}
      case R 
      of deptype(...) then
	 {InstantiateDepType R Env NewR} 
      [] rec(...) then
	 NewR = rec(...)
	 {RecordC.width NewR {Width R}}
	 {Record.forAllInd R proc {$ L V}  {InstantiateDepTypesInRec1 V Env NewR^L}  end} 
      else NewR = R
      end
   end
   
   proc{InstantiateDepType T Env Obj}
      %{Inspector.inspect T}
      choice
	 local
	    Fst Rst Obj1
	 in
	    T = deptype(lambda(_ _ _) Fst|Rst)
	    %{InstantiateType1 {EvalPath Root Fst} Root GensymDict Obj1}
	    Obj1 = {EvalPath {GetEnv Env root} Fst}
	    %{Inspector.inspect Obj1}
	    %{Inspector.inspect 'InstantiateDepType'#T#Fst#Obj1#{BetaConvert apply(T.1 Obj1)}}
	    case Obj1
	    of deptype(...) then Obj = T {PutEnv Env flg true}
	      %[] metavar(...) then Obj = T {PutEnv Env flg true}
	    [] select(...) then Obj = T {PutEnv Env flg true}  %Why did I want this?
	    %[] Obj1 = undef then Obj = T {PutEnv Env flg true}
	    else %{Inspector.inspect 'InstantiateDepType-Else'#T}
	       %{Inspector.inspect {BetaConvert apply(T.1 Obj1)}}
	       {InstantiateDepType deptype({BetaConvert apply(T.1 Obj1)} Rst) Env Obj} {PutEnv Env flg_inst_dep_type true}
	       %{Inspector.inspect 'InstantantiateDepType'#apply(T.1 Obj)#{BetaConvert apply(T.1 Obj1)}}
%	       {Inspector.inspect 'InstantiateDepType'#Obj}
	    end
	 end
      [] T = deptype(_ nil)
%	 {Inspector.inspect 'InstantiateDepType-nil'#T}
	 % Obj = T.1 
	 {InstantiateType2 T.1 Env Obj} {PutEnv Env flg true}
	 % local Obj1
% 	 in
% 	    {InstantiateType2 T.1 Env Obj1}
% 	    {InstantiateDepTypesInRec Obj1 Env Obj}
% 	 end
      end
     % {Inspector.inspect Obj}
   end

   fun{InstantiateTypeInModelAll T M}
      {Search.base.all
		   proc{$ Y} local Env = {NewEnv}
			     in
				{NewSubEnv Env gensymdict}
				{NewSubEnv Env vartypeass}
				%{PutEnv Env root Y}
					%{InstantiateType1 {SimplifyOp T} Env Y}
				{InstantiateTypeInModel1 T Env M Y}
				%{InstantiateDepTypesInRec X Env Y}
				%{GetEnv Env flg} = false
			     end
		   end} 
     
   end   

   proc{InstantiateTypeInModelAll1 T M Env Objs}
      Objs = {Search.base.all
	      proc{$ Y} local Env1={CloneEnv Env}
			in
			   {InstantiateTypeInModel1 T Env1 M Y}
			end
		 end
	     }
     
   end
   
   fun{InstantiateTypeInModel T M}
      {CondSelect {Search.base.one
		   proc{$ Y} local Env = {NewEnv}
			     in
				{NewSubEnv Env gensymdict}
				{NewSubEnv Env vartypeass}
				%{PutEnv Env root Y}
					%{InstantiateType1 {SimplifyOp T} Env Y}
				{InstantiateTypeInModel1 T Env M Y}
				%{InstantiateDepTypesInRec X Env Y}
				%{GetEnv Env flg} = false
			     end
		   end} 1 none}
     
   end
   proc{InstantiateTypeInModel1 T Env M Obj}
      local
	 Obj1 Obj2
      in
	 {PutEnv Env root Obj1}
	 {InstantiateTypeInModel2 T Env M Obj1}
	 %{Inspector.inspect Obj1}
	 {InstantiateDepTypesInRecInModel Obj1 Env M Obj2}
	 if {Record.some Obj2 fun {$ X} X == null end} then
	    Obj = null
	 else Obj = Obj2
	 end
      end
   end
   proc{InstantiateTypeInModel2 T Env M Obj}
      local
	 GensymDict = {GetEnv Env gensymdict}
      in
	 %{Inspector.inspect 'InstatiateType2'#T}
	 choice
	    {IsDet Obj} = true
	    {OfType1 Obj T Env}
	 [] {BType T}
	    %Obj = {Gensym a GensymDict}#T
	    {{M.1 T} Obj}
	 [] {RType T}
	    {Inspector.inspect ['Types.instantiateTypeInModel2: RType instantiation not implemented' T]}
	    Obj = {Gensym a GensymDict}#T
	 [] {PfType1 T Env}
	    %Obj = {Gensym pf GensymDict}#T
	    {{M.2 T} Obj}
	 [] T = 'Type'
	    %{Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    {Type Obj}
	    %Obj = {Gensym 'T' GensymDict}#T
	 [] T = 'RecType'
	    %{Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    local
	       T1
	    in
	       {Type T1}
	       Obj = rectype(x: T1)
	    end
	   % Obj = {Gensym 'R' GensymDict}#T
	 [] T = bot
	    Obj = null
	%  [] T = neg(_)
% 	    case {InstantiateTypeInModel1 T.1 Env M}
% 	    of null then
% 	       Obj = true
% 	    [] true then Obj = false
% 	    [] false then Obj = true
% 	    else Obj = false
% 	    end
	 [] {FunType1 T Env}
	    local
	       X = {Gensym x GensymDict}
	       Body1 = {InstantiateTypeInModel T.1 M}
	       Body2 = {InstantiateTypeInModel T.2 M}
	    in
	       %{Inspector.inspect Body1#Body2}
	       case Body1
	       of none then Obj = lambda(X T.1 pf(T.2)) %{Inspector.inspect Obj}
	       [] null then Obj = lambda(X T.1 pf(T.2))
	       else case Body2
		    of none then Obj = none
		    [] null then Obj = none
		    else Obj = lambda(X T.1 pf(T.2))
		    end
	       end

	    end
	 [] {DepFunType1 T Env}
	    %{Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    %{Inspector.inspect {InstantiateTypeInModelAll1 T.1.2 M Env}}
	    {All {InstantiateTypeInModelAll1 T.1.2 M Env}
	     fun {$ X}
		case {InstantiateTypeInModel1 {BetaConvert apply(T.1 X)} Env M}
		     of none then false
		     [] null then false
		     else true
		     end
	     end
	    } = true
	    Obj = lambda(T.1.1 T.1.2 pf(T.1.3))
	   %  local
% 	       X = {Gensym x GensymDict}
% 	       Body  Env1 %Body1
% 	    in
% 	       {PutSubEnv Env vartypeass X T.1.2}
% 	       {CloneEnv Env Env1}
% 	       {InstantiateTypeInModel1 {BetaConvert apply(T.1 X)} Env1 M Body}
% 	       %{Inspector.inspect Body}
% 	       %{InstantiateType2 {BetaConvert apply(T.1 X)} Env1 Body1}
% 	       %{InstantiateDepTypesInRec Body1 Env1 Body}
% 	       Obj = lambda(X T.1.2 Body) %{Inspector.inspect Obj}
% 	    end
	 [] {JoinType1 T Env}
	    choice
	       local
		  Env1 = {CloneEnv Env}
	       in
		  {InstantiateTypeInModel1 T.1 Env1 M Obj}
	       end
	    []
	       local
		  Env1 = {CloneEnv Env}
	       in
		  {InstantiateTypeInModel1 T.2 Env1 M Obj}
	       end
	    end
	    %Obj = {Gensym a GensymDict}#T
	 [] {MeetType1 T Env}
	    local
	       Env1 = {CloneEnv Env}
	       Env2 = {CloneEnv Env}
	    in
	       {InstantiateTypeInModel1 T.1 Env1 M Obj}
	       {InstantiateTypeInModel1 T.2 Env2 M Obj}
	    end
	    %Obj = {Gensym a GensymDict}#T
	 [] {ListType1 T Env}
	    {Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    Obj = {Gensym 'L' GensymDict}#T
	 [] T = '#'(...)
	    {Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    Obj = case T.2
		  of 'RecType' then {Gensym r GensymDict}#T
		  else {Gensym a GensymDict}#T
		  end
	 [] %{SinType1 T Env}
	    T = sintype(...)
	    Obj = T.2
	 [] %{OpType1 T Env}
	    T = opsintype(...)
	    %{Inspector.inspect ['InstantiateType2:' T#{EvalOp T.2}]}
	    Obj = {EvalOp T.2}
	 [] T = optype(...)
	    local
	       Env1
	       T1 = {EvalOp T.2}
	    in
	       {NewEnvIfRecOrRecType Env T1 Env1}
	    %{Inspector.inspect T#{EvalOp T.2}}
	       {InstantiateTypeInModel1 T1 Env1 M Obj}
	    %{Inspector.inspect 'Instantiation:'#T1#Obj}
	    end
	 [] T = deptype(...)
	 %{InstantiateType1 {ReduceDepType T Root GensymDict} Root GensymDict Obj}
	 %{InstantiateDepType T Root GensymDict Obj}
	    Obj = T
	    %Obj = {ElimDepType1 T Env}
	 [] T = rectype(...)
	    Obj = rec(...)
	    {Record.forAllInd T proc {$ L V} {InstantiateTypeInModel2 V  Env M Obj^L} end}
	    {RecordC.width Obj {Length {RecordC.reflectArity Obj}}}
	 end
      end
   end
   proc{InstantiateDepTypesInRecInModel R Env M NewR}
      local
	 NewR1 Env1
      in
	 {PutEnv Env flg false}
	 {PutEnv Env flg_inst_dep_type false}
	 {InstantiateDepTypesInRecInModel1 R Env M NewR1}
	 cond
	    {GetEnv Env flg} = true
	    {GetEnv Env flg_inst_dep_type} = false then
	    NewR = 'non-wellfounded dependency'
	 []
	    {GetEnv Env flg} = true then
	    Env1 = {CloneEnv Env}
	    {PutEnv Env1 flg false}
	    {PutEnv Env1 flg_inst_dep_type false}
	    {PutEnv Env1 root NewR1}
	    {InstantiateDepTypesInRecInModel NewR1 Env1 M NewR}
	 else NewR = NewR1
	 end
      end
   end
   
   proc{InstantiateDepTypesInRecInModel1 R Env M NewR}
      %{Inspector.inspect R}
      case R 
      of deptype(...) then
	 {InstantiateDepTypeInModel R Env M NewR} 
      [] rec(...) then
	 NewR = rec(...)
	 {RecordC.width NewR {Width R}}
	 {Record.forAllInd R proc {$ L V}  {InstantiateDepTypesInRecInModel1 V Env M NewR^L}  end} 
      else NewR = R
      end
   end
   
   proc{InstantiateDepTypeInModel T Env M Obj}
      %{Inspector.inspect T}
      choice
	 local
	    Fst Rst Obj1
	 in
	    T = deptype(lambda(_ _ _) Fst|Rst)
	    %{InstantiateType1 {EvalPath Root Fst} Root GensymDict Obj1}
	    Obj1 = {EvalPath {GetEnv Env root} Fst}
%	    {Inspector.inspect 'InstantiateDepType'#T#Fst#Obj1#{BetaConvert apply(T.1 Obj1)}}
	    case Obj1
	    of deptype(...) then Obj = T {PutEnv Env flg true}
	      %[] metavar(...) then Obj = T {PutEnv Env flg true}
	    %[] select(...) then Obj = T {PutEnv Env flg true}  %Why did I want this?
	    %[] Obj1 = undef then Obj = T {PutEnv Env flg true}
	    else %{Inspector.inspect 'InstantiateDepType-Else'#T}
	       {InstantiateDepTypeInModel deptype({BetaConvert apply(T.1 Obj1)} Rst) Env M Obj} {PutEnv Env flg_inst_dep_type true}
	       %{Inspector.inspect 'InstantantiateDepType'#apply(T.1 Obj)#{BetaConvert apply(T.1 Obj1)}}
%	       {Inspector.inspect 'InstantiateDepType'#Obj}
	    end
	 end
      [] T = deptype(_ nil)
%	 {Inspector.inspect 'InstantiateDepType-nil'#T}
	 % Obj = T.1 
	 {InstantiateTypeInModel2 T.1 Env M Obj} {PutEnv Env flg true}
	 % local Obj1
% 	 in
% 	    {InstantiateType2 T.1 Env Obj1}
% 	    {InstantiateDepTypesInRec Obj1 Env Obj}
% 	 end
      end
     % {Inspector.inspect Obj}
   end

   %Refine types in model
   fun{RefineTypeInModelAll T M}
      local
	 Res = {Search.base.all
		proc{$ Y} local Env = {NewEnv}
			  in
			     {NewSubEnv Env gensymdict}
			     {NewSubEnv Env vartypeass}
				%{PutEnv Env root Y}
					%{InstantiateType1 {SimplifyOp T} Env Y}
			     {RefineTypeInModel1 T Env M Y}
				%{InstantiateDepTypesInRec X Env Y}
				%{GetEnv Env flg} = false
			  end
		end}
      in
	 case Res of nil then T else Res end
      end
      
	 
     
   end   

  %  proc{RefineTypeInModelAll1 T M Env Objs}
%       Objs = {Search.base.all
% 	      proc{$ Y} local Env1={CloneEnv Env}
% 			in
% 			   {RefineTypeInModel1 T Env1 M Y}
% 			end
% 		 end
% 	     }
     
%    end
   
   fun{RefineTypeInModel T M}
    %  {Inspector.inspect refinetypeinmodel}
      {CondSelect {Search.base.one
		   proc{$ Y} local Env = {NewEnv}
			     in
				{NewSubEnv Env gensymdict}
				{NewSubEnv Env vartypeass}
				%{PutEnv Env root Y}
					%{InstantiateType1 {SimplifyOp T} Env Y}
				{RefineTypeInModel1 T Env M Y}
				%{InstantiateDepTypesInRec X Env Y}
				%{GetEnv Env flg} = false
			     end
		   end} 1 T}
     
   end
   proc{RefineTypeInModel1 T Env M Obj}
      local
	 Obj1 Obj2
      in
	 {PutEnv Env root Obj1}
	 {RefineTypeInModel2 T Env M Obj1}
	 % {Inspector.inspect refineTypeInModel1#T}
% 	 {Inspector.inspect Obj1}
	 {RefineDepTypesInRecTypeInModel Obj1 Env M Obj2}
	 if {Record.some Obj2 fun {$ X} X == null end} then
	    Obj = null
	 else Obj = Obj2
	 end
      end
   end
   proc{RefineTypeInModel2 T Env M NewT}
      local
	 GensymDict = {GetEnv Env gensymdict}
      in
	 %{Inspector.inspect 'InstatiateType2'#T}
	 choice
	    {IsDet NewT} = true
	    local Obj in
	       NewT = sintype(T Obj)
	       {IsDet Obj} = true
	       {OfType1 Obj T Env}
	    end
	 [] {BType T}
	    %NewT = sintype(T {Gensym a GensymDict}#T)
	    local Obj in
	       {{M.1 T} Obj}
	       NewT = sintype(T Obj)
	    end
	 [] {RType T}
	    {Inspector.inspect ['Types.refineTypeInModel2: RType instantiation not implemented' T]}
	    NewT = sintype(T {Gensym a GensymDict}#T)
	 [] {PfType1 T Env}
	    %Obj = {Gensym pf GensymDict}#T
	    local Obj in
	       {{M.2 T} Obj}
	       NewT = sintype(T Obj)
	    end
	 [] T = 'Type'
	    %{Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    local Obj in
	       {Type Obj}
	       NewT = sintype(T Obj)
	    end
	    %Obj = {Gensym 'T' GensymDict}#T
	 [] T = 'RecType'
	    %{Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    local
	       T1
	    in
	       {Type T1}
	       NewT = sintype(T rectype(x: T1))
	    end
	   % Obj = {Gensym 'R' GensymDict}#T
	 [] T = bot
	    NewT = sintype(T null)
	%  [] T = neg(_)
% 	    case {InstantiateTypeInModel1 T.1 Env M}
% 	    of null then
% 	       Obj = true
% 	    [] true then Obj = false
% 	    [] false then Obj = true
% 	    else Obj = false
% 	    end
	 [] {FunType1 T Env}
	    local
	       X = {Gensym x GensymDict}
	       Body1 = {InstantiateTypeInModel T.1 M}
	       Body2 = {InstantiateTypeInModel T.2 M}
	    in
	       %{Inspector.inspect Body1#Body2}
	       case Body1
	       of none then NewT = sintype(T lambda(X T.1 pf(T.2))) %{Inspector.inspect Obj}
	       [] null then NewT = sintype(T lambda(X T.1 pf(T.2)))
	       else case Body2
		    of none then NewT = none
		    [] null then NewT = none
		    else NewT = sintype(T lambda(X T.1 pf(T.2)))
		    end
	       end

	    end
	 [] {DepFunType1 T Env}
	    %{Inspector.inspect ['Types.instantiateTypeInModel2: Type instantiation not implemented' T]}
	    %{Inspector.inspect {InstantiateTypeInModelAll1 T.1.2 M Env}}
	    {All {InstantiateTypeInModelAll1 T.1.2 M Env}
	     fun {$ X}
		case {InstantiateTypeInModel1 {BetaConvert apply(T.1 X)} Env M}
		     of none then false
		     [] null then false
		     else true
		     end
	     end
	    } = true
	    NewT = sintype(T lambda(T.1.1 T.1.2 pf(T.1.3)))
	   %  local
% 	       X = {Gensym x GensymDict}
% 	       Body  Env1 %Body1
% 	    in
% 	       {PutSubEnv Env vartypeass X T.1.2}
% 	       {CloneEnv Env Env1}
% 	       {InstantiateTypeInModel1 {BetaConvert apply(T.1 X)} Env1 M Body}
% 	       %{Inspector.inspect Body}
% 	       %{InstantiateType2 {BetaConvert apply(T.1 X)} Env1 Body1}
% 	       %{InstantiateDepTypesInRec Body1 Env1 Body}
% 	       Obj = lambda(X T.1.2 Body) %{Inspector.inspect Obj}
% 	    end
	 [] {JoinType1 T Env}
	    choice
	       local
		  Env1 = {CloneEnv Env}
	       in
		  {RefineTypeInModel1 T.1 Env1 M NewT}
	       end
	    []
	       local
		  Env1 = {CloneEnv Env}
	       in
		  {RefineTypeInModel1 T.2 Env1 M NewT}
	       end
	    end
	    %Obj = {Gensym a GensymDict}#T
	 [] {MeetType1 T Env}
	    local
	       Env1 = {CloneEnv Env}
	       Env2 = {CloneEnv Env}
	       Obj
	    in
	       {RefineTypeInModel1 T.1 Env1 M Obj}
	       {RefineTypeInModel1 T.2 Env2 M Obj}
	       NewT = sintype(T Obj)
	    end
	    %Obj = {Gensym a GensymDict}#T
	 [] {ListType1 T Env}
	    {Inspector.inspect ['Types.refineTypeInModel2: Type instantiation not implemented' T]}
	    NewT = T
	 [] T = '#'(...)
	    {Inspector.inspect ['Types.refineTypeInModel2: Type instantiation not implemented' T]}
	    NewT = T
	    % Obj = case T.2
% 		  of 'RecType' then {Gensym r GensymDict}#T
% 		  else {Gensym a GensymDict}#T
% 		  end
	 [] %{SinType1 T Env}
	    T = sintype(...)
	    NewT = T
	 [] %{OpType1 T Env}
	    T = opsintype(...)
	    %{Inspector.inspect ['InstantiateType2:' T#{EvalOp T.2}]}
	    NewT = T
	 [] T = optype(...)
	    local
	       Env1
	       T1 = {EvalOp T.2}
	    in
	       {NewEnvIfRecOrRecType Env T1 Env1}
	    %{Inspector.inspect T#{EvalOp T.2}}
	       {RefineTypeInModel1 T1 Env1 M NewT}
	    %{Inspector.inspect 'Instantiation:'#T1#Obj}
	    end
	 [] T = deptype(...)
	 %{InstantiateType1 {ReduceDepType T Root GensymDict} Root GensymDict Obj}
	 %{InstantiateDepType T Root GensymDict Obj}
	    NewT = T
	    %Obj = {ElimDepType1 T Env}
	 [] T = rectype(...)
	    NewT = rectype(...)
	    {Record.forAllInd T proc {$ L V} {RefineTypeInModel2 V  Env M NewT^L} end}
	    {RecordC.width NewT {Length {RecordC.reflectArity NewT}}}
	% [] NewT = T
	 end
      end
   end
   proc{RefineDepTypesInRecTypeInModel R Env M NewR}
      local
	 NewR1 Env1
      in
	 {PutEnv Env flg false}
	 {PutEnv Env flg_inst_dep_type false}
	 {RefineDepTypesInRecTypeInModel1 R Env M NewR1}
	 cond
	    {GetEnv Env flg} = true
	    {GetEnv Env flg_inst_dep_type} = false then
	    NewR = 'non-wellfounded dependency'
	 []
	    {GetEnv Env flg} = true then
	    Env1 = {CloneEnv Env}
	    {PutEnv Env1 flg false}
	    {PutEnv Env1 flg_inst_dep_type false}
	    {PutEnv Env1 root NewR1}
	    {RefineDepTypesInRecTypeInModel NewR1 Env1 M NewR}
	 else NewR = NewR1
	 end
      end
   end
   
   proc{RefineDepTypesInRecTypeInModel1 R Env M NewR}
      %{Inspector.inspect R}
      case R 
      of deptype(...) then
	 {RefineDepTypeInModel R Env M NewR} 
      [] rectype(...) then
	 NewR = rectype(...)
	 {RecordC.width NewR {Width R}}
	 {Record.forAllInd R proc {$ L V}  {RefineDepTypesInRecTypeInModel1 V Env M NewR^L}  end} 
      else NewR = R
      end
   end
   
   proc{RefineDepTypeInModel T Env M NewT}
      %{Inspector.inspect T}
      choice
	 local
	    Fst Rst NewT1
	 in
	    T = deptype(lambda(_ _ _) Fst|Rst)
	    %{InstantiateType1 {EvalPath Root Fst} Root GensymDict Obj1}
	    NewT1 = {EvalPath {GetEnv Env root} Fst} 
	    %{Inspector.inspect Env}
	   %  {Inspector.inspect {GetEnv Env root}}
% 	    {Inspector.inspect {EvalPath {GetEnv Env root} Fst}}
% 	    {Inspector.inspect NewT1}
%	    {Inspector.inspect 'RefineDepTypeInModel'#T#Fst#Obj1#{BetaConvert apply(T.1 Obj1)}}
	    case NewT1
	    of deptype(...) then NewT = T {PutEnv Env flg true}
	      %[] metavar(...) then Obj = T {PutEnv Env flg true}
	    %[] select(...) then Obj = T {PutEnv Env flg true}  %Why did I want this?
	    %[] Obj1 = undef then Obj = T {PutEnv Env flg true}
	    else %{Inspector.inspect 'InstantiateDepType-Else'#T}
	       {RefineDepTypeInModel deptype({BetaConvert apply(T.1 {InstantiateTypeInModel NewT1 M})} Rst) Env M NewT} {PutEnv Env flg_inst_dep_type true}
	       %{Inspector.inspect 'InstantantiateDepType'#apply(T.1 Obj)#{BetaConvert apply(T.1 Obj1)}}
%	       {Inspector.inspect 'InstantiateDepType'#Obj}
	    end
	 end
      [] T = deptype(_ nil)
%	 {Inspector.inspect 'InstantiateDepType-nil'#T}
	 % Obj = T.1 
	 {RefineTypeInModel2 T.1 Env M NewT} {PutEnv Env flg true}
	 % local Obj1
% 	 in
% 	    {InstantiateType2 T.1 Env Obj1}
% 	    {InstantiateDepTypesInRec Obj1 Env Obj}
% 	 end
      end
     % {Inspector.inspect Obj}
   end


   %End refine types in model

   fun{IsSupported Type}
      case {InstantiateTypeInModel Type Model}
      of none then false
      [] null then false
      else true
      end
   end
	    
   fun{ReduceDepType  T Env}
      case T
      of deptype(lambda(_ _ _) Fst|Rst) then
	 %{Inspector.inspect {BetaConvert apply(T.1 {EvalPath {GetEnv Env root} Fst})}}
	 {ReduceDepType deptype({BetaConvert apply(T.1 {EvalPath {GetEnv Env root} Fst})} Rst) Env}
      [] deptype(T1 nil) then
	 T1
      end
   end
   % fun{InstantiatePath X Path T Root GensymDict}
%       case Path
%       of path(Fst|Rst) then
% 	 {InstantiatePath X^Fst path(Rst) T Root GensymDict}
%       [] path(Fst|nil) then
% 	 {InstantiateType X}
%       end
%    end

    %  proc{SubType T1 T2}
%       {OfType {InstantiateType T1} T2}
%    end
   fun {IsSubType T1 T2}
      case {Search.base.one proc {$ _} {SubType T1 T2} end}
      of [_] then true
      [] nil then false
      else {Inspector.inspect ['Types.isSubType error: ' T1 T2]}
      end
   end

   fun {IsSubType1 T1 T2 Env}
      case {Search.base.one proc {$ _} {SubType1 T1 T2 Env} end}
      of [_] then true
      [] nil then false
      else {Inspector.inspect ['Types.isSubType error: ' T1 T2]}
      end
   end
   
   proc{SubType T1 T2}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {SubType1 T1 T2 Env}
      end
   end
   proc{SubType1 T1 T2 Env}
      choice
	 {BasicSubType T1 T2}
      [] {RecursiveSubType T1 T2 Env}
      [] local
	    Obj
	    Env1 = {CloneEnv Env}
	 in
	    %{InstantiateType T1 Obj}
	    {InstantiateType1 T1 Env Obj} %?
	    %{Inspector.inspect ['Types.subType1:' Obj 'of type' T2 '?']}
	    {PutEnv Env1 root Obj}
	    {OfType1 Obj  T2 Env1}
	%    {Inspector.inspect ['Types.subType1:' Obj 'is of type' T2]} 
	 end
      end
   end
   % fun {IsRelSubType T1 T2 Env}
%       local Res = {Search.base.one proc {$ _}
% 				      local
% 					 Env1 = {CloneEnv Env}
% 				      in
% 					 {RelSubType T1 T2 Env1}
% 				      end
% 				   end}
%       in
% 	 case Res
% 	 of [_] then true
% 	 else false
% 	 end
%       end
%    end
 %   proc{RelSubType T1 T2 Env}
%       local
% 	 Obj
% 	 Env1 = {CloneEnv Env}
%       in
% 	 %{InstantiateType T1 Obj}
% 	 {InstantiateType1 T1 Env1 Obj} %?
% 	 %{PutEnv Env1 root Obj}
% 	 {OfType1 Obj  T2 Env1}
%       end
%    end
   fun {SimplifyOp T}
      local
	 Env = {NewEnv}
      in
	 {PutEnv Env path_from_root nil}
	 {SimplifyOp1 T Env}
      end
   end
   fun {SimplifyOp1 T Env}
      case T
      of optype(_ Op) then
	 % case Op
% 	 of apply(F Arg) then
% 	    %{Inspector.inspect F#Arg#{GetEnv Env path_from_root}#{ExtendPaths Env Arg}}
% 	    {SimplifyOp1 {EvalOp apply(F {ExtendPaths Env Arg})} Env}
% 	 else
	 {SimplifyOp1 {ExtendPaths {EvalOp Op} {GetEnv Env path_from_root}} Env}
	 %end
      [] meettype(T1 T2) then meettype({SimplifyOp T1} {SimplifyOp T2})
      [] rectype(...) then {Record.mapInd T fun {$ L V}
					       local
						  Env1 = {CloneEnv Env}
					       in
						  {PutEnv Env1 path_from_root
						   {Append {GetEnv Env path_from_root} [L]}}
						  {SimplifyOp1 V Env1}
					       end
					    end
			   }
      [] lambda(X T1 Body) then lambda(X T1 {SimplifyOp1 Body Env})
      [] sintype(T1 Obj) then sintype(T1 {SimplifyOp1 Obj Env})
      [] opsintype(T1 Op) then
	 local
	    Op1 = {SimplifyOp1 {ExtendPaths {EvalOp Op} {GetEnv Env path_from_root}} Env}  %Or just SimplifyOp?
	 in
	    %{Inspector.inspect Op1}?
	    if {IsOp Op1} then opsintype(T1 Op1)
	    else sintype(T1 Op1)
	    end
	 end
      [] deptype(F Paths) then %{Inspector.inspect [F {SimplifyOp F}]}
	 deptype({SimplifyOp1 F Env} Paths)
	 % local
% 	    Env1 = {CloneEnv Env}
% 	    P = {GetEnv Env path_from_root}
% 	 in
% 	    {PutEnv Env1 path_from_root {List.take P {Length P}-1}}
% 	    deptype({SimplifyOp1 F Env} {ExtendPaths Env1 Paths})
% 	 end
      else T
      end
   end
   fun {SimplifyDep T}
      case T
      of rectype(...) then
	 local Env = {NewEnv}
	 in
	    {PutEnv Env root T}
	    {SimplifyDep1 T Env}
	 end
      % [] rec(...) then
% 	 local Env = {NewEnv}
% 	 in
% 	    {PutEnv Env root T}
% 	    {SimplifyDep1 T Env}
% 	 end
      [] meettype(T1 T2) then
	 meettype({SimplifyDep T1} {SimplifyDep T2})
      else T
      end
   end
   
   fun {SimplifyDep1 T Env}
      case T
      of deptype(T1 nil) then T1
      [] deptype(F P|Paths) then
	 case P
	 of objpath(Obj)
	 then {SimplifyDep1 deptype({BetaConvert apply(F Obj)} Paths) Env}
	 else
	    case {ExportSintype {EvalSelect {EvalPath {GetEnv Env root} P}}}
	    of sintype(_ Obj) then % used to be sintype(T2 Obj)
	       if {IsOfType Obj F.2} then  % used to be {IsSubType F.2 T2}
		  {SimplifyDep1 deptype({BetaConvert apply(F Obj)} Paths) Env}
	       else bot
	       end
	    else T
	    end
	 end
	 
      [] rectype(...) then
	 {Record.map T fun {$ X} {SimplifyDep1 X Env} end}
      % [] rec(...) then
% 	 {Record.map T fun {$ X} {SimplifyDep1 X Env} end}
      [] meettype(T1 T2) then
	 meettype({SimplifyDep1 T1 Env} {SimplifyDep1 T2 Env})
      else T
      end
   end

   fun {NormalizeDep T}
      case T
      of deptype(lambda(X Type sintype(Type X))
		 [Path]) then
	 case Type
	 of rectype then T
	 [] rectype(...) then
	    {Record.mapInd Type
	     fun {$ L V}
		{NormalizeDep deptype(lambda(x V sintype(V x))
				      [{AppendPaths Path path([L])}])}
	     end
	    }
	 else T
	 end
      [] rectype(...) then
	 {Record.map T NormalizeDep}
      else T
      end
   end
   
	    

   fun {AbbrevDep T}
      local
	 Env = {NewEnv}
      in
	 {NewSubEnv Env gensymdict}
	 {AbbrevDep1 T Env}
	 %{RemoveIndicesAbbrevDep {AbbrevDep1 T Env}}
      end
   end
   
   fun {AbbrevDep1 T Env}
      case T
      of rectype(...) then
	 % local
% 	    Index = {Gensym r {GetEnv Env gensymdict}}
% 	 in
% 	    {PutEnv Env root Index}
	 {AbbrevDep2 T Env}
	   % Index#{AbbrevDep2 T Env}
	 %end
      [] meettype(T1 T2) then
	 meettype({AbbrevDep1 T1 Env} {AbbrevDep1 T2 Env})
      else {AbbrevDep2 T Env}
      end
   end

   fun {AbbrevDep2 T Env}
      case T
      of deptype(T1 nil) then {AbbrevDep2 T1 Env}
      [] deptype(F P|Paths) then
	 case P
	 of abspath(R Path) then
	    {AbbrevDep2 deptype({BetaConvert apply(F {Flatten {Append [R] Path}})} Paths) Env}
	    [] metapath(...) then {AbbrevDep2 deptype({BetaConvert apply(F P)} Paths) Env}
	 else{AbbrevDep2 deptype({BetaConvert apply(F P.1)} Paths) Env}
	    %{AbbrevDep2 deptype({BetaConvert apply(F {Append [{GetEnv Env root}] P.1})} Paths) Env}
	 end
      [] rectype(...) then
	 {Record.map T fun {$ X} {AbbrevDep1 X Env} end}
      [] meettype(T1 T2) then
	 meettype({AbbrevDep2 T1 Env}{AbbrevDep2 T2 Env})
      [] optype(_ Op) then
	 {AbbrevDep1 {EvalOp Op} Env}
      [] opsintype(T1 Op) then
	 sintype(T1 {AbbrevDep1 {EvalOp Op} Env})
      [] sintype('RecType' R) then
	 sintype('RecType' {AbbrevDep1 R Env})
      else T
      end
   end
  %  fun {RemoveIndicesAbbrevDep R}
%       local Env = {NewEnv}
%       in
% 	 {PutEnv Env indices nil}
% 	 {AssignIndicesAbbrevDep1 R Env nil}
% 	 {RemoveIndicesAbbrevDep1 R Env}
%       end
%    end
%    fun {AssignIndicesAbbrevDep1 R Env Path}
%       case R
%       of Index#rectype(...) then
% 	 {PutEnv Env Index Path}
% 	 {PutEnv Env indices Index|{GetEnv Env indices}}
% 	 {Record.mapInd R.2
% 	  fun {$ L V}
% 	     {AssignIndicesAbbrevDep1 V Env {Append Path [L]}}
% 	  end
% 	 }
%       else
% 	 R
%       end
%    end
%    fun {RemoveIndicesAbbrevDep1 R Env}
% 	case R
% 	of Index#rectype(...) then
	   
	 
      

	    
   
   fun {SimplifyJoin T}
      case T
      of jointype(T0 T0) then T0
      % [] jointype(bot T1) then T1
%       [] jointype(T2 bot) then T2
      [] jointype(T1 T2) then
	 local
	    Bool1 = {IsSubType T1 bot}
	    Bool2 = {IsSubType T2 bot}
	 in
	    if {And Bool1 Bool2} then T
	    elseif Bool1 then T2
	    elseif Bool2 then T1
	    else T
	    end
	 end
      else T
      end
   end
   fun {SimplifyMeet T}
      case T
      of meettype(...) then
	 local
	    T1 = {SimplifyMeet T.1}
	    T2 = {SimplifyMeet T.2}
	 in
	    if T1 == T2 then T1
	    %elseif {IsSubType T1 bot} orelse {IsSubType T2 bot} then bot
	    elseif T1 == bot orelse T2 == bot then bot
% 	    elseif {IsSubType T1 T2} then T1
% 	    elseif {IsSubType T2 T1} then T2
	    % elseif {IsDet T1} andthen {IsDet T2}
% 	       andthen {IsAtom T1} andthen  {IsAtom T2} then
% 	       bot %Assume basic types are disjoint 
	    else {Meet T1 T2}
	    end
	 end
      [] rectype(...) then
	 %{Inspector.inspect T}
	 {Record.map T SimplifyMeet}
      else T %{Inspector.inspect T} T
      end
   end
   fun {Meet T1 T2}
      {Search.base.one proc {$ X}
			  local Env = {NewEnv} X1 T
			  in
			     {NewSubEnv Env gensymdict}
			     {NewSubEnv Env vartypeass}
			     {PutEnv Env obj1 {InstantiateType T1}}
			     {PutEnv Env obj2 {InstantiateType T2}}
			     {PutEnv Env type1 T1}
			     {PutEnv Env type2 T2}
			     {PutEnv Env uniftype rectype}
			     {Meet1 T1 T2 Env X1}
			     T = {GetEnv Env uniftype}
			     if T  == rectype then
				X = X1
			     else 
				X = {SimplifyMeet meettype(X1  T)}
			     end
			  end
		       end
      }.1
   end
   proc {Meet1 T1 T2 Env T3}
      if cond T1 = T2 then true else false end then
	 T3 = T1 %{SimplifyOp T1}
      elseif T1 == bot orelse T2 == bot then
	 T3 = bot
      elseif cond T1 = rectype(...)
		T2 = rectype(...)
	     then true
	     else false
	     end then
	% {Inspector.inspect T1#T2}
	 T3 = {Adjoin
	       {Record.mapInd T1
		fun {$ L V}  {Meet1 V
			      {CondSelect T2 L V} Env} end}
	       {Record.subtractList T2 {Arity T1}}}
	% {Inspector.inspect T3}
      elseif {IsSubType T1 T2} then
	 T3 = T1 %{SimplifyOp T1}
      elseif {IsSubType T2 T1} then
	 T3 = T2 %{SimplifyOp T2}
      elseif
	 local
	    Type1 = {GetEnv Env type1}
	    Type2 = {GetEnv Env type2}
	 in
	    cond Type1 = rectype(...) Type2 = rectype(...) then true else false end andthen
	    {IsSubType
	     {RelativizeType T1 Type1}
	     {RelativizeType T2 Type2}}
	 end then
	    % {Inspector.inspect {GetEnv Env type1}}
% 	    {Inspector.inspect {InstantiateType {EvalPath {GetEnv Env type1} path([x])}}}
% 	    {Inspector.inspect {RelativizeType T1 {GetEnv Env type1}}}
	 T3 = T1
      elseif
	 local
	    Type1 = {GetEnv Env type1}
	    Type2 = {GetEnv Env type2}
	 in
	    cond Type1 = rectype(...) Type2 = rectype(...) then true else false end andthen
	    {IsSubType
	     {RelativizeType T2 Type2}
	     {RelativizeType T1 Type1}}
	 end then
	 T3 = T2
      elseif cond T1 = jointype(...) then true else false end then
	 case T2
	 of jointype(...) then
	    T3 = {SimplifyJoin
		  jointype(
		     {SimplifyJoin jointype({Meet1 T1.1 T2 Env}
					    {Meet1 T1.2 T2 Env})}
		     {SimplifyJoin jointype({Meet1 T1 T2.1 Env}
					    {Meet1 T1 T2.2 Env})})}
	 else T3 = {SimplifyJoin jointype(
				    {Meet1 T1.1 T2 Env}
				    {Meet1 T1.2 T2 Env})}
	 end
      elseif cond T2 = jointype(...) then true else false end then
	 T3 = {SimplifyJoin jointype(
			       {Meet1 T1 T2.1 Env}
			       {Meet1 T1 T2.2 Env})}
      elseif cond
		T1 = sintype(...)
		T2 = opsintype(...) then true else false end then
	 cond T1.2 = {EvalOp T2}
	 then T3 = T1
	 else T3 = bot
	 end
      elseif cond
		T2 = sintype(...)
		T1 = opsintype(...) then true else false end then
	 cond T2.2 = {EvalOp T1}
	 then T3 = T2 %{Inspector.inspect T3}
	 else T3 = bot
	 end
      elseif cond
		T1 = sintype(...)
		T2 = deptype(...) then true else false end then
%	    {Inspector.inspect T1}
%    {Inspector.inspect T2}
%	    T3 = meettype(T1 T2)
	 {MeetSinDep1 T1 T2 Env type2 T3}
      elseif cond
		T2 = sintype(...)
		T1 = deptype(...) then true else false end then
	    %{Inspector.inspect T2}
	   % T3 = meettype(T1 T2)
	 {MeetSinDep1 T2 T1 Env type1 T3}
	    %{Inspector.inspect T3}
      elseif cond
		T1 = opsintype(...)
		T2 = deptype(...) then true else false end then
	 {MeetOpDep1 T1 T2 Env type2 T3}
      elseif cond
		T2 = opsintype(...)
		T1 = deptype(...) then true else false end then
	 {MeetOpDep1 T2 T1 Env type1 T3}
	 % elseif cond
% 		   T1 = deptype(...) then true else false end then
% 	    {Meet1 {SimplifyDep1 T1 Env} T2 Env T3}
% 	 elseif cond
% 		   T2 = deptype(...) then true else false end then
% 	    {Meet1 T1 {SimplifyDep1 T2 Env} Env T3}
      elseif {DisjointTypes T1 T2}  then
	 T3 = bot
      else case T1
	   of sintype(T Obj) then
	      local
		 Tres
	      in
		 {Meet1 T T2 Env Tres}
		 T3 = sintype(Tres Obj)
	      end
	   else %{Inspector.inspect ['Failed to simplify:' meettype(T1 T2)]}
	      T3 = meettype(T1 T2)
	   end
      end
   end

	    


   fun {RelativizePath Path RecType}
      case Path
      of abspath(...) then Path
      [] objpath(...) then Path
      [] metapath(...) then Path
      [] path(L) then objpath(L#{RelativizeType {EvalPath RecType Path} RecType})
	 %objpath(L {EvalPath Path RecType})
      else {Inspector.inspect ['Types.relativizePath error: ' Path RecType]}
      end
   end
   fun {RelativizePaths PathList RecType}
      case PathList?
      of X|L then {RelativizePath X RecType}|{RelativizePaths L RecType}
      [] nil then nil
      else {Inspector.inspect ['Types.relativizePaths error: ' PathList RecType]}
      end
   end
   fun {RelativizeDepType T RecType}
      case T
      of deptype(F PathList) then deptype(F {RelativizePaths PathList RecType})
      else {Inspector.inspect ['Types.relativizeDepType error: ' T RecType]}
      end
   end
   fun {RelativizeType T RecType}
      case T
      of deptype(...) then {RelativizeDepType T RecType}
      [] rectype(...) then
	 {Record.map T
	  fun {$ V} {RelativizeType V RecType} end}
      else T
      end
   end
   fun {IsOp Op}
      case Op
      of append(_ _) then true
      [] apply(_ _) then true
      else false
      end
   end
   fun {EvalOp Op}
      case Op
      of append(X Y) then
	 local
	    X1 = {EvalOp X}
	    Y1 = {EvalOp Y}
	 in
	    if {And {IsList X1} {IsList Y1}} then {Append X1 Y1}
	    else append(X1 Y1)
	    end
	 end
      [] apply(F Arg) then
	 local
	    F1 = {EvalOp F}
	    Arg1 = {EvalOp Arg}
	 in
	    %{Inspector.inspect F1#Arg1}
	    cond F1 = lambda(...) then
	       case F1.3
	       of Y#T then Y#T#[Arg]
	       [] Y#T#L then Y#T#{Sort Arg|L fun {$ A B} {Value.'<' A.1 B.1} end}
	       else {BetaConvert apply(F1 Arg1)}
	       end
	    else apply(F1 Arg1)
	    end
	 end
      [] conj(Type1 Type2) then
	 rectype(c1 : {ExtendPaths {EvalOp Type1} [c1]}
		 c2 : {ExtendPaths {EvalOp Type2} [c2]})
      [] merge(Type1 Type2) then
	 {SimplifyMeet meettype({EvalOp Type1} {EvalOp Type2})}
      else Op
      end
   end
   fun {ExtendPaths Expr Path}
      if {IsAtom Expr} orelse Path == nil then Expr
      else
	 case Expr
	 of path(L) then path({Append Path L})
	 [] rectype(...) then
	    {Record.map Expr
	     fun {$ V}
		{ExtendPaths V Path}
	     end}
	 [] deptype(...) then
	    {Record.map Expr
	     fun {$ V}
		{ExtendPaths V Path}
	     end}
	 [] _|_ then
	    {Record.map Expr
	     fun {$ V}
		{ExtendPaths V Path}
	     end}
	 else Expr
	 end
      end
   end
   % proc {MatchSinDep T1 T2}
%       T1 = sintype(...)
%       T2 = deptype(...)
%       T1.1 = T2.1.2
%       T2.1.3 = sintype(...)
%       T2.1.3.1 = T1.1
%    end
   
   proc {MeetSinDep1 T1 T2 Env Root T3}
      case T2
      of deptype(lambda(X T sintype(T X)) [Path]) then
	 cond
	    T1 = sintype(T _) then
	    local TUnif  %Unif
	    in
	       {PutValInPath Path rectype {Meet T1
					   {EvalPath {GetEnv Env Root} Path}}
		TUnif}
	       {PutEnv Env uniftype {Meet {GetEnv Env uniftype} {CloseRec TUnif}}}
%	       {PutEnv Env uniftype TUnif}
	       T3 = T2
	    end
	 else cond
		 {SimplifyMeet meettype(T T1.1)} = bot then
		 T3 = bot
	      else
		 T3 = meettype(T1 T2)
	      end
	 end
      else T3 = meettype(T1 T2)
      end
   end

   proc {MeetOpDep1 T1 T2 Env Root T3}
      case T2
      of deptype(lambda(X listtype(T)
			lambda(Y listtype(T)
			       opsintype(listtype(T) append(X Y))))
		 [Path1 Path2]) then
	 local
	    TUnif
	 in
	    case T1 
	    of opsintype(listtype(T) append(L1 L2)) then
	       {PutValInPath Path1 rectype {Meet
					    opsintype(listtype(T) L1)
					    {EvalPath {GetEnv Env Root} Path1}}
		TUnif}
	       {PutValInPath Path2 rectype {Meet
					    opsintype(listtype(T) L2)
					    {EvalPath {GetEnv Env Root} Path2}}
		TUnif}
%	       {Inspector.inspect TUnif}
	       {PutEnv Env uniftype {Meet {GetEnv Env uniftype} {CloseRec TUnif}}}
	       %{Inspector.inspect T1}
	       T3 = T1
	    else T3 = meettype(T1 T2)
	    end
	 end
      else T3 = meettype(T1 T2)
      end
   end
   


   
   
   proc {NewEnvIfRecOrRecType Env Obj NewEnv}
      %{Inspector.inspect ['NewEnvIfRecOrRecType In:' Obj ]}
      case Obj
      of rec(...) then
	 NewEnv = {CloneEnv Env}
	 {PutEnv NewEnv root Obj}
      [] rectype(...) then
	 NewEnv = {CloneEnv Env}
	 {PutEnv NewEnv root Obj}
      else NewEnv = Env
      end
   end

   fun {DisjointTypes T1 T2}
      cond
	 {DisjointTypes1 T1 T2} = true then true
      [] {DisjointTypes1 T2 T1} = true then true
      else false
      end
   end
   

   fun {DisjointTypes1 T1 T2}
      cond
	 {IsAtom T1} = true
	 {IsAtom T2} = true
	 {IsBasicSubType T1 T2} = false
	 {IsBasicSubType T2 T1} = false
      then true %Assume basic types are disjoint unless one is a subtype of the other
      [] T1 = listtype(T2) then true
      [] T1 = sintype(...)
	 {DisjointTypes T1.1 T2} = true then true
      [] T1 = opsintype(...)
	 {DisjointTypes T1.1 T2} = true then true
      else false
      end
   end
   
   fun {IsBasicSubType T1 T2}
      case {Search.base.one proc {$ _}{BasicSubType T1 T2} end}
      of [_] then true
      [] nil then false
      else {Inspector.inspect ['Types.isBasicSubType error: ' T1 T2]} 
      end
   end
   proc {BasicSubType T1 T2}
      {IsAtom T1} = true
      {IsAtom T2} = true
      choice
	 T1 = 'RecType'
	 T2 = 'Type'
      [] T1 = T2 %Add an additional case allowing subtypes to be defined in btypes.oz?
      end
   end
   proc {RecursiveSubType T1 T2 Env}
      {RType T1}
      {ForAll {Substitute T2 T1 {RTypeDef T1}}
       proc {$ T} {SubType1 T T2 Env} end}
   end
   fun {FlattenRelabelRecType R}
%      {Inspector.inspect {RelabelRec {FlattenRec {InstantiateType R}}}}
      {FindType {RelabelRec {FlattenRec {InstantiateType R}}}}
   end
   fun {SimplifyEqualitiesLeft RecType}
      local
	 Equalities = {NewCell nil}
      in
	 {Record.forAll RecType
	  proc {$ T}
	     case T
	     of deptype(lambda(V0 'Ind'
			       lambda(V1 'Ind'
				      eq(V0 V1)))
			[path([X1])
			 path([X2])]) then
		{Assign Equalities X1#X2|{Access Equalities}}
	     else skip
	     end
	  end
	 }
	 local
	    Res = rectype(...)
	 in
	    {Record.forAllInd {SubstituteList {Access Equalities} RecType}
	     proc {$ L V}
		if {Some {Access Equalities}
		    fun {$ X} X.1 == L end} then
		   skip
		else case V
		     of deptype(lambda(_ 'Ind'
				       lambda(_ 'Ind'
					      eq(_ _)))
				_) then
			skip
		     else Res^L=V
		     end
		end
	     end
	    }
	    {CloseRec Res}
	 end
      end
   end
   fun {ExploitEqualities RecType}
      local
	 Equalities = {NewCell nil}
	 CollectEqualities = proc {$ R}
				{Record.forAll R
				 proc {$ T}
				    case T
				    of deptype(lambda(V0 T0
						      lambda(V1 T0
							     eq(T0 V0 V1)))
					       [Path1 Path2]) then
				       {Assign Equalities Path1#Path2|{Access Equalities}}
				    [] rectype(...) then
				       {CollectEqualities T}
				    else skip
				    end
				 end
				}
			     end
	 AssocList = {NewCell nil}
      in
	 {CollectEqualities RecType}
	 %{Inspector.inspect {Access Equalities}}
	 {ForAll {Access Equalities}
	  proc {$ Item}
	     local
		NewVal = optype('Type' merge({EvalPath RecType Item.1} {EvalPath RecType Item.2}))
	     in
		{Assign AssocList (Item.1#NewVal)|(Item.2#NewVal)|{Access AssocList}}
	     end
	  end
	 }
	 {SubstituteValInPathList {Access AssocList} RecType}
      end
   end
   
   fun {ExportSintype Rectype}
      case Rectype
      of rectype(...) then
	 if {Record.all Rectype
	     fun {$ X}
		case {ExportSintype X}
		of sintype(...) then true
		else false
		end
	     end
	    } then
	    sintype(Rectype {InstantiateType Rectype})
	 else Rectype
	 end
      else Rectype
      end
   end
   
	 
end



