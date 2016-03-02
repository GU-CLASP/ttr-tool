declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[DMoves Parse] = {Module.link ['../grammars/bear/bear-dmoves.ozf' '../ttr/parse.ozf']}
DMove2Abs = DMoves.dMove2Abs
Abs2DMove = DMoves.abs2DMove
ExplApply = Parse.convertTreeToExplApply
Tree = Parse.convertExplAppToTree
TokenizeFunArg = Parse.tokenizeFunArg
TokenizeTree = Parse.tokenizeTree

{Inspect {ExplApply {DMove2Abs presentEval('Nice' 'Bear')}}}

{Inspect {Tree app(app(d_d_s app(d_s 'Yes')) app(app(s_np_vp 'Pron') app(app(vp_cop_np 'Be') app(app(np_det_n 'IndefArt') app(app(n_adj_n 'Nice') 'Bear')))))}}

{Show {DMove2Abs presentEval('Nice' 'Bear')}}

{Inspect {ExplApply {TokenizeFunArg "s_np_vp('This' vp_cop_np('Be' np_det_n('IndefArt' n_adj_n('Nice' 'Bear'))))"}}}

{Inspect {TokenizeFunArg "np_det_n('IndefArt' 'Bear')"}}

{Inspect {DMove2Abs present('Bear')}}

{Inspect {DMove2Abs confirmPresentEval('Nice' 'Bear')}}

declare
Str = {DMove2Abs presentEval('Nice' 'Bear')}
{Inspect {Abs2DMove Str}}

declare
Str = {DMove2Abs present('Bear')}
{Inspect {Abs2DMove Str}}

declare
Str = {DMove2Abs confirmPresentEval('Nice' 'Bear')}
{Inspect {Abs2DMove Str}}