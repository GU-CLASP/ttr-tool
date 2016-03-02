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
   Abs at 'minigram-sem.ozf'
   Syntax at '../../ures/ures-syntax.ozf'
export
    Kim Sandy He Him It IndefArt Man Donkey Run Like Own Lexicon S_NP_VP VP_V_NP D_D_S  D_S Rules DRules 
define
   LexItemPhon = Syntax.lexItemPhon
   LRConcatRule = Syntax.lRConcatRule
   IdentityRule = Syntax.identityRule
   
   Kim = {LexItemPhon Abs.kim  [kim]}
   Sandy = {LexItemPhon Abs.sandy [sandy]}
   He = {LexItemPhon Abs.pronMasc [he]}
   Him = {LexItemPhon Abs.pronMasc [him]}
   It = {LexItemPhon Abs.pronNeut [it]}
   IndefArt = {LexItemPhon Abs.indefArt [a]}
   Man = {LexItemPhon Abs.man [man]}
   Donkey = {LexItemPhon Abs.donkey [donkey]}
   Run = {LexItemPhon Abs.run [runs]}
   Like = {LexItemPhon Abs.like [likes]}
   Own = {LexItemPhon Abs.own [owns]}
   Lexicon = [Kim Sandy He Him It IndefArt Man Donkey Run Like Own]
   
   S_NP_VP = {LRConcatRule Abs.s_NP_VP}
   NP_Det_N = {LRConcatRule Abs.nP_Det_N}
   VP_V_NP = {LRConcatRule Abs.vP_V_NP}
   D_D_S = {LRConcatRule Abs.d_D_S}
   D_S = {IdentityRule Abs.d_S}
   
   Rules = [S_NP_VP NP_Det_N VP_V_NP D_S]
   DRules = [D_D_S] 
   
end
