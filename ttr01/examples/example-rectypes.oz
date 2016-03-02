declare
[Utils] = {Module.link [{VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/ttr/utils.ozf"}]}
{Utils.initTypes "default"}

declare
TTRPath = Utils.tTRPath
[Types Preds] = {Module.link [{TTRPath "ttr/types.ozf"} {TTRPath "ttr/preds.ozf"}]}
Model = Types.model
Type = Types.type
IsOfType = Types.isOfType
IsOfTypeCareful = Types.isOfTypeCareful
FindType = Types.findType
FindObjects = Types.findObjects
IsFunType = Types.isFunType
InstantiateType = Types.instantiateType
InstantiateTypeInModel = Types.instantiateTypeInModel
InstantiateTypeInModelAll = Types.instantiateTypeInModelAll
IsSupported = Types.isSupported
IsSubType = Types.isSubType
SimplifyMeet = Types.simplifyMeet
SimplifyDep = Types.simplifyDep
SimplifyOp = Types.simplifyOp
DisjointTypes = Types.disjointTypes
IsBasicSubType = Types.isBasicSubType
ExploitEqualities = Types.exploitEqualities
ExportSintype = Types.exportSintype
NormalizeDep = Types.normalizeDep
Test = Utils.test

{Inspect {IsOfType rectype(x:'Ind') 'Type'}}

{Inspect {IsOfType rec(x:j) rectype(x:'Ind')}}

{Inspect {IsOfType rec(x:j y:k z:man#j) rectype(x:'Ind')}}

{Inspect {IsOfType rec(x:j) rectype(x:'Ind' y:'Ind')}}  %false

{Inspect {IsOfType rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])])) 'RecType'}}

{Inspect {IsOfType rectype(x:'Ind' y: rectype(z:deptype(lambda(x 'Ind' man(x)) [path([x])]))) 'RecType'}} 

{Inspect {IsOfType rectype(x:'Ind' y: deptype(lambda(x 'Ind' rectype(z: man(x))) [path([x])])) 'RecType'}}

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])]))}}

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) )}}

{Inspect {IsOfType rec(x:j y:j z:man#j) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))} }

{Inspect {InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))}}

{Inspect {InstantiateTypeInModel rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])])) Model}}


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
	  'RecType'}} 

{Inspect {IsOfType
	  rectype(x: rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) ))
 'RecType'}} % false

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
	  'RecType'}} 

{Inspect {IsOfType
	  rectype(x: deptype(lambda(v 'Ind'
				    rectype(x:'Ind'
					    y: man(v)))
			     [path([y])]) 
		  y: 'Ind')
	  'RecType'}} 

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
	  'RecType'}} 

{Inspect {IsOfType
	  rectype(x: deptype(lambda(v 'Ind' rectype(x:'Ind'
						    y:man(v)))
				    [path([y])]) 
		  y: deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]))
	  'RecType'}} %false - non-wellfounded

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
	  rec(x : [j]
	      y : [m]
	      z : [j m])
	  rectype(x : listtype('Ind')
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))}} 







{Inspect {InstantiateType
	  rectype(x : sintype(listtype('Ind') [j])
		  y : listtype('Ind')
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	 }} 

{Inspect {InstantiateType
	  rectype(x : sintype(listtype('Ind') [j])
		  y : sintype(listtype('Ind') [m])
		  z : deptype(lambda(x listtype('Ind')
				     lambda(y listtype('Ind')
					    opsintype(listtype('Ind') append(x y))))
			      [path([x]) path([y])]))
	 }} 






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
	 }} 

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
	 }} %false 

{Inspect {IsSubType
	  rectype(x : funtype('Ind' 'RecType')
		  y : 'Ind'
		  w : 'Ind'
		  z : deptype(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    opsintype('RecType' apply(f x))))
			      [path([x]) path([y])]))
	  rectype(z : 'RecType')
	 }} 



{Inspect {IsOfType
	  lambda(f funtype('Ind' 'RecType')
		 lambda(x 'Ind'
			optype('RecType' apply(f x)))) 
	  funtype(funtype('Ind' 'RecType') (funtype('Ind' 'Type')))}} 

{Inspect {IsOfType optype('RecType' apply(lambda(x 'Ind' rectype(x : sintype('Ind' x))) j)) 'RecType'}} 



{Inspect {IsOfType rectype(c:deptype(lambda(x 'Ind' man(x)) [abspath(rec(x:j) [x])])) 'Type'}} 


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




{Inspect {SimplifyMeet meettype(rectype(x:'Ind' y:'Ind') rectype(x: 'Ind'))}}

{Inspect {SimplifyMeet meettype(rectype(x: 'Ind') rectype(x:'Ind' y:'Ind'))}}

{Inspect {SimplifyMeet meettype(jointype('Ind' 'Type') 'RecType')}} %'RecType'

{Inspect {SimplifyMeet meettype(jointype('Ind' 'Type') 'Ind')}}

{Inspect {SimplifyMeet meettype(jointype('Ind' 'Type') jointype('Ind' 'RecType'))}}

{Inspect {SimplifyMeet meettype('Ind' jointype('Ind' 'Type'))}}

{Inspect {SimplifyMeet meettype(rectype(a:'Ind') rectype(b:'Ind'))}}

{Inspect {SimplifyMeet meettype(rectype(a:'Ind' c: jointype('Ind' 'Type')) rectype(b:'Ind' c:'Ind'))}}


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


{Inspect {SimplifyMeet meettype(deptype(lambda(x 'Ind' man(x)) [path([x])])
				deptype(lambda(x 'Ind' man(x)) [path([w])]))}} %contains meettype 





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
	  meettype(rectype(a : 'Ind'
			   b : 'Ind')
		   rectype(a : sintype('Ind' j)))}}


{Inspect {SimplifyMeet meettype(rectype rectype(a:'Ind'))}}


		 



{Inspect {InstantiateTypeInModel rectype(x: 'Ind'
		  y: rectype(
			a: 'Ind'
			c: deptype(lambda(x 'Ind' man(x)) [path([x])]))
		  z: 'Ind') Model}}




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

{Inspect {IsSupported rectype(f: depfuntype(lambda( r rectype(x : 'Ind'
							      c : deptype(lambda(x 'Ind' man(x))
									  [path([x])]))
						    rectype(c : deptype(lambda(x 'Ind' love(x m))
									[abspath(r [x])])))))}}


{Inspect {IsSupported rectype(x : 'Ind'
			      c : deptype(lambda(v 'Ind' man(v))
					  [path([x])]))}}


{Inspect {IsSupported funtype(rectype(x : 'Ind'
				      c : deptype(lambda(v 'Ind' man(v))
						  [path([x])]))
			      bot)}} %false

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




