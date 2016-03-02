declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "music-eng"}

declare
[G Lex Parse Grammar DMoves] = {Module.link ['../grammars/music/music-eng.ozf' '../ttr/lexicon.ozf' '../ttr/parse.ozf' '../ttr/grammar.ozf' '../grammars/music/music-dmoves.ozf']}
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

{Inspect G.s_NP_VP}

{Inspect IDLex}