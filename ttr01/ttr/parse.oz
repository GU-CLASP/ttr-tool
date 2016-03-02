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
   Inspector(inspect new)
   RecordC(monitorArity reflectArity)
   Utils at 'utils.ozf'
   InspectorConfig at 'inspectorconfig.ozf'
   Functions at 'functions.ozf'
   %Records at 'records.ozf'
   Types at 'types.ozf'
   Grammar at 'grammar.ozf'
   QTk at 'x-oz://system/wp/QTk.ozf'
export
   CreateInterface CreateInterfaceDMove CreateDialogueInterface NewChart  Generate ConvertTreeToExplApply ConvertExplAppToTree TokenizeTree TokenizeFunArg EvaluateFunArgExpr  %NewChartFunctionalInput
define
   Gensym = Utils.gensym
   NewEnv = Utils.newEnv
   NewSubEnv = Utils.newSubEnv
   PutEnv = Utils.putEnv
   PutSubEnv = Utils.putSubEnv
   GetEnv = Utils.getEnv
   GetSubEnv = Utils.getSubEnv
%   LastInStream = Utils.lastInStream
%   Monitor = Utils.monitor
   %IsStableRecordC = Utils.isStableRecordC
   InspectorConfigParse = InspectorConfig.inspectorConfigParse
   EmbeddingFunConvert = Functions.embeddingFunConvert
   %CloseRec = Records.closeRec
   %IsOfType = Types.isOfType
   IsSubType = Types.isSubType
   FlattenRelabelRecType = Types.flattenRelabelRecType
   InstantiateType = Types.instantiateType
   %EvalOp = Types.evalOp
   AbbrevDep = Types.abbrevDep
   IsRightBinaryRule = Grammar.isRightBinaryRule
   IsUnaryRule = Grammar.isUnaryRule
   fun {NewChart}
      local
	 Chart = {NewEnv}
	 %LongestEdgesStream
	 %ChartCounts = {NewDictionary}
      in
	 {NewSubEnv Chart edges_by_start}
	 {NewSubEnv Chart edges_by_end}
	 {NewSubEnv Chart chart_counts}
	 {PutEnv Chart current_vertex {NewCell 0}}
	 {InitializeEdgesCurrentVertex Chart}
	 %{PutEnv Chart longest_edges {NewPort LongestEdgesStream}#LongestEdgesStream}
	 %{AddLexEdge 1 InputStream Chart Lex LCRules ChartCounts InputWords}
	 Chart
      end
   end
   proc {ReInitChart Chart}
      {NewSubEnv Chart edges_by_start}
      {NewSubEnv Chart edges_by_end}
      {NewSubEnv Chart chart_counts}
      {PutEnv Chart current_vertex {NewCell 0}}
      {InitializeEdgesCurrentVertex Chart}
   end
      
   fun {CurrentVertex Chart}
      {Access {GetEnv Chart current_vertex}}
   end
   proc {InitializeEdgesCurrentVertex Chart}
      local
	 N = {CurrentVertex Chart}
      in
	 {PutSubEnv Chart edges_by_start N nil}
	 {PutSubEnv Chart edges_by_end N nil}
      end
   end
   proc {AddEdge Edge Chart}
      local
	 Start = {GetEdgeStart Edge}
	 End = {GetEdgeEnd Edge}
      in
	 {PutSubEnv Chart edges_by_start Start Edge|{GetSubEnv Chart edges_by_start Start}}
	 {PutSubEnv Chart edges_by_end  End Edge|{GetSubEnv Chart edges_by_end End}}
%      {Dictionary.exchange {GetEnv Chart edges_by_start} {GetEdgeStart Edge} OldStartEdges Edge|OldStartEdges}
	% {Dictionary.exchange {GetEnv Chart edges_by_end} {GetEdgeEnd Edge} OldEndEdges Edge|OldEndEdges}
      end
   end
   
   proc {IncrementCurrentVertex Chart}
      {Assign {GetEnv Chart current_vertex} {CurrentVertex Chart}+1}
      {InitializeEdgesCurrentVertex Chart}
   end

   proc {CreateInterface Lex IDLex LCRules LCDRules}
      {CreateInterfaceDMove Lex IDLex LCRules LCDRules nil}
   end
   
   proc {CreateInterfaceDMove Lex IDLex LCRules LCDRules DMoves}
      local
	 InputStream
	 InputPort = {NewPort InputStream}
	 InputWindow = {Inspector.new options(inspectorWidth: 400 inspectorHeight: 100) }
	 %ChartWindow = {Inspector.new options(inspectorWidth: 800 inspectorHeight: 600)}
	 ResWindow = {Inspector.new options(inspectorWidth: 400 inspectorHeight: 400)}
	 ResStream
	 ResPort = {NewPort ResStream}
	 ShowAllEdges
	 ShowLongestEdges
	 ShowLongestEdgesCatD
	 ShowLongestEdgesCatS
	 ShowLongestEdgesCatVP
	 ShowLongestEdgesCatNP
	 ShowCompleteEdge
	 ShowEdgeContents
	 ShowEdgeContentsCnt
	 ShowEdgeContentsCntInst
	 ShowEdgeContentsCntInstFlat
	 ShowEdgeContentsCntInstFlatAbbr
	 ShowDMove
	 InputWords
	 InputID
	 InputFunArg
	 InputDMove
	 OutputRecType
	 OutputPhon
	 OutputCnt
	 OutputCntInst
	 OutputCntInstFlat
	 OutputCntInstFlatAbbr
	 E R
	 Desc=td(lr(glue:w
		    menubutton(glue: nw
			       ipadx: 5
			       text:"Chart"
			       menu:menu(command(text:"New chart"
						 action: proc {$} {ReInitChart Chart} end)
					 % command(text:"Close chart"
% 						action: toplevel#close
% 						   % proc {$}
% % 							   {InputWindow close}
% % 							   {ResWindow close}
% % 							end
% 					       )
					)
			       )
		    menubutton(glue: nw
			       ipadx: 5
			       text:"Chart Show"
			       menu: menu(radiobutton(text:"Show all edges"
						      group: edges_to_show
						      init: false
						      handle: ShowAllEdges)
					  radiobutton(text:"Show all longest edges"
						      group: edges_to_show
						      init: true
						      handle: ShowLongestEdges)
					  cascade(text:"Show longest edges with cat..."
						  menu: menu(radiobutton(text:"d"
									 group: edges_to_show
									 init:false
									 handle: ShowLongestEdgesCatD)
							   radiobutton(text:"s"
									 group: edges_to_show
									 init:false
									 handle: ShowLongestEdgesCatS)
							     radiobutton(text:"vp"
									 group: edges_to_show
									 init:false
									 handle: ShowLongestEdgesCatVP)
							     radiobutton(text:"np"
									 group: edges_to_show
									 init:false
									 handle: ShowLongestEdgesCatNP)
							    )
						 )
					 )
			      )
		    menubutton(glue: nw
			       ipadx: 5
			       text: "Edge Show"
			       menu: menu(radiobutton(text:"Show complete edge"
						      group: edge_part_to_show
						      init: true
						      handle: ShowCompleteEdge)
					  radiobutton(text:"Show edge contents"
						      group: edge_part_to_show
						      init: false
						      handle: ShowEdgeContents)
					  radiobutton(text:"Show dialogue move"
						      group: edge_part_to_show
						      init: false
						      handle: ShowDMove)
					  cascade(text: "Show edge contents feature (only D or S edges)..."
						  menu: menu(cascade(text: "cnt"
								     menu: menu(radiobutton(text: "as is"
											    group: edge_part_to_show
											    init: false
											    handle: ShowEdgeContentsCnt)
										radiobutton(text: "instantiated"
											    group: edge_part_to_show
											    init: false
											    handle: ShowEdgeContentsCntInst)
										radiobutton(text: "instantiated and flattened"
											    group: edge_part_to_show
											    init: false
											    handle: ShowEdgeContentsCntInstFlat)
										radiobutton(text: "instantiated, flattened, abbreviated dep types"
											    group: edge_part_to_show
											    init: false
											    handle: ShowEdgeContentsCntInstFlatAbbr)
									       )
								    )
							    )
						  )
					 )
			      )
		    menubutton(glue: nw
			       ipadx: 5
			       text: "Input"
			       menu: menu(radiobutton(text:"Words (phonology)"
						      group: input
						      init: true
						      handle: InputWords)
					  radiobutton(text:"ID structure (e.g. s_np_vp('Kim' 'Run'))"
						      group: input
						      init: false
						      handle: InputID)
					  radiobutton(text:"FunArg structure (cnt, e.g. 'Kim'('Run'))"
						      group: input
						      init: false
						      handle: InputFunArg)
					  radiobutton(text:"DMove (e.g. presentEval('Nice' 'Bear'))"
						      group: input
						      init: false
						      handle: InputDMove)
					 )
			      )
		    menubutton(glue: nw
			       ipadx: 5
			       text: "Generation output"
			       menu: menu(radiobutton(text:"Whole record type"
						      group: output
						      init: false
						      handle: OutputRecType)
					  radiobutton(text:"phon (Phonology)"
						      group: output
						      init: true
						      handle: OutputPhon)
					  % radiobutton(text:"cnt (content)"
% 						      group: output
% 						      init: false
% 						      handle:OutputCnt)
					  cascade(text: "cnt (content)"
						  menu: menu(radiobutton(text: "as is"
									 group: output
									 init: false
									 handle: OutputCnt)
							     radiobutton(text: "instantiated"
									 group: output
									 init: false
									 handle: OutputCntInst)
							     radiobutton(text: "instantiated and flattened"
									 group: output
									 init: false
									 handle: OutputCntInstFlat)
							     radiobutton(text: "instantiated, flattened, abbreviated dep types"
									 group: output
									 init: false
									 handle: OutputCntInstFlatAbbr)
							    )
						 )
					 )
			       )
		   )
		 text(tdscrollbar:true
		      lrscrollbar:true
		      background:white
	     %init:"Hello world"
		      handle:E
		      return:R
		      height:5
		      width:70
		     )
		)
	 Chart = {NewChart}	 
	 %  Chart = {NewEnv}
% 	 {NewSubEnv Chart edges_by_start}
% 	  LongestEdgesStream
% % 	 LongestEdgesPort = {NewPort LongestEdgesStream}
% 	 {PutEnv Chart longest_edges {NewPort LongestEdgesStream}#LongestEdgesStream}
% 	 %{PutEnv Chart longest_edges_count {NewCell 0}}
% 	 ChartCounts = {NewDictionary}
%	 LongestEdges = {NewCell nil}
	% MonitorThread = {NewCell none}
      in
	 {InspectorConfigParse}
	 {InputWindow inspect(InputStream)}
	 %{Inspector.inspect Chart}
	 %{ChartWindow inspect(Chart)}
	 {{QTk.build td(title:"Parse Input" Desc)} show}
	 {E bind(event:"<Return>"
		 action:proc {$}
			  %  local
% 			      MThread = {Access MonitorThread}
% 			   in   
% 			      case MThread
% 			      of none then skip
% 			      else {Thread.terminate MThread}
% 				 {Assign MonitorThread none}
% 			      end
% 			   end
			   if {InputWords get(1:$)} then
			      local
				 Input = {Tokenize {E get($)} nil}
			      in
				 {AddInputItems
				  Input InputPort}
				 {AddInputToChart Input Chart Lex LCRules LCDRules}
				 {E set("")}
			      end
			      if {ShowAllEdges get(1:$)} then
				 {Send ResPort
				  if {ShowCompleteEdge get(1:$)} then
				     %{Map {Dictionary.items {GetEnv Chart edges_by_start}} fun {$ I} I.2 end}
				     {Flatten {Dictionary.items {GetEnv Chart edges_by_start}}}
				  elseif {ShowEdgeContents get(1:$)} then
				     {Flatten {Map {Dictionary.items {GetEnv Chart edges_by_start}}
					       fun {$ I} {Map I GetEdgeContents} end}}
				  else {Dictionary.items {GetEnv Chart edges_by_start}}
				  end
				 } 
			      elseif {ShowLongestEdges get(1:$)} then
				 {Send ResPort
				  if {ShowCompleteEdge get(1:$)} then
				     {GetLongestEdges Chart}
				  elseif {ShowEdgeContents get(1:$)} then
				     {Map  {GetLongestEdges Chart} GetEdgeContents}
				  elseif {ShowDMove get(1:$)} then
				     {Map {GetLongestEdges Chart} fun {$ E} {DMoves.2.1 {ConvertExplAppToTree {InstantiateType {GetEdgeContents E}.id}}} end}
				  else {GetLongestEdges Chart}
				  end
				 }
			      elseif {ShowLongestEdgesCatS get(1:$)} then
				 local
				    Res = {Filter {GetLongestEdges Chart}
					   fun {$ Edge}
					      case {GetEdgeCat Edge}
					      of s then true
					      else false
					      end
					   end
					  }
				 in
				    {Send ResPort
				     if {ShowCompleteEdge get(1:$)} then
					Res
				     elseif {ShowEdgeContents get(1:$)} then
					{Map Res GetEdgeContents}
				     elseif {ShowEdgeContentsCnt get(1:$)} then
					{Map Res fun {$ E} {GetEdgeContents E}.cnt end}
				     elseif {ShowEdgeContentsCntInst get(1:$)} then
					{Map Res fun {$ E} {InstantiateType {GetEdgeContents E}.cnt} end}
				     elseif {ShowEdgeContentsCntInstFlat get(1:$)} then
					{Map Res fun {$ E} {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}} end}
				     elseif {ShowEdgeContentsCntInstFlatAbbr get(1:$)} then
					{Map Res fun {$ E} {AbbrevDep {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}}} end}
				     elseif {ShowDMove get(1:$)} then
					{Map Res fun {$ E} {DMoves.2.1 {ConvertExplAppToTree {InstantiateType {GetEdgeContents E}.id}}} end}
				     else Res
				     end
				    }
				 end
			      elseif {ShowLongestEdgesCatD get(1:$)} then
				 local
				    Res = {Filter {GetLongestEdges Chart}
					   fun {$ Edge}
					      case {GetEdgeCat Edge}
					      of d then true
					      else false
					      end
					   end
					  }
				 in
				    {Send ResPort
				     if {ShowCompleteEdge get(1:$)} then
					Res
				     elseif {ShowEdgeContents get(1:$)} then
					{Map Res GetEdgeContents}
				     elseif {ShowEdgeContentsCnt get(1:$)} then
					{Map Res fun {$ E} {GetEdgeContents E}.cnt end}
				     elseif {ShowEdgeContentsCntInst get(1:$)} then
					{Map Res fun {$ E} {InstantiateType {GetEdgeContents E}.cnt} end}
				     elseif {ShowEdgeContentsCntInstFlat get(1:$)} then
					{Map Res fun {$ E} {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}} end}
				     elseif {ShowEdgeContentsCntInstFlatAbbr get(1:$)} then
					{Map Res fun {$ E} {AbbrevDep {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}}} end}
				     elseif {ShowDMove get(1:$)} then
					{Map Res fun {$ E} {DMoves.2.1 {ConvertExplAppToTree {InstantiateType {GetEdgeContents E}.id}}} end}
				     else Res
				     end
				    }
				 end
			      elseif {ShowLongestEdgesCatVP get(1:$)} then
				 local
				    Res = {Filter {GetLongestEdges Chart}
					   fun {$ Edge}
					      case {GetEdgeCat Edge}
					      of vp then true
					      else false
					      end
					   end
					  }
				 in
				    {Send ResPort
				     if {ShowEdgeContents get(1:$)} then
					{Map Res GetEdgeContents}
				     else Res
				     end
				    }
				 end
			      elseif {ShowLongestEdgesCatNP get(1:$)} then
				 local
				    Res = {Filter {GetLongestEdges Chart}
					   fun {$ Edge}
					      case {GetEdgeCat Edge}
					      of np then true
					      else false
					      end
					   end
					  }
				 in
				    {Send ResPort
				     if {ShowEdgeContents get(1:$)} then
					{Map Res GetEdgeContents}
				     else Res
				     end
				    }
				 end
			      end
			   elseif {InputID get(1:$)} then
			      local
				 Input = {TokenizeFunArg {E get($)}}
				 Res = {EvaluateIDExpr {ConvertTreeToExplApply Input} IDLex}
			      in
				 %{Inspector.inspect {E get($)}}
				 {Send InputPort Input}
				 {Send ResPort
				  if {OutputRecType get(1:$)} then Res
				  elseif {OutputPhon get(1:$)} then {Map Res fun {$ R} {InstantiateType R.phon} end}
				  elseif {OutputCnt get(1:$)} then {Map Res fun {$ R} R.cnt end}
				  elseif {OutputCntInst get(1:$)} then {Map Res fun {$ R} {InstantiateType R.cnt} end}
				  elseif {OutputCntInstFlat get(1:$)} then {Map Res fun {$ R} {FlattenRelabelRecType {InstantiateType R.cnt}} end}
				  elseif {OutputCntInstFlatAbbr get(1:$)} then {Map Res fun {$ R} {AbbrevDep {FlattenRelabelRecType {InstantiateType R.cnt}}} end}
				  else Res
				  end
				 }
				 {E set("")}
			      end
			   elseif {InputFunArg get(1:$)} then
			      local
				 Input = {TokenizeFunArg {E get($)}}
				 %{Inspector.inspect Input}
				 %{Inspector.inspect {NewChartFunctionalInput IDLex LCRules cnt Input}}
				 Res = {Filter {EvaluateFunArgExpr {ConvertTreeToExplApply Input} IDLex LCRules LCDRules}
					fun {$ R}
					   case {CondSelect R cat nil}
					   of sintype('Cat' d) then true
					   else false
					   end
					end
					}
				 % {GetSubEnv
% 					{NewChartFunctionalInput IDLex LCRules cnt Input}
% 					edges_by_start
% 					0}.2 
				 
			      in
				 {Send InputPort Input}
				 {Send ResPort
				  if {OutputRecType get(1:$)} then Res
				  elseif {OutputPhon get(1:$)} then {Map Res fun {$ R} {InstantiateType R.phon} end}
				  elseif {OutputCnt get(1:$)} then {Map Res fun {$ R} R.cnt end}
				  elseif {OutputCntInst get(1:$)} then {Map Res fun {$ R} {InstantiateType R.cnt} end}
				  elseif {OutputCntInstFlat get(1:$)} then {Map Res fun {$ R} {FlattenRelabelRecType {InstantiateType R.cnt}} end}
				  elseif {OutputCntInstFlatAbbr get(1:$)} then {Map Res fun {$ R} {AbbrevDep {FlattenRelabelRecType {InstantiateType R.cnt}}} end}
				  else Res
				  end
				 }
				 % thread
