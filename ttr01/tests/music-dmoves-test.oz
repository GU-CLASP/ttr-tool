declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[DMoves Parse] = {Module.link ['../grammars/music/music-dmoves.ozf' '../ttr/parse.ozf']}
DMove2Abs = DMoves.dMove2Abs
Abs2DMove = DMoves.abs2DMove
ExplApply = Parse.convertTreeToExplApply
Tree = Parse.convertExplAppToTree
TokenizeFunArg = Parse.tokenizeFunArg
TokenizeTree = Parse.tokenizeTree

{Inspect {DMove2Abs assert(pred('Conductor' 'Dudamel'))}}

{Inspect {TokenizeFunArg "pred('Conductor' 'Dudamel')"}}