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
   Utils at '../../ttr/utils.ozf'
   Abs at 'fishgram-abs.ozf'
   Syntax at '../../ures/ures-syntax.ozf'
   Inspector(inspect)
export
   IndefArt DefArt Man Men Fish Swims Swim Swam Lexicon S_NP_VP NP_Det_N Rules DRules
define
   Agr = Syntax.agrNumGenPers
   Sg = Syntax.singularLex
   Pl = Syntax.pluralLex
   Masc = Syntax.masculineLex
   Third = Syntax.thirdPersLex
   Daughter2 = Syntax.daughter2
   fun {LexItem Abs Phon Feats}
      {Utils.applyFuns {Syntax.lexItemPhonAgr Abs Phon Agr} Feats}
   end
   % fun {Agree Rule}
%       {Syntax.agreeBinary Agr cAgr Rule}
%    end
   fun {AgreeNum Rule}
      {Syntax.agreeBinarySpecific num 'Number' cNum Rule}
   end
   fun {AgreePers Rule}
     {Syntax.agreeBinarySpecific pers 'Person' cPers Rule}
   end
   fun {AgreeGen Rule}
     {Syntax.agreeBinarySpecific gen 'Gender' cGen Rule}
   end
   fun {Agree Rule}
      {AgreeGen {AgreePers {AgreeNum Rule}}}
   end
   % fun {PropagateAgreement Rule}
%       {Syntax.lRMergeOnMotherRule agr Agr Rule}
%    end
   fun {HFC Rule}
      {Syntax.hFC agr Agr Daughter2 Rule}
   end
   
   LRConcatRule = Syntax.lRConcatRule

   IndefArt = {LexItem Abs.indefArt  [a] [Sg Third]}
   DefArt = {LexItem Abs.defArt [the] [Third]}
   Man = {LexItem Abs.man [man] [Sg Masc Third]}
   Men = {LexItem Abs.men [men] [Pl Masc Third]}
   Fish = {LexItem Abs.fish [fish] [Third]}
   Swims = {LexItem Abs.swims [swims] [Sg Third]}
   Swim = {LexItem Abs.swim [swim] [Pl Third]}
   Swam = {LexItem Abs.swam [swam] [Third]}
   Lexicon = [IndefArt DefArt Man Men Fish Swims Swim Swam]

   
   S_NP_VP = {AgreePers {AgreeNum {LRConcatRule Abs.s_NP_VP}}}
%   {Inspector.inspect S_NP_VP}
   NP_Det_N = {HFC {Agree {LRConcatRule Abs.nP_Det_N}}}
   Rules = [S_NP_VP NP_Det_N]
   DRules = nil

end
