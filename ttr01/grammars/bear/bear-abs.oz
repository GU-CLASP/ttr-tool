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
 AbstractSyntax at '../../ures/ures-abs.ozf'  
export
   This Pron IndefArt Bear Nice Be Yes S_NP_VP NP_Det_N N_Adj_N VP_Cop_NP D_D_S D_S
define
   Lex = AbstractSyntax.lex
   RuleBinary = AbstractSyntax.ruleBinary
   RuleUnary = AbstractSyntax.ruleUnary
   
   This = {Lex 'This' np}
   Pron = {Lex 'Pron' np}
   IndefArt = {Lex 'IndefArt' det}
   Bear = {Lex 'Bear' n}
   Nice = {Lex 'Nice' adj}
   Be = {Lex 'Be' cop}
   Yes = {Lex 'Yes' s}
   
   S_NP_VP = {RuleBinary s_np_vp s np vp}
   NP_Det_N = {RuleBinary np_det_n np det n}
   N_Adj_N = {RuleBinary n_adj_n n adj n}
   VP_Cop_NP = {RuleBinary vp_cop_np vp cop np}
   D_D_S = {RuleBinary d_d_s d d s}
   D_S = {RuleUnary d_s d s}
   
end
