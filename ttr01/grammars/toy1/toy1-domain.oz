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
   Domain at '../../ures/ures-domain.ozf'
export
   Thing Action
   Device Switchable Light Fan DimLight On Off Location Kitchen Livingroom Located Dim SwitchOn SwitchOff
define
   Class = Domain.owlClass 
   SubClassOf = Domain.owlSubClassOf 
   Thing = Domain.owlThing
   Property = Domain.owlProperty

   fun {Action Pred Class}
      {Property Pred Thing Class}
   end

   Device = {SubClassOf {Class device} Thing}
   Switchable = {SubClassOf {Class switchable} Device}
   Light = {SubClassOf {Class light} Switchable}
   Fan = {SubClassOf {Class fan} Switchable}
   DimLight = {SubClassOf {Class dimmable} Light}
   On = {SubClassOf {Class on} Switchable}
   Off = {SubClassOf {Class off} Switchable}
   Location = {SubClassOf {Class location} Thing}
   Kitchen = {SubClassOf {Class kitchen} Location}
   Livingroom = {SubClassOf {Class livingroom} Location}

   Located = {Property located Device Location}

   Dim = {Action dim DimLight}
   SwitchOn = {Action switchon Switchable}
   SwitchOff = {Action switchoff Switchable}
   
end

	    