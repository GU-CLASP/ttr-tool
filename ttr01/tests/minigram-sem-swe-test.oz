declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "minigram-sem-swe"}

declare
[DebugFile] = {Module.link ['../ttr/debug.ozf']}
Debug = DebugFile.debug
{Debug no}

declare
[Minigram Parse Lex Grammar Utils] = {Module.link ['../grammars/mini/minigram-sem-swe.ozf' '../ttr/parse.ozf' '../ttr/lexicon.ozf' '../ttr/grammar.ozf' '../ttr/utils.ozf']}
Kim = Minigram.kim
Sandy = Minigram.sandy
Run = Minigram.run
Like = Minigram.like
S_NP_VP = Minigram.s_NP_VP
VP_V_NP = Minigram.vP_V_NP
Lexicon = Minigram.lexicon
Rules = Minigram.rules
DRules = Minigram.dRules
CompileIndexedLexicon = Lex.compileIndexedLexicon
CompileLeftCornerIndexedRules = Grammar.compileLeftCornerIndexedRules
GetRuleID = Grammar.getRuleID
AddRulesToIDIndexedLexicon = Grammar.addRulesToIDIndexedLexicon
%EvaluateIDExpr = Grammar.evaluateIDExpr
CreateInterface = Parse.createInterface
NewChart = Parse.newChart
%NewChartFunctionalInput = Parse.newChartFunctionalInput
Generate = Parse.generate
GetEnv = Utils.getEnv
PhonLex = {CompileIndexedLexicon Lexicon path([phon])}
LCRules = {CompileLeftCornerIndexedRules Rules}
LCDRules = {CompileLeftCornerIndexedRules DRules}
IDLex = {AddRulesToIDIndexedLexicon DRules
	 {AddRulesToIDIndexedLexicon Rules
	  {CompileIndexedLexicon Lexicon path([id])}}}

{Inspect Kim}


{CreateInterface PhonLex IDLex LCRules LCDRules}


{Inspect {Parse.evaluateFunArgExpr conj(apply('Kim' 'Run') apply('Sandy' 'Run'))
	  IDLex LCRules LCDRules}}

{Inspect {Parse.evaluateFunArgExpr conj(apply('Kim' 'Run') apply('Sandy' 'Run'))
	  IDLex LCRules LCDRules}}

{Inspect "conj("}

{Inspect IDLex}

{Inspect {CompileIndexedLexicon Lexicon path([id])}}

{Inspect {Parse.tokenizeFunArg {Append "Kim(Run)" [10]}}}

{Inspect Minigram.d_S}

{Inspect {Map Rules GetRuleID}}

{Inspect {GetRuleID S_NP_VP}}

{ForAll Rules proc {$ R} {Inspect R} {Inspect {GetRuleID R}} end}

{Inspect {Dictionary.entries LCRules}}

{Inspect {Parse.tokenizeFunArg "s_np_vp(Kim)(Run)"}}

{Inspect "'"}

{Inspect {Dictionary.entries {GetEnv {NewChartFunctionalInput IDLex LCRules cnt apply('Kim' apply('Like' 'Sandy'))} edges_by_start}}}

{Inspect {EvaluateIDExpr apply(apply(s_np_vp 'Kim') 'Run') IDLex}}

{Inspect {Parse.convertTreeToExplApply s_np_vp('Kim' 'Run')}}

{Inspect {Parse.convertTreeToExplApply apply('Like'('Sandy')'Kim')}}

{Inspect {Generate s_np_vp('Kim' vp_v_np('Like' 'Sandy')) IDLex}}

{Inspect {Dictionary.entries IDLex}}

{Inspect {Map Rules GetRuleID}}



declare
InputStream
Input = {NewPort InputStream}
Chart = {NewChart PhonLex LCRules InputStream}

{Send Input kim}

{Send Input likes}

{Send Input sandy}

{Inspect {Map {Dictionary.items {GetEnv Chart edges_by_start}} fun {$ I} I.2 end} }








declare
{Inspect {IsRecord 'Kim'}}

T
Stream
L = {NewPort Stream}
fun {GetLast L N}
   local
      Last = {Nth L N}
      T Last1
   in
      thread T={Thread.this} Last1={Nth L N+1} end
      if {Thread.state T} == blocked
      then Last
      else {GetLast L N+1}
      end
   end
end

{Send L a}

{Send L b}

{Send L c}

{Inspect Stream}



{Inspect {GetLast Stream 1}}

%    case L
%    of nil then undef
%    [] [X] then X
%    [] X|Rst then
%       local T W
%       in
% 	 thread T={Thread.this} W={GetLast Rst} end
% 	 {Inspect {Thread.state T}}
% 	 if {Thread.state T} == blocked
% 	 then X
% 	 else {GetLast Rst}
% 	 end
%       end
%    end
% end



thread T={Thread.this} 





L = a|b|_

L = {Filter L fun {$ X} X == a end}

Port
Stream
{Inspect Port}
{Inspect Stream}
Port = {NewPort Stream}

{Send Port d}

{Inspect {Nth Stream 4}}

{Inspect {RecordC.reflectArity Stream}}

{Inspect {Length Stream}}

X = {Access TestCell}

{Assign TestCell b}

{Inspect {Access TestCell}}

{Show a}

{Inspect Kim}

{Inspect Sandy}

{Inspect Run}

{Inspect Like}

{Inspect S_NP_VP}

{Inspect VP_V_NP}


declare
[Types Beta Records] = {Module.link ['types.ozf' 'betaconvert.ozf' 'records.ozf']}

