declare
[Types Anaph] = {Module.link ['../ttr/types.ozf' '../ttr/anaph.ozf']}
SimplifyOp = Types.simplifyOp
InstantiateType = Types.instantiateType
FlattenRelabelRecType = Types.flattenRelabelRecType
AbbrevDep = Types.abbrevDep
IsSupported = Types.isSupported
ResolveMetaPathsRemoveEq = Anaph.resolveMetaPathsRemoveEq
{Inspector.configure labeltupleMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
				     nil
					 ['Show'(proc {$ X} {System.show X} end)
					  'SimplifyOp'(proc {$ X} {Inspector.inspect {SimplifyOp X}} end)
					 'InstantiateType'(proc {$ X} {Inspector.inspect {InstantiateType X}} end)])}
{Inspector.configure recordMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
				     nil
				     ['Show'(proc {$ X} {System.show X} end)
				      'SimplifyOp'(proc {$ X} {Inspector.inspect {SimplifyOp X}} end)
				      'FlattenRelabelRecType'(proc {$ X} {Inspector.inspect {FlattenRelabelRecType X}} end)
				      'Resolve'(proc {$ X} {Inspector.inspect {Search.base.all proc {$ R} {ResolveMetaPathsRemoveEq X 'Ind' R} end}} end)
				      'AbbrevDep'(proc {$ X} {Inspector.inspect {AbbrevDep X}} end)
				      'IsSupported'(proc {$ X} {Inspector.inspect {IsSupported X}} end)])}
{Inspector.configure listMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
				     nil
				   ['Show'(proc {$ X} {System.show X} end)])}
{Inspector.configure hashtupleMenu menu([1 5 10 0 ~1 ~5 ~10] [1 5 10 0 ~1 ~5 ~10]
				     nil
					 ['Show'(proc {$ X} {System.show X} end)])}