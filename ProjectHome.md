Provides basic tools for making TTR judgements and writing grammars for natural language.  This is a preliminary alpha version.

From the README file for TTRtool0.1:

You can give yourself a tutorial on TTR and TTRtool by studying files
in the following order:

  1. examples/example-records.oz -- TTR records implemented as Oz
> records, basic operations of flattening and relabelling.

> 2) examples/example-types.oz -- introduces basic types, proof types
> (what I now call ptypes, i.e. types formed with predicates) and an
> "is of type" relation - e.g. {IsOfType a 'Ind'} is the code for
> a:Ind.  This uses the types specified in
> ttr/default-{btypes,pred,model}.oz .  (Sometime soon there will be
> a higher level representation of such files so you don't have to
> mess with the oz-code...).  We also introduce IsSupported for
> non-empty types, function types, functions, function application,
> beta conversion, dependent function types, type instantiation
> (with abstract objects used in subtyping computations),
> join types, meet types, simplification of meets and joins,
> subtyping, list types, singleton types, types defined in terms of
> the operators 'append' and 'apply', type instantiation in a model.

> 3) examples/example-rectypes.oz -- introduces record types
> implemented as Oz records, with instantiation, subtyping, relative
> and absolute paths, simplification of meets (unification) and joins,
> simplification of dependent types within records.

> 4) examples/example-minigram-sem-eng.oz  This provides a toy grammar
> that does a little discourse anaphora.  There is only one command
> to execute at the bottom of this file (after you have executed the
> two paragraphs beginning with 'declare').  This will provide you
> with a parse input window and some other windows for output.  You
> can type

> Kim runs

> or
> Kim
> runs

> That is, the parser is incremental and will do whatever it can
> with one or more words adding them to the chart.  If you want to
> start from an empty chart, choose Chart/New Chart from the menus
> in the Parse Input window.  The default setting is to show you the
> whole chart.  This can be changed in the Chart Show menu.  If
> you're interested in seeing edges for complete discourses you can
> choose "Show longest edges with cat... d".  If you change settings
> using these menus you need only type return in order to get the
> new representation for what you have parsed so far.  You probably don't
> want to see the complete edges either.  In the 'Edge Show' menu
> you can choose, for example, to see only the cnt-field
> corresponding to semantic interpretation.  (Show dialogue move is
> not relevant for this grammar.)  There are various options for
> showing content in the Edge Show menu.  The most abbreviated (and
> readable) is the one at the bottom.  The Input menu allows you to
> type sort of semantic representations as input and get back the
> type.  (Again DMove is not relevant for this grammar.)  The menu
> Generation output controls what you get back when your input is
> not a string of words.  To see the full power and coverage of this
> grammar (ahem)  try parsing

> kim owns a donkey he likes it

> Display the content on the option "instantiated and flattened" from
> the "Edge Show" menu.  Now middle-click (or maybe right-click) on
> the label "rectype" at the root of the record type and choose
> Actions/Resolve.  The result of anaphora resolution will appear in
> another Inspector window.  You can middle-click on the rectype
> label of the resolved type and choose Actions/AbbrevDep to
> abbreviate the dependent types and obtain a readable version of the type.

> 5) examples/example-minigram-sem-swe.oz  This is the Swedish version
> of minigram.  It uses the same abstract syntax and semantics.
> Check out the files grammars/mini

> 6) examples/example-minigram-sem-eng\_swe.oz  This is a merge of the
> Swedish and English minigrammars.  It will parse English and
> Swedish and "code-switching" examples such as

> kim äger en donkey

> Select ID structure in the Input menu and type

> s\_np\_vp('Kim' 'Run')

> in the input window and you will get output in both languages

> A variant is to select FunArg structure in the Input menu and type

> apply('Kim' 'Run')

> Check out the code for merging the two grammars in
> grammars/mini/minigram-sem-eng\_swe.oz

> 7)  examples/example-toy1-abs-domain-eng.oz and
> examples/example-toy1-abs-domain-swe.oz  This is an implementation
> of the toy1 grammar from Putting Linguistics into Speech
> Recognition: The Regulus Grammar Compiler M. Rayner, B.A. Hockey
> and P. Bouillon. CSLI Press, 2006.  It illustrates how ontologies
> can be coded in TTR and integrated in grammar.  The English and
> Swedish grammars share the same abstract syntax and domain
> (ontology).  Grammatical coverage is specified in
> tests/toy1-coverage.txt.  Grammar files are in grammars/toy1/

> 8) examples/example-fishgram-eng.oz This is a tiny study of how
> tools for agreement phenomena in a particular language can be
> imported from a universal syntax resource (ures/ures-syntax.oz).
> Grammar files in grammars/fish/

> 9) examples/example-bear-eng.oz Another tiny study of how you can
> parse to and generate from dialogue moves.  Try selecting !DMove in
> the Input menu and typing !presentEval('Nice' 'Bear') in the Parse
> Input window.  Grammar files in grammars/bear/  Note how dialogue
> moves are defined in terms of constructions (in something like the
> sense of contruction grammar) in _abstract_ syntax.