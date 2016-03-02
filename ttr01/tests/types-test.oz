declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
Substitute = Utils.substitute
InitTypes = Utils.initTypes
{InitTypes "default"}

declare
[DebugFile] = {Module.link ['../ttr/debug.ozf']}
Debug = DebugFile.debug
{Debug no}

declare
[Types Preds Utils] = {Module.link ['../ttr/types.ozf' '../ttr/preds.ozf' '../ttr/utils.ozf']}
Model = Types.model
Type = Types.type
BType = Types.bType
OfType = Types.ofType
IsOfType = Types.isOfType
IsOfTypeCareful = Types.isOfTypeCareful
FindType = Types.findType
FindObjects = Types.findObjects
PfType = Types.pfType
IsFunType = Types.isFunType
InstantiateType = Types.instantiateType
InstantiateTypeInModel = Types.instantiateTypeInModel
InstantiateTypeInModelAll = Types.instantiateTypeInModelAll
RefineTypeInModel = Types.refineTypeInModel
RefineTypeInModelAll = Types.refineTypeInModelAll
IsSupported = Types.isSupported
IsSubType = Types.isSubType
SubType = Types.subType
SimplifyMeet = Types.simplifyMeet
SimplifyDep = Types.simplifyDep
SimplifyOp = Types.simplifyOp
DisjointTypes = Types.disjointTypes
IsBasicSubType = Types.isBasicSubType
ExploitEqualities = Types.exploitEqualities
ExportSintype = Types.exportSintype
NormalizeDep = Types.normalizeDep
Test = Utils.test
John = rectype(x: sintype('Ind' j)
	       c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
Mary = rectype(x: sintype('Ind' m)
	       c: deptype(lambda(x 'Ind' woman(x)) [path([x])]))
Person = jointype(John Mary)

{Inspect {RefineTypeInModel 'Ind' Model}}

{Inspect {RefineTypeInModelAll rectype(x:'Ind' y:'Ind') Model}}

{Inspect {RefineTypeInModel
	  rectype(x:'Ind'
		  c1: deptype(lambda(v 'Ind' man(v))
			     [path([x])])
		  c2: deptype(lambda(v 'Ind' man(v))
			     [path([x])]))
	  Model}}

{Inspect {RefineTypeInModelAll
	  rectype(x:'Ind'
		  c1: deptype(lambda(v 'Ind' man(v))
			     [path([x])])
		  c2: deptype(lambda(v 'Ind' person(v))
			     [path([x])]))
	  Model}}

{Inspect {RefineTypeInModelAll
	  rectype(x:'Ind'
		  c1: deptype(lambda(v 'Ind' person(v))
			     [path([x])]))
	  Model}}

{Inspect {RefineTypeInModelAll
	  rectype(x:'Ind'
		  y:'Ind'
		  c1: deptype(lambda(v 'Ind' man(v))
			     [path([x])])
		  c2: deptype(lambda(v 'Ind'
				     lambda(w 'Ind' love(v w)))
			     [path([x]) path([y])]))
	  Model}}

{Inspect {RefineTypeInModel
	  rectype(x:'Ind'
		  y:'Ind'
		  c1: deptype(lambda(v 'Ind' man(v))
			     [path([x])])
		  c2: deptype(lambda(v 'Ind'
				     lambda(w 'Ind' love(v w)))
			     [path([y]) path([x])]))
	  Model}}

{Inspect {IsOfType 'Rec' 'Type'}}

{Inspect {SimplifyMeet meettype(rectype rectype(x:'Ind'))}}

{Inspect {IsOfType rec(x:j) rectype }}


% {Inspect {InstantiateType
% 	  rectype(agr:rectype(gen:deptype(lambda(x 'Gender' sintype('Gender' x)) [path([daughters rest first agr gen])])
% 			      num:deptype(lambda(x 'Number' sintype('Number' x)) [path([daughters rest first agr num])])
% 			      pers:deptype(lambda(x 'Person' sintype('Person' x)) [path([daughters rest first agr pers])]))
% 		  cGen:deptype(lambda(x 'Gender' lambda(y 'Gender' eq('Gender' x y))) [path([daughters first agr gen]) path([daughters rest first agr gen])])
% 		  cNum:deptype(lambda(x 'Number' lambda(y 'Number' eq('Number' x y))) [path([daughters first  agr num]) path([daughters rest first agr num])])
% 		  cPers:deptype(lambda(x 'Person' lambda(y 'Person' eq('Person' x y))) [path([daughters first agr pers]) path([daughters rest first agr pers])]) cat:sintype('Cat' np)
% 		  daughters:rectype(first:rectype(agr:rectype(gen:'Gender' num:sintype('Number' sg)
% 							      pers:sintype('Person' third))
% 						  cat:sintype('Cat' det)
% 						  id:sintype('Id' 'IndefArt')
% 						  phon:sintype('Phon' [a]))
% 				    rest:rectype(first:rectype(agr:rectype(gen:'Gender' num:'Number'
% 									   pers:sintype('Person' third)) cat:sintype('Cat' n) id:sintype('Id' 'Fish')
% 							       phon:sintype('Phon' [fish]))
% 						 rest:sintype(listtype('Rec') nil)))
% 		  id:deptype(lambda(v1 'Id' lambda(v2 'Id' sintype('Id' app(app(np_det_n v1) v2)))) [objpath('IndefArt') objpath('Fish')])
% 		  phon:opsintype('Phon' append([a] [fish])))}}

{Inspect {InstantiateTypeInModelAll 'Ind' Model}}

{Inspect {InstantiateTypeInModelAll rectype(x: 'Ind'
						     c: deptype(lambda(y 'Ind'
								       person(y))
								[path([x])])) Model}}

{Inspect {InstantiateTypeInModel 'Ind' Model}}



{Inspect {IsOfType person(j) 'Type'}}

{Inspect {IsOfType depfuntype(lambda(x 'Ind' person(x))) 'Type'}}

{Inspect {InstantiateTypeInModel funtype('Ind' bot) Model}}

{Inspect {InstantiateTypeInModel depfuntype(lambda(x 'Ind' person(x))) Model}}

{Inspect {InstantiateTypeInModel depfuntype(lambda(x 'Ind' man(x))) Model}}

{Inspect {InstantiateTypeInModel funtype(
				    depfuntype(lambda(x 'Ind' person(x)))
				    bot)
	  Model}}

{Inspect {IsFunType funtype(depfuntype(lambda(x 'Ind' person(x)))
			    bot) }}

{Inspect {InstantiateTypeInModel funtype(funtype(depfuntype(lambda(x 'Ind' person(x)))
			    bot) bot) Model}}

{Inspect {InstantiateTypeInModel funtype(
				    depfuntype(lambda(x 'Ind' man(x)))
				    bot)
	  Model}}

{Inspect {InstantiateTypeInModel funtype(funtype(
				    depfuntype(lambda(x 'Ind' man(x)))
				    bot) bot)
	  Model}}

{Inspect {IsSupported rectype(x : 'Ind'
			      c : deptype(lambda(v 'Ind' man(v))
					  [path([x])]))}}

{Inspect {IsSupported funtype(rectype(x : 'Ind'
			      c : deptype(lambda(v 'Ind' man(v))
					  [path([x])]))
			      bot)}}

{Inspect {IsSupported funtype(funtype(rectype(x : 'Ind'
					      c : deptype(lambda(v 'Ind' man(v))
					  [path([x])]))
				      bot)
			     bot)}}

{Inspect {InstantiateTypeInModel depfuntype(
				    lambda(r rectype(x: 'Ind'
						     c: deptype(lambda(y 'Ind'
								       man(y))
								[path([x])]))
					   rectype(c: deptype(lambda(y 'Ind'
								     person(y))
							      [abspath(r [x])])))) Model}}

{Inspect {InstantiateTypeInModel depfuntype(
				    lambda(r rectype(x: 'Ind'
						     c: deptype(lambda(y 'Ind'
								       person(y))
								[path([x])]))
					   rectype(c: deptype(lambda(y 'Ind'
								     man(y))
							      [abspath(r [x])])))) Model}}

{Inspect {IsSupported depfuntype(lambda(x 'Ind' man(x)))}}

{Inspect {InstantiateTypeInModel 'RecType' Model}}


{Inspect {IsSupported funtype('Ind' 'Ind')}}


{Inspect {SimplifyMeet meettype(rectype(cat:sintype('Cat' s)
					daughters:rectype(first:sintype(rectype(cat:sintype('Cat' np)) r1)
							  rest:rectype(first:sintype(rectype(cat:sintype('Cat' vp)) r2)
								       rest:sintype(listtype('Rec') nil)))
					id:deptype(lambda(v1 'Id'
							  lambda(v2 'Id' sintype('Id' apply(apply(s_np_vp v1) v2)))) [abspath(r1
															      [id])
														      abspath(r2 [id])]))
				rectype(phon:opsintype('Phon'
						       append(select(r1 phon) select(r2 phon)))))}}

{Inspect {InstantiateType rectype(cat:sintype('Cat' s)
					daughters:rectype(first:sintype(rectype(cat:sintype('Cat' np)) r1)
							  rest:rectype(first:sintype(rectype(cat:sintype('Cat' vp)) r2)
								       rest:sintype(listtype('Rec') nil)))
					id:deptype(lambda(v1 'Id'
							  lambda(v2 'Id' sintype('Id' apply(apply(s_np_vp v1) v2)))) [abspath(r1
															      [id])
														      abspath(r2 [id])]))}}

{Inspect {IsOfType nil listtype('Ind')}} % nil is the empty list

{Inspect {IsOfType null bot}} % null is the empty arbitrary object

{Inspect {InstantiateType rectype(c : bot)}}  %null

{Inspect {InstantiateTypeInModel rectype(c : bot) Model}}

{Inspect {IsSubType rectype(c : bot) bot}}

{Inspect {IsSubType bot bot}}

{Inspect {IsSubType bot rectype(c : bot) }} %true

{Inspect {FindType j}}

{Inspect {FindType love#j#m}}

{Inspect {FindType v}} % none -- v does not have a type

{Inspect {FindType rec(x:j y:m)}} %Doesn't work

{Inspect {FindObjects love(j m)}}

{Inspect {IsOfType j 'Ind'}}

{Inspect {IsOfTypeCareful j 'Ind'}}

{Inspect {IsOfTypeCareful j v}}%'Not a type'

{Inspect {IsOfType j v} } % false

{Inspect {IsOfType v 'Ind'}} %false

{Inspect {IsOfType love#j#m love(j m)}}

{Inspect {IsOfType j#m eq('Ind' j m)}}

{Inspect {IsOfType j#j eq('Ind' j j)}}

{Inspect {IsOfType m#m eq('Ind' j j)}}

{Inspect {SearchAll proc {$ T} {PfType T} end}}

{Inspect {InstantiateType 'Ind'}}

{Inspect {InstantiateTypeInModel rectype(x :'Ind') Model}}

{Inspect {InstantiateType depfuntype(lambda(x 'Ind' man(x)))}}

{Inspect {InstantiateTypeInModel depfuntype(lambda(x 'Ind' man(x))) Model}}

{Inspect {InstantiateType rectype(x:'Ind' y:'Ind')}}

{Inspect {InstantiateTypeInModel rectype(x:'Ind' y:'Ind') Model}}

{Inspect {InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]))}}

{Inspect {InstantiateTypeInModel rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])])) Model}}

{Inspect{IsOfType lambda(x0 'Ind' pf0#man(x0)) depfuntype(lambda(x 'Ind' man(x)))}}

{Inspect {IsOfType man(a0#'Ind') 'Type'}}

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind')}}

{Inspect {IsOfType rec(x:j) rectype(x:'Ind' y:'Ind')}}  %false

{Inspect {IsOfType rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])])) 'RecType'}}

{Inspect {IsOfType rectype(x:'Ind' y: rectype(z:deptype(lambda(x 'Ind' man(x)) [path([x])]))) 'RecType'}} %false because label x not local to z: deptype...

{Inspect {IsOfType rectype(x:'Ind' y: deptype(lambda(x 'Ind' rectype(z: man(x))) [path([x])])) 'RecType'}} %new

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])]))}}

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) )}}

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))} }

