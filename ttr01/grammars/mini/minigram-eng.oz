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
   ResGram at '../../res/res-eng-syntax.ozf'
export
   Kim Sandy Run Like Lexicon S_NP_VP VP_V_NP Rules
define
   
   
   Kim = {ResGram.kim Abs.kim}
   Sandy = {ResGram.sandy Abs.sandy}
   Run = {ResGram.run Abs.run}
   Like = {ResGram.like Abs.like}
   Lexicon = [Kim Sandy Run Like]
   
   S_NP_VP = {ResGram.s_NP_VP Abs.s_NP_VP}
   VP_V_NP = {ResGram.vP_V_NP Abs.vP_V_NP}
   Rules = [S_NP_VP VP_V_NP]
   
end
