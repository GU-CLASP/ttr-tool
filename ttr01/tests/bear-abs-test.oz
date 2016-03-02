declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "bear-eng"}

declare
[G F] = {Module.link ['../grammars/bear/bear-abs.ozf' '../ttr/functions.ozf']}
Apply = F.embeddingFunConvert

{Inspect G.bear}

{Inspect G.n_Adj_N}

{Inspect {Apply G.n_Adj_N G.nice}}

{Inspect {Apply {Apply G.n_Adj_N G.nice} G.bear}}

{Inspect G.s_NP_VP}

{Inspect G.nice}

{Browse LCDRules}

{Browse DRules}

{Inspect Rules}