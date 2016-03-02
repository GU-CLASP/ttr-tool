declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "minigram-sem"}

declare
[Minigram] = {Module.link ['../grammars/mini/minigram-sem.ozf']}
Kim = Minigram.kim
Sandy = Minigram.sandy
Run = Minigram.run
Like = Minigram.like
S_NP_VP = Minigram.s_NP_VP
VP_V_NP = Minigram.vP_V_NP
%D_S_D = Minigram.d_S_D
D_S = Minigram.d_S

{Inspect Minigram.man}


{Inspect Kim}

{Inspect Minigram.pronMasc}

{Inspect Sandy}

{Inspect Run}

{Inspect Like}

{Inspect S_NP_VP}

{Inspect VP_V_NP}

{Inspect D_S_D}

{Inspect D_S}

