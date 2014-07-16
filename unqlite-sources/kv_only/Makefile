
UNQLITE_PATH = ..
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

src_jx9 = \
			$(UNQLITE_PATH)/fastjson.c \
			$(UNQLITE_PATH)/jx9_api.c \
			$(UNQLITE_PATH)/jx9_builtin.c \
			$(UNQLITE_PATH)/jx9_compile.c \
			$(UNQLITE_PATH)/jx9_const.c \
			$(UNQLITE_PATH)/jx9_hashmap.c \
			$(UNQLITE_PATH)/jx9_json.c \
			$(UNQLITE_PATH)/jx9_lex.c \
			$(UNQLITE_PATH)/jx9_memobj.c \
			$(UNQLITE_PATH)/jx9_parse.c \
			$(UNQLITE_PATH)/jx9_vfs.c \
			$(UNQLITE_PATH)/jx9_vm.c \
			$(UNQLITE_PATH)/unqlite_jx9.c \
			$(UNQLITE_PATH)/unqlite_vm.c

all:
	gcc $(CFLAGS) -D DISABLE_JX9 test.c $(src_unqite) -o kv_only.exe
	gcc $(CFLAGS) test.c $(src_unqite) $(src_jx9) -o with_jx9.exe

clean:
	rm *.o -rf

cleanall:clean
	rm *.exe -rf

