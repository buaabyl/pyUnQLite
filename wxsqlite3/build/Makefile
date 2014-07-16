CFLAGS = /nologo /c /I ..

all:
	cl $(CFLAGS) ..\shell.c
	cl $(CFLAGS) ..\sqlite3secure.c
	link $(LFLAGS) shell.obj sqlite3secure.obj