{Inspect {InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))}}

{Inspect {InstantiateTypeInModel rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])])) Model}}


{Inspect {IsSubType 'Ind' 'Ind'}}

{Inspect {IsSubType rectype(x: 'Ind' y:'Ind') rectype(x:'Ind')}}

{Inspect {IsSubType
	  rectype(x:'Ind'
		  y:'Ind'
		  z:deptype(lambda(x 'Ind' man(x)) [path([y])]))
	  rectype(x:'Ind'
		  y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])])
		  z:deptype(lambda(x 'Ind' man(x)) [path([y])])) }} %false

{Inspect {IsSubType
	  rectype(x:'Ind'
		  y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])])
		  z:deptype(lambda(x 'Ind' man(x)) [path([y])]))
	  rectype(x:'Ind'
		  y:'Ind'
		  z:deptype(lambda(x 'Ind' man(x)) [path([y])]))  }} 

{Inspect {IsSubType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])])
			     z:deptype(lambda(x 'Ind' man(x)) [path([x y])])))
	  rectype(x: rectype(x:'Ind'
			     y:'Ind'
			     z:deptype(lambda(x 'Ind' man(x)) [path([x y])])))  }} 

{Inspect {IsOfType
	  rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) )
	  'RecType'}}

{Inspect {IsOfType
	  rectype(x:'Type' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) )
	  'RecType'}} %false  

{Inspect {IsOfType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x x])]) ))
	  'RecType'}} %  (37)

{Inspect {IsOfType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) ))
 'RecType'}} % (37.1) false

{Inspect {InstantiateType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x x])]) ))}}

{Inspect {InstantiateTypeInModel
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x x])]) )) Model}} 

{Inspect {InstantiateType 'RecType'}}


{Inspect {InstantiateTypeInModel 'RecType' Model}}

{Inspect {IsOfType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind')
	  'RecType'}} % (40)

{Inspect {IsOfType
	  rectype(x: deptype(lambda(v 'Ind'
				    rectype(x:'Ind'
					    y: man(v)))
			     [path([y])]) 
		  y: 'Ind')
	  'RecType'}} % (40.1)

{Inspect {InstantiateType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind')
	  }}

{Inspect {InstantiateTypeInModel
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind')
	  Model}}

{Inspect {IsOfType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  'RecType'}} % (42)

{Inspect {IsOfType
	  rectype(x: deptype(lambda(v 'Ind' rectype(x:'Ind'
						    y:man(v)))
				    [path([y])]) 
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  'RecType'}} %false - should be true?  Problem? No

{Inspect {InstantiateType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }}

{Inspect {InstantiateTypeInModel
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  Model}}

{Inspect {IsSubType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind') }} 

{Inspect {IsSubType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind') 
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }} %false 

{Inspect {InstantiateType
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }} %non-wellfounded

{Inspect {InstantiateTypeInModel
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 Model}} %non-wellfounded

{Inspect {InstantiateType x}}  %none

{Inspect {InstantiateTypeInModel x Model}}  %none

{Inspect {IsOfType
	  rec(x: rec(x: j
		     y: man#j)
	      y: j)
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }}

{Inspect {IsOfTypeCareful
	  rec(x: rec(x: j
		     y: man#j)
	      y: j)
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }} %Not a type

{Inspect {IsOfType
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  'RecType'}} %false


{Inspect {IsOfType
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  'Type'}} %false

{Inspect {IsOfType
	  rec(x : [j]
	      y : [m]
	      z : [j m])
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))}} % (51)



{Inspect {IsOfType
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	  'RecType'}} % (52)

{Inspect {IsOfType
	  rectype(x : listtype('Ind')
		  y : 'Ind'
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	  'RecType'}} %false  (53)

{Inspect {IsOfType
	  rectype(x : listtype('Ind')
		  y : 'Ind'
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y 'Ind'
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	  'RecType'}} %false (54)

{Inspect {InstantiateType
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	 }} % (55)

{Inspect {InstantiateTypeInModel
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	  Model}}

{Inspect {InstantiateType
	  rectype(x : sintype(listtype('Ind') [j])
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	 }} % (56)

{Inspect {InstantiateType
	  rectype(x : sintype(listtype('Ind') [j])
		  y : sintype(listtype('Ind') [m])
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	 }} % (57)

{Inspect {InstantiateType
	  rectype(z : sintype(listtype('Ind') [j])
		  y : sintype(listtype('Ind') [m])
		  x : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([z]) path([y])]))
	 }} % (58)

{Inspect {InstantiateType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(v 'Ind'
					    optype('RecType' apply(f v)))) % optype?
			      [path([x]) path([y])]))
	 }} % (59)

{Inspect {InstantiateTypeInModel
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(v 'Ind'
					    optype('RecType' apply(f v)))) % optype?
			      [path([x]) path([y])]))
	 Model}}

{Inspect {InstantiateType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(v 'Ind'
					    opsintype('RecType' apply(f v)))) 
			      [path([x]) path([y])]))
	 }} % (59.1)

{Inspect {IsOfType
	  rec(x : lambda(x 'Ind' rectype(c : man(x)))
	      y : j
	      z : rectype(c : man(j)))
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	 }} % (60)

{Inspect {IsSubType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([w])]))
	 }} %false (61)

{Inspect {IsSubType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	  rectype(z : 'RecType')
	 }} % (62)

{Inspect {InstantiateType 
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	 }} % (63)

{Inspect {IsOfType
	  lambda(x 'Ind' rectype(c : man(x)))
	  funtype('Ind' 'RecType')}}

{Inspect {IsOfType
	  lambda(f funtype('Ind' 'RecType')
		 lambda(x 'Ind'
			optype('RecType' apply(f x)))) %Should this be optype?
	  funtype(funtype('Ind' 'RecType') (funtype('Ind' 'Type')))}} %(65)

{Inspect {IsOfType optype('RecType' apply(lambda(x 'Ind' rectype(x : sintype('Ind' x))) j)) 'RecType'}} % (65.1)

{Inspect {IsOfType sintype(rectype(x:'Ind') rec(x:j)) 'RecType'}} % (65.2)

