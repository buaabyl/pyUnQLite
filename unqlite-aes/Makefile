
UNQLITE_PATH = .
CFLAGS 		 = -I $(UNQLITE_PATH)
src_unqite   = \
			$(UNQLITE_PATH)/api.c \
			$(UNQLITE_PATH)/bitvec.c \
			$(UNQLITE_PATH)/lhash_kv.c \
			$(UNQLITE_PATH)/mem_kv.c \
			$(UNQLITE_PATH)/os.c \
			$(UNQLITE_PATH)/os_unix.c \
			$(UNQLITE_PATH)/os_win.c \
			$(UNQLITE_PATH)/pager.c \
			$(UNQLITE_PATH)/jx9_lib.c

all:
	gcc $(CFLAGS) -D DISABLE_JX9 test.c $(src_unqite) -o kv_only.exe

clean:
	rm *.o -rf

cleanall:clean
	rm *.exe -rf

