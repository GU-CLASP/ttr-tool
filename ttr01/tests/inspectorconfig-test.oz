declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[InspectorConfig] = {Module.link ['../ttr/inspectorconfig.ozf']}

{InspectorConfig.inspectorProjector 18}

{InspectorConfig.inspectorDefault}

{InspectorConfig.inspectorConfigParse}