{Inspect {IsOfType
	  optype('RecType' apply(f#funtype('Ind' 'RecType') a#'Ind'))
	  'Type'}}

{Inspect {IsOfType
	  apply(f#funtype('Ind' 'RecType') a#'Ind')
	  'RecType'}}

{Inspect {InstantiateType rectype(x:sintype('Ind' j))}}

{Inspect {InstantiateTypeInModel rectype(x:sintype('Ind' j)) Model}}

{Inspect {InstantiateType Person}}

{Inspect {InstantiateTypeInModel Person Model}}

{Inspect Person}

{Inspect {InstantiateType jointype(rectype(x: sintype('Ind' j)
					   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
				 rectype(x: sintype('Ind' m)
					 c: deptype(lambda(x 'Ind' woman(x)) [path([x])])) )}}

{Inspect Person}

{Inspect {InstantiateType jointype(rectype(x:sintype('Ind' j)c: deptype(lambda(x 'Ind' man(x)) [path([x])])) rectype(x:'RecType'))}}

{Inspect {InstantiateTypeInModel jointype(rectype(x:sintype('Ind' j)c: deptype(lambda(x 'Ind' man(x)) [path([x])])) rectype(x:'RecType')) Model}}

{Inspect {IsOfType Person 'Type'}}

{Inspect {IsSubType  rectype(x:sintype('Ind' j)
			     c : man(j))
	  Person}}

{Inspect {IsOfType rectype(x : listtype(rectype(x:'Ind'
						c:deptype(lambda(x 'Ind' man(x)) [path([x])])))) 'RecType'}}


{Inspect {IsOfType
	  listtype(
	     rectype(x:'Ind'
		     c:deptype(lambda(x 'Ind' man(x)) [path([x])])))
	  'Type'}}

{Inspect {IsOfType
	     rectype(x:'Ind'
		     c:deptype(lambda(x 'Ind' man(x)) [path([x])]))
	  'Type'}}

{Inspect {IsOfType
	  rec(x: [rec(x: j c:man#j)
		  rec(x:j c:man#j)])
	  rectype(x : listtype(
			 rectype(x:'Ind'
				 c:deptype(lambda(x 'Ind' man(x)) [path([x])]))))}}

{Inspect {InstantiateType rectype(x:'Ind')}}

{Inspect {InstantiateType depfuntype(lambda(r rectype(x:'Ind')
			      rectype(x:'Ind')))}}

{Inspect {InstantiateType
	  depfuntype(lambda(r rectype(x:'Ind')
			    rectype(c:deptype(lambda(x 'Ind' man(x))
					      [abspath(r [x])]))))}} %81 

{Inspect {IsOfType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rec(x:a0#'Ind') [x])])) 'Type'}} 

{Inspect {IsOfType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rectype(x:'Ind') [x])])) 'Type'}} %false

{Inspect {InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rectype(x:'Ind') [x])])) }} %none

{Inspect {InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rec(x:a2#'Ind') [x])])) }}

{Inspect {InstantiateTypeInModel rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rec(x:a2#'Ind') [x])])) Model}}

{Inspect {InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(r [x])])) }} %none because r not assigned a type

{Inspect {InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(r#rectype(x:'Ind') [x])])) }}

{Inspect {InstantiateTypeInModel rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(r#rectype(x:'Ind') [x])])) Model}}

{Inspect {IsOfType
	  depfuntype(lambda(r rectype(x:'Ind')
			      rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r [x])]))))
	  'Type'}}

{Inspect {IsOfType
	  lambda(r rectype(x:'Ind') rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r [x])])))
	  depfuntype(lambda(r rectype(x:'Ind')
			      'RecType'))
	 }}

{Inspect {SimplifyMeet meettype('Ind' 'Ind')}}

{Inspect {IsSubType 'Ind' 'Type'}}  %false

{Inspect {IsBasicSubType 'Type' 'Type'}}

{Inspect {IsBasicSubType 'RecType' 'Type'}}

{Inspect {DisjointTypes 'Type' 'Ind'}}

{Inspect {SimplifyMeet 'Ind'}}

{Inspect {SimplifyMeet meettype('Ind' 'Type')}} %bot

{Inspect {SimplifyMeet meettype(rectype(x:'Ind' y:'Ind') rectype(x: 'Ind'))}}

{Inspect {SimplifyMeet meettype(rectype(x: 'Ind') rectype(x:'Ind' y:'Ind'))}}

{Inspect {SimplifyMeet meettype(jointype('Ind' 'Type') 'RecType')}} %'RecType'

{Inspect {SimplifyMeet meettype(jointype('Ind' 'Type') 'Ind')}}

{Inspect {SimplifyMeet meettype(jointype('Ind' 'Type') jointype('Ind' 'RecType'))}}

{Inspect {SimplifyMeet meettype('Ind' jointype('Ind' 'Type'))}}

{Inspect {SimplifyMeet meettype(rectype(a:'Ind') rectype(b:'Ind'))}}

{Inspect {SimplifyMeet meettype(rectype(a:'Ind' c: jointype('Ind' 'Type')) rectype(b:'Ind' c:'Ind'))}}

{Inspect {SimplifyMeet meettype(
			  depfuntype(lambda(r rectype(x:'Ind')
					    rectype(c:deptype(lambda(x 'Ind'
								     man(x))
						[abspath(r [x])]))))
			  depfuntype(lambda(r rectype(x:'Ind')
					    rectype(a:'Ind'
						    c:deptype(lambda(x 'Ind'
								     man(x))

					      [abspath(r [x])])))))}} 

{Inspect {SimplifyMeet
	  meettype(
	     rectype(x: 'Ind'
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     w: 'Ind'))}} 

{Inspect {SimplifyMeet
	  meettype(
	     rectype(x: 'Ind'
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([x])]))
		     w: 'Ind'))}} 

{Inspect {SimplifyMeet
	  meettype(
	     rectype(x: 'Ind'
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: 'Ind'))}} %contains meettype  


{Inspect {SimplifyMeet
	  meettype(rectype(x : 'Ind'
			   y : deptype(lambda(x 'Ind' man(x)) [path([x])]))
		   rectype(x : 'Ind'
			   w : 'Ind'
			   y : deptype(lambda(x 'Ind' man(x)) [path([w])])))}}
%contains meettype 

{Inspect {SimplifyMeet meettype(deptype(lambda(x 'Ind' man(x)) [path([x])])
				deptype(lambda(x 'Ind' man(x)) [path([w])]))}} %contains meettype 


{Inspect {InstantiateType deptype(lambda(x 'Ind' man(x)) [path([x])])}} %none, because path not defined 


{Inspect {SimplifyMeet
	  meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' j)))}} %contains meettype

{Inspect {SimplifyMeet
	  {SimplifyDep
	   meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' j)))}}}



 {Inspect {SimplifyMeet
	  meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' m)))}}  % contains meettype 

{Inspect {SimplifyMeet
	  {SimplifyDep
	  meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' m)))}}}  %contains meettype

{Inspect {SimplifyMeet
	  meettype(rectype(a : 'Ind'
			   b : 'Ind')
		   rectype(a : sintype('Ind' j)))}}

{Inspect {SimplifyMeet
	  meettype(rectype(a : sintype('Ind' j))
		   rectype(a : 'Ind'
			   b : 'Ind'))
	 }}

{Inspect {SimplifyMeet meettype(rectype rectype(a:'Ind'))}}


		 


{Inspect {InstantiateType rectype(x: 'Ind'
		  y: rectype(
			a: 'Ind'
			c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
				  z: 'Ind')}}

{Inspect {InstantiateTypeInModel rectype(x: 'Ind'
		  y: rectype(
			a: 'Ind'
			c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		  z: 'Ind') Model}}

{Inspect {IsSubType 
	  depfuntype(lambda(r rectype(x:'Ind')
			    rectype(a:'Ind'
				    c:deptype(lambda(x 'Ind' man(x))
					      [abspath(r [x])]))))
	  depfuntype(lambda(r1 rectype(x:'Ind')
			      rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r1 [x])]))))}} 

{Inspect {IsOfType [j k] listtype('Ind')}}

{Inspect {IsOfType append([j] [k]) listtype('Ind')}}

{Inspect {IsOfType apply(lambda(x 'Ind' [x k]) j) listtype('Ind')}}

{Inspect {IsOfType apply(lambda(x 'Ind' append([x] [k])) j) listtype('Ind')}}

{Inspect {IsOfType sintype(listtype('Ind') append([j] [k])) 'Type'}}

{Inspect {IsOfType append([j] [k]) listtype('Ind')}}

{Inspect {IsSubType meettype(rectype(a:'Ind') rectype(b:'Ind')) rectype(a:'Ind')}}

{Inspect {SimplifyMeet meettype(rectype(a:'Ind') rectype(a:listtype('Ind'))) }}


{Inspect {IsSubType meettype(rectype(a:'Ind') rectype(a:listtype('Ind'))) rectype(a:'RecType')}}

{Inspect {InstantiateType meettype(rectype(a:'Ind') rectype(a:listtype('Ind')))}} 


{Inspect {InstantiateType {SimplifyMeet meettype(rectype(a:'Ind') rectype(a:listtype('Ind')))}}} %null

{Inspect {InstantiateTypeInModel {SimplifyMeet meettype(rectype(a:'Ind') rectype(a:listtype('Ind')))} Model}} %null

{Inspect {IsSubType bot rectype(a:'RecType')}}

{Inspect {InstantiateType bot}}

{Inspect {InstantiateTypeInModel bot Model}}

{Inspect {IsSupported bot}}

{Inspect {InstantiateType rectype(a:bot)}}

{Inspect {InstantiateTypeInModel rectype(a:bot) Model}}

{Inspect {IsSubType rectype(a:bot) rectype(b: 'RecType')}} % (130)

{Inspect {InstantiateType rectype(a:bot b:'Ind')}} %null

{Inspect {IsSubType 'RecType' 'Type'}} 


{Inspect {IsSubType meettype(rectype(a: man(j)) rectype(a: man(m))) rectype(a: man(j))}} %true 

{Inspect {IsSubType meettype(rectype(a: man(j)) rectype(a: man(j))) rectype(a: woman(j))}} %false

{Inspect {IsSubType meettype(rectype(a: man(j)) rectype(a: man(m))) rectype(a: woman(j))}} %false  

{Inspect {IsSubType meettype(rectype(a: man(j)) rectype(b: man(m))) rectype(a: man(m))}} %false 


{Inspect {SimplifyMeet meettype(rectype(a: man(j)) rectype(a: man(m)))}} 

{Inspect {IsSubType meettype(man(j) man(m)) man(j)}} 

{Inspect {ExploitEqualities
	  rectype(x : rectype(x: sintype('Ind' j)
			      y: 'Ind')
		  y : rectype(x: 'Ind'
			      y: sintype('Ind' k))
		  c : deptype(lambda(v1 'Rec'
				     lambda(v2 'Rec'
					    eq('Rec' v1 v2)))
			      [path([x]) path([y])]))}}

{Inspect {SimplifyOp {ExploitEqualities
	  rectype(x : rectype(x: sintype('Ind' j)
			      y: 'Ind')
		  y : rectype(x: 'Ind'
			      y: sintype('Ind' k))
		  c : deptype(lambda(v1 'Rec'
				     lambda(v2 'Rec'
					    eq('Rec' v1 v2)))
			      [path([x]) path([y])]))}}}

{Inspect {SimplifyDep {SimplifyOp {ExploitEqualities
	  rectype(x : rectype(x: sintype('Ind' j)
			      y: 'Ind')
		  y : rectype(x: 'Ind'
			      y: sintype('Ind' k))
		  c : deptype(lambda(v1 rectype
				     lambda(v2 rectype
					    eq(rectype v1 v2)))
			      [path([x]) path([y])]))}}}}

{Inspect {ExportSintype rectype(x : rectype(x: sintype('Ind' j))
				y : sintype('Ind' m))}}

{Inspect {ExportSintype rectype(x : rectype(x: sintype('Ind' j))
				y : 'Ind')}}

{Inspect {IsOfTypeCareful rec(f:j g:m) 'Rec'}}

{Inspect {IsOfTypeCareful rec(f:j g:m) rectype}}

{Inspect {NormalizeDep deptype(lambda(x rectype(f:t1 g:t2)
				      sintype(rectype(f:t1 g:t2) x))
			       [path([p1 p2])])}}


{Inspect {IsOfType lambda(x 'Ind' man(x)) depfuntype(lambda(x 'Ind' 'Type'))}}

{Inspect {IsSupported rectype(f: depfuntype(lambda( r rectype(x : 'Ind'
							      c : deptype(lambda(x 'Ind' man(x))
									  [path([x])]))
						    rectype(c : deptype(lambda(x 'Ind' love(x m))
									[abspath(r [x])])))))}}

{Inspect {IsSupported depfuntype(lambda(x 'Ind' 'Ind'))}}

{Inspect {IsSupported rectype(x :'Ind'
			      c : deptype(lambda(v 'Ind' man(v))
					  [path([x])]))}}

% Also operators-test.oz

declare
TestSuite =
[1#{IsOfType nil listtype('Ind')}#true#'{IsOfType nil listtype(\'Ind\')}'
 2#{IsOfType null bot}#true#'{IsOfType null bot}'
 3#{InstantiateType rectype(c : bot)}#null#'{InstantiateType rectype(c : bot)}#nul}'
 4#{IsSubType rectype(c : bot) bot}#true#'{IsSubType rectype(c : bot) bot}'
 5#{IsSubType bot bot}#true#'{IsSubType bot bot}'
 6#{IsSubType bot rectype(c : bot) }#true#'{IsSubType bot rectype(c : bot) }'
 7#{FindType j}#'Ind'#'{FindType j}'
 8#{FindType love#j#m}#love(j m)#'{FindType love#j#m}'
 9#{FindType v}#none#'{FindType v}'
 10#{FindObjects love(j m)}#[love#j#m]#'{FindObjects love(j m)}'
 11#{IsOfType j 'Ind'}#true#'{IsOfType j \'Ind\'}'
 12#{IsOfTypeCareful j 'Ind'}#true#'{IsOfTypeCareful j \'Ind\'}'
 13#{IsOfTypeCareful j v}#'Not a type.'#'{IsOfTypeCareful j v}'
 14#{IsOfType j v}#false#'{IsOfType j v}'
 15#{IsOfType v 'Ind'}#false#'{IsOfType v \'Ind\'}'
 16#{IsOfType love#j#m love(j m)}#true#'{IsOfType love#j#m love(j m)}'
 16.1#{IsOfType j#m eq('Ind' j m)}#false#'{IsOfType j#m eq(\'Ind\' j m)}'
 16.2#{IsOfType j#j eq('Ind' j j)}#true#'{IsOfType j#j eq(\'Ind\' j j)}'
 16.3#{IsOfType m#m eq('Ind' j j)}#false#'{IsOfType m#m eq(\'Ind\' j j)}'
 17#{SearchAll proc {$ T} {PfType T} end}#
 [love(j j) love(j k) love(j l) love(j m) love(k j) love(k k) love(k l) love(k m) love(l j) love(l k) love(l l) love(l m) love(m j) love(m k) love(m l) love(m m) man(j) man(k) man(l) man(m) woman(j) woman(k) woman(l) woman(m)]#
 'SearchAll proc {$ T} {PfType T} end}'
 18#{InstantiateType 'Ind'}#(a0#'Ind')#'{InstantiateType \'Ind\'}'
 18.1#{InstantiateType depfuntype(lambda(x 'Ind' man(x)))}#lambda(x0 'Ind' pf0#man(x0))#'{InstantiateType depfuntype(lambda(x \'Ind\' man(x)))}'
 19#{InstantiateType rectype(x:'Ind' y:'Ind')}#rec(x:a0#'Ind' y:a1#'Ind')#'{InstantiateType rectype(x:\'Ind\' y:\'Ind\')}'
 20#{InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]))}#rec(x:a0#'Ind' y:a0#'Ind')#'{InstantiateType rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x])]))}'
 21#{IsOfType lambda(x0 'Ind' pf0#man(x0)) depfuntype(lambda(x 'Ind' man(x)))}#true#'{IsOfType lambda(x0 \'Ind\' pf0#man(x0)) depfuntype(lambda(x \'Ind\' man(x)))}'
 22#{IsOfType man(a0#'Ind') 'Type'}#true#'{IsOfType man(a0#\'Ind\') \'Type\'}'
 23#{IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind')}#true#'{IsOfType rec(x:j y:j z:man#j) rectype(x:\'Ind\')}'
 24#{IsOfType rec(x:j) rectype(x:'Ind' y:'Ind')}#false#'{IsOfType rec(x:j) rectype(x:\'Ind\' y:\'Ind\')}'
 25#{IsOfType rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])])) 'RecType'}#true#'{IsOfType rectype(x:\'Ind\' z:deptype(lambda(x \'Ind\' man(x)) [path([x])])) \'RecType\'}'
 26#{IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])]))}#true#'{IsOfType rec(x:j y:j z:man#j) rectype(x:\'Ind\' z:deptype(lambda(x \'Ind\' man(x)) [path([x])]))}'
 27#{IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) )}#true#'{IsOfType rec(x:j y:j z:man#j) rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x])]) )}'
 28#{IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))}#true#'{IsOfType rec(x:j y:j z:man#j) rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x])]) z:deptype(lambda(x \'Ind\' man(x)) [path([y])]))}'
 29#{InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))}#rec(x:a0#'Ind' y:a0#'Ind' z:pf0#man(a0#'Ind'))#'{InstantiateType rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x])]) z:deptype(lambda(x \'Ind\' man(x)) [path([y])]))}'
 30#{IsSubType 'Ind' 'Ind'}#true#'{IsSubType \'Ind\' \'Ind\'}'
 31#{IsSubType rectype(x: 'Ind' y:'Ind') rectype(x:'Ind')}#true#'{IsSubType rectype(x: \'Ind\' y:\'Ind\') rectype(x:\'Ind\')}'
 32#{IsSubType
  rectype(x:'Ind'
	  y:'Ind'
	  z:deptype(lambda(x 'Ind' man(x)) [path([y])]))
  rectype(x:'Ind'
	  y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])])
	  z:deptype(lambda(x 'Ind' man(x)) [path([y])])) }#false#'{IsSubType rectype(x:\'Ind\'
		  y:\'Ind\'
		  z:deptype(lambda(x \'Ind\' man(x)) [path([y])]))
	  rectype(x:\'Ind\'
		  y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x])])
		  z:deptype(lambda(x \'Ind\' man(x)) [path([y])])) }'
33#{IsSubType
	  rectype(x:'Ind'
		  y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])])
		  z:deptype(lambda(x 'Ind' man(x)) [path([y])]))
	  rectype(x:'Ind'
		  y:'Ind'
		  z:deptype(lambda(x 'Ind' man(x)) [path([y])]))  }#true#'{IsSubType rectype(x:\'Ind\'
		  y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x])])
		  z:deptype(lambda(x \'Ind\' man(x)) [path([y])]))
	  rectype(x:\'Ind\'
		  y:\'Ind\'
		  z:deptype(lambda(x \'Ind\' man(x)) [path([y])]))  }'
34#{IsSubType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])])
			     z:deptype(lambda(x 'Ind' man(x)) [path([x y])])))
	  rectype(x: rectype(x:'Ind'
			     y:'Ind'
			     z:deptype(lambda(x 'Ind' man(x)) [path([x y])])))  }#true#'{IsSubType rectype(x: rectype(x:\'Ind\'
			     y:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])])
			     z:deptype(lambda(x \'Ind\' man(x)) [path([x y])])))
	  rectype(x: rectype(x:\'Ind\'
			     y:\'Ind\'
			     z:deptype(lambda(x \'Ind\' man(x)) [path([x y])])))  }'
35#{IsOfType
	  rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) )
	  'RecType'}#true#'{IsOfType rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' man(x)) [path([x])]) ) \'RecType\'}'
36#{IsOfType
	  rectype(x:'Type' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) )
	  'RecType'}#false#'{IsOfType
	  rectype(x:\'Type\' y:deptype(lambda(x \'Ind\' man(x)) [path([x])]) )
	  \'RecType\'}'
37#{IsOfType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x x])]) ))
    'RecType'}#true#'{IsOfType rectype(x: rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' man(x)) [path([x x])]) )) \'RecType\'}'
37.1#{IsOfType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) ))
 'RecType'}#false#'{IsOfType rectype(x: rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' man(x)) [path([x])]) )) \'RecType\'}'
