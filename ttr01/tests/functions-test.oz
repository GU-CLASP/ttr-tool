declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Functions] = {Module.link ['../ttr/functions.ozf']}
FPT = Functions.fixedPointType

{Inspect {FPT lambda(r rectype(x:'Ind') rectype(c:deptype(lambda(v 'Ind'
								 man(v))
							  [abspath(r [x])])))}}