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
   Beethoven Dudamel Kim Sandy He Him It This IndefArt IndefArtAAn DefArt Bear Composer Conductor Donkey Fan Kitchen Light Livingroom Man Nice Run Dim Like Own Switch Turn Be In Off On Aha Ok Yes %Switch_On Switch_Off Turn_On Turn_Off
   S_NP_VP S_NP_VPagr S_VP S_Cop_SmallCl SmallCl_NP_Part NP_Det_N N_Adj_N N_N_PP PP_Prep_NP VP_V_NP VP_Cop_NP D_D_S  D_S 
define
   Daughter1 = Syntax.daughter1
   Daughter2 = Syntax.daughter2
   LexItemPhon = Syntax.lexItemPhon
   Singular = Syntax.singularLex
   Plural = Syntax.pluralLex
   First = Syntax.firstPersLex
   Second = Syntax.secondPersLex
   Third = Syntax.thirdPersLex
   Present = Syntax.presentLex
   Imperative = Syntax.imperativeLex
   PastPart = Syntax.pastPartLex
   LRConcatRule = Syntax.lRConcatRule
   IdentityRule = Syntax.identityRule
   AgreeBinarySpecific = Syntax.agreeBinarySpecific
   HFC = Syntax.hFC
   HFCUnary = Syntax.hFCUnary
   SpecifyDaughter = Syntax.specifyDaughterUnary
   %NonCompositionalCompoundWords = Syntax.nonCompositionalCompoundWords
   PropNameSg = Syntax.propNameSg
   SubjVAgr = Syntax.subjVAgrNumPers
   EndsIn = Phon.endsIn

   
   fun{RegN Abs W}
      paradigm(sg: {Singular {LexItemPhon Abs [W]}}
	       pl: {Plural {LexItemPhon Abs [{AddS W}]}})
   end
   fun{RegV Abs W}
      paradigm(imp: {Imperative {LexItemPhon Abs [W]}}
	       pres: pers(third: num(sg: {Present {Third {Singular {LexItemPhon Abs [{AddS W}]}}}}))
	       pastpart: {PastPart {LexItemPhon Abs [{AddEd W}]}})
   end
   fun{StrongV Abs W Ablaut}
      paradigm(imp: {Imperative {LexItemPhon Abs [W]}}
	       pres: pers(third: num(sg: {Present {Third {Singular {LexItemPhon Abs [{AddS W}]}}}})))
   end
   fun{AddS W}
      if {EndsIn W ch} then {VirtualString.toAtom W#es}
      else {VirtualString.toAtom W#s}
      end
   end
   fun{AddEd W}
      if {EndsIn W e} then {VirtualString.toAtom W#d}
      else {VirtualString.toAtom W#ed}
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
   fun{He Abs}
      {LexItemPhon Abs [he]}
   end
   fun{Him Abs}
      {LexItemPhon Abs [him]}
   end
   fun{It Abs}
      {LexItemPhon Abs [it]}
   end
   fun{This Abs}
      {LexItemPhon Abs [this]}
   end
   fun{IndefArt Abs}
      {LexItemPhon Abs [a]}
   end
   fun{IndefArtAAn Abs}
      paradigm(a: {LexItemPhon Abs [a]}
	       an:{LexItemPhon Abs [an]}) 
   end
   fun{DefArt Abs}
      {LexItemPhon Abs [the]}
   end

   %Common nouns
   fun{Bear Abs}
      {RegN Abs bear}
   end
   fun{Composer Abs}
      {RegN Abs composer}
   end
   fun{Conductor Abs}
      {RegN Abs conductor}
   end
   fun{Donkey Abs}
      {RegN Abs donkey}
   end
   fun{Fan Abs}
      {RegN Abs fan}
   end
   fun{Kitchen Abs}
      {RegN Abs kitchen}
   end
   fun{Light Abs}
      {RegN Abs light}
   end
   fun{Livingroom Abs}
      {RegN Abs livingroom}
   end
   fun{Man Abs}
      paradigm(sg: {Singular {LexItemPhon Abs [man]}}
	       pl: {Plural {LexItemPhon Abs [men]}})
   end
   fun{Nice Abs}
      {LexItemPhon Abs [nice]}
   end
   fun{Run Abs}
      {StrongV Abs run u#a#a}
   end
   fun{Dim Abs}
      {RegV Abs dim}
   end
   fun{Like Abs}
      {RegV Abs like}
   end
   fun{Own Abs}
      {RegV Abs owns}
   end
   fun{Switch Abs}
      {RegV Abs switch}
   end
   fun{Turn Abs}
      {RegV Abs turn}
   end
   fun{Be Abs}
      paradigm(pres: pers(first: num(sg: {Present {First {Singular {LexItemPhon Abs [am]}}}}
				     pl: {Present {First {Plural {LexItemPhon Abs [are]}}}})
			  second: num(sg: {Present {Second {Singular {LexItemPhon Abs [are]}}}}
				      pl: {Present {Second {Plural {LexItemPhon Abs [are]}}}})
			  third: num(sg: {Present {Third {Singular {LexItemPhon Abs [is]}}}}
				      pl: {Present {Third {Plural {LexItemPhon Abs [are]}}}})))
   end
   fun{In Abs}
      {LexItemPhon Abs ['in']}
   end
   fun{Off Abs}
      {LexItemPhon Abs [off]}
   end
   fun{On Abs}
      {LexItemPhon Abs [on]}
   end

   %Lexical sentences
   fun{Aha Abs}
      {LexItemPhon Abs [aha]}
   end
   fun{Ok Abs}
      {LexItemPhon Abs [ok]}
   end
   fun{Yes Abs}
      {LexItemPhon Abs [yes]}
   end
   
   % fun{Switch_On Abs}
%       {NonCompositionalCompoundWords switch on Abs}
%    end
%    fun{Switch_Off Abs}
%       {NonCompositionalCompoundWords switch off Abs}
%    end
%    fun{Turn_On Abs}
%       {NonCompositionalCompoundWords turn on Abs}
%    end
%    fun{Turn_Off Abs}
%       {NonCompositionalCompoundWords turn off Abs}
%    end
   
   fun{S_NP_VP Abs}
      {LRConcatRule Abs}
   end
   fun{S_NP_VPagr Abs}
      {SubjVAgr {LRConcatRule Abs}}
   end
   fun{S_VP Abs}
      {SpecifyDaughter
       rectype(mood : sintype('Mood' imp))
       {HFCUnary mood 'Mood' Daughter1 {IdentityRule Abs}}}
   end
   fun{S_Cop_SmallCl Abs}
      {AgreeBinarySpecific num 'Number' c_num {LRConcatRule Abs}}
   end
   fun{SmallCl_NP_Part Abs}
      {HFC agr rectype Daughter1 {LRConcatRule Abs}}
   end
   fun{NP_Det_N Abs}
      {HFC agr rectype Daughter2 {LRConcatRule Abs}}
   end
   fun{N_Adj_N Abs}
      {HFC agr rectype Daughter2 {LRConcatRule Abs}}
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
      {HFC agr rectype Daughter1 {LRConcatRule Abs}}
   end
   fun{D_D_S Abs}
      {LRConcatRule Abs}
   end
   fun{D_S Abs}
      {IdentityRule Abs}
   end
   
   
  
end