LIBDIR=/usr/lib/mysql/plugin/

install:
	gcc -m64 -O3 -DMYSQL_DYNAMIC_PLUGIN -fPIC -Wall -I/usr/include/mysql -I. -shared lib_mysqludf_sys.c -o $(LIBDIR)/lib_mysqludf_sys.so
