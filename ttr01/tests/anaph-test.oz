declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Anaph] = {Module.link ['../ttr/anaph.ozf']}
FindDomain = Anaph.findDomain
FindInequalities = Anaph.findInequalities
FindProperties = Anaph.findProperties
ResolveMetaPaths = Anaph.resolveMetaPaths
ResolveMetaPathsRemoveEq = Anaph.resolveMetaPathsRemoveEq
R = rectype(c0:deptype(lambda(v0 'Ind' man(v0)) [path([x1])]) c1:deptype(lambda(v0 'Ind' donkey(v0)) [path([x0])]) c2:deptype(lambda(v0 'Ind' lambda(v1 'Ind' own(v0 v1))) [path([x1]) path([x0])]) c3:deptype(lambda(v0 'Ind' lambda(v1 'Ind' eq(v0 v1))) [path([x3]) metapath('Ind' nil)]) c4:deptype(lambda(v0 'Ind' lambda(v1 'Ind' eq(v0 v1))) [path([x2]) metapath('Ind' nil)]) c5:deptype(lambda(v0 'Ind' lambda(v1 'Ind' like(v0 v1))) [path([x3]) path([x2])]) x0:'Ind' x1:'Ind' x2:'Ind' x3:'Ind')

{Inspect Anaph.genderMutuallyExclusive}

{Inspect {SearchAll proc {$ Res} {ResolveMetaPathsRemoveEq R 'Ind' Res} end}} 

{Inspect R}

{Inspect {FindProperties x1 R}}

{Inspect {List.partition [a b c d] fun {$ X} X==d end _}}


{Inspect {FindInequalities {FindDomain
	  rectype(c0:deptype(lambda(v0 'Ind' man(v0)) [path([x1])]) c1:deptype(lambda(v0 'Ind' donkey(v0)) [path([x0])]) c2:deptype(lambda(v0 'Ind' lambda(v1 'Ind' own(v0 v1))) [path([x1]) path([x0])]) c3:deptype(lambda(v0 'Ind' lambda(v1 'Ind' eq(v0 v1))) [path([x3]) metapath('Ind' nil)]) c4:deptype(lambda(v0 'Ind' lambda(v1 'Ind' eq(v0 v1))) [path([x2]) metapath('Ind' nil)]) c5:deptype(lambda(v0 'Ind' lambda(v1 'Ind' like(v0 v1))) [path([x3]) path([x2])]) x0:'Ind' x1:'Ind' x2:'Ind' x3:'Ind')
			    'Ind'}
	  rectype(c0:deptype(lambda(v0 'Ind' man(v0)) [path([x1])]) c1:deptype(lambda(v0 'Ind' donkey(v0)) [path([x0])]) c2:deptype(lambda(v0 'Ind' lambda(v1 'Ind' own(v0 v1))) [path([x1]) path([x0])]) c3:deptype(lambda(v0 'Ind' lambda(v1 'Ind' eq(v0 v1))) [path([x3]) metapath('Ind' nil)]) c4:deptype(lambda(v0 'Ind' lambda(v1 'Ind' eq(v0 v1))) [path([x2]) metapath('Ind' nil)]) c5:deptype(lambda(v0 'Ind' lambda(v1 'Ind' like(v0 v1))) [path([x3]) path([x2])]) x0:'Ind' x1:'Ind' x2:'Ind' x3:'Ind')}}

