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
   Abs at 'toy1-abs-preds.ozf'
   Dom at 'toy1-domain-preds.ozf'
export
   Pred Arity
   
define
   proc {Pred F}
      choice
	 {Abs.pred F}
      [] {Dom.pred F}
      end
   end
   fun {Arity F}
      cond {Abs.pred F} then {Abs.arity F}
      [] {Dom.pred F} then {Dom.arity F}
      end
   end
   

end