% 				    {ForAll Res proc {$ Edge}
% 						   {Send ResPort
% 						    if {OutputRecType get(1:$)} then {GetEdgeContents Edge}
% 						    elseif {OutputPhon get(1:$)} then {InstantiateType {GetEdgeContents Edge}.phon}
% 						    elseif {OutputCnt get(1:$)} then {GetEdgeContents Edge}.cnt
% 						    elseif {OutputCntInst get(1:$)} then {InstantiateType {GetEdgeContents Edge}.cnt}
% 						    elseif {OutputCntInstFlat get(1:$)} then {FlattenRelabelRecType {InstantiateType {GetEdgeContents Edge}.cnt}}
% 						    elseif {OutputCntInstFlatAbbr get(1:$)} then {AbbrevDep {FlattenRelabelRecType {InstantiateType {GetEdgeContents Edge}.cnt}}}
% 						    else Edge
% 						    end
% 						   }
% 						end
% 				    }
% 				 end
				 {E set("")}
			      end
			   elseif {InputDMove get(1:$)} then
			      local
				 Input = {TokenizeFunArg {E get($)}}
				 Res = {EvaluateIDExpr {ConvertTreeToExplApply {DMoves.1 Input}} IDLex}
			      in
				 {Send InputPort Input}
				 {Send ResPort
				  if {OutputRecType get(1:$)} then Res
				  elseif {OutputPhon get(1:$)} then {Map Res fun {$ R} {InstantiateType R.phon} end}
				  elseif {OutputCnt get(1:$)} then {Map Res fun {$ R} R.cnt end}
				  elseif {OutputCntInst get(1:$)} then {Map Res fun {$ R} {InstantiateType R.cnt} end}
				  elseif {OutputCntInstFlat get(1:$)} then {Map Res fun {$ R} {FlattenRelabelRecType {InstantiateType R.cnt}} end}
				  elseif {OutputCntInstFlatAbbr get(1:$)} then {Map Res fun {$ R} {AbbrevDep {FlattenRelabelRecType {InstantiateType R.cnt}}} end}
				  else Res
				  end
				 }
				 {E set("")}
			      end
			   end
			end
		)
	 }
