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
%    Types at 'types.ozf'
export
   IsRightBinaryRule IsUnaryRule FirstArgCatOfRule GetRuleID CompileLeftCornerIndexedRules
   AddRulesToIDIndexedLexicon %EvaluateIDExpr Generate
define
   % EmbeddingFunConvert = Functions.embeddingFunConvert
%    InstantiateType = Types.instantiateType
   % proc{BinaryRule F}
%       F = lambda(_ _ lambda(_ _ rectype(...)))
%    end
   RMatch = Utils.recursiveMatchInRecord
   proc{RightBinaryRule F}
      local
	 R Body
      in
	 F = lambda(R _ lambda(_ _ Body))
	 {RMatch proc {$ X} X = sintype(...) X.2=R end Body.daughters.first} = true 
      end
   end
   fun{IsRightBinaryRule F}
      cond {RightBinaryRule F} then true
      else false
      end
   end
   proc {UnaryRule F}
      local
	 R Body
      in
	 F = lambda(R _ Body)
	 Body = rectype(...)
	 choice
	    {CondSelect {CondSelect Body daughters error} first error} = sintype(_ R)
	 [] {CondSelect {CondSelect {CondSelect Body daughters error} rest  error} first error} = sintype(_ R)
	 end
      end
   end
   fun{IsUnaryRule F}
      case {Search.base.one proc {$ _} {UnaryRule F} end}
      of [_] then true
      else false
      end
   end
   fun{FirstArgCatOfRule F}
      local
	 R C
      in
	 F = lambda(_ R _)
	 R.cat = sintype('Cat' C)
	 C
      end
   end
   fun {GetRuleID F}
      case F
      of lambda(_ _ lambda(_ _ Body)) then
	 case Body
	 of rectype(...) then
	    case Body.id
	    of deptype(lambda(_ _ lambda(_ _ sintype('Id'
						     app(app(ID _) _))))
		       _) then ID
	    [] sintype('Id' ID) then ID
	    else {Inspector.inspect ['Grammar.getRuleID: no rule ID found in' F]} 'no rule ID found'
	    end
	 else {Inspector.inspect ['Grammar.getRuleID: body not rectype(...) in' F]} 'body not rectype'
	 end
      else case F
	   of lambda(_ _ Body) then
	      case Body
	      of rectype(...) then
		 case Body.id
		    of deptype(lambda(_ _ sintype('Id'
						 app(ID _)))
			       _) then ID
		 [] deptype(lambda(_ _ lambda(_ _ sintype('Id'
							  app(app(ID _) _))))
			    [objpath(ID1) _]) then ID#ID1
		 else {Inspector.inspect ['Grammar.getRuleID: no rule ID found in' F]} 'no rule ID found'
		 end
	      else {Inspector.inspect ['Grammar.getRuleID: body not rectype(...) in' F]} 'body not rectype'
	      end
	   else {Inspector.inspect ['Grammar.getRuleID: not implemented for this rule' F]} 'rule ID not implemented'
	   end
      end
   end
   
			    
			  
%       local
% 	 Body
%       in
% 	 choice
% 	    F = lambda(_ _ lambda(_ _ Body))
% 	    Body = rectype(...)
% 	    Body.id = deptype(lambda(_ _ lambda(_ _ sintype('Id'
% 							    apply(apply(ID _) _))))
% 			      _)
% 	 [] F = lambda(_ _ Body)
% 	    Body = rectype(...)
% 	    Body.id = deptype(lambda(_ _ sintype('Id'
% 						 apply(ID _)))
% 			      _)
% 	 end
%       end
%    end
   fun{CompileLeftCornerIndexedRules Rules}
      local
	 LCRules = {NewDictionary}
	 AddToLCRules = fun{$ Item}
			local OldVal
			   in
			   {Dictionary.condExchange
			    LCRules
			    {FirstArgCatOfRule Item}
			    nil
			    OldVal
			    Item|OldVal}
			   Item
			end
		     end
      in
	 {Map {Filter Rules fun {$ R} {IsRightBinaryRule R} orelse {IsUnaryRule R} end} AddToLCRules _}
	 LCRules
      end
   end
   fun {AddRulesToIDIndexedLexicon Rules Lexicon}
      {ForAll Rules proc {$ F}
		       local
			  OldVal OldVal1
			  RuleID = {GetRuleID F}
		       in
			  case RuleID
			  of ID#ID1 then
			     {Dictionary.condExchange
			      Lexicon
			      ID
			      nil
			      OldVal
			      lambda(r rectype(id: sintype('Id' ID1)) F)|OldVal}
			     {Dictionary.condExchange
			      Lexicon
			      ID1
			      nil
			      OldVal1
			      rectype(id: sintype('Id' ID1))|OldVal1}
			  else   
			     {Dictionary.condExchange
			      Lexicon
			      RuleID
			      nil
			      OldVal
			      F|OldVal}
			  end
		       end
		    end
      }
      Lexicon
   end
   
   

end
