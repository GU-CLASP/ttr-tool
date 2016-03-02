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
   Abs at 'minigram-abs.ozf'
   Syntax at '../../ures/ures-syntax.ozf'
export
   Kim Sandy Run Like Lexicon S_NP_VP VP_V_NP Rules
define
   LexItemPhon = Syntax.lexItemPhon
   LRConcatRule = Syntax.lRConcatRule
   
   Kim = {LexItemPhon Abs.kim  [kim]}
   Sandy = {LexItemPhon Abs.sandy [sandy]}
   Run = {LexItemPhon Abs.run [runs]}
   Like = {LexItemPhon Abs.like [likes]}
   Lexicon = [Kim Sandy Run Like]
   
   S_NP_VP = {LRConcatRule Abs.s_NP_VP}
   VP_V_NP = {LRConcatRule Abs.vP_V_NP}
   Rules = [S_NP_VP VP_V_NP]
   
end
