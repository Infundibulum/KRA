

.PHONY:
test: nTm.pl
	echo "test." | swipl $< | tee $@

load:
	swipl nTm.pl
