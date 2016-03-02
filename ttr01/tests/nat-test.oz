declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "nat"}

declare
[Types] = {Module.link ['../ttr/types.ozf']}
IsOfType = Types.isOfType
InstantiateType = Types.instantiateType
IsSubType = Types.isSubType

{Inspect {IsOfType rec(n:0) 'Nat'}}

{Inspect {IsOfType rec(s:0
		       n:rec(s:0
			     n:rec(n:0))) 'Nat'}}

{Inspect {InstantiateType 'Nat'}}

{Inspect {IsSubType rectype(s:'Zero'
			    n:'Nat') 'Nat'}}

{Inspect {IsSubType rectype(s:'Zero'
			    n:rectype(s:'Zero'
				      n:'Nat'))
	  rectype(s:'Zero'
		  n:'Nat')}}

{Inspect {IsSubType 'Zero' 'Nat'}}

{Inspect {InstantiateType 'Zero'}}

{Inspect {IsOfType 0 'Nat'}}

{Inspect {IsSubType 'Even' 'Nat'}}

{Inspect {IsSubType 'Odd' 'Nat'}}

{Inspect {IsSubType 'Nat' 'Even'}}

{Inspect {IsSubType 'Nat' 'Odd'}}

{Inspect {IsSubType 'Even' 'Odd'}}


