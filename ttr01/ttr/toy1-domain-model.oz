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
   Inspector(inspect)
   Utils at 'utils.ozf'
   Models at '../ures/ures-models.ozf'
export
   M
   
define
   MemberR = Utils.memberR
   Failure = Utils.failure
   Proofs = Models.proofs
   State=rec(light1: rec(onoff: {NewCell off})
	     light2: rec(onoff: {NewCell off})
	     fan1: rec(onoff: {NewCell off}))
   M = A#F
   fun {A BType}
      case BType
      of 'Ind' then
	 proc {$ X}
	    %{Inspector.inspect 'model Ind'}
	    {MemberR X [sys light1 light2 fan1 kitchen1 livingroom1]}
	 end
      end
   end
   fun {F PfType}
      case PfType
      of device(_) then
	 {Proofs PfType [light1 light2 fan1]}
      [] switchable(_) then
	 {Proofs PfType [light1 light2 fan1]}
      [] light(_) then
	 {Proofs PfType [light1 light2]}
      [] fan(_) then
	 {Proofs PfType [fan1]}
      [] dimmable(_) then
	 {Proofs PfType [light2]}
      [] on(X) then
	 if {Member X [light1 light2 fan1]}
	    andthen {Access State.X.onoff} == on then
	    proc {$ Y}
	       Y = on#X
	    end
	 else Failure
	 end
      [] off(X) then
	 if {Member X [light1 light2 fan1]}
	    andthen {Access State.X.onoff} == off then
	    proc {$ Y}
	       Y = off#X
	    end
	 else Failure
	 end
      [] location(_) then
	 {Proofs PfType [kitchen1 livingroom1]}
      [] kitchen(_) then
	 {Proofs PfType [kitchen1]}
      [] livingroom(_) then
	 {Proofs PfType [livingroom1]}
      [] located(_ _) then
	 {Proofs PfType [[light1 kitchen1][light2 livingroom1][fan1 kitchen1]]}
      [] dim(_ _) then
	 {Proofs PfType nil}
      [] switchon(sys X) then
	 if {Member X [light1 light2 fan1]}
	    andthen {Access State.X.onoff} == off then
	    {Assign State.X.onoff on}
	    proc {$ Y}
	       Y = switchon#sys#X
	    end
	 else Failure
	 end
      [] switchoff(sys X) then
	 if {Member X [light1 light2 fan1]}
	    andthen {Access State.X.onoff} == on then
	    {Assign State.X.onoff off}
	    proc {$ Y}
	       Y = switchoff#sys#X
	    end
	 else Failure
	 end	 
      else Failure
      end
   end
   

end
