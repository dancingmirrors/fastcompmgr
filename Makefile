PACKAGES = x11 xcomposite xfixes xdamage xrender
LIBS = `pkg-config --libs ${PACKAGES}` -lm
INCS = `pkg-config --cflags ${PACKAGES}`
CFLAGS = -Wall -O3 -flto
PREFIX = /usr/local
MANDIR = ${PREFIX}/man/man1
CC = gcc

OBJS=fastcompmgr.o comp_rect.o cm-root.o cm-global.o cm-util.o

.c.o:
	$(CC) $(CFLAGS) $(INCS) -c $*.c

fastcompmgr: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LIBS)

install: fastcompmgr
	@mkdir -p "${PREFIX}/bin"
	@cp fastcompmgr "${PREFIX}/bin"
	@mkdir -p "${MANDIR}"
	@cp fastcompmgr.1 "${MANDIR}"

uninstall:
	@rm -f "${PREFIX}/bin/fastcompmgr"
	@rm -f "${MANDIR}/fastcompmgr.1"

clean:
	rm -f $(OBJS) fastcompmgr

.PHONY: uninstall clean
