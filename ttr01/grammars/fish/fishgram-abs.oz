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
    IndefArt DefArt Man Men Fish Swims Swim Swam S_NP_VP NP_Det_N 
define
   Lex = AbstractSyntax.lex
   RuleBinary = AbstractSyntax.ruleBinary
   %RuleUnary = AbstractSyntax.ruleUnary
   
   IndefArt = {Lex 'IndefArt' det}
   DefArt = {Lex 'DefArt' det}
   Man = {Lex 'Man' n}
   Men = {Lex 'Men' n}
   Fish = {Lex 'Fish' n}
   Swims = {Lex 'Swims' vp}
   Swim = {Lex 'Swim' vp}
   Swam = {Lex 'Swam' vp}
   
   S_NP_VP = {RuleBinary s_np_vp s np vp}
   NP_Det_N = {RuleBinary np_det_n np det n}

   
end
