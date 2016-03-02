declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Fol2ttr Types] = {Module.link ['../ttr/fol2ttr.ozf' '../ttr/types.ozf']}
Tr=Fol2ttr.fol2ttr
%Tr=Fol2ttr.fol2ttrAbbrev
AbbrevDep = Types.abbrevDep
SimplifyDep = Types.simplifyDep
FlattenRelabelRecType = Types.flattenRelabelRecType

{Inspect {Tr exists(x man(x))}}

{Inspect {Tr exists(x and(man(x) run(x)))}}

{Inspect {Tr forall(x ifthen(man(x) run(x)))}}

{Inspect {Tr exists(x exists(y and(man(x) and(woman(y) love(x y)))))}}

{Inspect {Tr and(man(a) woman(b))}}

{Inspect {Tr man(a)}}