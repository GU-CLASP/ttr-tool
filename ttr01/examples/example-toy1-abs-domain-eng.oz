declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "toy1-abs-domain-eng"}

declare
[G Lex Parse Grammar] = {Module.link ['../grammars/toy1/toy1-abs-domain-eng.ozf' '../ttr/lexicon.ozf' '../ttr/parse.ozf' '../ttr/grammar.ozf']}
Lexicon = G.lexicon
Rules = G.rules
DRules = G.dRules
CompileIndexedLexicon = Lex.compileIndexedLexicon
CreateInterface = Parse.createInterface
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


{CreateInterface PhonLex IDLex LCRules LCDRules}


