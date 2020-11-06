build:
	gcc -shared -Wl,-soname,libhai.so.0 -o libhai.so hai.c
	gcc -o hai main.c libhai.so
	cc -g -shared -Wl,-soname,libhai-dbg.so.0 -o libhai-dbg.so hai.c
	gcc -g -o hai-dbg main.c libhai-dbg.so

install:
	sudo cp hai /usr/bin/
	sudo cp libhai.so /usr/lib/
	sudo ln -sf /usr/lib/libhai.so /usr/lib/libhai.so.0
	sudo ldconfig

clean:
	rm -rf a.out
	rm -rf hai
	rm -rf libhai.so
	rm -rf hai-dbg
	rm -rf libhai-dbg.so
