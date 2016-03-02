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
   Semantics at '../../ures/ures-semantics.ozf'
export
   Kim Sandy PronMasc PronNeut IndefArt Man Donkey Run Like Own Lexicon S_NP_VP NP_Det_N VP_V_NP D_D_S D_S Rules DRules
define
   PropNameSem = Semantics.propNameSem
   PronSemWithGen = Semantics.pronSemWithGen
   DeterminerSem = Semantics.determinerSem
   CommonNounSem = Semantics.commonNounSem
   CommonNounSemWithGen = Semantics.commonNounSemWithGen
   IntransVerbSem = Semantics.intransVerbSem
   TransVerbExtSem = Semantics.transVerbExtSem
   LRApplyNP_VP = Semantics.lRApplyNP_VP
   LRApplyDet_N = Semantics.lRApplyDet_N
   LRApplyV_NP = Semantics.lRApplyV_NP
   LRApplyConj = Semantics.lRApplyConj
   IdentityS = Semantics.identityS

   Kim = {PropNameSem Abs.kim 'Kim'}
   Sandy = {PropNameSem Abs.sandy 'Sandy'}
   PronMasc = {PronSemWithGen Abs.pron male}
   PronNeut = {PronSemWithGen Abs.pron neuter}
   IndefArt = {DeterminerSem Abs.indefArt 'IndefArt'}
   Man = {CommonNounSemWithGen Abs.man man male}
   Donkey = {CommonNounSem Abs.donkey donkey}
   Run = {IntransVerbSem Abs.run run}
   Like = {TransVerbExtSem Abs.like like}
   Own = {TransVerbExtSem Abs.own own}
   Lexicon = [Kim Sandy PronMasc PronNeut IndefArt Man Donkey Run Like Own] 

   S_NP_VP = {LRApplyNP_VP Abs.s_NP_VP}
   NP_Det_N = {LRApplyDet_N Abs.nP_Det_N}
   VP_V_NP = {LRApplyV_NP Abs.vP_V_NP}
   D_D_S = {LRApplyConj Abs.d_D_S}
   D_S = {IdentityS Abs.d_S}
   Rules = [S_NP_VP NP_Det_N VP_V_NP  D_S]
   DRules = [D_D_S]
   
end
