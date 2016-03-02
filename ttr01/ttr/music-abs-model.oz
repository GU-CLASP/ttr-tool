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
   %UDom at '../ures/ures-domain.ozf'
export
   M
   
define
   MemberR = Utils.memberR
   %Class = UDom.owlClass
   M = A#F
   fun {A BType}
      case BType
      of 'Cat' then
	 proc {$ X}
	    {MemberR X [d s np det n vp cop]}
	 end
      [] 'Ind' then
	 proc {$ X}
	    %{Inspector.inspect 'model Ind'}
	    {MemberR X [dudamel beethoven]}
	    %{IsAtom X} = true
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
      of conductor(dudamel) then
	 proc {$ X}
	    choice
	       X = conductor#dudamel
	    end
	 end
      [] composer(beethoven) then
	 proc {$ X}
	    choice
	       X = composer#beethoven
	    end
	 end
      % [] person(X) then
% 	 if {Member X [j k l m]} then
% 	   proc {$ Y}
% 	    choice
% 	       Y = person#X
% 	    end
% 	   end
% 	 else proc {$ X} false = X == X end
% 	 end
      else proc {$ X} false = X == X end
      end
   end
  %  fun {F PfType}
%       local
% 	 BearClass = {Class bear}
%       in
% 	 case PfType
% 	 of bear(bear1) then
% 	    proc {$ X}
% 	       X = bear#bear1
% 	    end
% 	 [] nice(bear1 !BearClass) then
% 	    proc {$ X}
% 	       X = nice#bear1#BearClass
% 	    end
% 	 else proc {$ X} false = X == X end
% 	 end
%       end
%   end
   

end
