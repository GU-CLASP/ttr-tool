declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Phon] = {Module.link ['../ures/ures-phon.ozf']}
EndsIn = Phon.endsIn
GeminateFinal = Phon.geminateFinal
DeleteFinal = Phon.deleteFinal

{Inspect {DeleteFinal 'tänd'}}

{Inspect {GeminateFinal rum}}

{Inspect {EndsIn 'tänd' d}}

{Inspect {Length {Atom.toString d}}}