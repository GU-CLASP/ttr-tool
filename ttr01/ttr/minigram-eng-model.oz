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
   Abs at 'minigram-abs-model.ozf'
export
   M
   
define
   M = A#F
   fun {A T}
      case T
      of 'Word' then
	 proc {$ X}
	    choice
	       X = kim
	    [] X = sandy
	    [] X = runs
	    [] X = likes
	    end
	 end
	 else {Abs.m.1 T}
      end
   end
   fun {F T}
      {Abs.m.2 T}
      % case PfType
%       of love(j m) then
% 	 proc {$ X}
% 	    choice
% 	       X = love#j#m
% 	    end
% 	 end
%       [] man(j) then
% 	 proc {$ X}
% 	    choice
% 	       X = man#j
% 	    end
% 	 end
% 	 else proc {$ X} false = X == X end
      % end
   end
   

end
