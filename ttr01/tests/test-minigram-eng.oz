declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
Substitute = Utils.substitute
InitTypes = Utils.initTypes
{InitTypes "../grammars/mini/minigram-eng"}

declare
[Eng Functions Types] = {Module.link ['../grammars/mini/minigram-eng.ozf' '../ttr/functions.ozf' '../ttr/types.ozf']}
EmbeddingFunConvert = Functions.embeddingFunConvert
IsSubType = Types.isSubType

{Inspect Eng.kim}
{Inspect Eng.sandy}

{Inspect Eng.run}

{Inspect Eng.s_NP_VP}

{Inspect {EmbeddingFunConvert {EmbeddingFunConvert Eng.s_NP_VP Eng.kim} Eng.run}}

{Inspect {EmbeddingFunConvert Eng.s_NP_VP Eng.kim} }

{Inspect {IsSubType Eng.kim rectype(cat: sintype('Cat' np)
				    id:sintype('Id' 'Kim')
				    phon: sintype('Phon' [kim]))}}