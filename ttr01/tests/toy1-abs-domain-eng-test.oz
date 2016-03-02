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


{Inspect G.defArt}

{Inspect G.light}

{Inspect G.lights}

{Inspect G.fan}

{Inspect G.fans}

{Inspect G.kitchen}

{Inspect G.livingroom}

{Inspect G.'in'}

{Inspect G.switch}

{Inspect G.switched}

{Inspect G.turn}

{Inspect G.on}

{Inspect G.off}

{Inspect G.is}

{Inspect G.are}

{Inspect G.dim}

{Inspect G.v_Switch_On}

{Inspect G.v_Switch_Off}

{Inspect G.v_Turn_On}

{Inspect G.v_Turn_Off}

{Inspect G.s_VP}

{Inspect G.s_Cop_SmallCl}

{Inspect G.smallCl_NP_Part}

{Inspect G.nP_Det_N}

{Inspect G.n_N_PP}

{Inspect G.pP_Prep_NP}

{Inspect G.vP_V_NP}

{Inspect LCRules}

