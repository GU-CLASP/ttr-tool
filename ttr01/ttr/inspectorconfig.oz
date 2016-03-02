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
   Inspector(configure inspect)
   System(show)
   Search(base)
   Types at 'types.ozf'
   Anaph at 'anaph.ozf'

export
   InspectorConfigParse InspectorProjector InspectorDefault

define
   ExploitEqualities = Types.exploitEqualities
   SimplifyOp = Types.simplifyOp
   SimplifyMeet = Types.simplifyMeet
   SimplifyDep = Types.simplifyDep
   InstantiateType = Types.instantiateType
   FlattenRelabelRecType = Types.flattenRelabelRecType
   AbbrevDep = Types.abbrevDep
   IsSupported = Types.isSupported
   ResolveMetaPathsRemoveEq = Anaph.resolveMetaPathsRemoveEq
   proc {InspectorConfigParse}
      {Inspector.configure labeltupleMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
					       nil
					       ['Show'(proc {$ X} {System.show X} end)
						'SimplifyOp'(proc {$ X} {Inspector.inspect {SimplifyOp X}} end)
						'InstantiateType'(proc {$ X} {Inspector.inspect {InstantiateType X}} end)])}
      {Inspector.configure recordMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
					   nil
					   ['Show'(proc {$ X} {System.show X} end)
					    'InstantiateType'(proc {$ X} {Inspector.inspect {InstantiateType X}} end)
					    'ExploitEqualities'(proc {$ X} {Inspector.inspect {ExploitEqualities X}} end)
					    'SimplifyOp'(proc {$ X} {Inspector.inspect {SimplifyOp X}} end)
					    'SimplifyMeet'(proc {$ X} {Inspector.inspect {SimplifyMeet X}} end)
					    'SimplifyDep'(proc {$ X} {Inspector.inspect {SimplifyDep X}} end)
					    'FlattenRelabelRecType'(proc {$ X} {Inspector.inspect {FlattenRelabelRecType X}} end)
					    'Resolve'(proc {$ X} {Inspector.inspect {Search.base.all proc {$ R} {ResolveMetaPathsRemoveEq X 'Ind' R} end}} end)
					    'AbbrevDep'(proc {$ X} {Inspector.inspect {AbbrevDep X}} end)
					    'IsSupported'(proc {$ X} {Inspector.inspect {IsSupported X}} end)])}
      {Inspector.configure listMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
					 nil
					 ['Show'(proc {$ X} {System.show X} end)])}
      {Inspector.configure hashtupleMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
					      nil
					      ['Show'(proc {$ X} {System.show X} end)])}
   end
   proc {InspectorProjector FontSize}
      {Inspector.configure widgetTreeFont font(family:'courier' size:FontSize weight:'bold')}
      {Inspector.configure atomColor '#FF0000'}
   end
   proc {InspectorDefault}
      {Inspector.configure widgetTreeFont font(family:'courier' size:10 weight:'normal')}
      {Inspector.configure atomColor '#FFCCFF'}
   end
   
   
   

end
