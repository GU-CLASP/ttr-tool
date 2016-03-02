declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "default"}

declare
[Types Preds] = {Module.link ['../ttr/types.ozf' '../ttr/preds.ozf']}
Type = Types.type
BType = Types.bType
OfType = Types.ofType
IsOfType = Types.isOfType
IsOfTypeCareful = Types.isOfTypeCareful
FindType = Types.findType
FindObjects = Types.findObjects
PfType = Types.pfType
InstantiateType = Types.instantiateType
IsSubType = Types.isSubType
SubType = Types.subType
John = rectype(x: sintype('Ind' j)
	       c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
Mary = rectype(x: sintype('Ind' m)
	       c: deptype(lambda(x 'Ind' woman(x)) [path([x])]))
Person = jointype(John Mary)

{Inspect {InstantiateType rectype(x:sintype('Ind' j))}}
{Inspect {InstantiateType Person}}
{Inspect {InstantiateType jointype(rectype(x: sintype('Ind' j)
					   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
				 rectype(x: sintype('Ind' m)
	       c: deptype(lambda(x 'Ind' woman(x)) [path([x])])) )}}
{Inspect Person}
{Inspect {InstantiateType jointype(rectype(x:sintype('Ind' j)c: deptype(lambda(x 'Ind' man(x)) [path([x])])) rectype(x:'RecType'))}}
{Inspect {IsOfType Person 'Type'}}
{Inspect {IsSubType  rectype(x:sintype('Ind' j)
			     c : man(j))
	 Person}}



