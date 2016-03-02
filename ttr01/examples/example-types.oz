declare
[Utils] = {Module.link [{VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/ttr/utils.ozf"}]}
{Utils.initTypes "default"}

declare
TTRPath = Utils.tTRPath
[Types BConvert] = {Module.link [{TTRPath "ttr/types.ozf"} {TTRPath "ttr/betaconvert.ozf"}]}
Model = Types.model
IsBType = Types.isBType
IsPfType = Types.isPfType
IsFunType = Types.isFunType
IsDepFunType = Types.isDepFunType
IsOfType = Types.isOfType
IsOfTypeCareful = Types.isOfTypeCareful
IsSupported = Types.isSupported
SimplifyJoin = Types.simplifyJoin
SimplifyMeet = Types.simplifyMeet
IsSubType = Types.isSubType
BetaConvert = BConvert.betaConvert
InstantiateType = Types.instantiateType
InstantiateTypeInModel = Types.instantiateTypeInModel
InstantiateTypeInModelAll = Types.instantiateTypeInModelAll


{Inspect {IsBType 'Ind'}}

{Inspect {IsBType x}}  %false

{Inspect {IsOfType j 'Ind'}}

{Inspect {IsPfType love(j m)}}

{Inspect {IsOfType a 'Ind'}}  %false

{Inspect {IsOfType j x}} %false

{Inspect {IsOfTypeCareful j x}} %not a type

{Inspect {IsOfType 'Ind' 'Type'}}

{Inspect {IsOfType 'Type' 'Type'}}

{Inspect {IsPfType love(j m)}}

{Inspect {IsPfType love(j)}}  %false

{Inspect {IsPfType love(j 'Ind')}} %false

{Inspect {IsOfType love#j#m love(j m)}}

{Inspect {IsOfType j#m eq('Ind' j m)}} %false

{Inspect {IsOfType j#j eq('Ind' j j)}} 

{Inspect {IsOfType m#m eq('Ind' j j)}}

{Inspect {IsSupported love(j m)}}

{Inspect {IsSupported love(m j)}}  %false

{Inspect {IsFunType funtype('Ind' 'Ind')}}

{Inspect {IsFunType funtype('Ind' 'Type')}}

{Inspect {IsOfType funtype('Ind' 'Ind') 'Type'}}

{Inspect {IsOfType funtype('Ind' 'Type') 'Type'}}

{Inspect {IsFunType funtype('Ind' funtype('Ind' 'Type'))}}

{Inspect {IsOfType lambda(x 'Ind' j) funtype('Ind' 'Ind')}}

{Inspect {IsOfType lambda(x 'Ind' man(x)) funtype('Ind' 'Type')}}

{Inspect {IsOfType apply(lambda(x 'Ind' man(x)) j) 'Type'}}

{Inspect {BetaConvert apply(apply(lambda(x 'Ind' lambda(y 'Ind' love(x y))) j) k)}}

{Inspect {BetaConvert apply(lambda(x 'Ind' apply(lambda(y 'Ind' love(x y)) j)) k)}}

{Inspect {IsSupported funtype('Ind' 'Ind')}}

{Inspect {IsDepFunType depfuntype(lambda(x 'Ind' man(x)))}}

{Inspect {IsSupported depfuntype(lambda(x 'Ind' man(x)))}} %false because there is no function from all individuals to a proof that they are a man

{Inspect {InstantiateType depfuntype(lambda(x 'Ind' man(x)))}}



{Inspect {InstantiateTypeInModel depfuntype(lambda(x 'Ind' man(x))) Model}}

{Inspect {IsOfType lambda(x 'Ind' man(x)) depfuntype(lambda(x 'Ind' man(x)))}} % false

{Inspect {IsOfType lambda(x 'Ind' man#x) depfuntype(lambda(x 'Ind' man(x)))}}  %Also false, no guarantee that man#x will be a proof of man(x)

{Inspect {SimplifyJoin jointype('Ind' 'Ind')}}

{Inspect {SimplifyMeet meettype('Ind' 'Ind')}}

{Inspect {SimplifyMeet meettype('Ind' 'Type')}} %bot

{Inspect {IsSubType 'Ind' 'Ind'}}

{Inspect {IsSubType 'Ind' jointype('Ind' 'Type')}}

{Inspect {IsSubType meettype('Ind' 'Type') 'Ind'}}

{Inspect {IsSubType funtype('Ind' 'Type') funtype('Ind' jointype('Ind' 'Type'))}}

{Inspect {IsSubType funtype('Ind' 'Type') funtype(jointype('Ind' 'Type') 'Type')}} %false

{Inspect {IsOfType [j k] listtype('Ind')}}

{Inspect {IsOfType nil listtype('Ind')}} % nil is the empty list

{Inspect {IsOfType j sintype('Ind' j)}}

{Inspect {IsOfType k sintype('Ind' j)}} %false

{Inspect {IsOfType [j k] opsintype(listtype('Ind') append([j] [k]))}}

{Inspect {IsOfType j opsintype('Ind' apply(lambda(x 'Ind' j) k))}}

{Inspect {IsOfType j optype('Type' apply(lambda(x 'Ind' 'Ind') j))}}

{Inspect {IsOfType man#j optype('Type' apply(lambda(x 'Ind' man(x)) j))}}

{Inspect {IsOfType j optype('Ind' apply(lambda(x 'Ind' j) k))}} %false

{Inspect {IsOfType man#j opsintype('Type' apply(lambda(x 'Ind' man(x)) j))}} %false

{Inspect {InstantiateTypeInModelAll 'Ind' Model}}

{Inspect {InstantiateTypeInModel 'Ind' Model}}

{Inspect {InstantiateType 'Ind'}}