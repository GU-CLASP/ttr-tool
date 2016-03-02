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
   Thing 
   PhysObj Animate Bear Brown Black White BrownBear BlackAndWhiteBear BrownOrBlackAndWhiteBear %Panda
define
   Class = Domain.owlClass 
   SubClassOf = Domain.owlSubClassOf
   JoinClassOf = Domain.joinClassOf
   Thing = Domain.owlThing
   %Property = Domain.owlProperty

   PhysObj = {SubClassOf {Class physobj} Thing}
   Animate = {SubClassOf {Class animate} PhysObj}
   Bear = {SubClassOf {Class bear} Animate}
  %Panda = {SubClassOf {Class panda} Animate}
  %Panda = {SubClassOf {Class panda} Bear}
   Brown = {SubClassOf {Class brown} PhysObj}
   Black = {SubClassOf {Class black} PhysObj}
   White = {SubClassOf {Class white} PhysObj}
   BlackAndWhite = {SubClassOf Black White}
   BrownOrBlackAndWhite = {JoinClassOf Brown BlackAndWhite}
   BrownBear = {SubClassOf Bear Brown}
   BlackAndWhiteBear = {SubClassOf Bear BlackAndWhite}
   BrownOrBlackAndWhiteBear = {SubClassOf Bear BrownOrBlackAndWhite}

   


   
end

	    