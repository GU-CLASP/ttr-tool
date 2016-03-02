declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}

{Inspect {Utils.chooseRandom [a b c]}}

{Inspect {OS.rand} mod 3}

RMatch = Utils.recursiveMatchInRecord

{Inspect {SearchOne proc {$ _} {RMatch f(_)  g(h(a) f(b))} = true  end}}



declare
MemberR = Utils.memberR
AtLeast = Utils.atLeast

{Inspect {SearchAll proc {$ X} X = f(_ _) {MemberR X  [f(a b) f(c)]} end}}

{Inspect {AtLeast 2 [a b _ c] fun {$ X} case {SearchOne
					      proc {$ _} {MemberR X [a]} end
					     }
					of nil then false
					else true
					end
			      end}}