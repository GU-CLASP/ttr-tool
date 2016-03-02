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
   Kim Sandy Pron IndefArt Man Donkey Run Like Own S_NP_VP NP_Det_N VP_V_NP D_D_S D_S
define
   Lex = AbstractSyntax.lex
   RuleBinary = AbstractSyntax.ruleBinary
   RuleUnary = AbstractSyntax.ruleUnary
   
   Kim = {Lex 'Kim' np}
   Sandy = {Lex 'Sandy' np}
   Pron = {Lex 'Pron' np}
   IndefArt = {Lex 'IndefArt' det}
   Man = {Lex 'Man' n}
   Donkey = {Lex 'Donkey' n}
   Run = {Lex 'Run' vp}
   Like = {Lex 'Like' v}
   Own = {Lex 'Own' v}
   
   S_NP_VP = {RuleBinary s_np_vp s np vp}
   NP_Det_N = {RuleBinary np_det_n np det n}
   VP_V_NP = {RuleBinary vp_v_np vp v np}
   D_D_S = {RuleBinary d_d_s d d s}
   D_S = {RuleUnary d_s d s}
   
end
