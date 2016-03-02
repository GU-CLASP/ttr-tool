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
export
   Pred Arity
   
define
   proc {Pred F}
      {Member F [device switchable light fan dimmable on off location kitchen livingroom located dim switchon switchoff]} = true
   end
   fun {Arity F}
      case F
      of device then ['Ind']
      [] switchable then ['Ind']
      [] light then ['Ind']
      [] fan then ['Ind']
      [] dimmable then ['Ind']
      [] on then ['Ind']
      [] off then ['Ind']
      [] location then ['Ind']
      [] kitchen then ['Ind']
      [] livingroom then ['Ind']
      [] located then ['Ind' 'Ind']
      [] dim then ['Ind' 'Ind']
      [] switchon then ['Ind' 'Ind']
      [] switchoff then ['Ind' 'Ind']
      end
   end
   

end