declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "toy1-abs-domain-swe"}

declare
[G Lex Parse Grammar] = {Module.link ['../grammars/toy1/toy1-abs-domain-swe.ozf' '../ttr/lexicon.ozf' '../ttr/parse.ozf' '../ttr/grammar.ozf']}
Lexicon = G.lexicon
Rules = G.rules
DRules = G.dRules
CompileIndexedLexicon = Lex.compileIndexedLexicon
CreateInterface = Parse.createInterface
%IsRightBinaryRule = Grammar.<isRightBinaryRule
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


{Inspect IDLex}

{Inspect G.nP_N}

{Inspect G.lampan}

{Inspect G.lamporna}

{Inspect G.fläkten}

{Inspect G.fläktarna}

{Inspect G.köket}

{Inspect G.vardagsrummet}

{Inspect G.i}

{Inspect G.tänd}

{Inspect G.släck}

{Inspect G.på}

{Inspect G.av}

{Inspect G.är}

{Inspect G.sänk}

{Inspect G.s_VP}

{Inspect G.s_Cop_SmallCl}

{Inspect G.smallCl_NP_Part}

{Inspect G.nP_N}

{Inspect G.n_N_PP}

{Inspect G.pP_Prep_NP}

{Inspect G.vP_V_NP}

{Inspect G.v_Sätt_På}

{Inspect LCRules}

{Inspect Rules}