declare
{OS.chDir {VirtualString.toAtom {OS.getEnv 'TTRHOME'}#"/tests"}}
[Abs] = {Module.link ['../ures/ures-abs1.ozf']}
Lex = Abs.lex

{Inspect {Lex 'Bear' n}}

{Inspect {Abs.ruleBinary id mother daughter1 daughter2}}

{Inspect {Abs.ruleUnary id mother daughter}}