38#{InstantiateType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x x])]) ))}#rec(x:rec(x:a0#'Ind' y:pf0#man(a0#'Ind')))#'{InstantiateType rectype(x: rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' man(x)) [path([x x])]) ))}'
39#{InstantiateType 'RecType'}#('R0'#'RecType')#'{InstantiateType \'RecType\'}'
40#{IsOfType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind')
    'RecType'}#true#'{IsOfType rectype(x: rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) ) y: \'Ind\')\'RecType\'}'
40.1#{IsOfType
	  rectype(x: deptype(lambda(v 'Ind'
				    rectype(x:'Ind'
					    y: man(v)))
			     [path([y])]) 
		  y: 'Ind')
	  'RecType'}#true#'{IsOfType rectype(x: deptype(lambda(v \'Ind\'				    rectype(x:\'Ind\'					    y: man(v)))			     [path([y])]) 		  y: \'Ind\')	  \'RecType\'}'
41#{InstantiateType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind')
	  }#rec(x:rec(x:a0#'Ind' y:pf0#man(a1#'Ind')) y:a1#'Ind')#'{InstantiateType	  rectype(x: rectype(x:\'Ind\' y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		 y: \'Ind\')
	  }'
42#{IsOfType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
 'RecType'}#true#'{IsOfType	  rectype(x: rectype(x:\'Ind\'			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))	  \'RecType\'}'
