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
   Types at '../ttr/types.ozf'
   Functions at '../ttr/functions.ozf'
export
   OwlThing OwlClass OwlSubClassOf JoinClassOf OwlProperty LexDomainType LexUnspecifiedDomainInfo LexDomainInfo  SetCat IdentityUnary IdentityBinarySecond MergeBinary LRApplyProperty RestrictDomainFunctionDomainInRecType RestrictDomainInRecType
define
   SimplifyMeet = Types.simplifyMeet
   SimplifyJoin = Types.simplifyJoin
   EmbeddingFunMerge = Functions.embeddingFunMerge
   RestrictDomainFunctionType = Functions.restrictDomainFunctionType
   RestrictDomainFunction = Functions.restrictDomainFunction
   
   
   OwlThing = rectype(x:'Ind') 
    
   fun {OwlClass Pred}
      local
	 L = {OntologyLabel Pred}
      in
	 rectype(x:'Ind'
		 L: deptype(lambda(v 'Ind' Pred(v))
			    [path([x])]))
      end
   end
   fun {OwlSubClassOf RecType1 RecType2}  
      {SimplifyMeet
       meettype(RecType1 RecType2)
      }
   end
   fun{JoinClassOf RecType1 RecType2}
      {SimplifyJoin
       jointype(RecType1 RecType2)}
   end
   fun {OwlProperty Pred Class1 Class2}
      local
	 L = {OntologyLabel Pred}
      in
	 lambda(r Class2
		{SimplifyMeet
		 meettype(Class1
			  rectype(x: 'Ind'
				  L: deptype(lambda(v 'Ind'
						    lambda(w 'Ind'
							   Pred(v w)))
					     [path([x]) abspath(r [x])])))
	       }
	       )
      end
   end
   
   fun {OntologyLabel Pred}
      {VirtualString.toAtom o_#Pred}
   end

   
   fun {LexDomainType Abs Type}
      {SimplifyMeet
       meettype(Abs rectype(domain: Type ))
      }
   end
   fun {LexUnspecifiedDomainInfo Abs}
      {SimplifyMeet
       meettype(Abs rectype(domain: 'RecType'))
      }
   end
   fun {LexDomainInfo Abs Type DomInfo}
      {SimplifyMeet
       meettype(Abs rectype(domain: sintype(Type DomInfo)))
      }
   end
   fun {IdentityDomain Type}
      lambda(r rectype(domain : Type)
	     rectype(domain : sintype(Type select(r domain))))
   end
   fun {IdentityDomainSecond Type1 Type2}
      lambda(r1 rectype(domain : Type1)
	     lambda(r2 rectype(domain: Type2)
		    rectype(domain : sintype(Type2 select(r2 domain)))))
   end
   fun {MergeDomain Type}
      lambda(r1 rectype(domain: Type)
	     lambda(r2 rectype(domain: Type)
		    rectype(domain: opsintype(Type merge(select(r1 domain)
							 select(r2 domain))))))
   end
   fun {LRApplyOwlProperty Type}
      lambda(r1 rectype(domain: Type)
	     lambda(r2 rectype(domain: 'RecType')
		    rectype(domain: opsintype('RecType'
					    rectype(property: sintype(Type select(r1 domain))
						    valuetype: sintype('RecType' select(r2 domain)))))))
   end

   fun{RestrictDomainFunctionDomainInRecType RecType Type}
      {Record.mapInd RecType
       fun{$ L V}
	  case L
	  of domain then
	     case V
	     of sintype(funtype(...) lambda(...)) then
		sintype({RestrictDomainFunctionType V.1 Type}
			{RestrictDomainFunction V.2 Type})
	     else V
	     end
	  else V
	  end
       end
      }
   end

   fun{RestrictDomainInRecType RecType Type}
      {Record.mapInd RecType
       fun{$ L V}
	  case L
	  of domain then
	     case V
	     of sintype('RecType' rectype(...)) then
		sintype('RecType' {SimplifyMeet meettype(V.2 Type)})
	     else V
	     end
	  else V
	  end
       end
      }
   end

   fun{SetCat RecType Cat}
      {Record.mapInd RecType
       fun{$ L V}
	  case L
	  of cat then sintype('Cat' Cat)
	  else V
	  end
       end
      }
   end
   
   
			  
   
      
   
      
   fun {IdentityUnary Abs}
      {EmbeddingFunMerge Abs {IdentityDomain 'RecType'}}
   end
   fun {IdentityBinarySecond Abs}
      {EmbeddingFunMerge Abs {IdentityDomainSecond 'RecType' 'RecType'}}
   end
   fun {MergeBinary Abs}
      {EmbeddingFunMerge Abs {MergeDomain 'RecType'}}
   end
   fun {LRApplyProperty Abs Type}
      {EmbeddingFunMerge Abs {LRApplyOwlProperty Type}}
   end
   
   
      
   
end

