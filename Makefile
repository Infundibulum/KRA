

.PHONY:
test: nTm.pl
	echo "test(c)." | swipl $< | tee $@

load:
	swipl nTm.pl
