declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "minigram-eng"}

declare
[Types Functions Minigram Lex Parse Grammar] = {Module.link ['../ttr/types.ozf' '../ttr/functions.ozf' '../grammars/mini/minigram-eng.ozf' '../ttr/lexicon.ozf' '../ttr/parse.ozf' '../ttr/grammar.ozf']}
BType = Types.bType
Model = Types.model
Pred = Types.pred
PredArity = Types.predArity
BetaConvert = Types.betaConvert
IsOfType = Types.isOfType
InstantiateType = Types.instantiateType
IsSubType = Types.isSubType
SimplifyOp = Types.simplifyOp
Kim = Minigram.kim
Sandy = Minigram.sandy
Run = Minigram.run
Like = Minigram.like
S_NP_VP = Minigram.s_NP_VP
VP_V_NP = Minigram.vP_V_NP
EmbeddingFunConvert = Functions.embeddingFunConvert
Lexicon = Minigram.lexicon
Rules = Minigram.rules
CompileIndexedLexicon = Lex.compileIndexedLexicon
AddRulesToIDIndexedLexicon = Grammar.addRulesToIDIndexedLexicon
CreateInterface = Parse.createInterface
IsRightBinaryRule = Grammar.isRightBinaryRule
FirstArgCatOfRule = Grammar.firstArgCatOfRule
CompileLeftCornerIndexedRules = Grammar.compileLeftCornerIndexedRules
PhonLex = {CompileIndexedLexicon Lexicon path([phon])}
LCRules = {CompileLeftCornerIndexedRules Rules}
LCDRules = {CompileLeftCornerIndexedRules nil}
IDLex = {AddRulesToIDIndexedLexicon Rules
	  {CompileIndexedLexicon Lexicon path([id])}}

{CreateInterface PhonLex IDLex LCRules LCDRules}

{Inspect Rules}

{Inspect {Dictionary.entries PhonLex}}

{Inspect {Dictionary.entries LCRules}}

{Inspect Like}


