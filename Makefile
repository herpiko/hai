prefix = /usr

all: hai

hai: main.c
	# Using lib. Skip for now.
	#gcc -shared -Wl,-soname,libhai.so.0 -o libhai.so hai.c
	@echo "CFLAGS=$(CFLAGS)" | \
                fold -s -w 70 | \
                sed -e 's/^/# /'
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDCFLAGS) -o $@ $^ #libhai.so.0


install: hai
	install -D hai \
                $(DESTDIR)$(prefix)/bin/hai

uninstall:
	rm -f /usr/bin/hai
	rm -f /usr/lib/libhai.so
	rm -f /usr/lib/libhai.so.0
	ldconfig

###########################################################################

build:
	gcc -shared -Wl,-soname,libhai.so.0 -o libhai.so hai.c
	gcc -o hai main.c libhai.so
	cc -g -shared -Wl,-soname,libhai-dbg.so.0 -o libhai-dbg.so hai.c
	gcc -g -o hai-dbg main.c libhai-dbg.so

direct-install:
	cp hai /usr/bin/
	cp libhai.so /usr/lib/
	ln -sf /usr/lib/libhai.so /usr/lib/libhai.so.0
	ldconfig

direct-lib-install:
	cp libhai.so /usr/lib/
	ln -sf /usr/lib/libhai.so /usr/lib/libhai.so.0
	ldconfig


clean:
	rm -rf a.out
	rm -rf hai
	rm -rf libhai.so
	rm -rf hai-dbg
	rm -rf libhai-dbg.so

orig:
	rm ../*.orig.tar.xz || true
	dh_make -s -y --createorig

dpkg-buildpackage:
	dpkg-buildpackage -us -uc

reset:
	rm -rf ../*.orig.tar.xz
	rm -rf ../*.buildinfo
	rm -rf ../*.changes
	rm -rf ../*.deb
	rm -rf ../*.dsc


.PHONY: install uninstall
