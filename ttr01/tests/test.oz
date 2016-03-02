declare
X = f
Y = a
{Inspect assert(X(Y))}

{Inspect {OS.getEnv 'HOME'}}

{Inspect {OS.uName}}

declare
proc{P D A}
   local
      X Y
   in
      choice
	 D = f(X Y)
	 A = f
      [] D = g(Y)
	 A = g
      end
   end
end

{Inspect {SearchOne proc{$ X}{P f(a b) X} end}}

D={NewDictionary}
{Dictionary.put D resgram_eng {NewDictionary}}
{Dictionary.put D.resgram_eng lexicon {NewDictionary}}
{Dictionary.put D.resgram_eng.lexicon bear rectype(x:'Ind')}

{Inspect {Dictionary.toRecord d D}}

{Pickle.save D.resgram_eng.lexicon.bear "testAg"}

{Inspect {Record.toDictionary rec(f:rec(g:a)
				  g:rec(f:b))}}

{Inspect {Record.toDictionary domain}}


fun {Åsna X}
   case X
   of åsna then true
   else false
   end
end
{Inspect {Åsna åsna}}

proc {P X}
   fail
end
proc {P1 X}
   {Member X [a b]} = true
end
fun {F X}
   cond {P X} then {F1 X}
   [] {P1 X} then {F2 X}
   end
end
fun {F1 X}
   case X
   of a then yes
   [] b then no
   end
end
fun {F2 X}
   case X
   of a then yes
   [] b then no
   end
end

{Inspect {F b}}

{Inspect {F c}}

{Inspect {SearchAll proc {$ X} {P X} end}}

declare
{Inspect a|b|[c]}

{Inspector.configure labeltupleMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
					       nil
					       ['Show'(proc {$ X} {System.show X} end)])}


R = r(f:a g:b)
{Inspect {Record.mapInd R fun {$ L V} case L of f then c else V end end}}
{Inspect R}

declare
R1=[a b]
{Inspect {Record.mapInd R1 fun {$ L V} case L of f then c else V end end}}

Rec^g=b

{Inspect {SearchAll proc {$ _} {Inspector.inspect a==b} (a==a) == (b==b) = true end}}

Kim = kim

{Inspect Kim}

{Inspect {Record.map a(b c) fun {$ V} {IsAtom V} end}}

declare
{Pickle.save true "debugflg.ozp"}
{Inspect {Pickle.load "debugflg.ozp"}}

X = {NewCell a}
{Inspect {SearchAll proc {$ Y} Y = {Access X} end}}

   
proc {P X}
   try
      or
	 X = a
      [] {IsList X} = true
      end
   catch failure(...) then {Inspect ['Fail' X]} fail
   end
end
{Inspect {SearchAll proc {$ _} {P b} end}}
	 

declare
proc {P X Y}
   local
      W=a Z=b
   in
   cond choice X=W [] Y=Z end then {Inspect success} a=a else {Inspect failure} fail end
   end
end
{Inspect {SearchAll proc {$ _} {P c d} end}}

fun {IsTrue P}
   case {Search.base.one  P }
   of [_] then true
   [] nil then false
   else {Inspector.inspect ['IsTrue: unable to evaluate' P]} error
   end
end
X
{Inspect {IsTrue proc {$ _} a=X end}}

X=a

declare
[Utils] = {Module.link ['utils.ozf']}
 fun {NewRootEnv Obj}
      local
	 Env = {Utils.newEnv}
      in
	 {Utils.putEnv Env root Obj}
	 {Utils.newSubEnv Env gensymdict}
	 Env
      end
 end
 {Inspect {Dictionary.entries {NewRootEnv 'Ind'}}}

declare
L = [a b c]
{Inspect L^2}

L = a|L^1

L1 = b|L2


declare
Dict = {NewDictionary}
{Dictionary.put Dict x a}
{Inspect {Dictionary.get Dict x}}
fun{F Item} {Dictionary.condExchange Dict Item nil _ b} Dict end
{F y Dict}
{Inspect {Dictionary.get Dict y}}


declare
[Utils] = {Module.link ['utils.ozf']}
SubstituteCompare = Utils.substituteCompare
{Inspect {SubstituteCompare a fun {$ X} if {IsAtom X} then true else false end end [a b c]}}

{Inspect {IsAtom nil}}

