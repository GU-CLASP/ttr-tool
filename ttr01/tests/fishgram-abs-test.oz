declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
TTRPath = Utils.tTRPath
{InitTypes "fishgram-abs"}

declare
[Types Functions Fishgram] = {Module.link [{TTRPath "ttr/types.ozf"} {TTRPath "ttr/functions.ozf"} {TTRPath "grammars/fish/fishgram-abs.ozf"}]}
BType = Types.bType
Model = Types.model
Pred = Types.pred
PredArity = Types.predArity
BetaConvert = Types.betaConvert
IsOfType = Types.isOfType
InstantiateType = Types.instantiateType
IsSubType = Types.isSubType
Man = Fishgram.man
Men = Fishgram.men
Fish = Fishgram.fish
Swim = Fishgram.swim
Swims = Fishgram.swims
Swam = Fishgram.swam
DefArt = Fishgram.defArt
S_NP_VP = Fishgram.s_NP_VP
NP_Det_N = Fishgram.nP_Det_N
EmbeddingFunConvert = Functions.embeddingFunConvert


   

{Inspect {IsOfType 'Man' 'Id'}}

{Inspect {IsOfType s 'Cat'}}

{Inspect Man}

{Inspect {InstantiateType Man}}

{Inspect {InstantiateType Swims}}

{Inspect S_NP_VP}

{Inspect NP_Det_N}

{Inspect {EmbeddingFunConvert NP_Det_N DefArt}}

{Inspect {EmbeddingFunConvert {EmbeddingFunConvert NP_Det_N DefArt} Fish}}

{Inspect {EmbeddingFunConvert {EmbeddingFunConvert S_NP_VP {EmbeddingFunConvert {EmbeddingFunConvert NP_Det_N DefArt} Fish}} Swims}}

{Inspect {IsSubType Man rectype(cat : sintype('Cat' n))}}

