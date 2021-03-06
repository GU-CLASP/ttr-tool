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
export
   NewAgent NewDomain
define
   fun{NewAgent Domains Memory LingRes}
      local
	 A = {NewDictionary}
      in
	 {Dictionary.put A domains Domains}
	 {Dictionary.put A memory Memory}
	 {Dictionary.put A lingres LingRes}
	 A
      end
   end
   fun{NewDomain Ontology AbsSyntax ConcrSyntax}
      local
	 D = {NewDictionary}
      in
	 {Dictionary.put D ontology Ontology}
	 {Dictionary.put D abs AbsSyntax}
	 {Dictionary.put D concr ConcrSyntax}
	 D
      end
   end
   
   
end
