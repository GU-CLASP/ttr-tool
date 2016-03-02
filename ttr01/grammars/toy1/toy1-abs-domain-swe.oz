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
   Lampan Lamporna Fl�kten Fl�ktarna K�ket Vardagsrummet I T�nd Sl�ck T�ndAdj T�ndaAdj Sl�cktAdj Sl�cktaAdj S�tt St�ng
   P� Av Ner �r Vrid V_S�tt_P� V_St�ng_Av V_Vrid_Ner S_VP S_Cop_SmallCl SmallCl_NP_Part SmallCl_NP_Adj NP_N N_N_PP PP_Prep_NP VP_V_NP
   Lexicon Rules DRules %VP_Cop_Part
define
   RestrictFunction = UResDom.restrictDomainFunctionDomainInRecType
   Restrict = UResDom.restrictDomainInRecType
   SetCat = UResDom.setCat
   Lexicon = [Lampan Lamporna Fl�kten Fl�ktarna K�ket Vardagsrummet I T�nd Sl�ck T�ndAdj T�ndaAdj Sl�cktAdj Sl�cktaAdj S�tt St�ng P� Av Ner �r Vrid]
   Rules = [V_S�tt_P� V_St�ng_Av V_Vrid_Ner
	    S_VP S_Cop_SmallCl SmallCl_NP_Part SmallCl_NP_Adj NP_N N_N_PP PP_Prep_NP VP_V_NP]
   DRules = nil

   Lampan = {ResGram.lampa AbsDom.light}.sg.def
   Lamporna ={ResGram.lampa AbsDom.light}.pl.def 
   Fl�kten = {ResGram.fl�kt AbsDom.fan}.sg.def
   Fl�ktarna = {ResGram.fl�kt AbsDom.fan}.pl.def
   K�ket = {ResGram.k�k AbsDom.kitchen}.sg.def
   Vardagsrummet = {ResGram.vardagsrum AbsDom.livingroom}.sg.def
   I = {ResGram.i AbsDom.'in'}
   T�nd = {ResGram.t�nda {RestrictFunction AbsDom.switchOn Dom.light}}.imp
   Sl�ck = {ResGram.sl�cka {RestrictFunction AbsDom.switchOff Dom.light}}.imp
   T�ndAdj = {ResGram.t�nd {SetCat {Restrict AbsDom.on Dom.light} adj}}.sg.indef.utr
   T�ndaAdj = {ResGram.t�nd {SetCat {Restrict AbsDom.on Dom.light} adj}}.pl
   Sl�cktAdj = {ResGram.sl�ckt {SetCat {Restrict AbsDom.on Dom.light} adj}}.sg.indef.utr
   Sl�cktaAdj = {ResGram.sl�ckt {SetCat {Restrict AbsDom.on Dom.light} adj}}.pl
   S�tt = {ResGram.s�tta {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Switch' v}}}.imp
   St�ng = {ResGram.st�nga {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Switch' v}}}.imp
   P� = {ResGram.p� {Restrict AbsDom.on Dom.fan}}
   Av = {ResGram.av {Restrict AbsDom.off Dom.fan}}
   Ner = {ResGram.ner {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Down' part}}}
   �r = {ResGram.vara AbsDom.be}.pres
   Vrid = {ResGram.vrida {UResDom.lexUnspecifiedDomainInfo {UResAbs.lex 'Turn' v}}}.imp

    V_S�tt_P� = {UResSyn.nonCompositionalCompoundWords S�tt P� {UResSyn.imperativeLex {RestrictFunction AbsDom.switchOn Dom.fan}}}
   V_St�ng_Av = {UResSyn.nonCompositionalCompoundWords St�ng Av {UResSyn.imperativeLex {RestrictFunction AbsDom.switchOff Dom.fan}}}
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