%	 {AddLexEdge 1 InputStream Chart Lex LCRules ChartCounts}
	 %{ShowResult 1 InputStream InputWindow}
	 {ShowResult 1 ResStream ResWindow} 
	 {Wait R}
%         {CloseRec Input} = Input
	 %{CloseRec Chart} = Chart
	 
	 % {CntWindow inspect({Map {GetLongestEdges Chart}
% 			    fun {$ E} {GetEdgeContents E}.cnt end}) }

      end
   end
   proc {CreateDialogueInterface Lex IDLex LCRules LCDRules}
      local
	 InputStream
	 InputPort = {NewPort InputStream}
	 InputWindow = {Inspector.new options(inspectorWidth: 400 inspectorHeight: 100) }
	 %ChartWindow = {Inspector.new options(inspectorWidth: 800 inspectorHeight: 600)}
	 ResWindow = {Inspector.new options(inspectorWidth: 400 inspectorHeight: 400)}
	 ResStream
	 ResPort = {NewPort ResStream}
	 % ShowAllEdges
% 	 ShowLongestEdges
% 	 ShowLongestEdgesCatD
% 	 ShowLongestEdgesCatS
% 	 ShowLongestEdgesCatVP
% 	 ShowLongestEdgesCatNP
% 	 ShowCompleteEdge
% 	 ShowEdgeContents
% 	 ShowEdgeContentsCnt
% 	 ShowEdgeContentsCntInst
% 	 ShowEdgeContentsCntInstFlat
% 	 ShowEdgeContentsCntInstFlatAbbr
% 	 InputWords
% 	 InputID
% 	 InputFunArg
% 	 OutputRecType
% 	 OutputPhon
% 	 OutputCnt
% 	 OutputCntInst
% 	 OutputCntInstFlat
% 	 OutputCntInstFlatAbbr
	 E R
	 Desc=td(
		 %lr(glue:w
% 		    menubutton(glue: nw
% 			       ipadx: 5
% 			       text:"Chart"
% 			       menu:menu(command(text:"New chart"
% 						 action: proc {$} {ReInitChart Chart} end)
% 					)
% 			       )
% 		    menubutton(glue: nw
% 			       ipadx: 5
% 			       text:"Chart Show"
% 			       menu: menu(radiobutton(text:"Show all edges"
% 						      group: edges_to_show
% 						      init: false
% 						      handle: ShowAllEdges)
% 					  radiobutton(text:"Show all longest edges"
% 						      group: edges_to_show
% 						      init: true
% 						      handle: ShowLongestEdges)
% 					  cascade(text:"Show longest edges with cat..."
% 						  menu: menu(radiobutton(text:"d"
% 									 group: edges_to_show
% 									 init:false
% 									 handle: ShowLongestEdgesCatD)
% 							   radiobutton(text:"s"
% 									 group: edges_to_show
% 									 init:false
% 									 handle: ShowLongestEdgesCatS)
% 							     radiobutton(text:"vp"
% 									 group: edges_to_show
% 									 init:false
% 									 handle: ShowLongestEdgesCatVP)
% 							     radiobutton(text:"np"
% 									 group: edges_to_show
% 									 init:false
% 									 handle: ShowLongestEdgesCatNP)
% 							    )
% 						 )
% 					 )
% 			      )
% 		    menubutton(glue: nw
% 			       ipadx: 5
% 			       text: "Edge Show"
% 			       menu: menu(radiobutton(text:"Show complete edge"
% 						      group: edge_part_to_show
% 						      init: true
% 						      handle: ShowCompleteEdge)
% 					  radiobutton(text:"Show edge contents"
% 						      group: edge_part_to_show
% 						      init: false
% 						      handle: ShowEdgeContents)
% 					  cascade(text: "Show edge contents feature (only D or S edges)..."
% 						  menu: menu(cascade(text: "cnt"
% 								     menu: menu(radiobutton(text: "as is"
% 											    group: edge_part_to_show
% 											    init: false
% 											    handle: ShowEdgeContentsCnt)
% 										radiobutton(text: "instantiated"
% 											    group: edge_part_to_show
% 											    init: false
% 											    handle: ShowEdgeContentsCntInst)
% 										radiobutton(text: "instantiated and flattened"
% 											    group: edge_part_to_show
% 											    init: false
% 											    handle: ShowEdgeContentsCntInstFlat)
% 										radiobutton(text: "instantiated, flattened, abbreviated dep types"
% 											    group: edge_part_to_show
% 											    init: false
% 											    handle: ShowEdgeContentsCntInstFlatAbbr)
% 									       )
% 								    )
% 							    )
% 						  )
% 					 )
% 			      )
% 		    menubutton(glue: nw
% 			       ipadx: 5
% 			       text: "Input"
% 			       menu: menu(radiobutton(text:"Words (phonology)"
% 						      group: input
% 						      init: true
% 						      handle: InputWords)
% 					  radiobutton(text:"ID structure (e.g. s_np_vp('Kim' 'Run'))"
% 						      group: input
% 						      init: false
% 						      handle: InputID)
% 					  radiobutton(text:"FunArg structure (cnt, e.g. 'Kim'('Run'))"
% 						      group: input
% 						      init: false
% 						      handle: InputFunArg)
% 					 )
% 			      )
% 		    menubutton(glue: nw
% 			       ipadx: 5
% 			       text: "Generation output"
% 			       menu: menu(radiobutton(text:"Whole record type"
% 						      group: output
% 						      init: false
% 						      handle: OutputRecType)
% 					  radiobutton(text:"phon (Phonology)"
% 						      group: output
% 						      init: true
% 						      handle: OutputPhon)
% 					  % radiobutton(text:"cnt (content)"
% % 						      group: output
% % 						      init: false
% % 						      handle:OutputCnt)
% 					  cascade(text: "cnt (content)"
% 						  menu: menu(radiobutton(text: "as is"
% 									 group: output
% 									 init: false
% 									 handle: OutputCnt)
% 							     radiobutton(text: "instantiated"
% 									 group: output
% 									 init: false
% 									 handle: OutputCntInst)
% 							     radiobutton(text: "instantiated and flattened"
% 									 group: output
% 									 init: false
% 									 handle: OutputCntInstFlat)
% 							     radiobutton(text: "instantiated, flattened, abbreviated dep types"
% 									 group: output
% 									 init: false
% 									 handle: OutputCntInstFlatAbbr)
% 							    )
% 						 )
% 					 )
% 			       )
% 		   )
		 text(tdscrollbar:true
		      lrscrollbar:true
		      background:white
	     %init:"Hello world"
		      handle:E
		      return:R
		      height:5
		      width:70
		     )
		)
	 Chart = {NewChart}	 
      in
