declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Records] = {Module.link ['../ttr/records.ozf']}
EvalPath = Records.evalPath
EvalSelect = Records.evalSelect
SList = Records.substituteValInPathList
S = Records.substituteValInPath
AppendPaths = Records.appendPaths

{Inspect {EvalSelect {EvalPath select(rec(f:rec(f:a g:b) g:b) f) path([g])}}}




{Inspect {SList [path([f g])#r(h:a i:b) path([k])#r(l:d)]
	 r(f:r(g:r(j:a))
	   k:r(k:b
	       l:c)) }}




{Inspect {S path([f g]) r(h:a i:b) r(f:r(g:r(j:a))
				    k:r(k:b
					l:c))}}




{Inspect {AppendPaths path([x y]) path([z w])}}

{Inspect {AppendPaths path([x y]) abspath([z w])}}

{Inspect {AppendPaths objpath([x y]) path([z w])}}