declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Phon] = {Module.link ['../ures/ures-phon.ozf']}
EndsIn = Phon.endsIn
GeminateFinal = Phon.geminateFinal
DeleteFinal = Phon.deleteFinal

{Inspect {DeleteFinal 't�nd'}}

{Inspect {GeminateFinal rum}}

{Inspect {EndsIn 't�nd' d}}

{Inspect {Length {Atom.toString d}}}