%	 {InspectorConfigParse}
	 {InputWindow inspect(InputStream)}
	 {{QTk.build td(title:"Dialogue Input" Desc)} show}
	 {E bind(event:"<Return>"
		 action:proc {$}
			   local
			      Input = {Tokenize {E get($)} nil}
			      Res
			   in
			      {Send ResPort Input}
			      {AddInputItems
			       Input InputPort}
			      {AddInputToChart Input Chart Lex LCRules LCDRules}
			      Res = {Map {GetLongestEdges Chart} GetEdgeContents}
			      {Send ResPort  {Filter {Map Res fun {$ R} {InstantiateType {CondSelect R phon bot}} end}
					      fun {$ X}
						 case X of null then false else true end end}}
			      {E set("")}
			   end
			end
		)
	  }
% 			      if {ShowAllEdges get(1:$)} then
% 				 {Send ResPort
% 				  if {ShowCompleteEdge get(1:$)} then
% 				     %{Map {Dictionary.items {GetEnv Chart edges_by_start}} fun {$ I} I.2 end}
% 				     {Flatten {Dictionary.items {GetEnv Chart edges_by_start}}}
% 				  elseif {ShowEdgeContents get(1:$)} then
% 				     {Flatten {Map {Dictionary.items {GetEnv Chart edges_by_start}}
% 					       fun {$ I} {Map I GetEdgeContents} end}}
% 				  else {Dictionary.items {GetEnv Chart edges_by_start}}
% 				  end
% 				 } 
% 			      elseif {ShowLongestEdges get(1:$)} then
% 				 {Send ResPort
% 				  if {ShowCompleteEdge get(1:$)} then
% 				     {GetLongestEdges Chart}
% 				  elseif {ShowEdgeContents get(1:$)} then
% 				     {Map  {GetLongestEdges Chart} GetEdgeContents}
% 				  else {GetLongestEdges Chart}
% 				  end
% 				 }
% 			      elseif {ShowLongestEdgesCatS get(1:$)} then
% 				 local
% 				    Res = {Filter {GetLongestEdges Chart}
% 					   fun {$ Edge}
% 					      case {GetEdgeCat Edge}
% 					      of s then true
% 					      else false
% 					      end
% 					   end
% 					  }
% 				 in
% 				    {Send ResPort
% 				     if {ShowCompleteEdge get(1:$)} then
% 					Res
% 				     elseif {ShowEdgeContents get(1:$)} then
% 					{Map Res GetEdgeContents}
% 				     elseif {ShowEdgeContentsCnt get(1:$)} then
% 					{Map Res fun {$ E} {GetEdgeContents E}.cnt end}
% 				     elseif {ShowEdgeContentsCntInst get(1:$)} then
% 					{Map Res fun {$ E} {InstantiateType {GetEdgeContents E}.cnt} end}
% 				     elseif {ShowEdgeContentsCntInstFlat get(1:$)} then
% 					{Map Res fun {$ E} {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}} end}
% 				     elseif {ShowEdgeContentsCntInstFlatAbbr get(1:$)} then
% 					{Map Res fun {$ E} {AbbrevDep {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}}} end}
% 				     else Res
% 				     end
% 				    }
% 				 end
% 			      elseif {ShowLongestEdgesCatD get(1:$)} then
% 				 local
% 				    Res = {Filter {GetLongestEdges Chart}
% 					   fun {$ Edge}
% 					      case {GetEdgeCat Edge}
% 					      of d then true
% 					      else false
% 					      end
% 					   end
% 					  }
% 				 in
% 				    {Send ResPort
% 				     if {ShowCompleteEdge get(1:$)} then
% 					Res
% 				     elseif {ShowEdgeContents get(1:$)} then
% 					{Map Res GetEdgeContents}
% 				     elseif {ShowEdgeContentsCnt get(1:$)} then
% 					{Map Res fun {$ E} {GetEdgeContents E}.cnt end}
% 				     elseif {ShowEdgeContentsCntInst get(1:$)} then
% 					{Map Res fun {$ E} {InstantiateType {GetEdgeContents E}.cnt} end}
% 				     elseif {ShowEdgeContentsCntInstFlat get(1:$)} then
% 					{Map Res fun {$ E} {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}} end}
% 				     elseif {ShowEdgeContentsCntInstFlatAbbr get(1:$)} then
% 					{Map Res fun {$ E} {AbbrevDep {FlattenRelabelRecType {InstantiateType {GetEdgeContents E}.cnt}}} end}
% 				     else Res
% 				     end
% 				    }
% 				 end
% 			      elseif {ShowLongestEdgesCatVP get(1:$)} then
% 				 local
% 				    Res = {Filter {GetLongestEdges Chart}
% 					   fun {$ Edge}
% 					      case {GetEdgeCat Edge}
% 					      of vp then true
% 					      else false
% 					      end
% 					   end
% 					  }
% 				 in
% 				    {Send ResPort
% 				     if {ShowEdgeContents get(1:$)} then
% 					{Map Res GetEdgeContents}
% 				     else Res
% 				     end
% 				    }
% 				 end
% 			      elseif {ShowLongestEdgesCatNP get(1:$)} then
% 				 local
% 				    Res = {Filter {GetLongestEdges Chart}
% 					   fun {$ Edge}
% 					      case {GetEdgeCat Edge}
% 					      of np then true
% 					      else false
% 					      end
% 					   end
% 					  }
% 				 in
% 				    {Send ResPort
% 				     if {ShowEdgeContents get(1:$)} then
% 					{Map Res GetEdgeContents}
% 				     else Res
% 				     end
% 				    }
% 				 end
% 			      end
% 			   elseif {InputID get(1:$)} then
% 			      local
% 				 Input = {TokenizeFunArg {E get($)}}
% 				 Res = {EvaluateIDExpr Input IDLex}
% 			      in
% 				 %{Inspector.inspect {E get($)}}
% 				 {Send InputPort Input}
% 				 {Send ResPort
% 				  if {OutputRecType get(1:$)} then Res
% 				  elseif {OutputPhon get(1:$)} then {Map Res fun {$ R} {InstantiateType R.phon} end}
% 				  elseif {OutputCnt get(1:$)} then {Map Res fun {$ R} R.cnt end}
% 				  elseif {OutputCntInst get(1:$)} then {Map Res fun {$ R} {InstantiateType R.cnt} end}
% 				  elseif {OutputCntInstFlat get(1:$)} then {Map Res fun {$ R} {FlattenRelabelRecType {InstantiateType R.cnt}} end}
% 				  elseif {OutputCntInstFlatAbbr get(1:$)} then {Map Res fun {$ R} {AbbrevDep {FlattenRelabelRecType {InstantiateType R.cnt}}} end}
% 				  else Res
% 				  end
% 				 }
% 				 {E set("")}
% 			      end
% 			   elseif {InputFunArg get(1:$)} then
% 			      local
% 				 Input = {TokenizeFunArg {E get($)}}
% 				 %{Inspector.inspect Input}
% 				 %{Inspector.inspect {NewChartFunctionalInput IDLex LCRules cnt Input}}
% 				 Res = {Filter {EvaluateFunArgExpr Input IDLex LCRules LCDRules}
% 					fun {$ R}
% 					   case {CondSelect R cat nil}
% 					   of sintype('Cat' d) then true
% 					   else false
% 					   end
% 					end
% 					}
% 				 % {GetSubEnv
% % 					{NewChartFunctionalInput IDLex LCRules cnt Input}
% % 					edges_by_start
% % 					0}.2 
				 
