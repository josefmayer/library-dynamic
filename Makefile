all: 

# static: ctest1.o ctest2.o libctest.a

# ctest1.o ctest2.o: ctest1.c ctest2.c
#	cc -Wall -c ctest1.c ctest2.c 

# libctest.a: ctest1.o ctest2.o
#	ar -cvq libctest.a ctest1.o ctest2.o


dynamic: ctest1.c ctest2.c prog.c
	gcc -Wall -fPIC -c ctest1.c ctest2.c prog.c
	gcc -shared -Wl,-soname,libctest.so.1 -o libctest.so.1.0   *.o
#	gcc -shared -Wl,-soname,libctest.so.1.0 -o libctest.so.1.0   *.o


move:
	mv libctest.so.1.0 /opt/lib/libctest.so
#	mv libctest.so.1.0 /opt/lib/libctest.so.1.0


link:
	ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so.1
	ln -sf /opt/lib/libctest.so.1.0 /opt/lib/libctest.so

prog: prog.c
	gcc -Wall -L/opt/lib prog.c -lctest -o prog
#	gcc -Wall -L/ prog.c -lctest -o prog


progdl:
	gcc -rdynamic -o progdl progdl.c -ldl

clean: clean_static clean_dynamic

clean_static:
	rm *.o *.a

clean_dynamic:
	rm *.o *.so.*