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
   Inspector(inspect)
   Utils at 'utils.ozf'
export
   M
   
define
   MemberR = Utils.memberR
   M = A#F
   fun {A BType}
      case BType
      of 'Cat' then
	 proc {$ X}
	    {Member X [d s np det n vp v]} = true
	 end
      [] 'Ind' then
	 proc {$ X}
	    %{Inspector.inspect 'model Ind'}
	    {MemberR X [a b c k s]}
	 end
      [] 'Id' then
	 proc {$ X}
%	 {Member X ['Kim' 'Sandy' 'Run' s_np_vp]} = true
	    {IsRecord X} = true
	 end
      end
   end
   fun {F PfType}
      case PfType
      of man(k) then
	 proc {$ X}
	    X = man#k
	 end
      [] donkey(a) then
	 proc {$ X}
	    X = donkey#a
	 end
      [] run(k) then
	 proc {$ X}
	    X = run#k
	 end
      [] like(k s) then
	 proc {$ X}
	    X = like#k#s
	 end
      [] like(k a) then
	 proc {$ X}
	    X = like#k#a
	 end
      [] own(k a) then
	 proc {$ X}
	    X = own#k#a
	 end	 
      else proc {$ X} false = X == X end
      end
   end
   

end
