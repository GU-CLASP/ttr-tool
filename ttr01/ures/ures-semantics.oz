/*

    Copyright 2012 Robin Cooper

    This file is part of TTR Tools 0.1alpha.

    TTR Tools 0.1alpha is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    TTR Tools 0.1alpha is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with TTR Tools 0.1alpha.  If not, see <http://www.gnu.org/licenses/>.

*/



functor
import
   Inspector(inspect)
   Types at '../ttr/types.ozf'
   Functions at '../ttr/functions.ozf'
export
   PropNameSem PronSem PronSemWithGen DeterminerSem CommonNounSem CommonNounSemWithGen IntransVerbSem TransVerbExtSem LRApplyNP_VP LRApplyV_NP LRApplyDet_N LRApplyConj IdentityS %NegationClassical
define
   IsSubType = Types.isSubType
   SimplifyMeet = Types.simplifyMeet
   %IsSupported = Types.isSupported
   EmbeddingFunMerge = Functions.embeddingFunMerge
   
   
   EntityT = rectype(x:'Ind')
   PropertyT = funtype(EntityT 'RecType')
   QuantifierT = funtype(PropertyT 'RecType')
   DeterminerT = funtype(PropertyT QuantifierT)
   BinaryRelationT = funtype(QuantifierT PropertyT)

      
   
   %Adding content to abstract syntax without using domain (ontology)

   fun {PropNameSem Abs Name}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(QuantifierT
				      lambda('P' PropertyT
					     rectype(par : EntityT
						     c1 : deptype(lambda(v 'Ind' named(v Name)) [path([par x])])
						     c2 : deptype(lambda(v EntityT optype('RecType' apply('P' v))) [path([par])]))))))}
   end
  fun {PronSem Abs}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(QuantifierT
				      lambda('P' PropertyT
					     rectype(par : EntityT
						     c1 : deptype(lambda(v 'Ind' lambda(w 'Ind' eq(v w))) [path([par x]) metapath('Ind' nil)])
						     c2 : deptype(lambda(v EntityT optype('RecType' apply('P' v))) [path([par])]))))))}
  end
  fun {PronSemWithGen Abs Gen}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(QuantifierT
				      lambda('P' PropertyT
					     rectype(par : EntityT
						     c1 : deptype(lambda(v 'Ind' lambda(w 'Ind' eq(v w))) [path([par x]) metapath('Ind' nil)])
						     c2 : deptype(lambda(v 'Ind' Gen(v)) [path([par x])])
						     c3 : deptype(lambda(v EntityT optype('RecType' apply('P' v))) [path([par])]))))))}
  end
   fun {DeterminerSem Abs Det}
      case Det
      of 'IndefArt' then
	 {SimplifyMeet
	  meettype(Abs
		   rectype(cnt : sintype(DeterminerT
					 lambda('Q' PropertyT
						lambda('P' PropertyT
						       rectype(par : EntityT
							       c1 : deptype(lambda(v EntityT optype('RecType' apply('Q' v))) [path([par])])
							       c2 : deptype(lambda(v EntityT optype('RecType' apply('P' v))) [path([par])])))))))}
      else {Inspector.inspect ['Ures-semantics.determinerSem not implemented for' Det]} 'not implemented'
      end
   end
   fun {CommonNounSem Abs Pred}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(PropertyT
				      lambda(r EntityT
					     rectype(c: deptype(lambda(v 'Ind' Pred(v)) [abspath(r [x])]))))))}
   end
   fun {CommonNounSemWithGen Abs Pred Gen}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(PropertyT
				      lambda(r EntityT
					     rectype(c1 : deptype(lambda(v 'Ind' Gen(v)) [abspath(r [x])])
						     c2 : deptype(lambda(v 'Ind' Pred(v)) [abspath(r [x])]))))))}
   end
   fun {IntransVerbSem Abs Pred}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(PropertyT
				      lambda(r EntityT
					     rectype(c: deptype(lambda(v 'Ind' Pred(v)) [abspath(r [x])]))))))}
   end
   fun {TransVerbExtSem Abs Pred}
      {SimplifyMeet
       meettype(Abs
		rectype(cnt : sintype(BinaryRelationT
				      lambda('N' QuantifierT
					     lambda(r1 EntityT
						    rectype(c: optype('RecType' apply('N'
										      lambda(r2 EntityT
											     rectype(c: deptype(lambda(v1 'Ind'
														       lambda(v2 'Ind'
															      Pred(v1 v2)))
														[abspath(r1 [x])
														 abspath(r2 [x])])))))))))))}
   end
   fun {LRApplySem Type1 Type2}
      lambda(r1 rectype(cnt : Type1)
	     lambda(r2 rectype(cnt : Type2)
		    rectype(cnt : opsintype({AppType Type1 Type2}
					    apply(select(r1 cnt)
						  select(r2 cnt))))))
   end
   % fun {LRDisSem Type1 Type2}
%       lambda(r1 rectype(cnt : Type1)
% 	     lambda(r2 rectype(cnt : Type2)
% 		    rectype(cnt : sintype('RecType'
% 					  rectype(s : Type1
% 						  d : Type2))))) %InstantiateType Type1 and Type2?
%    end
   LRConjSem = lambda(r1 rectype(cnt : 'RecType')
		      lambda(r2 rectype(cnt : 'RecType')
			     rectype(cnt : opsintype('RecType'
						     conj(select(r1 cnt)
							  select(r2 cnt))))))
   fun {IdentitySem Type}
      lambda(r rectype(cnt : Type)
	     rectype(cnt : sintype(Type select(r cnt))))
   end
   fun {AppType Type1 Type2}
      case Type1
      of funtype(T1 T2) then
	 if {IsSubType Type2 T1} then T2
	 else {Inspector.inspect {VirtualString.toAtom "ures-semantics: AppType -  inappropriate argument type"}} {Inspector.inspect Type2} nil
	 end
      else {Inspector.inspect {VirtualString.toAtom "ures-semantics: AppType - first argument not a recognized function type"}} {Inspector.inspect Type1} nil
      end
   end
   fun {LRApplyNP_VP Abs}
      {EmbeddingFunMerge Abs {LRApplySem QuantifierT PropertyT}}
   end
   fun {LRApplyV_NP Abs}
      {EmbeddingFunMerge Abs {LRApplySem BinaryRelationT QuantifierT}}
   end
   fun {LRApplyDet_N Abs}
      {EmbeddingFunMerge Abs {LRApplySem DeterminerT PropertyT}}
   end
   fun {LRApplyConj Abs}
      {EmbeddingFunMerge Abs LRConjSem}
   end
   fun {IdentityS Abs}
      {EmbeddingFunMerge Abs {IdentitySem 'RecType'}}
   end

   % fun {NegationClassical T}
%       case {IsSupported T}
%       of false then
% 	 proc {$ Y}
% 	    Y = true
% 	 end
%       else proc {$ X} false = X == X end
%       end
%    end
   


end
