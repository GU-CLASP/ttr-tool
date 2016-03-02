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
   UResAbs at '../../ures/ures-abs.ozf'
   UResDom at '../../ures/ures-domain.ozf'
   UResSyn at '../../ures/ures-syntax.ozf'
   ResGram at '../../res/res-eng-syntax.ozf'
   AbsDom at 'toy1-abs-domain.ozf'
export
   DefArt Light Lights Fan Fans Kitchen Livingroom In Switch Switched Turn V_Switch_On V_Switch_Off V_Turn_On V_Turn_Off
   On Off Is Are Dim S_VP S_Cop_SmallCl SmallCl_NP_Part NP_Det_N N_N_PP PP_Prep_NP VP_V_NP
   Lexicon Rules DRules %VP_Cop_Part
define
   Lexicon = [DefArt Light Lights Fan Fans Kitchen Livingroom In Switch Switched Turn On Off Is Are Dim]
   Rules = [V_Switch_On V_Switch_Off V_Turn_On V_Turn_Off
	    S_VP S_Cop_SmallCl SmallCl_NP_Part NP_Det_N N_N_PP PP_Prep_NP VP_V_NP]
   DRules = nil

   DefArt = {ResGram.defArt AbsDom.defArt}
   Light = {ResGram.light AbsDom.light}.sg
   Lights ={ResGram.light AbsDom.light}.pl 
   Fan = {ResGram.fan AbsDom.fan}.sg
   Fans = {ResGram.fan AbsDom.fan}.pl
   Kitchen = {ResGram.kitchen AbsDom.kitchen}.sg
   Livingroom = {ResGram.livingroom AbsDom.livingroom}.sg
   In = {ResGram.'in' AbsDom.'in'}
   Switch = {ResGram.switch {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Switch' v}}}.imp
   Switched = {ResGram.switch {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Switch' v}}}.pastpart
   Turn = {ResGram.turn {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Turn' v}}}.imp
   On = {ResGram.on AbsDom.on}
   Off = {ResGram.off AbsDom.off}
   Is = {ResGram.be AbsDom.be}.pres.third.sg
   Are = {ResGram.be AbsDom.be}.pres.third.pl
   Dim = {ResGram.dim AbsDom.dim}.imp

   V_Switch_On = {UResSyn.nonCompositionalCompoundWords Switch On {UResSyn.imperativeLex AbsDom.switchOn}}
   V_Switch_Off = {UResSyn.nonCompositionalCompoundWords Switch Off {UResSyn.imperativeLex AbsDom.switchOff}}
  V_Turn_On = {UResSyn.nonCompositionalCompoundWords Turn On {UResSyn.imperativeLex AbsDom.switchOn}}
  V_Turn_Off = {UResSyn.nonCompositionalCompoundWords Turn Off {UResSyn.imperativeLex AbsDom.switchOff}}
   
    S_VP = {ResGram.s_VP AbsDom.s_VP}
    S_Cop_SmallCl = {ResGram.s_Cop_SmallCl AbsDom.s_Cop_SmallCl}
    SmallCl_NP_Part = {ResGram.smallCl_NP_Part AbsDom.smallCl_NP_Part}
    NP_Det_N = {ResGram.nP_Det_N AbsDom.nP_Det_N}
    N_N_PP = {ResGram.n_N_PP AbsDom.n_N_PP}
    PP_Prep_NP = {ResGram.pP_Prep_NP AbsDom.pP_Prep_NP}
    VP_V_NP = {ResGram.vP_V_NP AbsDom.vP_V_NP}
   %VP_Cop_Part = {RuleBinary vp_cop_part vp cop part}
   
   
end