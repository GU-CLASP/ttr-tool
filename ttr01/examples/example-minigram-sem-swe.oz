declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "minigram-sem-swe"}

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


{CreateInterface PhonLex IDLex LCRules LCDRules}


