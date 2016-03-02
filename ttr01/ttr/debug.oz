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
   Inspector(inspect) OS(system) Pickle(save load)
   Utils at 'utils.ozf'

export
   Debug DebugFlg CatchDebugInfo OrError ReportError RaiseErrorVal

define
   TTRPath = Utils.tTRPath
   proc {Debug X}
      case X
      of help then {Inspector.inspect 'Possible arguments to debug: help, yes, no, verbose'}
      [] yes then {Pickle.save  true {TTRPath "ttr/debugflg.ozp"}} {OS.system {VirtualString.toString "ozc -c "#{TTRPath "ttr/debug.oz"}}} = 0 {Inspector.inspect 'Debugging on'}
      [] no then {Pickle.save false {TTRPath "ttr/debugflg.ozp"}} {OS.system {VirtualString.toString "ozc -c "#{TTRPath "ttr/debug.oz"}}} = 0 {Inspector.inspect 'Debugging off'}
      [] verbose then {Pickle.save verbose {TTRPath "debugflg.ozp"}} {OS.system {VirtualString.toString "ozc -c "#{TTRPath "ttr/debug.oz"}}} = 0 {Inspector.inspect 'Debugging verbose mode'}
      else {Inspector.inspect 'Possible arguments to debug: help, yes, no, verbose'}
      end
   end
   DebugFlg = {Pickle.load {TTRPath "ttr/debugflg.ozp"}}
   proc {CatchDebugInfo X}
      case X
      of ttrTrace(Msg) then {Member DebugFlg [true verbose]} = true
			     {ReportError Msg}
			     
      [] failure(...) then  DebugFlg = verbose {ReportError X} 
      else skip
      end
   end
   proc {OrError Proc Msg}
      try
	 choice
	    {Proc}
	 [] raise ttrTrace(Msg) end fail
	 end
      catch E then {CatchDebugInfo E} fail
      end
   end
   proc {ReportError E}
      {Inspector.inspect E}
   end
   fun {RaiseErrorVal Msg Val}
      try
	 raise ttrTrace(Msg) end
      catch E then {CatchDebugInfo E}
      end
      Val
   end
   
end
