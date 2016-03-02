declare
[Utils] = {Module.link [{VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/ttr/utils.ozf"}]}
TTRPath = Utils.tTRPath
[Records] = {Module.link [{TTRPath "ttr/records.ozf"}]}
FlattenRec = Records.flattenRec
RelabelRec = Records.relabelRec
R = rec(f:rec(f:rec(ff:a gg:b) g:c) g:rec(h:rec(g:a h:d)))

{Inspect R}
{Inspect R.f}
{Inspect R.g.h}
{Inspect R.f.f.ff}

{Inspect {FlattenRec R}}

{Inspect {RelabelRec R}}

{Inspect {RelabelRec {FlattenRec R}}}