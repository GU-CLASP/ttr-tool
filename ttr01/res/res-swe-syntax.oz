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
   Syntax at '../ures/ures-syntax.ozf'
   Phon at '../ures/ures-phon.ozf'
export
   Beethoven Dudamel Kim Sandy Han Honom Det IndefArt DefArt Dirigent Fläkt Kök Lampa Tonsättare Vardagsrum Man Åsna Tänd Släckt Springa Gilla Stänga Sänka Sätta Vrida Äga Tända Släcka Vara I Av På Ner Jaha Ok
   S_NP_VPagr S_NP_VP S_VP S_Cop_SmallCl SmallCl_NP_Part SmallCl_NP_Adj NP_Det_N NP_N N_N_PP PP_Prep_NP VP_V_NP VP_Cop_NP D_D_S  D_S 
define
   Daughter1 = Syntax.daughter1
   Daughter2 = Syntax.daughter2
   LexItemPhon = Syntax.lexItemPhon
   Singular = Syntax.singularLex
   Plural = Syntax.pluralLex
   % First = Syntax.firstPersLex
%    Second = Syntax.secondPersLex
%    Third = Syntax.thirdPersLex
   Utrum = Syntax.utrumLex
   Neuter = Syntax.neuterLex
   Indefinite = Syntax.indefiniteLex
   Definite = Syntax.definiteLex
   Present = Syntax.presentLex
   Imperative = Syntax.imperativeLex
   PastPart = Syntax.pastPartLex
   LRConcatRule = Syntax.lRConcatRule
   IdentityRule = Syntax.identityRule
   AgreeBinary = Syntax.agreeBinary
   %AgreeBinarySpecific = Syntax.agreeBinarySpecific
   HFC = Syntax.hFC
   HFCUnary = Syntax.hFCUnary
   SpecifyDaughter = Syntax.specifyDaughterUnary
   %NonCompositionalCompoundWords = Syntax.nonCompositionalCompoundWords
   PropNameSg = Syntax.propNameSg
   SubjVAgr = Syntax.subjVAgrNumPers
   EndsIn = Phon.endsIn
   GeminateFinal = Phon.geminateFinal
   DeleteFinal = Phon.deleteFinal

   fun{RegNAStem Abs W}
      paradigm(sg: definiteness(indef: {Utrum {Indefinite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#a}]}}}}
				def: {Utrum {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#an}]}}}})
	       pl: definiteness(indef: {Utrum {Indefinite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#'or'}]}}}}
				def: {Utrum {Definite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#orna}]}}}}))
   end
   fun{RegNCStemUtr Abs W}
      paradigm(sg: definiteness(indef: {Utrum {Indefinite {Singular {LexItemPhon Abs [W]}}}}
				def: {Utrum {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#en}]}}}})
	       pl: definiteness(indef: {Utrum {Indefinite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#ar}]}}}}
				def: {Utrum {Definite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#arna}]}}}}))
   end
   fun{RegNCStemNeut Abs W}
      paradigm(sg: definiteness(indef: {Neuter {Indefinite {Singular {LexItemPhon Abs [W]}}}}
				def: {Neuter {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#et}]}}}})
	       pl: definiteness(indef: {Neuter {Indefinite {Plural {LexItemPhon Abs [W]}}}}
				def: {Neuter {Definite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#en}]}}}}))
   end
   fun{RegNCStemNeutGeminate Abs W}
      paradigm(sg: definiteness(indef: {Neuter {Indefinite {Singular {LexItemPhon Abs [W]}}}}
				def: {Neuter {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom {GeminateFinal W}#et}]}}}})
	       pl: definiteness(indef: {Neuter {Indefinite {Plural {LexItemPhon Abs [W]}}}}
				def: {Neuter {Definite {Plural {LexItemPhon Abs [{VirtualString.toAtom {GeminateFinal W}#en}]}}}}))
   end
   fun{RegNCStemEUtr Abs W} %dirigent
      paradigm(sg: definiteness(indef: {Utrum {Indefinite {Singular {LexItemPhon Abs [W]}}}}
				def: {Utrum {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#en}]}}}})
	       pl: definiteness(indef: {Utrum {Indefinite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#er}]}}}}
				def: {Utrum {Definite {Plural {LexItemPhon Abs [{VirtualString.toAtom W#erna}]}}}}))
   end
   fun{RegNareUtr Abs W} %tonsättare
      paradigm(sg: definiteness(indef: {Utrum {Indefinite {Singular {LexItemPhon Abs [W]}}}}
				def: {Utrum {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#n}]}}}})
	       pl: definiteness(indef: {Utrum {Indefinite {Plural {LexItemPhon Abs [{VirtualString.toAtom W}]}}}}
				def: {Utrum {Definite {Plural {LexItemPhon Abs [{VirtualString.toAtom {DeleteFinal W}#na}]}}}}))
   end
   fun{RegAdj Abs W}
      paradigm(sg: definiteness(indef: gender(utr: {Utrum {Indefinite {Singular {LexItemPhon Abs [W]}}}}
					      neut: {Neuter {Indefinite {Singular {LexItemPhon Abs [{AddT W}]}}}})
				def: {Definite {Singular {LexItemPhon Abs [{VirtualString.toAtom W#a}]}}})
	       pl: {Plural {LexItemPhon Abs [{VirtualString.toAtom W#a}]}})
   end
   fun{RegV Abs W}
      paradigm(imp: {Imperative {LexItemPhon Abs [W]}}
	       pres: {Present {LexItemPhon Abs [{VirtualString.toAtom W#r}]}}
	       pastpart: {PastPart {LexItemPhon Abs [{VirtualString.toAtom W#t}]}}) %Swedish supine
   end
   fun{RegVCStem Abs W}
      paradigm(imp: {Imperative {LexItemPhon Abs [W]}}
	       pres: {Present {LexItemPhon Abs [{VirtualString.toAtom W#er}]}}
	       pastpart: {PastPart {LexItemPhon Abs [{AddT W}]}}) %Swedish supine
   end
   fun{StrongV Abs W Ablaut}
      paradigm(imp: {Imperative {LexItemPhon Abs [W]}}
	       pres: {Present {LexItemPhon Abs [{VirtualString.toAtom W#er}]}})
   end
   fun{AddT W}
      if {EndsIn W d} then {VirtualString.toAtom {DeleteFinal W}#t}
      elseif {EndsIn W t} then W
      else {VirtualString.toAtom W#t}
      end
   end
  
   
    %Proper names
   fun{Beethoven Abs}
      {PropNameSg Abs beethoven}
   end
   fun{Dudamel Abs}
      {PropNameSg Abs dudamel}
   end
   
   fun{Kim Abs}
      {LexItemPhon Abs [kim]}
   end
   fun{Sandy Abs}
      {LexItemPhon Abs [sandy]}
   end
   
   fun{Han Abs}
      {LexItemPhon Abs [han]}
   end
   fun{Honom Abs}
      {LexItemPhon Abs [honom]}
   end
   fun{Det Abs}
      {LexItemPhon Abs.pronNeut [det]}
   end
   fun{IndefArt Abs}
      paradigm(utr: {Utrum {Singular {LexItemPhon Abs [en]}}}
	       neut: {Neuter {Singular {LexItemPhon Abs [ett]}}})
   end
   fun{DefArt Abs}
      paradigm(utr: num(sg: {Utrum {Singular {LexItemPhon Abs [den]}}}
			pl: {Utrum {Plural {LexItemPhon Abs [de]}}})
	       neut: num(sg: {Neuter {Singular {LexItemPhon Abs [det]}}}
			 pl: {Neuter {Plural {LexItemPhon Abs [de]}}}))
   end

   %Common nouns
   fun{Dirigent Abs}
      {RegNCStemEUtr Abs dirigent}
   end
   fun{Fläkt Abs}
      {RegNCStemUtr Abs fläkt}
   end
   fun{Kök Abs}
      {RegNCStemNeut Abs kök}
   end
   fun{Lampa Abs}
      {RegNAStem Abs lamp}
   end
   fun{Vardagsrum Abs}
      {RegNCStemNeutGeminate Abs vardagsrum}
   end
   fun{Man Abs}
      paradigm(sg: definiteness(indef: {Utrum {Indefinite {Singular {LexItemPhon Abs [man]}}}}
				def: {Utrum {Definite {Singular {LexItemPhon Abs [mannen]}}}})
	       pl: definiteness(indef: {Utrum {Indefinite {Plural {LexItemPhon Abs [män]}}}}
				def: {Utrum {Definite {Plural {LexItemPhon Abs [männen]}}}}))
   end
   fun{Tonsättare Abs}
      {RegNareUtr Abs tonsättare}
   end
   fun{Åsna Abs}
      {RegNAStem Abs åsn}
   end
   
   fun{Tänd Abs}
      {RegAdj Abs tänd}
   end
   fun{Släckt Abs}
      {RegAdj Abs släckt}
   end
   
   fun{Springa Abs}
      {StrongV Abs spring i#a#u}
   end
   fun{Gilla Abs}
      {RegV Abs gilla}
   end
   fun{Stänga Abs}
      {RegVCStem Abs stäng}
   end
   fun{Sänka Abs}
      {RegVCStem Abs sänk}
   end
   fun{Sätta Abs}
      {StrongV Abs sätt ä#a#a}
   end
   fun{Vrida Abs}
      {StrongV Abs vrid i#e#i}
   end
   fun{Äga Abs}
      {RegVCStem Abs äg}
   end
   fun{Tända Abs}
      {RegVCStem Abs tänd}
   end
   fun{Släcka Abs}
      {RegVCStem Abs släck}
   end
   fun{Vara Abs}
      paradigm(imp: {Imperative {LexItemPhon Abs [var]}}
	       pres: {Present {LexItemPhon Abs [är]}}
	       pastpart: {PastPart {LexItemPhon Abs [varit]}})
   end
   fun{I Abs}
      {LexItemPhon Abs [i]}
   end
   fun{Av Abs}
      {LexItemPhon Abs [av]}
   end
   fun{På Abs}
      {LexItemPhon Abs [på]}
   end
   fun{Ner Abs}
      {LexItemPhon Abs [ner]}
   end

   %Lexical sentences
   fun{Jaha Abs}
      {LexItemPhon Abs [jaha]}
   end
   fun{Ok Abs}
      {LexItemPhon Abs [ok]}
   end

   fun{S_NP_VPagr Abs}
      {SubjVAgr {LRConcatRule Abs}}
   end
   fun{S_NP_VP Abs}
      {LRConcatRule Abs}
   end
   fun{S_VP Abs}
      {SpecifyDaughter
       rectype(mood : sintype('Mood' imp))
       {HFCUnary mood 'Mood' Daughter1 {IdentityRule Abs}}}
   end
   fun{S_Cop_SmallCl Abs}
      {LRConcatRule Abs}
   end
   fun{SmallCl_NP_Part Abs}
      {HFC agr rectype Daughter1 {LRConcatRule Abs}}
   end
   fun{SmallCl_NP_Adj Abs}
      {HFC agr rectyp Daughter1 {AgreeBinary rectype c_agr {LRConcatRule Abs}}}
   end
   fun{NP_Det_N Abs}
      {HFC agr rectype Daughter2 {AgreeBinary rectype c_agr {LRConcatRule Abs}}}
   end
   fun{NP_N Abs}
      {HFCUnary agr rectype  Daughter1 {IdentityRule Abs}}
   end
   fun{N_N_PP Abs}
      {HFC agr rectype Daughter1 {LRConcatRule Abs}}
   end
   fun{PP_Prep_NP Abs}
      {LRConcatRule Abs}
   end
   fun{VP_V_NP Abs}
      {HFC mood 'Mood' Daughter1 {LRConcatRule Abs}}
   end
   fun{VP_Cop_NP Abs}
      {LRConcatRule Abs}
   end
   fun{D_D_S Abs}
      {LRConcatRule Abs}
   end
   fun{D_S Abs}
      {IdentityRule Abs}
   end
   
   
  
end