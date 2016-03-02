compileall: bear fish mini toy1 music res ures ttr


bear: 
	cd grammars/bear; make

fish: 
	cd grammars/fish; make

mini:

	cd grammars/mini; make

toy1: 
	cd grammars/toy1; make

music: 
	cd grammars/music; make

res:	force
	cd res; make

ures: 	force
	cd ures; make

ttr:	force
	cd ttr; make

banner: force
	cd grammars/bear; make banner
	cd grammars/fish; make banner
	cd grammars/mini; make banner
	cd grammars/toy1; make banner
	cd grammars/music; make banner
	cd res; make banner
	cd ures; make banner
	cd ttr; make banner

clean: force
	rm -f *{.ozf,~,#}
	rm -rf scrap
	cd grammars/bear; rm -f *{.ozf,~,#}
	cd grammars/fish; rm -f *{.ozf,~,#}
	cd grammars/mini; rm -f *{.ozf,~,#}
	cd grammars/toy1; rm -f *{.ozf,~,#}
	cd grammars/music; rm -f *{.ozf,~,#}
	cd res; rm -f *{.ozf,~,#}
	cd ures; rm -f *{.ozf,~,#}
	cd ttr; rm -f *{.ozf,~,#}
	cd examples; rm -f *{~,#}
	cd tests; rm -f *{~,#}
	cd utilities; rm -f *{~,#}

cleansvn: force
	rm -rf .svn
	cd grammars; rm -rf .svn
	cd grammars/bear; rm -rf .svn
	cd grammars/fish; rm -rf .svn
	cd grammars/mini; rm -rf .svn
	cd grammars/toy1; rm -rf .svn
	cd grammars/music; rm -rf .svn
	cd res; rm -rf .svn
	cd ures; rm -rf .svn
	cd ttr; rm -rf .svn
	cd examples; rm -rf .svn
	cd tests; rm -rf .svn
	cd utilities; rm -rf .svn

force:

