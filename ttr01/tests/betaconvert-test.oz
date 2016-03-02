declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[BConvert] = {Module.link ['../ttr/betaconvert.ozf']}
ReletterBoundVars = BConvert.reletterBoundVars
BetaConvert = BConvert.betaConvert
AlphaEquiv = BConvert.alphaEquiv
AlphaConvert = BConvert.alphaConvert

{Inspect {AlphaConvert lambda(v 'Ind' f(v)) alphaEquivVar}}

{Inspect {AlphaEquiv lambda(v 'Ind' male(v)) lambda(v0 'Ind' male(v0))}}

{Inspect {BetaConvert apply(apply(f b) a)}}

{Inspect {BetaConvert apply(f b)}}

{Inspect {BetaConvert a}}

{Inspect {BetaConvert apply(f apply(g b))}}

{Inspect {BetaConvert apply(app(f b) a)}}


{Inspect {ReletterBoundVars lambda(x 'Ind' f(x))}}


{Inspect {ReletterBoundVars apply(f lambda(x 'Ind' lambda(x 'Ind' r(x y))))}}

{Inspect {BetaConvert
	  apply(lambda('P' funtype('Ind' 'Type') apply('P' kim))
	  apply(lambda('N' funtype(funtype('Ind' 'Type') 'Type')
				   lambda(x 'Ind' apply('N' lambda(y 'Ind'
								   like(x y)))))
			    lambda('P' funtype('Ind' 'Type')
				   apply('P' sandy))))}}

{Inspect {BetaConvert apply(
			 lambda(r 'RecType'
				rectype(x : r))
			 rectype(x : 'Ind'
				 y : deptype(lambda(v 'Ind' man(v))
					     [path([x])])))}}

{Inspect {BetaConvert
	  apply(lambda('N' funtype(funtype(rectype(x:'Ind') 'RecType') 'RecType') lambda(r1 rectype(x:'Ind') rectype(c:optype('RecType' apply('N' lambda(r2 rectype(x:'Ind') rectype(c:deptype(lambda(x 'Ind' lambda(y 'Ind' like(x y)) [abspath(r1 [x]) abspath(r2 [x])]))))))))) lambda('P' funtype(rectype(x:'Ind') 'RecType') rectype(c1:deptype(lambda(x 'Ind' named(x 'Sandy')) [path([par x])]) c2:deptype(lambda(x rectype(x:'Ind') optype('RecType' apply('P' x))) [path([par])]) par:rectype(x:'Ind'))))}}

{Inspect {BetaConvert
	  apply(lambda('P' funtype(rectype(x:'Ind') 'RecType') rectype(c1:deptype(lambda(x 'Ind' named(x 'Sandy')) [path([par x])]) c2:deptype(lambda(x rectype(x:'Ind') optype('RecType' apply('P' x))) [path([par])]) par:rectype(x:'Ind'))) lambda(r2 rectype(x:'Ind') rectype(c:deptype(lambda(x 'Ind' lambda(y 'Ind' like(x y)) [abspath(r1 [x]) abspath(r2 [x])])))))}}

{Inspect {BetaConvert
	  apply(lambda(r2 rectype(x:'Ind') rectype(c:deptype(lambda(x 'Ind' lambda(y 'Ind' like(x y)) [abspath(r1 [x]) abspath(r2 [x])])))) x)}}