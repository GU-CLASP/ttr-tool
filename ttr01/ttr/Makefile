compileall: 
	ozc -c *.oz
	ozc -x debug-init.oz
	./debug-init

banner:
	for f in *.oz; do\
		cat ../banner $$f > $$f.tmp;\
		mv $$f.tmp $$f;\
	done