42.1#{InstantiateType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))}#
rec(x:rec(x:a0#'Ind' y:pf0#man(a0#'Ind')) y:a0#'Ind')#
'{InstantiateType
	  rectype(x: rectype(x:\'Ind\'
			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )
		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))}'
43#{IsSubType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind') }#true#'{IsSubType	  rectype(x: rectype(x:\'Ind\'			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))	  rectype(x: rectype(x:\'Ind\'			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: \'Ind\') }'
44#{IsSubType
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: 'Ind') 
	  rectype(x: rectype(x:'Ind'
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }#false#'{IsSubType	  rectype(x: rectype(x:\'Ind\'			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: \'Ind\') 	  rectype(x: rectype(x:\'Ind\'			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))
	 }'
45#{InstantiateType
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
}#'non-wellfounded dependency'#'{InstantiateType	  rectype(x: rectype(x:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([y])])			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))	 }'
46#{InstantiateType x}#none#'{InstantiateType x}'
47#{IsOfType
	  rec(x: rec(x: j
		     y: man#j)
	      y: j)
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }#true#'{IsOfType	  rec(x: rec(x: j		     y: man#j)	      y: j)	  rectype(x: rectype(x:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([y])])			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))
	 }'
48#{IsOfTypeCareful
	  rec(x: rec(x: j
		     y: man#j)
	      y: j)
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	 }#'Not a type.'#'{IsOfTypeCareful	  rec(x: rec(x: j		     y: man#j)	      y: j)	  rectype(x: rectype(x:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([y])])			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))
	 }'
49#{IsOfType
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
 'RecType'}#false#'{IsOfType	  rectype(x: rectype(x:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([y])])			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))	  \'RecType\'}'
50#{IsOfType
	  rectype(x: rectype(x:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([y])])
			     y:deptype(lambda(x 'Ind' man(x)) [path([y])]) )
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
 'Type'}#false#'{IsOfType	  rectype(x: rectype(x:deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([y])])			     y:deptype(lambda(x \'Ind\' man(x)) [path([y])]) )		  y: deptype(lambda(x \'Ind\' sintype(\'Ind\' x)) [path([x x])]))	  \'Type\'}'
51#{IsOfType
	  rec(x : [j]
	      y : [m]
	      z : [j m])
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))}#true#'{IsOfType	  rec(x : [j]	      y : [m]	      z : [j m])	  rectype(x : listtype(\'Ind\')		  y : listtype(\'Ind\')		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))			      [path([x]) path([y])]))}'
52#{IsOfType
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
 'RecType'}#true#'{IsOfType	  rectype(x : listtype(\'Ind\')		  y : listtype(\'Ind\')		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))			      [path([x]) path([y])]))	  \'RecType\'}'
53#{IsOfType
	  rectype(x : listtype('Ind')
		  y : 'Ind'
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
 'RecType'}#false#'{IsOfType	  rectype(x : listtype(\'Ind\')		  y : \'Ind\'		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))			      [path([x]) path([y])]))	  \'RecType\'}'
54#{IsOfType
	  rectype(x : listtype('Ind')
		  y : 'Ind'
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y 'Ind'
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
 'RecType'}#false#'{IsOfType	  rectype(x : listtype(\'Ind\')		  y : \'Ind\'		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y \'Ind\'					    opsintype(listtype(\'Ind\') append(x y))))			      [path([x]) path([y])]))	  \'RecType\'}'
55#{InstantiateType
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
}#rec(x:'L0'#listtype('Ind') y:'L1'#listtype('Ind') z:append('L0'#listtype('Ind') 'L1'#listtype('Ind')))#'{InstantiateType	  rectype(x : listtype(\'Ind\')		  y : listtype(\'Ind\')		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))			      [path([x]) path([y])]))	  }'
56#{InstantiateType
	  rectype(x : sintype(listtype('Ind') [j])
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	 }#rec(x:[j] y:'L0'#listtype('Ind') z:append([j] 'L0'#listtype('Ind')))#'{InstantiateType	  rectype(x : sintype(listtype(\'Ind\') [j])		  y : listtype(\'Ind\')		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))
			      [path([x]) path([y])]))
	 }'
57#{InstantiateType
	  rectype(x : sintype(listtype('Ind') [j])
		  y : sintype(listtype('Ind') [m])
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
}#rec(x:[j] y:[m] z:[j m])#'{InstantiateType	  rectype(x : sintype(listtype(\'Ind\') [j])		  y : sintype(listtype(\'Ind\') [m])		  z : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))			      [path([x]) path([y])]))	 }'
58#{InstantiateType
	  rectype(z : sintype(listtype('Ind') [j])
		  y : sintype(listtype('Ind') [m])
		  x : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([z]) path([y])]))
	 }#rec(x:[j m] y:[m] z:[j])#'{InstantiateType	  rectype(z : sintype(listtype(\'Ind\') [j])		  y : sintype(listtype(\'Ind\') [m])		  x : deptype(lambda(x listtype(\'Ind\')				     lambda(y listtype(\'Ind\')					    opsintype(listtype(\'Ind\') append(x y))))			      [path([z]) path([y])]))	 }'
59#{InstantiateType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(v 'Ind'
					    optype('RecType' apply(f v))))
			      [path([x]) path([y])]))
	 }#rec(x:lambda(x0 'Ind' 'R0'#'RecType') y:a0#'Ind' z:r0#('R0'#'RecType'#[a0#'Ind']))#'{InstantiateType
	  rectype(x : funtype(\'Ind\' \'RecType\')
		  y : \'Ind\'
		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')
				     lambda(v \'Ind\'
					    optype(\'RecType\' apply(f v))))
			      [path([x]) path([y])]))
	 }'
59.1#{InstantiateType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(v 'Ind'
					    opsintype('RecType' apply(f v))))
			      [path([x]) path([y])]))
	 }#rec(x:lambda(x0 'Ind' 'R0'#'RecType') y:a0#'Ind' z:'R0'#'RecType'#[a0#'Ind'])#'{InstantiateType
	  rectype(x : funtype(\'Ind\' \'RecType\')
		  y : \'Ind\'
		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')
				     lambda(v \'Ind\'
					    opsintype(\'RecType\' apply(f v))))
			      [path([x]) path([y])]))
	 }'
60#{IsOfType
	  rec(x : lambda(x 'Ind' rectype(c : man(x)))
	      y : j
	      z : rectype(c : man(j)))
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	 }#true#'{IsOfType	  rec(x : lambda(x \'Ind\' rectype(c : man(x)))	      y : j	      z : rectype(c : man(j)))	  rectype(x : funtype(\'Ind\' \'RecType\')		  y : \'Ind\'		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')				     lambda(x \'Ind\'					    opsintype(\'RecType\' apply(f x))))
			      [path([x]) path([y])]))
	 }'
61#{IsSubType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([w])]))
}#false#'{IsSubType	  rectype(x : funtype(\'Ind\' \'RecType\')		  y : \'Ind\'		  w : \'Ind\'		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')				     lambda(x \'Ind\'					    opsintype(\'RecType\' apply(f x))))			      [path([x]) path([y])]))	  rectype(x : funtype(\'Ind\' \'RecType\')		  y : \'Ind\'		  w : \'Ind\'		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')				     lambda(x \'Ind\'					    opsintype(\'RecType\' apply(f x))))			      [path([x]) path([w])]))	 }'
62#{IsSubType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	  rectype(z : 'RecType')
	 }#true#'{IsSubType	  rectype(x : funtype(\'Ind\' \'RecType\')		  y : \'Ind\'		  w : \'Ind\'		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')				     lambda(x \'Ind\'					    opsintype(\'RecType\' apply(f x))))			      [path([x]) path([y])]))	  rectype(z : \'RecType\')
	 }'
63#{InstantiateType 
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	 }#rec(w:a0#'Ind' x:lambda(x0 'Ind' 'R0'#'RecType') y:a1#'Ind' z:'R0'#'RecType'#[a1#'Ind'])#'{InstantiateType 	  rectype(x : funtype(\'Ind\' \'RecType\')		  y : \'Ind\'		  w : \'Ind\'		  z : deptype(lambda(f funtype(\'Ind\' \'RecType\')				     lambda(x \'Ind\'					    opsintype(\'RecType\' apply(f x))))
			      [path([x]) path([y])]))
	 }'
64#{IsOfType
	  lambda(x 'Ind' rectype(c : man(x)))
	  funtype('Ind' 'RecType')}#true#'{IsOfType	  lambda(x \'Ind\' rectype(c : man(x)))	  funtype(\'Ind\' \'RecType\')}'
65#{IsOfType
	  lambda(f funtype('Ind' 'RecType')
		 lambda(x 'Ind'
			optype('RecType' apply(f x))))
    funtype(funtype('Ind' 'RecType') (funtype('Ind' 'Type')))}#true#'{IsOfType	  lambda(f funtype(\'Ind\' \'RecType\')		 lambda(x \'Ind\'			optype(\'RecType\' apply(f x))))	  funtype(funtype(\'Ind\' \'RecType\') (funtype(\'Ind\' \'Type\')))}'
65.1#{IsOfType optype('RecType' apply(lambda(x 'Ind' rectype(x : sintype('Ind' x))) j)) 'RecType'}#true#'IsOfType optype(\'RecType\' apply(lambda(x \'Ind\' rectype(x : sintype(\'Ind\' x))) j)) \'RecType\'}'
65.2#{IsOfType sintype(rectype(x:'Ind') rec(x:j)) 'RecType'}#true#'{IsOfType sintype(rectype(x:\'Ind\') rec(x:j)) \'RecType\'}'
66#{IsOfType
	  optype('RecType' apply(f#funtype('Ind' 'RecType') a#'Ind'))
	  'Type'}#true#'{IsOfType	  optype(\'RecType\' apply(f#funtype(\'Ind\' \'RecType\') a#\'Ind\'))	  \'Type\'}'
67#{IsOfType
	  apply(f#funtype('Ind' 'RecType') a#'Ind')
	  'RecType'}#true#'{IsOfType	  apply(f#funtype(\'Ind\' \'RecType\') a#\'Ind\')	  \'RecType\'}'
68#{InstantiateType rectype(x:sintype('Ind' j))}#rec(x:j)#'{InstantiateType rectype(x:sintype(\'Ind\' j))}'
69#{InstantiateType Person}#(a2#jointype(rectype(c:deptype(lambda(x 'Ind' man(x)) [path([x])]) x:sintype('Ind' j)) rectype(c:deptype(lambda(x 'Ind' woman(x)) [path([x])]) x:sintype('Ind' m))))#'{InstantiateType Person}'
70#{InstantiateType jointype(rectype(x: sintype('Ind' j)
					   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
				 rectype(x: sintype('Ind' m)
					 c: deptype(lambda(x 'Ind' woman(x)) [path([x])])) )}#(a2#jointype(rectype(c:deptype(lambda(x 'Ind' man(x)) [path([x])]) x:sintype('Ind' j)) rectype(c:deptype(lambda(x 'Ind' woman(x)) [path([x])]) x:sintype('Ind' m))))#'{InstantiateType jointype(rectype(x: sintype(\'Ind\' j)					   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))				 rectype(x: sintype(\'Ind\' m)					 c: deptype(lambda(x \'Ind\' woman(x)) [path([x])])) )}'
71#Person#jointype(rectype(c:deptype(lambda(x 'Ind' man(x)) [path([x])]) x:sintype('Ind' j)) rectype(c:deptype(lambda(x 'Ind' woman(x)) [path([x])]) x:sintype('Ind' m)))#'Person'
72#{InstantiateType jointype(rectype(x:sintype('Ind' j)c: deptype(lambda(x 'Ind' man(x)) [path([x])])) rectype(x:'RecType'))}#(a1#jointype(rectype(c:deptype(lambda(x 'Ind' man(x)) [path([x])]) x:sintype('Ind' j)) rectype(x:'RecType')))#'{InstantiateType jointype(rectype(x:sintype(\'Ind\' j)c: deptype(lambda(x \'Ind\' man(x)) [path([x])])) rectype(x:\'RecType\'))}'
73#{IsOfType Person 'Type'}#true#'{IsOfType Person \'Type\'}'
74#{IsSubType  rectype(x:sintype('Ind' j)
			     c : man(j))
	 Person}#true#'{IsSubType  rectype(x:sintype(\'Ind\' j)			     c : man(j))
	 Person}'
75#{IsOfType rectype(x : listtype(rectype(x:'Ind'
				       c:deptype(lambda(x 'Ind' man(x)) [path([x])])))) 'RecType'}#true#'{IsOfType rectype(x : listtype(rectype(x:\'Ind\'						c:deptype(lambda(x \'Ind\' man(x)) [path([x])])))) \'RecType\'}'
76#{IsOfType
	  listtype(
	     rectype(x:'Ind'
		     c:deptype(lambda(x 'Ind' man(x)) [path([x])])))
	  'Type'}#true#'{IsOfType	  listtype(	     rectype(x:\'Ind\'		     c:deptype(lambda(x \'Ind\' man(x)) [path([x])])))	  \'Type\'}'
77#{IsOfType
	     rectype(x:'Ind'
		     c:deptype(lambda(x 'Ind' man(x)) [path([x])]))
	  'Type'}#true#'{IsOfType	     rectype(x:\'Ind\'		     c:deptype(lambda(x \'Ind\' man(x)) [path([x])]))	  \'Type\'}'
78#{IsOfType
	  rec(x: [rec(x: j c:man#j)
		  rec(x:j c:man#j)])
	  rectype(x : listtype(
			 rectype(x:'Ind'
				 c:deptype(lambda(x 'Ind' man(x)) [path([x])]))))}#true#'{IsOfType	  rec(x: [rec(x: j c:man#j)(x:j c:man#j)])	  rectype(x : listtype(			 rectype(x:\'Ind\'				 c:deptype(lambda(x \'Ind\' man(x)) [path([x])]))))}'
79#{InstantiateType rectype(x:'Ind')}#rec(x:a0#'Ind')#'{InstantiateType rectype(x:\'Ind\')}'
80#{InstantiateType depfuntype(lambda(r rectype(x:'Ind')
			      rectype(x:'Ind')))}#lambda(x0 rectype(x:'Ind') rec(x:a1#'Ind'))#'{InstantiateType depfuntype(lambda(r rectype(x:\'Ind\')			      rectype(x:\'Ind\')))}'
81#{InstantiateType depfuntype(lambda(r rectype(x:'Ind')
			      rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r [x])]))))}#lambda(x0 rectype(x:'Ind') rec(c:pf0#man(select(x0 x))))#'{InstantiateType depfuntype(lambda(r rectype(x:\'Ind\')			      rectype(c:deptype(lambda(x \'Ind\' man(x))
						[abspath(r [x])]))))}'
82#{IsOfType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rec(x:a0#'Ind') [x])])) 'Type'}#true#'{IsOfType rectype(c:deptype(lambda(x \'Ind\' man(x)) [abspath(rec(x:a0#\'Ind\') [x])])) \'Type\'}'
83#{IsOfType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rectype(x:'Ind') [x])])) 'Type'}#false#'{IsOfType rectype(c:deptype(lambda(x \'Ind\' man(x)) [abspath(rectype(x:\'Ind\') [x])])) \'Type\'}'
84#{InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rectype(x:'Ind') [x])])) }#none#'{InstantiateType rectype(c:deptype(lambda(x \'Ind\' man(x)) [abspath(rectype(x:\'Ind\') [x])])) }'
85#{InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rec(x:a2#'Ind') [x])])) }#rec(c:pf0#man(a2#'Ind'))#'{InstantiateType rectype(c:deptype(lambda(x \'Ind\' man(x)) [abspath(rec(x:a2#\'Ind\') [x])])) }'
86#{InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(r [x])])) }#none#'{InstantiateType rectype(c:deptype(lambda(x \'Ind\' man(x)) [abspath(r [x])])) }'
87#{InstantiateType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(r#rectype(x:'Ind') [x])])) }#rec(c:pf0#man(select(r#rectype(x:'Ind') x)))#'{InstantiateType rectype(c:deptype(lambda(x \'Ind\' man(x)) [abspath(r#rectype(x:\'Ind\') [x])])) }'
88#{IsOfType
	  depfuntype(lambda(r rectype(x:'Ind')
			      rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r [x])]))))
	  'Type'}#true#'{IsOfType	  depfuntype(lambda(r rectype(x:\'Ind\')			      rectype(c:deptype(lambda(x \'Ind\' man(x))						[abspath(r [x])]))))	  \'Type\'}'
89#{IsOfType
	  lambda(r rectype(x:'Ind') rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r [x])])))
	  depfuntype(lambda(r rectype(x:'Ind')
			      'RecType'))
	 }#true#'{IsOfType	  lambda(r rectype(x:\'Ind\') rectype(c:deptype(lambda(x \'Ind\' man(x))						[abspath(r [x])])))	  depfuntype(lambda(r rectype(x:\'Ind\')			      \'RecType\'))
	 }'