% 			      in
% 				 {Send InputPort Input}
% 				 {Send ResPort
% 				  if {OutputRecType get(1:$)} then Res
% 				  elseif {OutputPhon get(1:$)} then {Map Res fun {$ R} {InstantiateType R.phon} end}
% 				  elseif {OutputCnt get(1:$)} then {Map Res fun {$ R} R.cnt end}
% 				  elseif {OutputCntInst get(1:$)} then {Map Res fun {$ R} {InstantiateType R.cnt} end}
% 				  elseif {OutputCntInstFlat get(1:$)} then {Map Res fun {$ R} {FlattenRelabelRecType {InstantiateType R.cnt}} end}
% 				  elseif {OutputCntInstFlatAbbr get(1:$)} then {Map Res fun {$ R} {AbbrevDep {FlattenRelabelRecType {InstantiateType R.cnt}}} end}
% 				  else Res
% 				  end
% 				 }
				 % thread
% 				    {ForAll Res proc {$ Edge}
% 						   {Send ResPort
% 						    if {OutputRecType get(1:$)} then {GetEdgeContents Edge}
% 						    elseif {OutputPhon get(1:$)} then {InstantiateType {GetEdgeContents Edge}.phon}
% 						    elseif {OutputCnt get(1:$)} then {GetEdgeContents Edge}.cnt
% 						    elseif {OutputCntInst get(1:$)} then {InstantiateType {GetEdgeContents Edge}.cnt}
% 						    elseif {OutputCntInstFlat get(1:$)} then {FlattenRelabelRecType {InstantiateType {GetEdgeContents Edge}.cnt}}
% 						    elseif {OutputCntInstFlatAbbr get(1:$)} then {AbbrevDep {FlattenRelabelRecType {InstantiateType {GetEdgeContents Edge}.cnt}}}
% 						    else Edge
% 						    end
% 						   }
% 						end
% 				    }
% 				 end
%			      end
% 			      {E set("")}
% 			   end
% 			end
% 		)
% 	 }
%	 {AddLexEdge 1 InputStream Chart Lex LCRules ChartCounts}
	 %{ShowResult 1 InputStream InputWindow}
	 {ShowResult 1 ResStream ResWindow} 
	 {Wait R}
