declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "bear-eng"}

declare
[G Lex Parse Grammar DMoves] = {Module.link ['../grammars/bear/bear-eng.ozf' '../ttr/lexicon.ozf' '../ttr/parse.ozf' '../ttr/grammar.ozf' '../grammars/bear/bear-dmoves.ozf']}
Lexicon = G.lexicon
Rules = G.rules
DRules = G.dRules
CompileIndexedLexicon = Lex.compileIndexedLexicon
CreateInterface = Parse.createInterfaceDMove
%IsRightBinaryRule = Grammar.isRightBinaryRule
%FirstArgCatOfRule = Grammar.firstArgCatOfRule
CompileLeftCornerIndexedRules = Grammar.compileLeftCornerIndexedRules
AddRulesToIDIndexedLexicon = Grammar.addRulesToIDIndexedLexicon
PhonLex = {CompileIndexedLexicon Lexicon path([phon])}
LCRules = {CompileLeftCornerIndexedRules Rules}
LCDRules = {CompileLeftCornerIndexedRules DRules}
IDLex = {AddRulesToIDIndexedLexicon DRules
	 {AddRulesToIDIndexedLexicon Rules
	  {CompileIndexedLexicon Lexicon path([id])}}}
DMvs = [DMoves.dMove2Abs DMoves.abs2DMove]

{CreateInterface PhonLex IDLex LCRules LCDRules DMvs}

{Inspect G.bear}

{Inspect G.nice}

{Inspect G.n_Adj_N}

{Browse LCDRules}

{Browse DRules}

{Inspect Rules}