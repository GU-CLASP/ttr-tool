declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Bear Types InspectorConfig ] = {Module.link ['../grammars/bear/ontology-bear.ozf' '../ttr/types.ozf' '../ttr/inspectorconfig.ozf']}

{InspectorConfig.inspectorConfigParse}

{InspectorConfig.inspectorProjector 18}

%{Inspect Bear.panda}

{Inspect Bear.thing}

{Inspect Bear.bear}

{Inspect Bear.brownBear}

{Inspect Bear.brownOrBlackAndWhiteBear}

{Inspect Bear.brown}

{Inspect {Types.simplifyMeet meettype(Bear.bear Bear.brown)}}