declare
T1 = rectype(c:optype('RecType' apply(lambda('P_00' funtype(rectype(x:'Ind') 'RecType') rectype(c1:deptype(lambda(v_00 'Ind' named(v_00 'Sandy')) [path([par x])]) c2:deptype(lambda(v_10 rectype(x:'Ind') optype('RecType' apply('P_00' v_10))) [path([par])]) par:rectype(x:'Ind'))) lambda(r2_00 rectype(x:'Ind') rectype(c:deptype(lambda(v1_00 'Ind' lambda(v2_00 'Ind' like(v1_00 v2_00))) [abspath(rec(x:a0#'Ind') [x]) abspath(r2_00 [x])]))))))

{Inspect {Types.simplifyOp T1}}


{Inspect {Types.instantiateType T1}}


T2 = rectype(cat:sintype('Cat' d) cnt:'RecType' id:'Id' phon:'Phon')

{Inspect T1}

{Inspect {Types.isOfType T1 'RecType'}}

{Inspect {Types.instantiateType T1}}

{Inspect {Types.isOfType {Types.instantiateType T1} T2}}

{Inspect {Types.isOfType
	  rectype(c1:deptype(lambda(v_0 'Ind' named(v_0 'Sandy')) [path([par x])]) c2:deptype(lambda(v_1 rectype(x:'Ind') optype('RecType' apply(lambda(r1_00 rectype(x:'Ind') rectype(c:optype('RecType' apply(lambda('P_00' funtype(rectype(x:'Ind') 'RecType') rectype(c1:deptype(lambda(v_00 'Ind' named(v_00 'Kim')) [path([c2 c par x])]) c2:deptype(lambda(v_10 rectype(x:'Ind') optype('RecType' apply('P_00' v_10))) [path([c2 c par])]) par:rectype(x:'Ind'))) lambda(r2_00 rectype(x:'Ind') rectype(c:deptype(lambda(v1_00 'Ind' lambda(v2_00 'Ind' like(v1_00 v2_00))) [abspath(r1_00 [x]) abspath(r2_00 [x])]))))))) v_1))) [path([par])]) par:rectype(x:'Ind'))
	  'RecType'}}

{Inspect {Types.isOfType
	  apply(d_s apply(apply(s_np_vp 'Sandy') 'Run'))
	  'Id'}}
	  
{Inspect T1}

{Inspect {Types.isSubType T1 T2}}


{Inspect {Types.isOfType d 'Cat'}}

{Inspect {Types.isOfType [sandy runs] 'Phon'}}

{Inspect R}

{Inspect R.cnt}

{Inspect {Types.abbrevDep {Types.simplifyOp R.cnt}}} 

{Inspect {Types.instantiateType {Types.simplifyOp R.cnt}}} 



{Inspect {Types.instantiateType R.cnt}} 

{Inspect {Types.flattenRelabelRecType R.cnt}}

{Inspect {Types.abbrevDep {Types.flattenRelabelRecType R.cnt}}}

{Inspect {Types.simplifyOp R.cnt}}

{Inspect {Types.simplifyOp {Types.simplifyOp R.cnt}}}

{Inspect {Types.abbrevDep {Types.instantiateType {Types.simplifyOp R.cnt}}}}

{Inspect {SearchAll proc {$ T} {Types.bType T} end}}

{Inspect {Types.abbrevDep{Types.instantiateType R.cnt}}}

{Inspect {Types.simplifyOp {Types.instantiateType R}}}

{Inspect {Types.instantiateType {Types.simplifyOp R.cnt}} }

declare
Cnt = opsintype('RecType' apply(lambda('P' funtype(rectype(x:'Ind') 'RecType') rectype(c1:deptype(lambda(v 'Ind' named(v 'Kim')) [path([par x])]) c2:deptype(lambda(v rectype(x:'Ind') optype('RecType' apply('P' v))) [path([par])]) par:rectype(x:'Ind'))) apply(lambda('N' funtype(funtype(rectype(x:'Ind') 'RecType') 'RecType') lambda(r1 rectype(x:'Ind') rectype(c:optype('RecType' apply('N' lambda(r2 rectype(x:'Ind') rectype(c:deptype(lambda(v1 'Ind' lambda(v2 'Ind' like(v1 v2))) [abspath(r1 [x]) abspath(r2 [x])])))))))) lambda('P' funtype(rectype(x:'Ind') 'RecType') rectype(c1:deptype(lambda(v 'Ind' named(v 'Sandy')) [path([par x])]) c2:deptype(lambda(v rectype(x:'Ind') optype('RecType' apply('P' v))) [path([par])]) par:rectype(x:'Ind'))))))

{Inspect Cnt}

{Inspect {Types.instantiateType Cnt}}

{Inspect {Types.flattenRelabelRecType {Types.instantiateType Cnt}}}

{Inspect {Types.abbrevDep {Types.flattenRelabelRecType {Types.instantiateType Cnt}}}}

declare
TestInspector = {Inspector.new options(inspectorWidth:200)}

{TestInspector inspect(a)}

declare
TestInspector1 = {Inspector.new unit}

{Inspect a}

{Inspect {Inspector.object}}

{Inspector.inspectN TestInspector a}

{TestInspector inspect(a)}

{TestInspector1 inspect(b)}

declare
TestInspector2 = {Inspector.new }

{TestInspector2 inspect(c)}

{TestInspector2 set(title:"Test Inspector 2")}

declare
TestInspector3 = {Inspector.new options(title:"Test Inspector 3")}
{TestInspector3 inspect(d)}

declare
