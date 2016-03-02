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
  DefArt Light Fan Kitchen Livingroom In SwitchOn SwitchOff On Off Be Dim S_VP S_Cop_SmallCl SmallCl_NP_Part NP_Det_N N_N_PP PP_Prep_NP VP_V_NP %VP_Cop_Part
define
   Lex = AbstractSyntax.lex
   RuleBinary = AbstractSyntax.ruleBinary
   RuleUnary = AbstractSyntax.ruleUnary
   
   DefArt = {Lex 'DefArt' det}
   Light = {Lex 'Light' n}
   Fan = {Lex 'Fan' n}
   Kitchen = {Lex 'Kitchen' n}
   Livingroom = {Lex 'Livingroom' n}
   In = {Lex 'In' prep}
   SwitchOn = {Lex 'SwitchOn' v}
   SwitchOff = {Lex 'SwitchOff' v}
   On = {Lex 'On' part}
   Off = {Lex 'Off' part}
   Be = {Lex 'Be' cop}
   Dim = {Lex 'Dim' v}
   
   S_VP = {RuleUnary s_vp s vp}
   S_Cop_SmallCl = {RuleBinary s_cop_smallcl s cop smallcl}
   SmallCl_NP_Part = {RuleBinary smallcl_np_part smallcl np part}
   NP_Det_N = {RuleBinary np_det_n np det n}
   N_N_PP = {RuleBinary n_n_pp n n pp}
   PP_Prep_NP = {RuleBinary pp_prep_np pp prep np}
   VP_V_NP = {RuleBinary vp_v_np vp v np}
   %VP_Cop_Part = {RuleBinary vp_cop_part vp cop part}
   
   
end
