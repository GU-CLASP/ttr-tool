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
   Utils at 'utils.ozf'
   Abs at 'toy1-abs-domain-model.ozf'
   Syn at '../ures/ures-syntax.ozf'
export
   M
   
define
   MemberR = Utils.memberR
   
   M = A#F
   fun {A T}
      case T
      of 'Word' then
	 proc {$ X}
	   {MemberR X [lampan lamporna fläkten fläktarna köket vardagsrummet i tänd släck tända släckt släckta sätt stäng vrid på av ner är]}
	 end
      [] 'Gender' then
	 proc {$ X}
	    {MemberR X Syn.genValsUN}
	 end
      [] 'Number' then
	 proc {$ X}
	    {MemberR X Syn.numValsSgPl}
	 end
      % [] 'Person' then
% 	 proc {$ X}
% 	    {MemberR X Syn.persValsFST}
% 	 end
      [] 'Mood' then
	 proc {$ X}
	    {MemberR X Syn.moodValsImpActPass}
	 end
      [] 'Tense' then
	 proc {$ X}
	    {MemberR X Syn.tenseValsPresPastFut}
	 end
      [] 'Cat' then
	 proc {$ X}
	    choice
	       {MemberR X [adj]}
	    [] {Abs.m.1 'Cat'}
	    end
	 end
      else {Abs.m.1 T}
      end
   end
   fun {F T}
      {Abs.m.2 T}
   end
   

end
