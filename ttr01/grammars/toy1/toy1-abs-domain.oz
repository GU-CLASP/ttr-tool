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
   DomainRes at '../../ures/ures-domain.ozf'
   Abs at 'toy1-abs.ozf'
   Dom at 'toy1-domain.ozf'
export
  DefArt Light Fan Kitchen Livingroom In SwitchOn SwitchOff On Off Be Dim S_VP S_Cop_SmallCl SmallCl_NP_Part NP_Det_N N_N_PP PP_Prep_NP VP_V_NP %VP_Cop_Part
define
   LexDomainInfo = DomainRes.lexDomainInfo
   IdentityUnary = DomainRes.identityUnary
   IdentityBinarySecond = DomainRes.identityBinarySecond
   MergeBinary = DomainRes.mergeBinary
   LRApplyProperty = DomainRes.lRApplyProperty

   DefArt = {LexDomainInfo Abs.defArt 'RecType' rectype}
   Light = {LexDomainInfo Abs.light 'RecType' Dom.light}
   Fan = {LexDomainInfo Abs.fan 'RecType' Dom.fan}
   Kitchen = {LexDomainInfo Abs.kitchen 'RecType' Dom.kitchen}
   Livingroom = {LexDomainInfo Abs.livingroom 'RecType' Dom.livingroom}
   In = {LexDomainInfo Abs.'in' funtype(Dom.location 'RecType') Dom.located}
   SwitchOn = {LexDomainInfo Abs.switchOn funtype(Dom.switchable 'RecType') Dom.switchOn}
   SwitchOff = {LexDomainInfo Abs.switchOff funtype(Dom.switchable 'RecType') Dom.switchOff}
   On = {LexDomainInfo Abs.on 'RecType' Dom.on}
   Off = {LexDomainInfo Abs.off 'RecType' Dom.off}
   Be = {LexDomainInfo Abs.be 'RecType' rectype}
   Dim = {LexDomainInfo Abs.dim funtype(Dom.dimLight 'RecType') Dom.dim}
   
    S_VP = {IdentityUnary Abs.s_VP}
    S_Cop_SmallCl = {IdentityBinarySecond Abs.s_Cop_SmallCl}
    SmallCl_NP_Part = {MergeBinary Abs.smallCl_NP_Part}
    NP_Det_N = {IdentityBinarySecond Abs.nP_Det_N}
    N_N_PP = {MergeBinary Abs.n_N_PP}
    PP_Prep_NP = {LRApplyProperty Abs.pP_Prep_NP funtype(Dom.location 'RecType')}
    VP_V_NP = {LRApplyProperty Abs.vP_V_NP jointype(funtype(Dom.switchable 'RecType')
 						   funtype(Dom.dimLight 'RecType'))}
   %VP_Cop_Part = {RuleBinary vp_cop_part vp cop part}
   
   
end
