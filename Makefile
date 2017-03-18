PROG = shuriken
PREFIX ?= /usr/local

# escape slashes in path to be used by sed
pescape = $(subst /,\/,$1)
ESCPREFIX = $(call pescape,${PREFIX})

all:
	@echo "$(PROG) is a script and does not need compilation, it can be simply executed."
	@echo
	@echo "To install it in /usr/local together use 'make install' as root."
	@echo "To change the install location, override the env var PREFIX=/usr/local"
	@echo

install:
	@echo "Installing $(PROG) to ${PREFIX}/share/$(PROG)"
	@mkdir -p  $(PREFIX)/share/$(PROG)
	@cp -ra zuper     $(PREFIX)/share/$(PROG)
	@echo "Installing executable in ${PREFIX}/bin/$(PROG)"
	@sed "s/^basedir=./basedir=$(ESCPREFIX)\/share\/$(PROG)/g" \
		$(PROG) > $(PREFIX)/bin/$(PROG)
	@chmod +x      $(PREFIX)/bin/$(PROG)
	@install -m 0755 $(PROG)-dmenu    $(PREFIX)/bin/$(PROG)-dmenu

lint:
	shellcheck -e SC1083,SC2048,SC2086,SC2034 -s zsh -f gcc $(PROG)
