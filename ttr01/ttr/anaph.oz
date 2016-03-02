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
   Search(base)
   Utils at 'utils.ozf'
   Records at 'records.ozf'
   Types at 'types.ozf'
   BetaConvert at 'betaconvert.ozf'
export
   GenderMutuallyExclusive FindDomain FindInequalities FindProperties ResolveMetaPaths ResolveMetaPathsRemoveEq 
define
   MemberR = Utils.memberR
   AtLeast = Utils.atLeast
   CloseRec = Records.closeRec
   IsSubType = Types.isSubType
   SimplifyEqualitiesLeft = Types.simplifyEqualitiesLeft
   AlphaEquiv = BetaConvert.alphaEquiv
   
   GenderMutuallyExclusive = [lambda(v 'Ind' male(v)) 
			      lambda(v 'Ind' neuter(v))]
   fun {FindDomain RecType Type}
      {Arity {Record.filterInd RecType fun {$ L T}
				       {IsSubType T Type}
				       end}}
   end
   fun {FindInequalities Domain RecType}
      local
	 Inequalities = {NewCell nil}
      in
	 {Record.forAll RecType proc {$ T} {AddInequalities T Domain Inequalities} end}
	 {Access Inequalities}
      end
   end
   proc {AddInequalities Type Domain Inequalities}
      case Type
      of deptype(_ Paths) then
	 local
	    Elements = {FindElementsDomain Domain Paths}
	 in
	    %{Inspector.inspect Elements}
	   if {Length Elements} > 1 then 
	      {Assign Inequalities Elements|{Access Inequalities}}
	   else skip
	   end
	 end
      else skip
      end
   end
   fun {FindElementsDomain Domain Paths}
      local
	 Elements = {NewCell nil}
      in
	 {ForAll Paths proc {$ P}
			  case P
			  of path([X]) then
			     if {Member X Domain} then
				{Assign Elements {Append {Access Elements}
						  [X]}}
			     else skip
			     end
			  else skip
			  end
		       end
	 }
	 {Access Elements}
      end
   end
   fun {FindProperties X RecType}
      local
	 Properties = {NewCell nil}
      in
	 {Record.forAll RecType
	  proc {$ T}
	     case T
	     of deptype(F [path([!X])]) then
		{Assign Properties {Append {Access Properties} [F]}}
	     else skip
	     end
	  end
	 }
	 {Access Properties}
      end
   end
   fun {FindEqualityConstraints X RecType}
      local
	 EqualityConstraints = {NewCell nil}
      in
	 {Record.forAll RecType
	  proc {$ T}
	     case T
	     of deptype(F [path([!X]) _]) then
		case F
		of lambda(X T lambda(Y T eq(X Y))) then
		   {Assign EqualityConstraints {Append {Access EqualityConstraints} [F]}}
		else skip
		end
	     else skip
	     end
	  end
	 }
	 {Access EqualityConstraints}
      end
   end	 
   proc {ResolveMetaPaths RecType Type NewRecType}
      local
	 Domain = {FindDomain RecType Type}
	 Inequalities = {NewCell {FindInequalities Domain RecType}}
      in
	 NewRecType = rectype(...)
	 {Record.forAllInd RecType
	  proc {$ L V}
	     case V
	     of deptype(F [path([X])
			   metapath(!Type C)]) then
		local
		   Resolution
		in
		   {Resolve C X RecType Domain Inequalities Resolution}
		   NewRecType^L = deptype(F [path([X]) path([Resolution])])
		   {Assign Inequalities {Append {Access Inequalities}
					 {List.partition 
					  {Map {Access Inequalities}
					   fun {$ Y}
					      case Y
					      of [!X Z] then [Resolution Z]
					      [] [Z !X] then [Z Resolution]
					      else nil
					      end
					   end
					  }
					  fun {$ Y} Y==nil end
					 _}}}
		end
	     else NewRecType^L = V
	     end
	  end
	 }
	 NewRecType = {CloseRec NewRecType}
      end
   end
   proc {ResolveMetaPathsRemoveEq RecType Type NewRecType}
      local
	 R
      in
	 {ResolveMetaPaths RecType Type R}
	 NewRecType = {SimplifyEqualitiesLeft R}
	 %{Inspector.inspect {FindDomain NewRecType Type}}
	 {All {FindDomain NewRecType Type}
	  fun {$ X}
	     case
		{AtLeast 2 GenderMutuallyExclusive
		 fun {$ P}
		    %{Inspector.inspect {FindProperties X RecType}}
		    {AtLeast 1 {FindProperties X NewRecType}
		     fun {$ Q}
			{AlphaEquiv P Q}
		     end
		    } 
		 end
		}
	     of true then false
	     else  true
	     end
	  end
	 } = true
      end
   end
   
   proc {Resolve Constraint X RecType Domain Inequalities Resolution}
      case Constraint
      of nil then
	 {MemberR Resolution {List.partition Domain fun {$ Y} Y==X end _}}
	 {FindEqualityConstraints Resolution RecType} = nil
%	 {Inspector.inspect [X Resolution]}
	 {ForAll {Access Inequalities}
	  proc {$ Pair}
	     case Pair
	     of [!X !Resolution] then fail
	     [] [!Resolution !X] then fail
	     else x=x
	     end
	  end
	 }
	 case
	    {AtLeast 2 GenderMutuallyExclusive
	     fun {$ P}
		{AtLeast 1 {Append
			    {FindProperties X RecType}
			    {FindProperties Resolution RecType}}
		 fun {$ Q}
		    {AlphaEquiv P Q}
		 end
		} 
	     end
	    }
	 of true then fail
	 else  x=x
	 end
      else {Inspector.inspect ['Anaph.resolve:' Constraint 'not implemented']}
	 Resolution = Constraint
      end
   end


   %proc {Consistent Properties1 Properties2 MutuallyExclusive}
      
   
 % proc {Resolve Constraints X Domain Inequalities Resolution}
%     {MemberR Resolution {List.partition Domain fun {$ Y} Y==X end _}}
%     {ForAll {Access Inequalities}
%      proc {$ Pair}
% 	case Pair
% 	of [!X !Resolution] then fail
% 	[] [!Resolution !X] then fail
% 	else x=x
% 	end
%      end
%     }
%     {ForAll Constraints
%      proc {$ C}
% 	{ForAll {FindProperties Resolution
%    end	 
					  
      
	 
end
