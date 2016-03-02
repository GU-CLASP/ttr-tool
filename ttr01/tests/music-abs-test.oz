declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "music-abs"}

declare
[G F] = {Module.link ['../grammars/music/music-abs.ozf' '../ttr/functions.ozf']}
Apply = F.embeddingFunConvert

{Inspect G.conductor}

{Inspect G.s_NP_VP}

{Inspect {Apply G.nP_Det_N G.indefArt}}

declare
A = {Apply G.nP_Det_N G.indefArt}
{Inspect {Apply A G.conductor}}

declare
AConductor = {Apply A G.conductor}
{Inspect {Apply {Apply G.vP_Cop_NP G.be} AConductor}}

declare
BeAConductor = {Apply {Apply G.vP_Cop_NP G.be} AConductor}
{Inspect {Apply {Apply G.s_NP_VP G.dudamel} BeAConductor}}