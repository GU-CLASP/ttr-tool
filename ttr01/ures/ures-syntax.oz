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
   Records at '../ttr/records.ozf'
   Inspector(inspect)
export
   AgrNumGenPers NumValsSgPl GenValsMFN GenValsUN DefValsBool PersValsFST MoodValsImpActPass TenseValPresPastFut Daughter1 Daughter2 LexItemPhon LexItemPhonAgr SingularLex PluralLex MasculineLex FeminineLex UtrumLex NeuterLex DefiniteLex IndefiniteLex FirstPersLex SecondPersLex ThirdPersLex PresentLex ImperativeLex PastPartLex Cat PropNameSg LRMergeRule LRMergeRulePropagation LRMergeOnMotherRule AgreeBinary AgreeBinaryD2WithD1 AgreeBinarySpecific AgreeBinaryD2WithD1Specific NonCompositionalCompoundWords HFC HFCUnary SpecifyDaughterUnary LRConcatRule IdentityRule SubjVAgrNumPers
define
   SimplifyMeet = Types.simplifyMeet
   NormalizeDep = Types.normalizeDep
   EmbeddingFunMerge = Functions.embeddingFunMerge
   AppendPaths = Records.appendPaths

   AgrNumGenPers = rectype(num : 'Number'
			   gen : 'Gender'
			   pers : 'Person')
   NumValsSgPl = [sg pl]
   GenValsMFN = [masc fem neut]
   GenValsUN = [utr neut]
   DefValsBool = [yes no]
   PersValsFST = [first second third]
   MoodValsImpActPass = [imp active pass]
   TenseValPresPastFut = [pres past future]

   Daughter1 = path([daughters first])
   Daughter2 = path([daughters rest first])

   fun {LexItemPhon Abs Phon}
      {SimplifyMeet meettype(Abs rectype(phon: sintype('Phon' Phon)))}
   end
   fun {LexItemPhonAgr Abs Phon Agr}
      {SimplifyMeet meettype(Abs rectype(phon: sintype('Phon' Phon)
					 agr: Agr))}
   end
   fun {SingularLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(num:sintype('Number' sg))))}
   end
   fun {PluralLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(num:sintype('Number' pl))))}
   end
   fun {MasculineLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(gen:sintype('Gender' masc))))}
   end
   fun {FeminineLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(gen:sintype('Gender' fem))))}
   end
   fun {UtrumLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(gen:sintype('Gender' utr))))}
   end
   fun {NeuterLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(gen:sintype('Gender' neut))))}
   end
   fun {DefiniteLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(def:sintype('Definiteness' yes))))}
   end
   fun {IndefiniteLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(def:sintype('Definiteness' no))))}
   end
   fun {FirstPersLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(pers:sintype('Person' first))))}
   end
   fun {SecondPersLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(pers:sintype('Person' second))))}
   end
   fun {ThirdPersLex Lex}
      {SimplifyMeet meettype(Lex rectype(agr:rectype(pers:sintype('Person' third))))}
   end
   fun {PresentLex Lex}
      {SimplifyMeet meettype(Lex rectype(tns: sintype('Tense' pres)))}
   end
   fun {ImperativeLex Lex}
      {SimplifyMeet meettype(Lex rectype(mood: sintype('Mood' imp)))}
   end
   fun {PastPartLex Lex}
      {SimplifyMeet meettype(Lex rectype(vform: sintype('VForm' pastpart)))}
   end
   fun {Cat Abs C}
      {SimplifyMeet meettype(Abs rectype(cat: sintype('Cat' C)))}
   end
   fun{PropNameSg Abs W}
      {ThirdPersLex {SingularLex {LexItemPhon Abs [W]}}}
   end
   
   LRConcatPhon = lambda(r1 rectype(phon: 'Phon')
		     lambda(r2 rectype(phon: 'Phon')
			    rectype(phon: opsintype('Phon' append(select(r1 phon)
								  select(r2 phon))))))%Change select to work with paths
   IdentityPhon = lambda(r rectype(phon: 'Phon')
			 rectype(phon: sintype('Phon' select(r phon))))
   fun{LRMergeRule Label Type Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(Label: Type)
	     lambda(r2 rectype(Label: Type)
		    rectype(daughters: rectype(first: rectype(Label: optype('RecType' merge(select(r1 Label)
											    select(r2 Label))))
					       rest: rectype(first: rectype(Label: optype('RecType' merge(select(r1 Label)
											    select(r2 Label)))))))))}
   end

   fun{LRMergeRulePropagation Label Type Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(Label: Type)
	      lambda(r2 rectype(Label: Type)
		     rectype(Label: optype('RecType' merge(select(r1 Label)
							   select(r2 Label)))
			     daughters: rectype(first: rectype(Label: optype('RecType' merge(select(r1 Label)
											     select(r2 Label))))
						rest: rectype(first: rectype(Label: optype('RecType' merge(select(r1 Label)
													   select(r2 Label)))))))))}
   end

   fun{LRMergeOnMotherRule Label Type Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(Label: Type)
	      lambda(r2 rectype(Label: Type)
		     rectype(Label: optype('RecType' merge(select(r1 Label)
							   select(r2 Label)))
			     )))}
   end

   fun{AgreeBinary  Type CLabel Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(agr : Type)
	      lambda(r2 rectype(agr : Type)
		     rectype(CLabel : deptype(lambda(x Type
						     lambda(y Type
							    eq(Type x y)))
					      [path([daughters first agr])
					       path([daughters rest first agr])]))))}
   end

   fun{AgreeBinaryD2WithD1 Type Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(agr : Type)
	      lambda(r2 rectype(agr : Type)
		     rectype(daughters : rectype(first : rectype(agr : Type)
						 rest : rectype(first : rectype(agr : deptype(lambda(v Type
												     sintype(Type v))
											      [path([daughters first agr])])))))))}
   end

   fun{AgreeBinarySpecific Label Type CLabel Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(agr : rectype(Label: Type))
	      lambda(r2 rectype(agr : rectype(Label: Type))
		     rectype(CLabel : deptype(lambda(x Type
						     lambda(y Type
							    eq(Type x y)))
					      [path([daughters first agr Label])
					       path([daughters rest first agr Label])]))))}
   end

  fun{AgreeBinaryD2WithD1Specific Label Type Rule}
      {EmbeddingFunMerge Rule
       lambda(r1 rectype(agr : rectype(Label : Type))
	      lambda(r2 rectype(agr : rectype(Label : Type))
		     rectype(daughters : rectype(first : rectype(agr : rectype(Label : Type))
						 rest : rectype(first : rectype(agr : rectype(Label : deptype(lambda(v Type
														     sintype(Type v))
													      [path([daughters first agr Label])]))))))))}
   end 

   fun{HFC Label Type PathToDaughter Rule}
      {EmbeddingFunMerge Rule
       case PathToDaughter
	  of !Daughter1 then
	  lambda(r1 rectype(Label : Type)
		 lambda(r2 rectype
			rectype(Label : {NormalizeDep deptype(lambda(x Type sintype(Type x))
							      [{AppendPaths PathToDaughter path([Label])}])})))
       [] !Daughter2 then
	  lambda(r1 rectype
		 lambda(r2 rectype(Label : Type)
			rectype(Label : {NormalizeDep deptype(lambda(x Type sintype(Type x))
							      [{AppendPaths PathToDaughter path([Label])}])})))
       else {Inspector.inspect ['ures-syntax.hFC: not defined for PathToDaughter:' PathToDaughter]}
       end
      }
   end

   fun{HFCUnary Label Type PathToDaughter Rule}
      {EmbeddingFunMerge Rule
       lambda(r rectype(Label : Type)
	      rectype(Label : {NormalizeDep deptype(lambda(x Type sintype(Type x))
						    [{AppendPaths PathToDaughter path([Label])}])}))}
   end
   
   fun{NonCompositionalCompoundWords WType1 WType2 Abs}
      lambda(r1 WType1
	     lambda(r2 WType2
		    {SimplifyMeet meettype(Abs rectype(phon: opsintype('Phon' append(select(r1 phon)
										     select(r2 phon)))
						       daughters: rectype(first: sintype(WType1 r1)
									  rest: rectype(first: sintype(WType2 r2)
											rest: sintype(listtype('Rec') nil)))))}))
   end

   fun{SpecifyDaughterUnary RecType Abs}
      {EmbeddingFunMerge Abs
       lambda(r RecType rectype)}
   end

   fun {LRConcatRule Abs}
      %{Inspector.inspect Abs#LRConcatPhon}
      %{Inspector.inspect {EmbeddingFunMerge Abs LRConcatPhon}}
      {EmbeddingFunMerge Abs LRConcatPhon}
   end
   fun {IdentityRule Abs}
      {EmbeddingFunMerge Abs IdentityPhon}
   end

   fun{SubjVAgrNumPers Rule}
      {AgreeBinaryD2WithD1Specific num 'Number'
       {AgreeBinaryD2WithD1Specific pers 'Person' Rule}}
   end  

end