declare
[Types] = {Module.link ['types.ozf']}
SimplifyMeet = Types.simplifyMeet
{Inspect {SimplifyMeet meettype(rectype(cat : sintype('Cat' s)
					id : sintype('Id' s_np_vp)
					daughters : rectype(first : sintype(rectype(cat : sintype('Cat' np)) r1)
							    rest : rectype(first : sintype(rectype(cat : sintype('Cat' vp)) r2)
									   rest : sintype(['Rec'] nil)))) rectype(phon:'Phon'))}}



declare
fun {F X}
   cond X = a then true
   else false
   end
end
{Inspect {F a}}
{Inspect {F b}}


{Inspect {OS.system {VirtualString.toString "cp"#" btypes.ozf"#" testbtypes.ozf"}}}

{Inspect {OS.system "ozc -c btypes.oz"}}

{Inspect "a"}
{Inspect "b"}
{Inspect {VirtualString.toString "a"#"b"}}

declare
[Utils] = {Module.link ['utils.ozf']}
Substitute = Utils.substitute

{Inspect {Substitute 'Nat' 'Odd' [rectype(s:'Zero' n:rectype(n:'Zero'))
		     rectype(s:'Zero'
			      n:rectype(s:'Zero'
					n:'Odd'))]}}


InitTypes = Utils.initTypes
{InitTypes "default"}

{Inspect "ozc -c types.oz"}

{Inspect {Substitute f(a) h(b) g(f(b))}}

{Inspect {IsAtom a}}

declare
    fun {Eval E}  
      case E
      of   plus(X Y) then X+Y
      []   times(X Y) then X*Y
      else raise illFormedExpression(E) end
	 
      end 
    end
    try Z =  {Eval 11} catch E then {Inspect E} end
{Inspect Z}

    
try {Inspect {Eval 11}} catch E then {Inspect E} end


    
    {Inspect try {Eval plus(5 6)} catch X then {Inspect X} end}



[Types Utils Models BConvert Records] = {Module.link ['types.ozf' 'utils.ozf' 'models.ozf' 'betaconvert.ozf' 'records.ozf']}
SubType = Types.subType
Meet = Types.meet
SimplifyMeet = Types.simplifyMeet
BType = Types.bType
Model = Types.model
IsOfType = Types.isOfType
SimplifyOp = Types.simplifyOp
InstantiateType = Types.instantiateType
IsSubType = Types.isSubType
OfType1 = Types.ofType1
CloseRec = Records.closeRec
NewEnv = Utils.newEnv
PutEnv = Utils.putEnv



{Assign BType
 proc {$ T}
    {Member T ['Word' 'Ind']} = true
 end
}
{Assign Model A#F}
fun {A T}
   case T
   of  'Word' then
      proc {$ X}
	 {Member X [w1 w2]} = true
      end
   [] 'Ind' then
      proc {$ X}
	 {Member X [j m]} = true
      end
   end
end
fun {F T}
   case T
   of run(j) then
      proc {$ X}
	 X = run#j
      end
   else
      proc {$ X}
	 false = X == X
      end
   end
end
T1 = rectype(phon : sintype(listtype('Word') [w1 w2]))
%T1 = rectype(phon : listtype('Word'))
T2 = rectype(phon : deptype(lambda(x listtype('Word')
				   lambda(y listtype('Word')
					  optype(listtype('Word') append(x y))))
			    [path([phon1])
			     path([phon2])])
	     phon1 : listtype('Word')
	     phon2 : listtype('Word'))
% T2 = rectype(phon : listtype('Word')
% 	    phon1 : deptype(lambda x listtype('Word') sintype(listtype('Word') x) [path([phon])]))
T3 = rectype(a : sintype('Word' w1))
T31 = rectype(a : 'Word')
T32 = rectype(a : sintype('Ind' j))
T4 = rectype(a : deptype(lambda(x 'Word' sintype('Word' x)) [path([b])])
	     b : 'Word')
%{Inspect {SimplifyMeet meettype(T4 T3)}}
T5 = rectype(a : sintype(listtype('Word') [w1 w2]))
T6 = rectype(a : optype(listtype('Word') append([w1] [w2])))
%{Inspect {Meet T5 T6}}
T7 = rectype(a : optype(listtype('Word') append(append([w1] nil) [w2])))
T8 = rectype(a : deptype(lambda(x listtype('Word')
				lambda(y listtype('Word')
				       optype(listtype('Word') append(x y))))
			 [path([b]) path([c])])
	     b : listtype('Word') %'Word' % sintype(listtype('Word') [w2])% 
	     c : listtype('Word'))
T = {SimplifyMeet meettype(T7 T8)}
% {Inspect meettype(T7 T8)}
{Inspect T}
 {Inspect {IsSubType T bot}}
% {Inspect {SimplifyOp T}}
{Inspect {IsSubType {SimplifyOp T} bot}}

%{Inspect {IsOfType [w1 w2] bot}}
% {Inspect {InstantiateType T}}
{Inspect {InstantiateType bot}}
{Inspect {IsSubType T rectype(a : listtype('Word')
			      b : listtype('Word')
			      c : listtype('Word'))}}

T9 = {InstantiateType jointype('Word' 'Ind')}

{Inspect {IsOfType T9 'Word'}}

{Inspect {SimplifyMeet meettype('Ind' 'Word')}}


{Inspect {Meet T T}}
{Inspect {SimplifyMeet meettype(T T)}}




{Inspect {Meet T1 T2}}
{Inspect {InstantiateType T2}}

{Inspect {InstantiateType rectype(phon : optype(listtype('Word') append([w1] [w2])))}}

{Inspect {InstantiateType optype(listtype('Word') append([w1] [w2]))}}
						   

{Inspect {EvalPath rec(x:a) path([y])}}

{Inspect {SearchAll proc {$ X} %local Env={NewEnv}  in
				 or local Env in Env = {NewEnv}{SubType1 'Ind' 'Ind' Env} end
				  then X = 'Ind'
				 [] X = bot
				 end
			      end }}

{Inspect {InstantiateType man(select(r x))}}


 
{Inspect {SearchAll proc {$ Body}
		       local Env = {NewEnv} in {PutEnv Env root Body}
			  {InstantiateDepTypesInRec
			   rec(c:deptype(lambda(x 'Ind' man(x))
					 [abspath(r [x])])) Env Body} end end }}

declare R
{Inspect {EvalPath R abspath(r1 [x])}}

{Inspect {EvalPath rec(y:j) abspath(rec(x:a0#'Ind') [x])}}

{Inspect {BetaConvert apply(lambda(r rectype(x:'Ind') rectype(c:man(select(r x)))) rec(x:j))}}

{Inspect {BetaConvert apply(lambda(r rectype(x:'Ind')
			      rectype(c:deptype(lambda(x 'Ind' man(x))
						[abspath(r [x])])))
			    rec(x:j))}}

{Inspect {EvalOp apply(lambda(x0 'Ind' 'R0'#'RecType'#[a0#'Ind']) a1#'Ind')}}

{Inspect {EvalOp apply({InstantiateType funtype('Ind' 'RecType')} a#'Ind')}}

{Inspect {SearchAll proc {$ _} {InstantiateType funtype('Ind' 'RecType')} = lambda(_ _ _#'RecType') end }}



{Inspect {InstantiateType funtype('Ind' 'RecType')}}






{Inspect {SearchAll proc {$ _}{OpType optype('RecType' apply(f#funtype('Ind' 'RecType') a#'Ind'))} end}}

Env = {NewEnv}
{Inspect {BetaConvert apply(apply(lambda(f funtype('Ind' 'RecType')
				     lambda(x 'Ind'
					    optype('RecType' apply(f x))))
			    lambda(x 'Ind' rectype(c : man(x)))) j)}}
					  

{Inspect {BetaConvert apply(lambda(x 'Ind' rectype(c : man(x))) j)}}


{PutEnv Env root rec(x:j y:j z:man#j)}
{Inspect {SearchAll proc {$ _} {OfType1 {GetEnv Env root} rectype(x:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([x])])) Env} end}}

{Inspect {EvalPath {GetEnv Env root} path([x])}}

{Inspect {SearchAll proc {$ _} {OfType j 'Ind'} end}}









{Inspect {SearchAll proc {$ _} {SubType rectype(x:'Ind' y:'Ind' z:deptype(lambda(x 'Ind' man(x)) [path([y])])) rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])])) } end}}

{Inspect {InstantiateType deptype(lambda(x 'Ind' man(x)) [path([x])])}}


 
{Inspect {SearchAll proc {$ _} {Type rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) )} end}}


R = {InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x])]) z:deptype(lambda(x 'Ind' rectype(w:man(x))) [path([y])]))}
{Inspect R}



{Inspect {InstantiateType rectype(x:rectype(x:'Ind') y:deptype(lambda(x 'Ind' sintype('Ind' x)) [path([x x])]) z:deptype(lambda(x 'Ind' man(x)) [path([y])]))}}

{Inspect {InstantiateType rectype(z:rectype(x:'Ind') y:deptype(lambda(x 'Ind' man(x)) [path([z x])]))}}
{Inspect {InstantiateType rectype(z:rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([z x])])))}}
{Inspect {InstantiateType rectype(x:'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([x])]) )}}
{Inspect {InstantiateType rectype(z:rectype(x:'Ind') y:rectype(x : 'Ind' y:deptype(lambda(x 'Ind' man(x)) [path([z x])])))}}

{Inspect {SearchAll proc {$ _} {Type rectype(x:'Ind' c:deptype(lambda(x 'Ind' man(x)) [path([x])]))} end}}

{Inspect {SearchAll proc {$ _} {OfType rec(x:j c:rec(y:m)) rectype(c:rectype(y:'Ind'))} end}}

{Inspect {SearchAll proc {$ _} {OfType j sintype('Ind' j)} end}}

{Inspect {SearchAll proc {$ _} {OfType [j m] listtype('Ind')} end}}

{Inspect {SearchAll proc {$ _} {OfType love(j m) jointype('Ind' 'Type')} end}}

{Inspect {SearchAll proc {$ _} {OfType {BetaConvert apply(lambda(x 'Ind' man#x) j)} {BetaConvert apply(depfuntype(lambda(a 'Ind' man(a))).1 j)}} end}}

{Inspect {SearchAll proc {$ _} {DepFunType depfuntype(lambda(a 'Ind' depfuntype(lambda(b 'Ind' love(b a)))))} end}}

{Inspect {SearchAll proc {$ _} {OfType lambda('P' funtype('Ind' 'Type') apply('P' j)) funtype(funtype('Ind' 'Type') 'Type')} end}}

{Inspect {SearchAll proc {$ _} {OfType lambda(x 'Ind' lambda(y 'Ind' love(x y))) funtype('Ind' funtype('Ind' 'Ind'))} end}}

{Inspect {SearchAll proc {$ _} {OfType lambda(x 'Ind' love(x m)) funtype('Ind' rectype(x:'Ind' y:'Ind'))}end}}

{Inspect {SearchAll proc {$ _} {FunType funtype('Ind' rectype(x:'Ind' y:'Ind'))}end}}
{Inspect {SearchAll proc {$ T} {Type T} end}}
{Inspect {SearchAll proc {$ _} {Type 'Ind'} end}}



{Inspect {SearchAll proc {$ _} {PfType love(j m)} end}}
{Inspect {SearchAll proc {$ _} {OfType rectype(x:'Ind' y:rectype(a:'Ind' p:love(j m))) 'RecType'} end}}


{Inspect {SearchAll proc {$ _} {OfType j 'Ind'} end}}
{Inspect {SearchAll proc {$ T} {OfType j T} end}}
{Inspect {SearchAll proc {$ T} {PfType T} end}}
{Inspect {SearchAll proc {$ X} {OfType X love(j m)} end}}
{Inspect {SearchAll proc {$ _} {OfType love#j#m love(j m)} end}}
{Inspect {SearchAll proc {$ T} {PfType T} {OfType love#j#m T} end}}
{Inspect {SearchAll proc {$ T} {OfType j T} end}}
{Inspect {SearchAll proc {$ X} {OfType X 'Ind'} end}}
{Inspect {SearchAll proc {$ _} {OfType v 'Ind'} end}}





{Inspect {SearchAll proc {$ _} {RecType rectype(x:'Ind' y:rectype(a:'Ind' p:love(j m)))} end}}

fun {Symbol T}
   if {SearchAll proc {$ _} {BType T} end}  == [_] then x end
end
{Inspect {Symbol 'Ind'}}




HypObjGenerator = Utils.hypObjGenerator
ObjFactory = {NewDictionary}


fun {NewObject Type}
   if {Member Type {Dictionary.keys ObjFactory}}
   then {{Dictionary.get ObjFactory Type}}
   else {Dictionary.put ObjFactory Type {HypObjGenerator x Type}}
      {{Dictionary.get ObjFactory Type}}
   end
end
{Inspect {NewObject 'Ind'}}
{Inspect {NewObject 'Ind'}}




