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
   ResGram at '../../res/res-eng-syntax.ozf'
   Abs at 'bear-abs.ozf'  
export
   This It IndefArt Bear Nice Is Yes S_NP_VP NP_Det_N N_Adj_N VP_Cop_NP D_D_S D_S
   Lexicon Rules DRules
define
   
   Lexicon = [This It IndefArt Bear Nice Is Yes]
   Rules = [S_NP_VP NP_Det_N N_Adj_N VP_Cop_NP D_S]
   DRules = [D_D_S]
   
   This = {ResGram.this Abs.this}
   It = {ResGram.it Abs.pron}
   IndefArt = {ResGram.indefArt Abs.indefArt}
   Bear = {ResGram.bear Abs.bear}.sg
   Nice = {ResGram.nice Abs.nice}
   Is = {ResGram.be Abs.be}.pres.third.sg
   Yes = {ResGram.yes Abs.yes}
   
   S_NP_VP = {ResGram.s_NP_VP Abs.s_NP_VP}
   NP_Det_N = {ResGram.nP_Det_N Abs.nP_Det_N}
   N_Adj_N = {ResGram.n_Adj_N Abs.n_Adj_N}
   VP_Cop_NP = {ResGram.vP_Cop_NP Abs.vP_Cop_NP}
   D_D_S = {ResGram.d_D_S Abs.d_D_S}
   D_S = {ResGram.d_S Abs.d_S}
   
end