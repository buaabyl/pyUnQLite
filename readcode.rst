Reading UnQLite Codes
===========================================

Architecture  
--------------

UnQLite have two difference module:

  1. key-value storage engine.
  2. jx9 script based document engine.

And all codes is convert to amalgamation source file.
It is hard to read and not easy to know how it work.

So we just unpack amalgamation to serval source files.
And some of description text is copy from source files.

Need both of kv and jx9:

 *amalgamation.h*
    auto-generate amalgamation header.

 *unqlite.h*
    api declare, library define and else.

 *api.c*
    This file implement the public interfaces presented to host-applications.
    Routines in other files are for internal use by UnQLite and should not be
    accessed by users of the library.

 *unqliteInt.h*
    Internal type defines.

 *bitvec.c*
    A bitmap is used to record which pages of a database file have been
    journalled during a transaction, or which pages have the "dont-write"
    property.  Usually only a few pages are meet either condition.
    So the bitmap is usually sparse and has low cardinality.

 *jx9_lib.c*
    Implement mutex, CRC, MD5, SHA1, Blob, Archive, Memory, Heap interface.

 *os.c*
    Mostly an abstract os file interface.

 *os_unix.c*
    Implement of os interface for unix.

 *os_win.c*
    Implement of os interface for windows.

 *pager.c*
    This file implements the pager and the transaction manager for UnQLite
    (Mostly inspired from the SQLite3 Source tree).


kv module:

 *lhash_kv.c*
    This file implements disk based hashtable using the linear 
    hashing algorithm.

 *mem_kv.c*
    This file implements an in-memory key value storage engine for unQLite.
    Note that this storage engine does not support transactions.

jx9 module:

 *jx9.h*
    Jx9 script library header

 *jx9Int.h*
    Internal type defines.

 *jx9_api.c*
    This file implement the public interfaces presented to host-applications.
    Routines in other files are for internal use by JX9 and should not be
    accessed by users of the library.

 *jx9_builtin.c*
    This file implement built-in 'foreign' functions for the JX9 engine.
    As we known, jx9 script engine can call c function, and function
    need to be register to virtual machine.

 *jx9_compile.c*
    This file implement a thread-safe and full-reentrant compiler 
    for the JX9 engine.

 *jx9_const.c*
    This file implement built-in constants for the JX9 engine.

 *jx9_hashmap.c*
    This file implement generic hashmaps used to represent JSON 
    arrays and objects

 *jx9_json.c*
    This file deals with JSON serialization, decoding and stuff like that.

 *jx9_lex.c*
    This file implements a thread-safe and full reentrant 
    lexical analyzer for the Jx9 programming language.

 *jx9_memobj.c*
    This file manage low-level stuff related to indexed memory
    objects (i.e: jx9_value).

 *jx9_parse.c*
    This file implements expression parser for the Jx9 programming language.

 *jx9_vfs.c*
    This file implement a virtual file systems (VFS) for the JX9 engine.

 *jx9_vm.c*
    The code in this file implements execution method of the JX9 
    Virtual Machine.

 *fastjson.c*
    Encode jx9_value to json, decode json to jx9_value.

 *unqlite_jx9.c*
    This file implements UnQLite functions 
    (db_exists(), db_create(), db_put(), db_get(), etc.) 
    for the underlying Jx9 Virtual Machine. 

 *unqlite_vm.c*
    This file deals with low level stuff related to the
    unQLite Virtual Machine.

UnQLite is design as "Pluggable Run-Time Interchangeable Storage Engines".
But jx9 and kv engine can't compile seperate without modify.

Also I have a look at api.c and pager.c, 
we need some modify to remove jx9 from UnQLite.
After that, we only need this files to use UnQLite as key-value only.

    api.c
    bitvec.c
    lhash_kv.c
    mem_kv.c
    os.c
    os_unix.c
    os_win.c
    pager.c
    jx9_lib.c

The target size from 510420 bytes to 154790 bytes (mingw32),
it is 30% of original full version.