90#{SimplifyMeet meettype('Ind' 'Ind')}#'Ind'#'{SimplifyMeet meettype(\'Ind\' \'Ind\')}'
91#{IsSubType 'Ind' 'Type'}#false#'{IsSubType \'Ind\' \'Type\'}'
92#{IsBasicSubType 'Type' 'Type'}#true#'{IsBasicSubType \'Type\' \'Type\'}'
93#{IsBasicSubType 'RecType' 'Type'}#true#'{IsBasicSubType \'RecType\' \'Type\'}'
94#{DisjointTypes 'Type' 'Ind'}#true#'{DisjointTypes \'Type\' \'Ind\'}'
95#{SimplifyMeet 'Ind'}#'Ind'#'{SimplifyMeet \'Ind\'}'
96#{SimplifyMeet meettype('Ind' 'Type')}#bot#'{SimplifyMeet meettype(\'Ind\' \'Type\')}'
97#{SimplifyMeet meettype(rectype(x:'Ind' y:'Ind') rectype(x: 'Ind'))}#rectype(x:'Ind' y:'Ind')#'{SimplifyMeet meettype(rectype(x:\'Ind\' y:\'Ind\') rectype(x: \'Ind\'))}'
98#{SimplifyMeet meettype(rectype(x: 'Ind') rectype(x:'Ind' y:'Ind'))}#rectype(x:'Ind' y:'Ind')#'{SimplifyMeet meettype(rectype(x: \'Ind\') rectype(x:\'Ind\' y:\'Ind\'))}'
99#{SimplifyMeet meettype(jointype('Ind' 'Type') 'RecType')}#'RecType'#'{SimplifyMeet meettype(jointype(\'Ind\' \'Type\') \'RecType\')}'
100#{SimplifyMeet meettype(jointype('Ind' 'Type') 'Ind')}#'Ind'#'{SimplifyMeet meettype(jointype(\'Ind\' \'Type\') \'Ind\')}'
101#{SimplifyMeet meettype(jointype('Ind' 'Type') jointype('Ind' 'RecType'))}#jointype('Ind' 'RecType')#'{SimplifyMeet meettype(jointype(\'Ind\' \'Type\') jointype(\'Ind\' \'RecType\'))}'
102#{SimplifyMeet meettype('Ind' jointype('Ind' 'Type'))}#'Ind'#'{SimplifyMeet meettype(\'Ind\' jointype(\'Ind\' \'Type\'))}'
103#{SimplifyMeet meettype(rectype(a:'Ind') rectype(b:'Ind'))}#rectype(a:'Ind' b:'Ind')#'{SimplifyMeet meettype(rectype(a:\'Ind\') rectype(b:\'Ind\'))}'
104#{SimplifyMeet meettype(rectype(a:'Ind' c: jointype('Ind' 'Type')) rectype(b:'Ind' c:'Ind'))}#rectype(a:'Ind' b:'Ind' c:'Ind')#'{SimplifyMeet meettype(rectype(a:\'Ind\' c: jointype(\'Ind\' \'Type\')) rectype(b:\'Ind\' c:\'Ind\'))}'
105#{SimplifyMeet meettype(
			  depfuntype(lambda(r rectype(x:'Ind')
					    rectype(c:deptype(lambda(x 'Ind'
								     man(x))
						[abspath(r [x])]))))
			  depfuntype(lambda(r rectype(x:'Ind')
					    rectype(a:'Ind'
						    c:deptype(lambda(x 'Ind'
								     man(x))
					      [abspath(r [x])])))))}#depfuntype(lambda(r rectype(x:'Ind') rectype(a:'Ind' c:deptype(lambda(x 'Ind' man(x)) [abspath(r [x])]))))#'{SimplifyMeet meettype(			  depfuntype(lambda(r rectype(x:\'Ind\')					    rectype(c:deptype(lambda(x \'Ind\'								     man(x))						[abspath(r [x])]))))			  depfuntype(lambda(r rectype(x:\'Ind\')					    rectype(a:\'Ind\'						    c:deptype(lambda(x \'Ind\'								     man(x))					      [abspath(r [x])])))))}'
105.1#{SimplifyMeet
	  meettype(
	     rectype(x: 'Ind'
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     w: 'Ind'))}#rectype(w:'Ind' x:'Ind' y:rectype(a:'Ind' c:deptype(lambda(x 'Ind' man(x)) [path([x])])) z:'Ind')#'{SimplifyMeet	  meettype(	     rectype(x: \'Ind\'		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     w: \'Ind\'))}'
106#{SimplifyMeet
	  meettype(
	     rectype(x: 'Ind'
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([x])]))
		     w: 'Ind'))}#rectype(w:'Ind' x:'Ind' y:rectype(a:'Ind' c:deptype(lambda(x 'Ind' man(x)) [path([x])])) z:'Ind')#'{SimplifyMeet	  meettype(	     rectype(x: \'Ind\'		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		    z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(y \'Ind\' man(y)) [path([x])]))		     w: \'Ind\'))}'
107#{SimplifyMeet
	  meettype(
	     rectype(x: 'Ind'
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: 'Ind'))}#rectype(w:'Ind' x:'Ind' y:rectype(a:'Ind' c:meettype(deptype(lambda(x 'Ind' man(x)) [path([x])]) deptype(lambda(y 'Ind' man(y)) [path([w])]))) z:'Ind')#'{SimplifyMeet	  meettype(	     rectype(x: \'Ind\'		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(y \'Ind\' man(y)) [path([w])]))		     w: \'Ind\'))}'
108#{SimplifyMeet
	  meettype(rectype(x : 'Ind'
			   y : deptype(lambda(x 'Ind' man(x)) [path([x])]))
		   rectype(x : 'Ind'
			   w : 'Ind'
			   y : deptype(lambda(x 'Ind' man(x)) [path([w])])))}#rectype(w:'Ind' x:'Ind' y:meettype(deptype(lambda(x 'Ind' man(x)) [path([x])]) deptype(lambda(x 'Ind' man(x)) [path([w])])))#'{SimplifyMeet	  meettype(rectype(x : \'Ind\'			   y : deptype(lambda(x \'Ind\' man(x)) [path([x])]))		   rectype(x : \'Ind\'			   w : \'Ind\'			   y : deptype(lambda(x \'Ind\' man(x)) [path([w])])))}'
109#{SimplifyMeet meettype(deptype(lambda(x 'Ind' man(x)) [path([x])])
				deptype(lambda(x 'Ind' man(x)) [path([w])]))}#meettype(deptype(lambda(x 'Ind' man(x)) [path([x])]) deptype(lambda(x 'Ind' man(x)) [path([w])]))#'{SimplifyMeet meettype(deptype(lambda(x \'Ind\' man(x)) [path([x])])				deptype(lambda(x \'Ind\' man(x)) [path([w])]))}'
110#{InstantiateType deptype(lambda(x 'Ind' man(x)) [path([x])])}#none#'{InstantiateType deptype(lambda(x \'Ind\' man(x)) [path([x])])}'
111#{SimplifyMeet
	  meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' j)))}#rectype(w:sintype('Ind' j) x:sintype('Ind' j) y:rectype(a:'Ind' c:meettype(deptype(lambda(x 'Ind' man(x)) [path([x])]) deptype(lambda(y 'Ind' man(y)) [path([w])]))) z:'Ind')#'{SimplifyMeet	  meettype(	     rectype(x: sintype(\'Ind\' j)		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(y \'Ind\' man(y)) [path([w])]))		     w: sintype(\'Ind\' j)))}'
112#{SimplifyMeet
	  {SimplifyDep
	   meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' j)))}}#rectype(w:sintype('Ind' j) x:sintype('Ind' j) y:rectype(a:'Ind' c:man(j)) z:'Ind')#'{SimplifyMeet	  {SimplifyDep	   meettype(	     rectype(x: sintype(\'Ind\' j)		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(y \'Ind\' man(y)) [path([w])]))		     w: sintype(\'Ind\' j)))}}'
113#{SimplifyMeet
	  meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' m)))}#rectype(w:sintype('Ind' m) x:sintype('Ind' j) y:rectype(a:'Ind' c:meettype(deptype(lambda(x 'Ind' man(x)) [path([x])]) deptype(lambda(y 'Ind' man(y)) [path([w])]))) z:'Ind')#'{SimplifyMeet	  meettype(	     rectype(x: sintype(\'Ind\' j)		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(y \'Ind\' man(y)) [path([w])]))		     w: sintype(\'Ind\' m)))}'
113.1#{SimplifyMeet
	  {SimplifyDep
	  meettype(
	     rectype(x: sintype('Ind' j)
		     y: rectype(
			   a: 'Ind'
			   c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		     z: 'Ind')
	     rectype(x: 'Ind'
		     y: rectype(
			   c: deptype(lambda(y 'Ind' man(y)) [path([w])]))
		     w: sintype('Ind' m)))}}#rectype(w:sintype('Ind' m) x:sintype('Ind' j) y:rectype(a:'Ind' c:meettype(man(j) man(m))) z:'Ind')#'{SimplifyMeet	  {SimplifyDep	  meettype(	     rectype(x: sintype(\'Ind\' j)		     y: rectype(			   a: \'Ind\'			   c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		     z: \'Ind\')	     rectype(x: \'Ind\'		     y: rectype(			   c: deptype(lambda(y \'Ind\' man(y)) [path([w])]))		     w: sintype(\'Ind\' m)))}}'
114#{SimplifyMeet
	  meettype(rectype(a : 'Ind'
			   b : 'Ind')
		   rectype(a : sintype('Ind' j)))}#rectype(a:sintype('Ind' j) b:'Ind')#'{SimplifyMeet	  meettype(rectype(a : \'Ind\'			   b : \'Ind\')		   rectype(a : sintype(\'Ind\' j)))}'
115#{SimplifyMeet
	  meettype(rectype(a : sintype('Ind' j))
		   rectype(a : 'Ind'
			   b : 'Ind'))
	 }#rectype(a:sintype('Ind' j) b:'Ind')#'{SimplifyMeet	  meettype(rectype(a : sintype(\'Ind\' j))		   rectype(a : \'Ind\'			   b : \'Ind\'))
	 }'
116#{SimplifyMeet meettype(rectype rectype(a:'Ind'))}#rectype(a:'Ind')#'{SimplifyMeet meettype(rectype rectype(a:\'Ind\'))}'
117#{InstantiateType rectype(x: 'Ind'
		  y: rectype(
			a: 'Ind'
			c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		  z: 'Ind')}#rec(x:a0#'Ind' y:rec(a:a1#'Ind' c:pf0#man(a0#'Ind')) z:a2#'Ind')#'{InstantiateType rectype(x: \'Ind\'		  y: rectype(			a: \'Ind\'			c: deptype(lambda(x \'Ind\' man(x)) [path([x])]))		  z: \'Ind\')}'
118#{IsSubType 
	  depfuntype(lambda(r rectype(x:'Ind')
			    rectype(a:'Ind'
				    c:deptype(lambda(x 'Ind' man(x))
					      [abspath(r [x])]))))
	  depfuntype(lambda(r1 rectype(x:'Ind')
			      rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r1 [x])]))))}#true#'{IsSubType 	  depfuntype(lambda(r rectype(x:\'Ind\')			    rectype(a:\'Ind\'				    c:deptype(lambda(x \'Ind\' man(x))					      [abspath(r [x])]))))	  depfuntype(lambda(r1 rectype(x:\'Ind\')			      rectype(c:deptype(lambda(x \'Ind\' man(x))
						[abspath(r1 [x])]))))}'
