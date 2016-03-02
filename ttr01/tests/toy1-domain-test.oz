declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "toy1-domain"}

declare
[Domain InspectorConfig] = {Module.link ['../grammars/toy1/toy1-domain.ozf' '../ttr/inspectorconfig.ozf']}
Device = Domain.device
Switchable = Domain.switchable
Light = Domain.light
DimLight = Domain.dimLight
On = Domain.on
Dim = Domain.dim
SwitchOn = Domain.switchOn


{InspectorConfig.inspectorConfigParse}

{Inspect Device}

{Inspect Switchable}

{Inspect Light}

{Inspect DimLight}

{Inspect Dim}

{Inspect SwitchOn}

{Inspect On}

{Inspect Domain.located}