%         {CloseRec Input} = Input
	 %{CloseRec Chart} = Chart
	 
	 % {CntWindow inspect({Map {GetLongestEdges Chart}
% 			    fun {$ E} {GetEdgeContents E}.cnt end}) }

      end
   end
   proc {AddInputToChart Input Chart Lex LCRules LCDRules}
      {ForAll Input proc {$ X} {AddLexItem X Chart Lex LCRules} end}
      case Input of nil then skip else {TryToCombineLongestEdges Chart LCDRules} end
   end
   
   proc {AddLexItem X Chart Lex LCRules}
      local
	 N = {CurrentVertex Chart}
      in
	 %{Inspector.inspect N}
	 {IncrementCurrentVertex Chart}
	 %{Inspector.inspect N}
	 {ForAll {Dictionary.condGet Lex X [rectype(phon: sintype('Phon' [X]))]}
	  proc {$ C}
	     local
		CurrentEdgeLabel = {Gensym edge {GetEnv Chart chart_counts}}
		NewEdge = edge(CurrentEdgeLabel N N+1 C)
	     in
		%{Inspector.inspect NewEdge}
		{AddEdge NewEdge Chart}
		%{Inspector.inspect [addEdge Chart]}
		{TryToCombine NewEdge Chart Lex LCRules}
		%{Inspector.inspect [tryToCombine Chart]}
		{AddLCRuleEdges NewEdge Chart Lex LCRules}
		%{Inspector.inspect [addLCRuleEdges Chart]}
	     end
	  end
	 }
      end
   end
   proc {TryToCombine Edge Chart Lex LCRules}
      {ForAll {GetSubEnv Chart edges_by_end {GetEdgeStart Edge}}
       proc {$ E}
	  % case {GetEdgeContents E}
% 	  of lambda(_ T _) then
% 	     %if T.cat == sintype('Cat' pp) then
% 		{Inspector.inspect E#Edge}
% 		{Inspector.inspect {IsSubType {GetEdgeContents Edge} T}}
% 	     %else skip
% 	     %end
% 	  else skip
% 	  end
		     
	  case {GetEdgeContents E}
	  of lambda(_ T _) then  %Active edge
	     if {IsSubType {GetEdgeContents Edge} T} then
		local
		   NewEdge = edge({Gensym edge {GetEnv Chart chart_counts}}
				  {GetEdgeStart E}
				  {GetEdgeEnd Edge}
				  {EmbeddingFunConvert
				   {GetEdgeContents E}
				   {GetEdgeContents Edge}})
		in
		   {AddEdge NewEdge Chart}
		  % {Inspector.inspect ['in' tryToCombine after addEdge NewEdge added]}
		   case {GetEdgeContents NewEdge}
		   of rectype(...) then   %Inactive edge
		      {TryToCombine NewEdge Chart Lex LCRules}
		      {AddLCRuleEdges NewEdge Chart Lex LCRules}
		   else skip
		   end
		end
	     else skip
	     end
	  else skip
	  end
       end
      }
   end

   proc {TryToCombineLongestEdges Chart LCDRules}
   %    {ForAll {GetLongestEdges Chart}
%        proc {$ E}
% 	  {ApplyUnaryLongestEdge E Chart LCDRules}
%        end
%       }
%       {TryToCombineLongestEdges1 {GetLongestEdges Chart} Chart LCDRules}
%    end
      local
	 LongestEdges = {GetLongestEdges Chart}
      in
	 case LongestEdges
	 of nil then skip
	 [] [_] then skip %{ApplyUnaryLongestEdge E Chart LCDRules}
	 else {TryToCombineLongestEdges1 LongestEdges Chart LCDRules}
	 end
      end
   end
   proc {TryToCombineLongestEdges1 LongestEdges Chart LCDRules}
      case LongestEdges
      of nil then skip
      [] [_] then skip
      [] Edge1|Edge2|Rst then
	 if {GetEdgeEnd Edge1} == {GetEdgeStart Edge2} then
	    local
	       CombinedEdges = {CombineLongestEdges Edge1 Edge2 Chart LCDRules}
	    in
	       case CombinedEdges
	       of nil then {TryToCombineLongestEdges1 Edge2|Rst Chart LCDRules}
	       else
		  {ForAll CombinedEdges
		   proc {$ E}{TryToCombineLongestEdges1 E|Rst Chart LCDRules} end}
	       end
	    end
	 elseif {GetEdgeEnd Edge1} == {GetEdgeEnd Edge2} then
	    {TryToCombineLongestEdges1 Edge1|Rst Chart LCDRules}
	    {TryToCombineLongestEdges1 Edge2|Rst Chart LCDRules}
	 else {TryToCombineLongestEdges1 Edge2|Rst Chart LCDRules}
	 end
      end
   end
   % proc {ApplyUnaryLongestEdge E Chart LCDRules}
%       {ForAll {Dictionary.condGet LCDRules {GetEdgeCat E} nil}
%        proc {$ F}
% 	  if {IsUnaryRule F} then
% 	     {AddEdge
% 	      edge({Gensym edge {GetEnv Chart chart_counts}}
% 		   {GetEdgeStart E}
% 		   {GetEdgeEnd E}
% 		   {EmbeddingFunConvert F {GetEdgeContents E}}
% 		  )
% 	      Chart
% 	     }
% 	  else skip
% 	  end
%        end
%       }
%    end
	     
   fun {CombineLongestEdges Edge1 Edge2 Chart LCDRules}
      case {GetEdgeContents Edge1}
      of rectype(...) then
	 {Filter
	  {Map {Dictionary.condGet LCDRules {GetEdgeCat Edge1} nil}
	   fun {$ F}
	      if {IsRightBinaryRule F} then
		 local
		    F1 = {EmbeddingFunConvert F {GetEdgeContents Edge1}}
		    NewEdge
		 in
		    case F1
		    of lambda(_ T _) then
		       if {IsSubType {GetEdgeContents Edge2} T} then
			  NewEdge = edge({Gensym edge {GetEnv Chart chart_counts}} {GetEdgeStart Edge1}
					 {GetEdgeEnd Edge2}
					 {EmbeddingFunConvert F1
					  {GetEdgeContents Edge2}})
			  {AddEdge NewEdge Chart}
			  NewEdge
		       else no_result
		       end
		    else no_result
		    end
		 end
	      else no_result
	      end
	   end
	  }
	  fun {$ E}
	     case E
	     of no_result then false
	     else true
	     end
	  end
	  }
      else nil
      end
   end
   
	     
		
       
   
		   
   proc {AddLCRuleEdges CurrentEdge Chart Lex LCRules}
     %{Inspector.inspect addLCRuleEdges}
      %{Inspector.inspect {Dictionary.condGet LCRules {GetEdgeCat CurrentEdge} nil}}
      {ForAll {Dictionary.condGet LCRules {GetEdgeCat CurrentEdge} nil}
       proc {$ F}
	  % {Inspector.inspect
% 	   [{GetEdgeContents CurrentEdge}.phon F.2.phon {IsSubType {GetEdgeContents CurrentEdge}.phon F.2.phon}]}
			  
	  if {IsSubType {GetEdgeContents CurrentEdge}.phon F.2.phon} then
	     local
		NewEdgeLabel = {Gensym edge {GetEnv Chart chart_counts}}
		%{Inspector.inspect F#{GetEdgeContents CurrentEdge}}
  		%{Inspector.inspect {EmbeddingFunConvert F {GetEdgeContents CurrentEdge}}}
		NewEdge = edge(NewEdgeLabel {GetEdgeStart CurrentEdge}
			       {GetEdgeEnd CurrentEdge}
			       {EmbeddingFunConvert F
				{GetEdgeContents CurrentEdge}})
	     in
	    % {Inspector.inspect NewEdge}
	     %{Inspector.inspect [NewEdge added]}
		case {GetEdgeContents NewEdge}
		of rectype(...) then   %Inactive edge
		   {AddEdge NewEdge Chart}
		   {TryToCombine NewEdge Chart Lex LCRules}
		   {AddLCRuleEdges NewEdge Chart Lex LCRules}
		else {AddEdge NewEdge Chart}
		end
	     end
	  else skip
	  end
       end
      }
   end

   fun {GetEdgeCat Edge}
      local
	 CatInfo = {CondSelect {GetEdgeContents Edge} cat nil}
      in
	 case CatInfo
	 of nil then nil
	 [] sintype('Cat' C) then C
	 else {Inspector.inspect {VirtualString.toAtom "parse.getEdgeCat:"#CatInfo#" not recognized"}}
	 end
      end
   end
   fun {GetRecTypeCat R}
      local
	 CatInfo = {CondSelect R cat nil}
      in
	 case CatInfo
	 of nil then nil
	 [] sintype('Cat' C) then C
	 else {Inspector.inspect {VirtualString.toAtom "Parse.getRecTypeCat:"#CatInfo#" not recognized"}}
	 end
      end
   end
   fun {GetEdgeContents Edge}
      Edge.4
   end
   fun {GetEdgeStart Edge}
      Edge.2
   end
   fun {GetEdgeEnd Edge}
      Edge.3
   end
   % fun {GetEdgeLength Edge}
%       {GetEdgeEnd Edge} - {GetEdgeStart Edge}
%    end
%    fun {IsLongerEdge Edge1 Edge2}
%       if {GetEdgeStart Edge1} == {GetEdgeStart Edge2}
% 	 andthen
% 	 {GetEdgeEnd Edge1} == {GetEdgeEnd Edge2}
%       then false
%       elseif {GetEdgeStart Edge1} =< {GetEdgeStart Edge2}
% 	 andthen
% 	 {GetEdgeEnd Edge2} =< {GetEdgeEnd Edge1}
%       then true
%       else false
%       end
%    end
   fun {Tokenize Str Previous}
      case Str
      of nil then Previous
      [] 32|Rst then {Tokenize Rst Previous} %Space
      [] 10|Rst then {Tokenize Rst Previous} %Return
      else
	 local
	    Wrd Rest
	 in
	    {List.takeDropWhile Str fun {$ X}
				       case X
				       of 32 then false
				       [] 10 then false
				       else true
				       end
				    end
	     Wrd Rest}
	    {Tokenize Rest {Append Previous [{String.toAtom Wrd}]}}
	 end
      end
   end
   
   fun {TokenizeTree Str Previous}
      case Str
      of nil then Previous
      [] 32|Rst then {TokenizeTree Rst Previous} %Space
      [] 10|Rst then {TokenizeTree Rst Previous} %Return
      [] 39|Rst then {TokenizeTree Rst Previous} %'
      [] 40|Rst then  %(
	 local
	    Pred
	    RestPrevious
	 in
	    Previous = Pred|RestPrevious
	    [Pred {TokenizeTree Rst RestPrevious}]
	 end
      [] 41|Rst then {TokenizeTree Rst Previous} %)
      else
	 local
	    Wrd Rest
	 in
	   {List.takeDropWhile Str fun {$ X}
				       case X
				       of 32 then false
				       [] 10 then false
				       [] 39 then false
				       [] 40 then false
				       [] 41 then false
				       else true
				       end
				    end
	    Wrd Rest}
	    {TokenizeTree Rest {Append Previous [{String.toAtom Wrd}]}}
	 end
      end
   end
   
   fun {TokenizeFunArg Str}
      {TokenizeFunArg1 Str nil nil}.1
   end
   fun {TokenizeFunArg1 Str Previous ExtraArgs}
      case Str
      of nil then case Previous of nil then ExtraArgs.1#nil else Previous#nil end
      [] 32|Rst then
	 %{Inspector.inspect Str#Previous#ExtraArgs}
	 {TokenizeFunArg1 {IgnoreWhiteSpace Rst} nil case Previous of nil then ExtraArgs else Previous|ExtraArgs end} %Space
      [] 10|Rst then {TokenizeFunArg1 {IgnoreWhiteSpace Rst} nil case Previous of nil then ExtraArgs else Previous|ExtraArgs end} %Return
      [] 39|Rst then {TokenizeFunArg1 Rst Previous ExtraArgs} %'
      [] 40|Rst then                               %(
	 local
	    Res = {TokenizeFunArg1 {IgnoreWhiteSpace Rst} nil nil}
	 in
	    %{Inspector.inspect Str#Res}
	    %{TokenizeFunArg1 Res.2 {ApplyExtraArgs Res.3 apply(case Previous of nil then ExtraArgs.1 else Previous end Res.1)} ExtraArgs}
	    local
	       Pred = case Previous of nil then ExtraArgs.1 else Previous end
	    in
	       {TokenizeFunArg1 Res.2 {ApplyExtraArgs Res.3 Pred(Res.1)} ExtraArgs}
	    end
	 end
      [] 99|111|110|106|40|Rst then %conj(
	 local
	    Res = {TokenizeFunArg1 {IgnoreWhiteSpace Rst} nil nil}
	 in
	    {TokenizeFunArg1 Res.2 conj(Res.3.1 Res.1) ExtraArgs}
	 end
      [] 41|Rst then
	 %{Inspector.inspect Str#Previous#ExtraArgs}
case Previous of nil then ExtraArgs.1#Rst#ExtraArgs.2 else ExtraArgs.1#Rst#(Previous|ExtraArgs.2) end%Previous#Rst#ExtraArgs end %)
      else
	 local
	    Wrd Rst
	 in
	   {List.takeDropWhile Str fun {$ X}
				       case X
				       of 32 then false
				       [] 10 then false
				       [] 39 then false
				       [] 40 then false
				       [] 41 then false
				       else true
				       end
				    end
	    Wrd Rst}
	    {TokenizeFunArg1 Rst case Wrd of nil then Previous else {String.toAtom Wrd} end ExtraArgs}
	 end
      end
   end
   fun {ApplyExtraArgs ExtraArgs Expr}
      case ExtraArgs
      of nil then Expr
      [] Arg|Rst then %{ApplyExtraArgs Rst apply(Expr Arg)}
	 case {Arity Expr}
	 of nil then {ApplyExtraArgs Rst Expr(Arg)}
	 [] [1] then local P={Label Expr} in {ApplyExtraArgs Rst P(Expr.1 Arg)} end
	 [] [1 2] then local P={Label Expr} in {ApplyExtraArgs Rst P(Expr.1 Expr.2 Arg)} end
	 else {Inspector.inspect ['Parse.applyExtraArgs: not defined for' Expr 'and' ExtraArgs]} 'not defined'
	 end
      end
   end
   
   fun {IgnoreWhiteSpace Str}
      case Str
      of 32|Rst then {IgnoreWhiteSpace Rst} %Space
      [] 10|Rst then {IgnoreWhiteSpace Rst} %Return
      else Str
      end
   end


   
   
  %  proc {TokenizeFunArg DiffList Previous Expr}
%       case DiffList
%       of nil#Rem then Rem = nil Expr = Previous
%       [] 32|Rst#Rem then {TokenizeFunArg Rst#Rem Previous Expr} %Space
%       [] 10|Rst#Rem then {TokenizeFunArg Rst#Rem Previous Expr} %Return
%       [] 40|Rst#Rem then                                        %(
% 	 local
% 	    Rem1
% 	    Expr1
% 	 in
% 	    {TokenizeFunArg Rst#Rem1 nil Expr1}
% 	    {TokenizeFunArg Rem1#Rem apply(Previous Expr1) Expr}
% 	 end
%       [] 41|Rst#Rem then Rem = Rst Expr = Previous
%       else
% 	 local
% 	    Wrd %Rst
% 	 in
% 	    {List.takeDropWhile DiffList.1 fun {$ X}
% 					      case X
% 					      of 32 then false
% 					      [] 10 then false
% 					      [] 40 then false
% 					      [] 41 then false
% 					      else true
% 					      end
% 					   end
% 	     Wrd DiffList.2}
% 	    Expr = {String.toAtom Wrd}
% 	 end
%       end
%    end
   
      
   proc {AddInputItems Tokens InputPort}
      {ForAll Tokens proc {$ X} {Send InputPort X} end}
 %      case Tokens
%       of nil then skip
%       [] X|Rst then
% 	 {Send InputPort X}
% 	% {Delay 500}
% 	 {AddInputItems Rst InputPort}
%       end
   end
   
   % proc {AddInputItems Tokens Input}
%       local
% 	 Arity = {RecordC.reflectArity Input}
%       in
% 	 case Arity
% 	 of nil then {AddInputItemsAfterVertex Tokens Input 0}
% 	 else {AddInputItemsAfterVertex Tokens Input {List.last {Sort {RecordC.reflectArity Input} Value.'<'}}}
% 	 end
%       end
%    end
%    proc {AddInputItemsAfterVertex Tokens Input V}
%       case Tokens
%       of nil then a=a
%       [] X|Rst then
% 	 {Send Input X}
% 	 {AddInputItemsAfterVertex Rst Input V+1}
%       end
%    end
   % fun{GetLongestEdges Chart}
%       {Map
%        {GetLongestEdges1
% 	{Record.toListInd Chart}
% 	nil}
%        fun {$ X} X.1 end}
%    end
   
%    fun {GetLongestEdges1 ChartList Found}
%       case ChartList
%       of nil then Found
%       [] _#Edge|Rst then
% 	 local
% 	    LenEdge = {GetEdgeLength Edge}
% 	 in
% 	    case Found
% 	    of nil then {GetLongestEdges1 Rst [Edge#LenEdge]}
% 	    [] _#LenFound|_ then
% 	       if LenEdge > LenFound then {GetLongestEdges1 Rst [Edge#LenEdge]}
% 	       elseif LenEdge == LenFound then {GetLongestEdges1 Rst Edge#LenEdge|Found}
% 	       else {GetLongestEdges1 Rst Found}
% 	       end
% 	    end
% 	 end
%       else 'Parse.getLongestEdges1 error'
%       end
%    end
   fun {GetLongestEdges Chart}
      {GetLongestEdges1 Chart 0}
   end
   fun {GetLongestEdges1 Chart Vertex}
      local
	 Res = {GetLongestEdgesFromVertex Chart Vertex}
      in
	 case Res
	 of nil then Res
	 else
	    local
	       LastVertex = {GetEdgeEnd Res.1}
	    in
	       if LastVertex == {GetEnv Chart current_vertex} then Res
	       else {Append Res {GetLongestEdges1 Chart LastVertex}}
	       end
	    end
	 end
      end
   end
	 
   fun {GetLongestEdgesFromVertex Chart Vertex}
      {GetLongestEdgesInList {GetSubEnv Chart edges_by_start Vertex} nil}
   end
   fun {GetLongestEdgesInList EdgeList Prev}
      case EdgeList
      of nil then Prev
      [] E|Rst then
	 case Prev
	 of nil then {GetLongestEdgesInList Rst [E]}
	 else
	    local
	       End = {GetEdgeEnd E}
	       PrevEnd = {GetEdgeEnd Prev.1}
	    in
	       if End > PrevEnd then {GetLongestEdgesInList Rst [E]}
	       elseif End == PrevEnd then {GetLongestEdgesInList Rst E|Prev}
	       else {GetLongestEdgesInList Rst Prev}
	       end
	    end
	 end
      else {Inspector.inspect ['Parse.findLongestEdges:' EdgeList 'not a list']} 'not a list'
      end
   end
   
%    fun {AddLongEdge Edge Previous}
%       if {Some Previous fun {$ X} {IsLongerEdge X Edge} end}
%       then %{Inspector.inspect Previous}
% 	 Previous
%       else %{Inspector.inspect Edge|{Filter Previous fun {$ X} {Not{IsLongerEdge Edge X}} end}}
% 	 Edge|{Filter Previous fun {$ X} {Not {IsLongerEdge Edge X}} end}
%       end
%    end
   %    local
% 	 LenEdge = {GetEdgeLength Edge}
%       in
% 	 case Previous
% 	 %of nil then LenEdge#[Edge]
% 	 of LenPrev#L then
% 	    if LenEdge > LenPrev then LenEdge#[Edge]
% 	    elseif LenEdge == LenPrev then LenEdge#(Edge|L)
% 	    else LenPrev#L
% 	    end
% 	 end
%       end
%    end
   proc {ShowResult N ResStream ResWindow}
      {ResWindow inspect({Nth ResStream N})}
      {ShowResult N+1 ResStream ResWindow}
   end
   % fun {EvaluateIDExpr Expr Lexicon}
%       	 case Expr
% 	 of apply(F X) then
% 	    {EmbeddingFunConvert
% 	     {EvaluateIDExpr F Lexicon}
% 	     {EvaluateIDExpr X Lexicon}
% 	    }
% 	 else
% 	    if {IsAtom Expr} then
% 	       {Dictionary.condGet Lexicon Expr [undef]}.1
% 	    end
% 	 end
%    end
   fun {EvaluateIDExpr Expr Lexicon} %Allowing ambig
      case Expr
      of apply(F X) then
	 {Flatten
	  {Map {EvaluateIDExpr F Lexicon}
	   fun {$ F1}
	      {Map {EvaluateIDExpr X Lexicon}
	       fun {$ X1}
		  {EmbeddingFunConvert F1 X1}
	       end
	      }
	   end
	  }
	 }
      else
	 if {IsAtom Expr} then
	    {Dictionary.condGet Lexicon Expr undef}
	 end
      end
   end

   fun {EvaluateFunArgExpr Expr Lexicon Rules DRules}
      case Expr
      of apply(F X) then
	 local
	    BinaryRes = 
	    {Flatten
	     {Map {EvaluateFunArgExpr F Lexicon Rules DRules}
	      fun {$ F1}
		 {Map {EvaluateFunArgExpr X Lexicon Rules DRules}
		  fun {$ X1}
		     {Map {Filter {Dictionary.condGet Rules {GetRecTypeCat F1} nil} IsRightBinaryRule}
		      fun {$ R}
			 local
			    Res = {EmbeddingFunConvert
				   {EmbeddingFunConvert R F1}
				   X1}
			 in
			    if Res.cnt.2 == apply(F1.cnt.2 X1.cnt.2) then Res
			    else nil
			    end
			 end
		      end
		     }
		  end
		 }
	      end
	     }
	    }
	 in
	    {Append BinaryRes
	     {Flatten
	      {Map BinaryRes
	       fun {$ R}
		  {Map {Filter {Dictionary.condGet Rules {GetRecTypeCat R} nil} IsUnaryRule}
		   fun {$ Rule}
		      {EmbeddingFunConvert Rule R}
		   end
		  }
	       end
	      }
	     }
	    }
	 end
      [] conj(R1 R2) then
	 {Flatten
	  {Map {EvaluateFunArgExpr R1 Lexicon Rules DRules}
	   fun {$ R11}
	      {Map {EvaluateFunArgExpr R2 Lexicon Rules DRules}
	       fun {$ R21}
		  {Map {Filter {Dictionary.condGet DRules {GetRecTypeCat R11} nil} IsRightBinaryRule}
		   fun {$ R}
		      %{Inspector.inspect R}
		      local
			 Res1 = {EmbeddingFunConvert R R11}
		      in
			 case Res1
			 of lambda(_ T _) then
			    if {IsSubType R21 T} then
			       local
				  Res = {EmbeddingFunConvert
					 Res1
					 R21}
			       in
				  if Res.cnt.2 == conj(R11.cnt.2 R21.cnt.2) then Res
				  else nil
				  end
			       end
			    else nil
			    end
			 end
		      end
		   end
		  }
	       end
	      }
	   end
	  }
	 }
      else
	 if {IsAtom Expr} then
%	    {Inspector.inspect {Dictionary.condGet Lexicon Expr nil}}
	    {Dictionary.condGet Lexicon Expr nil}
	 else nil
	 end
      end
   end
   
		   
	 
 
   fun {Generate IDExpr IDLex}
      {InstantiateType {EvaluateIDExpr {ConvertTreeToExplApply IDExpr} IDLex}.phon}
   end 
   fun {ConvertTreeToExplApply Tree}
      if {IsAtom Tree} then Tree
      else
	 case Tree
	 of apply(F X)
	 then apply({ConvertTreeToExplApply F}{ConvertTreeToExplApply X})
	 else
	    case {Arity Tree}
	    of [1] then apply({ConvertTreeToExplApply {Label Tree}}{ConvertTreeToExplApply Tree.1})
	    [] [1 2] then
	       apply(apply({ConvertTreeToExplApply {Label Tree}}{ConvertTreeToExplApply Tree.1})
		     {ConvertTreeToExplApply Tree.2})
	    else
	       Tree
	    end
	 end
      end
   end
   fun {ConvertExplAppToTree Expr}
      if {IsAtom Expr} then Expr
      else
	 case Expr
	 of app(P Arg) then
	    if {IsAtom P} then P({ConvertExplAppToTree Arg})
	    else case P
		 of app(P1 Arg1) then
		    if {IsAtom P1} then
		       P1({ConvertExplAppToTree Arg1}
			  {ConvertExplAppToTree Arg})
		    else {Inspector.inspect ['Parse.convertExplAppToTree: not defined for' Expr P1 'not an atom']} 'not defined'
		    end
		 else {Inspector.inspect ['Parse.convertExplAppToTree: not defined for' Expr]} 'not defined'
		 end
	    end
	 end
      end
   end
   
		    
  %  fun {NewChartFunctionalInput Lex Rules Feat Expr}
%       local
% 	 Chart = {NewEnv}
% 	 LongestEdgesStream
% 	 ChartCounts = {NewDictionary}
%       in
% 	 {NewSubEnv Chart edges_by_start}
% 	 {PutEnv Chart longest_edges {NewPort LongestEdgesStream}#LongestEdgesStream}
% 	 %{Inspector.inspect Expr}
% 	 {AddEdgeFunctionalInput 0 0 Expr Feat Chart Lex Rules ChartCounts}
% 	 Chart
%       end
%    end
%    proc {AddEdgeFunctionalInput N M Expr Feat Chart Lex Rules ChartCounts}
%       local
% 	 Prt = {GetSubEnv Chart edges_by_start N}
% 	 EdgePortStream
% 	 EdgeStream
%       in
% 	 case Prt
% 	 of undef then
% 	    EdgePortStream = {NewPort EdgeStream}#EdgeStream
% 	    {PutSubEnv Chart edges_by_start N
% 	     EdgePortStream}
% 	 else
% 	    EdgePortStream = Prt
% 	 end
% 	 if {IsAtom Expr} then
% 	    % {Inspector.inspect Expr}
% % 	    {Inspector.inspect Lex}
% % 	    {Inspector.inspect {Dictionary.condGet Lex Expr nil}}
% 	    {ForAll {Dictionary.condGet Lex Expr nil}
% 	     proc {$ C}
% 		local
% 		   CurrentEdgeLabel = {Gensym edge ChartCounts}
% 		   NewEdge = edge(CurrentEdgeLabel N M C)
% 		in
% 		   %{Inspector.inspect NewEdge}
% 		   {Send {GetEnv Chart longest_edges}.1
% 		    {AddLongEdge NewEdge
% 		     {LastInStream {GetEnv Chart longest_edges}.2}
% 		    }
% 		   }
% 		   {Send EdgePortStream.1 NewEdge}
% 		   {Inspector.inspect 'LexEdge'#NewEdge}
% 		end
% 	     end
% 	    }
% 	 else
% 	    case Expr
% 	    of apply(F X) then
% 	       local
% 		  Prt1 = {GetSubEnv Chart edges_by_start N+1}
% 		  EdgePortStream1
% 		  EdgeStream1
% 	       in
% 		  case Prt1
% 		  of undef then
% 		     EdgePortStream1 = {NewPort EdgeStream1}#EdgeStream1
% 		     {PutSubEnv Chart edges_by_start N+1
% 		      EdgePortStream1}
% 		  else
% 		     EdgePortStream1 = Prt1
% 		  end
% 		  %{Inspector.inspect Expr}
% 		  {AddEdgeFunctionalInput N+1 1 F Feat Chart Lex Rules ChartCounts}
% 		  {AddEdgeFunctionalInput N+1 2 X Feat Chart Lex Rules ChartCounts}
% 		  thread
% 		     {ForAll EdgePortStream1.2
% 		      proc {$ E1}
% 			 case {GetEdgeEnd E1}
% 			 of 1 then
% 			    thread
% 			       {ForAll EdgePortStream1.2
% 				proc {$ E2}
% 				   case {GetEdgeEnd E2}
% 				   of 2 then
% 				      {ForAll {Dictionary.condGet Rules {GetEdgeCat E1} nil}
% 				       proc {$ R}
% 					  local
% 					     NewEdgeContents = {EmbeddingFunConvert {EmbeddingFunConvert R {GetEdgeContents E1}}
% 								{GetEdgeContents E2}}
% 					  in
% 					     % {Inspector.inspect NewEdgeContents}
% % 					     {Inspector.inspect NewEdgeContents.Feat#apply({InstantiateType {GetEdgeContents E1}.Feat}
% % 													     {InstantiateType {GetEdgeContents E2}.Feat})}
% 					     cond NewEdgeContents.Feat.2 = apply({GetEdgeContents E1}.Feat.2
% 												{GetEdgeContents E2}.Feat.2) then
% 						local
% 						   NewEdge = edge({Gensym edge ChartCounts} N M NewEdgeContents)
% 						in
% 						   %{Inspector.inspect NewEdge}
% 						   {Send {GetEnv Chart longest_edges}.1
% 						    {AddLongEdge NewEdge
% 						     {LastInStream {GetEnv Chart longest_edges}.2}
% 						    }
% 						   }
% 						   {Send EdgePortStream.1 NewEdge}
% 						   {Inspector.inspect 'ApplyEdge'#NewEdge}
% 						end
% 					     else skip
% 					     end
% 					  end
% 				       end
% 				      }
% 				   else skip
% 				   end
% 				end
% 			       }
% 			    end
% 			 else skip
% 			 end
% 		      end
% 		     }
% 		  end
% 	       end
% 	    [] conj(R1 R2) then
% 	       local
% 		  Prt1 = {GetSubEnv Chart edges_by_start N+1}
% 		  EdgePortStream1
% 		  EdgeStream1
% 	       in
% 		  case Prt1
% 		  of undef then
% 		     EdgePortStream1 = {NewPort EdgeStream1}#EdgeStream1
% 		     {PutSubEnv Chart edges_by_start N+1
% 		      EdgePortStream1}
% 		  else
% 		     EdgePortStream1 = Prt1
% 		  end
% 		  %{Inspector.inspect Expr}
% 		  {AddEdgeFunctionalInput N+1 1 R1 Feat Chart Lex Rules ChartCounts}
% 		  {AddEdgeFunctionalInput N+1 2 R2 Feat Chart Lex Rules ChartCounts}
% 		  thread
% 		     {ForAll EdgePortStream1.2
% 		      proc {$ E1}
% 			 case {GetEdgeEnd E1}
% 			 of 1 then
% 			    thread
% 			       {ForAll EdgePortStream1.2
% 				proc {$ E2}
% 				   case {GetEdgeEnd E2}
% 				   of 2 then
% 				      {ForAll {Dictionary.condGet Rules {GetEdgeCat E1} nil}
% 				       proc {$ R}
% 					  if {IsRightBinaryRule R} then
% 					     local
% 						NewEdgeContents = {EmbeddingFunConvert {EmbeddingFunConvert R {GetEdgeContents E1}}
% 								   {GetEdgeContents E2}}
% 					     in
% 						%{Inspector.inspect R#E1#E2#NewEdgeContents}
% 					     % {Inspector.inspect NewEdgeContents.Feat#apply({InstantiateType {GetEdgeContents E1}.Feat}
% % 													     {InstantiateType {GetEdgeContents E2}.Feat})}
% 						cond NewEdgeContents.Feat.2 = conj({GetEdgeContents E1}.Feat.2
% 										   {GetEdgeContents E2}.Feat.2) then
% 						   local
% 						      NewEdge = edge({Gensym edge ChartCounts} N M NewEdgeContents)
% 						   in
% 						   {Inspector.inspect 'ConjEdge'#NewEdge}
% 						      {Send {GetEnv Chart longest_edges}.1
% 						       {AddLongEdge NewEdge
% 							{LastInStream {GetEnv Chart longest_edges}.2}
% 						       }
% 						      }
% 						      {Send EdgePortStream.1 NewEdge}
% 						   end
% 						else skip
% 						end
% 					     end
% 					  else skip
% 					  end
% 				       end
% 				      }
% 				   else skip
% 				   end
% 				end
% 			       }
% 			    end
% 			 else skip
% 			 end
% 		      end
% 		     }
% 		  end
% 	       end
	       
% 	    else
% 	       local
% 		  NewEdge = edge({Gensym edge ChartCounts} N N Expr)
% 	       in
% 		  %{Inspector.inspect NewEdge}
% 		  {Send {GetEnv Chart longest_edges}.1
% 		   {AddLongEdge NewEdge
% 		    {LastInStream {GetEnv Chart longest_edges}.2}
% 		   }
% 		  }
% 		  {Send EdgePortStream.1 NewEdge}
% 	       end
% 	    end
% 	 end
%       end
%    end


				    
					     

				    
		
		      
   
end
