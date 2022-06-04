PROGRAM := i-hist
OUTPATH := ${HOME}/.local/bin/$(PROGRAM)

clean:
	rm -rf ./target

install: 
	cargo install --path .

uninstall: 
	rm $(OUTPATH)

.PHONY: clean install uninstall
.DEFAULT_GOAL := install