119#{IsOfType [j k] listtype('Ind')}#true#'{IsOfType [j k] listtype(\'Ind\')}'
120#{IsOfType append([j] [k]) listtype('Ind')}#true#'{IsOfType append([j] [k]) listtype(\'Ind\')}'
121#{IsOfType apply(lambda(x 'Ind' [x k]) j) listtype('Ind')}#true#'{IsOfType apply(lambda(x \'Ind\' [x k]) j) listtype(\'Ind\')}'
122#{IsOfType apply(lambda(x 'Ind' append([x] [k])) j) listtype('Ind')}#true#'{IsOfType apply(lambda(x \'Ind\' append([x] [k])) j) listtype(\'Ind\')}'
123#{IsOfType sintype(listtype('Ind') append([j] [k])) 'Type'}#true#'{IsOfType sintype(listtype(\'Ind\') append([j] [k])) \'Type\'}'
124#{IsOfType append([j] [k]) listtype('Ind')}#true#'{IsOfType append([j] [k]) listtype(\'Ind\')}'
125#{IsSubType meettype(rectype(a:'Ind') rectype(b:'Ind')) rectype(a:'Ind')}#true#'{IsSubType meettype(rectype(a:\'Ind\') rectype(b:\'Ind\')) rectype(a:\'Ind\')}'
126#{SimplifyMeet meettype(rectype(a:'Ind') rectype(a:listtype('Ind'))) }#rectype(a:bot)#'{SimplifyMeet meettype(rectype(a:\'Ind\') rectype(a:listtype(\'Ind\'))) }'
127#{IsSubType meettype(rectype(a:'Ind') rectype(a:listtype('Ind'))) rectype(a:'RecType')}#true#'{IsSubType meettype(rectype(a:\'Ind\') rectype(a:listtype(\'Ind\'))) rectype(a:\'RecType\')}'
128#{InstantiateType {SimplifyMeet meettype(rectype(a:'Ind') rectype(a:listtype('Ind')))}}#null#'{InstantiateType {SimplifyMeet meettype(rectype(a:\'Ind\') rectype(a:listtype(\'Ind\')))}}'
129#{IsSubType bot rectype(a:'RecType')}#true#'{IsSubType bot rectype(a:\'RecType\')}'
130#{IsSubType rectype(a:bot) rectype(b: 'RecType')}#true#'{IsSubType rectype(a:bot) rectype(b: \'RecType\')}'
131#{InstantiateType rectype(a:bot b:'Ind')}#null#'{InstantiateType rectype(a:bot b:\'Ind\')}'
132#{IsSubType 'RecType' 'Type'}#true#'{IsSubType \'RecType\' \'Type\'}'
133#{IsSubType meettype(rectype(a: man(j)) rectype(a: man(m))) rectype(a: man(j))}#true#'{IsSubType meettype(rectype(a: man(j)) rectype(a: man(m))) rectype(a: man(j))}'
134#{IsSubType meettype(rectype(a: man(j)) rectype(a: man(j))) rectype(a: woman(j))}#false#'{IsSubType meettype(rectype(a: man(j)) rectype(a: man(j))) rectype(a: woman(j))}'
135#{IsSubType meettype(rectype(a: man(j)) rectype(a: man(m))) rectype(a: woman(j))}#false#'{IsSubType meettype(rectype(a: man(j)) rectype(a: man(m))) rectype(a: woman(j))}'
136#{IsSubType meettype(rectype(a: man(j)) rectype(b: man(m))) rectype(a: man(m))}#false#'{IsSubType meettype(rectype(a: man(j)) rectype(b: man(m))) rectype(a: man(m))}'
137#{SimplifyMeet meettype(rectype(a: man(j)) rectype(a: man(m)))}#rectype(a:meettype(man(j) man(m)))#'{SimplifyMeet meettype(rectype(a: man(j)) rectype(a: man(m)))}'
138#{IsSubType meettype(man(j) man(m)) man(j)}#true#'{IsSubType meettype(man(j) man(m)) man(j)}}'
]

{ForAll TestSuite proc {$ X} {Inspect X} end }

{Test TestSuite} 

{Inspect {IsSubType rectype(agr:deptype(lambda(x rectype sintype(rectype x)) [path([daughters first agr])]) cat:sintype('Cat' vp) daughters:rectype(first:rectype(agr:rectype(num:sintype('Number' sg) pers:sintype('Person' third)) cat:sintype('Cat' cop) id:sintype('Id' 'Be') phon:sintype('Phon' [is]) tns:sintype('Tense' pres)) rest:rectype(first:rectype(agr:sintype(rectype rec(num:sg)) cat:sintype('Cat' np) daughters:rectype(first:rectype(cat:sintype('Cat' det) id:sintype('Id' 'IndefArt') phon:sintype('Phon' [a])) rest:rectype(first:rectype(agr:rectype(num:sintype('Number' sg)) cat:sintype('Cat' n) id:sintype('Id' 'Conductor') phon:sintype('Phon' [conductor])) rest:sintype(listtype('Rec') nil))) id:sintype('Id' app(app(np_det_n 'IndefArt') 'Conductor')) phon:opsintype('Phon' append([a] [conductor]))) rest:sintype(listtype('Rec') nil))) id:deptype(lambda(v1 'Id' lambda(v2 'Id' sintype('Id' app(app(vp_cop_np v1) v2)))) [objpath('Be') objpath(app(app(np_det_n 'IndefArt') 'Conductor'))]) phon:opsintype('Phon' append([is] append([a] [conductor]))))
rectype(agr:rectype(num:'Number' pers:'Person') cat:sintype('Cat' vp) id:'Id' phon:'Phon')}}

{Inspect {IsSubType rectype(agr:sintype(rectype rec(num:sg
	  pers:third)) cat:sintype('Cat' vp)
	  daughters:rectype(first:rectype(agr:rectype(num:sintype('Number'
	  sg) pers:sintype('Person' third)) cat:sintype('Cat' cop)
	  id:sintype('Id' 'Be') phon:sintype('Phon' [is])
	  tns:sintype('Tense' pres))
	  rest:rectype(first:rectype(agr:sintype(rectype rec(num:sg))
	  cat:sintype('Cat' np)
	  daughters:rectype(first:rectype(cat:sintype('Cat' det)
	  id:sintype('Id' 'IndefArt') phon:sintype('Phon' [a]))
	  rest:rectype(first:rectype(agr:rectype(num:sintype('Number'
	  sg)) cat:sintype('Cat' n) id:sintype('Id' 'Conductor')
	  phon:sintype('Phon' [conductor]))
	  rest:sintype(listtype('Rec') nil))) id:sintype('Id'
	  app(app(np_det_n 'IndefArt') 'Conductor'))
	  phon:opsintype('Phon' append([a] [conductor])))
	  rest:sintype(listtype('Rec') nil))) id:sintype('Id'
	  app(app(vp_cop_np 'Be') app(app(np_det_n 'IndefArt')
	  'Conductor'))) phon:opsintype('Phon' append([is] append([a]
	  [conductor])))) rectype(agr:rectype(num:'Number'
	  pers:'Person') cat:sintype('Cat' vp) id:'Id' phon:'Phon')}}

{Inspect {IsSubType rectype(agr:sintype(rectype rec(num:sg pers:third)))
	  rectype(agr:rectype(num:'Number' pers:'Person'))}}

{Inspect {IsOfType pl 'Number'}}

{Inspect {IsOfType first 'Person'}}

{Inspect {FindObjects 'Person'}}

{Inspect {IsSubType rectype(agr:deptype(lambda(x rectype sintype(rectype x)) [path([daughters first agr])]) cat:sintype('Cat' vp) daughters:rectype(first:rectype(cat:sintype('Cat' cop) id:sintype('Id' 'Be') phon:sintype('Phon' [är]) tns:sintype('Tense' pres)) rest:rectype(first:rectype(agr:sintype(rectype rec(def:no gen:utr num:sg)) cat:sintype('Cat' np) daughters:rectype(first:rectype(agr:rectype(def:sintype('Definiteness' no) gen:sintype('Gender' utr) num:sintype('Number' sg)) cat:sintype('Cat' n) id:sintype('Id' 'Conductor') phon:sintype('Phon' [dirigent])) rest:sintype(listtype('Rec') nil)) id:sintype('Id' app(app(np_det_n 'IndefArt') 'Conductor')) phon:sintype('Phon' [dirigent])) rest:sintype(listtype('Rec') nil))) id:deptype(lambda(v1 'Id' lambda(v2 'Id' sintype('Id' app(app(vp_cop_np v1) v2)))) [objpath('Be') objpath(app(app(np_det_n 'IndefArt') 'Conductor'))]) phon:opsintype('Phon' append([är] [dirigent])))
	  rectype(cat:sintype('Cat' vp) id:'Id' phon:'Phon')}}

{Inspect {IsSubType rectype(cat:sintype('Cat' vp) daughters:rectype(first:rectype(cat:sintype('Cat' cop) id:sintype('Id' 'Be') phon:sintype('Phon' [är]) tns:sintype('Tense' pres)) rest:rectype(first:rectype(agr:sintype(rectype rec(def:no gen:utr num:sg)) cat:sintype('Cat' np) daughters:rectype(first:rectype(agr:rectype(def:sintype('Definiteness' no) gen:sintype('Gender' utr) num:sintype('Number' sg)) cat:sintype('Cat' n) id:sintype('Id' 'Conductor') phon:sintype('Phon' [dirigent])) rest:sintype(listtype('Rec') nil)) id:sintype('Id' app(app(np_det_n 'IndefArt') 'Conductor')) phon:sintype('Phon' [dirigent])) rest:sintype(listtype('Rec') nil))) id:deptype(lambda(v1 'Id' lambda(v2 'Id' sintype('Id' app(app(vp_cop_np v1) v2)))) [objpath('Be') objpath(app(app(np_det_n 'IndefArt') 'Conductor'))]) phon:opsintype('Phon' append([är] [dirigent])))
	  rectype(cat:sintype('Cat' vp) id:'Id' phon:'Phon')}}