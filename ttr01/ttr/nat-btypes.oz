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
   BType RType RTypeDef
   
define
   proc {BType T}
      choice
	 T = 'Zero'
      end
   end
   proc {RType T}
      choice
	 T = 'Nat'
      [] T = 'Even'
      [] T = 'Odd'
      end
   end
   fun {RTypeDef T}
      case T of
	 'Nat' then [rectype(n:'Zero') rectype(s:'Zero' n:'Nat')]
      [] 'Even' then [rectype(n:'Zero')
		      rectype(s:'Zero'
			      n:rectype(s:'Zero'
					n:'Even'))]
      [] 'Odd' then [rectype(s:'Zero' n:rectype(n:'Zero'))
		     rectype(s:'Zero'
			      n:rectype(s:'Zero'
					n:'Odd'))]
      else nil
      end
   end
   
end
