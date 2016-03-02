declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}  
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "minigram-abs"}

declare
[Types Functions Minigram] = {Module.link ['../ttr/types.ozf' '../ttr/functions.ozf' '../grammars/mini/minigram-abs.ozf']}
BType = Types.bType
Model = Types.model
Pred = Types.pred
PredArity = Types.predArity
BetaConvert = Types.betaConvert
IsOfType = Types.isOfType
InstantiateType = Types.instantiateType
IsSubType = Types.isSubType
Kim = Minigram.kim
Sandy = Minigram.sandy
Run = Minigram.run
S_NP_VP = Minigram.s_NP_VP
EmbeddingFunConvert = Functions.embeddingFunConvert


   

{Inspect {IsOfType 'Kim' 'Id'}}

{Inspect {IsOfType s 'Cat'}}

{Inspect {IsOfType k 'Ind'}}

{Inspect Kim}

{Show Kim}

{Inspect Minigram.pron}

{Inspect {InstantiateType Kim}}

{Inspect {InstantiateType Run}}

{Inspect S_NP_VP}

{Browse S_NP_VP}

{Show S_NP_VP}

{Inspect {BetaConvert apply(apply(S_NP_VP {InstantiateType Kim}) {InstantiateType Run})}}

{Inspect {EmbeddingFunConvert S_NP_VP Kim}}

{Inspect {EmbeddingFunConvert {EmbeddingFunConvert S_NP_VP Kim} Run}}

{Inspect {EmbeddingFunConvert {EmbeddingFunConvert S_NP_VP
			       rectype(cat:sintype('Cat' np))}
	  rectype(cat:sintype('Cat' vp))}}


{Inspect {EmbeddingFunConvert {EmbeddingFunConvert S_NP_VP
			       rectype(cat:'Cat')}
	  rectype(cat:'Cat')}}  %badly typed argument

{Inspect {IsSubType Kim rectype(cat : sintype('Cat' np))}}

