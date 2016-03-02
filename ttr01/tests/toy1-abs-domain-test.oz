declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Utils] = {Module.link ['../ttr/utils.ozf']}
InitTypes = Utils.initTypes
{InitTypes "toy1-abs-domain"}


declare
[Abs InspectorConfig] = {Module.link ['../grammars/toy1/toy1-abs-domain.ozf' '../ttr/inspectorconfig.ozf']}

{InspectorConfig.inspectorConfigParse}

{Inspect Abs.defArt}

{Inspect Abs.light}

{Inspect Abs.fan}

{Inspect Abs.kitchen}

{Inspect Abs.livingroom}

{Inspect Abs.'in'}

{Inspect Abs.switchOn}

{Inspect Abs.switchOff}

{Inspect Abs.on}

{Inspect Abs.off}

{Inspect Abs.be}

{Inspect Abs.dim}

{Inspect Abs.s_VP}

{Inspect Abs.s_Cop_SmallCl}

{Inspect Abs.smallCl_NP_Part}

{Inspect Abs.nP_Det_N}

{Inspect Abs.n_N_PP}

{Inspect Abs.pP_Prep_NP}

{Inspect Abs.vP_V_NP}

{Inspect {VirtualString.toAtom like#s}}

