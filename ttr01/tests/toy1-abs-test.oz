declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "toy1-abs"}


declare
[Abs InspectorConfig] = {Module.link ['../grammars/toy1/toy1-abs.ozf' '../ttr/inspectorconfig.ozf']}

{Inspect Abs.light}

{Inspect Abs.s_VP}

