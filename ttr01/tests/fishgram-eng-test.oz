declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "fishgram-eng"}

declare
[Fishgram Lex Parse Grammar] = {Module.link ['../grammars/fish/fishgram-eng.ozf' '../ttr/lexicon.ozf' '../ttr/parse.ozf' '../ttr/grammar.ozf']}
Lexicon = Fishgram.lexicon
Rules = Fishgram.rules
DRules = Fishgram.dRules
CompileIndexedLexicon = Lex.compileIndexedLexicon
CreateInterface = Parse.createInterface
IsRightBinaryRule = Grammar.isRightBinaryRule
FirstArgCatOfRule = Grammar.firstArgCatOfRule
CompileLeftCornerIndexedRules = Grammar.compileLeftCornerIndexedRules
AddRulesToIDIndexedLexicon = Grammar.addRulesToIDIndexedLexicon
PhonLex = {CompileIndexedLexicon Lexicon path([phon])}
LCRules = {CompileLeftCornerIndexedRules Rules}
LCDRules = {CompileLeftCornerIndexedRules DRules}
IDLex = {AddRulesToIDIndexedLexicon DRules
	 {AddRulesToIDIndexedLexicon Rules
	  {CompileIndexedLexicon Lexicon path([id])}}}

{CreateInterface PhonLex IDLex LCRules LCDRules}

{Inspect Lexicon}

{Inspect Fishgram.indefArt}

{Inspect Fishgram.s_NP_VP}

{Inspect Fishgram.nP_Det_N}

{Inspect Fishgram.man}

{Inspect {Dictionary.entries PhonLex}}

{Inspect {Dictionary.entries LCRules}}

{Inspect {Dictionary.entries IDLex}}

{Inspect {Dictionary.entries LCDRules}}





