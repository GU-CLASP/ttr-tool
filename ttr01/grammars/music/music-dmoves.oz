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
   Search(base)
export
   DMove2Abs Abs2DMove
define
   proc{DMoveAbs DMove Abs}
      local
	 X Y
      in
	 choice
	    DMove = assert(pred(X Y))
	    Abs = s_np_vp(Y vp_cop_np('Be' np_det_n('IndefArt' X)))
	 [] DMove = assert(pred(X Y))
	    Abs = d_s(s_np_vp(Y vp_cop_np('Be' np_det_n('IndefArt' X))))
	 [] DMove = acknowledge
	    Abs = d_s('Ok')
	 end
      end
   end
   fun{DMove2Abs DMove}
      local
	 Res = {Search.base.one proc {$ Abs} {DMoveAbs DMove Abs} end}
      in
	 case Res
	 of nil then nil
	 else Res.1
	 end
      end
   end
   fun{Abs2DMove Abs}
      local
	 Res = {Search.base.one proc {$ DMove} {DMoveAbs DMove Abs} end}
      in
	 case Res
	 of nil then nil
	 else Res.1
	 end
      end
   end
   
end

	 
