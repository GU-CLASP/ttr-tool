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
   Utils at '../ttr/utils.ozf'
export
   Proofs
define
   Failure = Utils.failure
   fun {Proofs PfType Set}
      local
	 Pred = {Label PfType}
      in
	 case PfType
	 of Pred(X) then
	    if {Member X Set} then
	       proc {$ Y}
		  Y = Pred#X
	       end
	    else Failure
	    end
	 [] Pred(X Y) then
	    if {Member [X Y] Set} then
	       proc {$ Y}
		  Y = Pred#X#Y
	       end
	    else Failure
	    end
	 end
      end
   end
   
	       
end
