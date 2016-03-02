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
   ResGram at '../../res/res-swe-syntax.ozf'
   AbsDom at 'toy1-abs-domain.ozf'
   Dom at 'toy1-domain.ozf'
export
   Lampan Lamporna Fläkten Fläktarna Köket Vardagsrummet I Tänd Släck TändAdj TändaAdj SläcktAdj SläcktaAdj Sätt Stäng
   På Av Ner Är Vrid V_Sätt_På V_Stäng_Av V_Vrid_Ner S_VP S_Cop_SmallCl SmallCl_NP_Part SmallCl_NP_Adj NP_N N_N_PP PP_Prep_NP VP_V_NP
   Lexicon Rules DRules %VP_Cop_Part
define
   RestrictFunction = UResDom.restrictDomainFunctionDomainInRecType
   Restrict = UResDom.restrictDomainInRecType
   SetCat = UResDom.setCat
   Lexicon = [Lampan Lamporna Fläkten Fläktarna Köket Vardagsrummet I Tänd Släck TändAdj TändaAdj SläcktAdj SläcktaAdj Sätt Stäng På Av Ner Är Vrid]
   Rules = [V_Sätt_På V_Stäng_Av V_Vrid_Ner
	    S_VP S_Cop_SmallCl SmallCl_NP_Part SmallCl_NP_Adj NP_N N_N_PP PP_Prep_NP VP_V_NP]
   DRules = nil

   Lampan = {ResGram.lampa AbsDom.light}.sg.def
   Lamporna ={ResGram.lampa AbsDom.light}.pl.def 
   Fläkten = {ResGram.fläkt AbsDom.fan}.sg.def
   Fläktarna = {ResGram.fläkt AbsDom.fan}.pl.def
   Köket = {ResGram.kök AbsDom.kitchen}.sg.def
   Vardagsrummet = {ResGram.vardagsrum AbsDom.livingroom}.sg.def
   I = {ResGram.i AbsDom.'in'}
   Tänd = {ResGram.tända {RestrictFunction AbsDom.switchOn Dom.light}}.imp
   Släck = {ResGram.släcka {RestrictFunction AbsDom.switchOff Dom.light}}.imp
   TändAdj = {ResGram.tänd {SetCat {Restrict AbsDom.on Dom.light} adj}}.sg.indef.utr
   TändaAdj = {ResGram.tänd {SetCat {Restrict AbsDom.on Dom.light} adj}}.pl
   SläcktAdj = {ResGram.släckt {SetCat {Restrict AbsDom.on Dom.light} adj}}.sg.indef.utr
   SläcktaAdj = {ResGram.släckt {SetCat {Restrict AbsDom.on Dom.light} adj}}.pl
   Sätt = {ResGram.sätta {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Switch' v}}}.imp
   Stäng = {ResGram.stänga {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Switch' v}}}.imp
   På = {ResGram.på {Restrict AbsDom.on Dom.fan}}
   Av = {ResGram.av {Restrict AbsDom.off Dom.fan}}
   Ner = {ResGram.ner {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Down' part}}}
   Är = {ResGram.vara AbsDom.be}.pres
   Vrid = {ResGram.vrida {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Turn' v}}}.imp

    V_Sätt_På = {UResSyn.nonCompositionalCompoundWords Sätt På {UResSyn.imperativeLex {RestrictFunction AbsDom.switchOn Dom.fan}}}
   V_Stäng_Av = {UResSyn.nonCompositionalCompoundWords Stäng Av {UResSyn.imperativeLex {RestrictFunction AbsDom.switchOff Dom.fan}}}
   V_Vrid_Ner = {UResSyn.nonCompositionalCompoundWords Vrid Ner {UResSyn.imperativeLex AbsDom.dim}}

   S_VP = {ResGram.s_VP AbsDom.s_VP}
   S_Cop_SmallCl = {ResGram.s_Cop_SmallCl AbsDom.s_Cop_SmallCl}
   SmallCl_NP_Part = {ResGram.smallCl_NP_Part AbsDom.smallCl_NP_Part}
   SmallCl_NP_Adj = {ResGram.smallCl_NP_Adj {UResDom.mergeBinary {UResAbs.ruleBinary smallcl_np_adj smallcl np adj}}}
   NP_N = {ResGram.nP_N {UResAbs.applyRule AbsDom.nP_Det_N AbsDom.defArt}}
   N_N_PP = {ResGram.n_N_PP AbsDom.n_N_PP}
   PP_Prep_NP = {ResGram.pP_Prep_NP AbsDom.pP_Prep_NP}
   VP_V_NP = {ResGram.vP_V_NP AbsDom.vP_V_NP}
   %VP_Cop_Part = {RuleBinary vp_cop_part vp cop part}
   
   
end