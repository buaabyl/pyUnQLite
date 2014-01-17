# distutils: sources = unqlite.c

from libc.stdlib cimport malloc, free


###
### Import
###

cdef extern from 'unqlite.h':
    #types (http://unqlite.org/c_api_object.html)-----------
    cdef struct unqlite
    cdef struct unqlite_kv_cursor

    ctypedef signed long long int sxi64
    ctypedef unsigned long long int sxu64
    ctypedef sxi64 unqlite_int64

    ## functions -------------------------------------------
    #private interface(need modify unqite.c!)
    #cdef jx9_int64 unqliteCollectionTotalRecords(unqlite_col *pCol)


    #database engine handle
    cdef int unqlite_open(unqlite **ppDb, const char *zFilename, unsigned int iMode)
    cdef int unqlite_config(unqlite *pDb, int nOp, ...)
    cdef int unqlite_close(unqlite *pDb)

    #transaction
    cdef int unqlite_begin(unqlite *pDb)
    cdef int unqlite_commit(unqlite *pDb)
    cdef int unqlite_rollback(unqlite *pDb)

    #key/value store interfaces
    cdef int unqlite_kv_store(unqlite *pDb, const void *pKey, int nKeyLen, const void *pData, unqlite_int64 nDataLen)
    cdef int unqlite_kv_store_fmt(unqlite *pDb, const void *pKey, int nKeyLen, const char *zFormat, ...)
    cdef int unqlite_kv_append(unqlite *pDb, const void *pKey, int nKeyLen, const void *pData, unqlite_int64 nDataLen)
    cdef int unqlite_kv_append_fmt(unqlite *pDb, const void *pKey, int nKeyLen, const char *zFormat, ...)
    cdef int unqlite_kv_fetch(unqlite *pDb, const void *pKey, int nKeyLen, void *pBuf, unqlite_int64 *pSize)
    cdef int unqlite_kv_fetch_callback(
        unqlite *pDb, const void *pKey,int nKeyLen,
        int (*xConsumer)(const void *pData, unsigned int iDataLen, void *pUserData), void *pUserData)
    cdef int unqlite_kv_delete(unqlite *pDb, const void *pKey, int nKeyLen)
    cdef int unqlite_kv_config(unqlite *pDb, int iOp, ...)

    #iterator
    cdef int unqlite_kv_cursor_init(unqlite *pDb,unqlite_kv_cursor **ppOut)
    cdef int unqlite_kv_cursor_release(unqlite *pDb,unqlite_kv_cursor *pCur)
    cdef int unqlite_kv_cursor_seek(unqlite_kv_cursor *pCursor,const void *pKey,int nKeyLen,int iPos)

    cdef int unqlite_kv_cursor_first_entry(unqlite_kv_cursor *pCursor)
    cdef int unqlite_kv_cursor_last_entry(unqlite_kv_cursor *pCursor)
    cdef int unqlite_kv_cursor_valid_entry(unqlite_kv_cursor *pCursor)
    cdef int unqlite_kv_cursor_next_entry(unqlite_kv_cursor *pCursor)
    cdef int unqlite_kv_cursor_prev_entry(unqlite_kv_cursor *pCursor)
    cdef int unqlite_kv_cursor_key(unqlite_kv_cursor *pCursor,void *pBuf,int *pnByte)
    cdef int unqlite_kv_cursor_key_callback(unqlite_kv_cursor *pCursor,int (*xConsumer)(const void *,unsigned int,void *),void *pUserData)
    cdef int unqlite_kv_cursor_data(unqlite_kv_cursor *pCursor,void *pBuf,unqlite_int64 *pnData)
    cdef int unqlite_kv_cursor_data_callback(unqlite_kv_cursor *pCursor,int (*xConsumer)(const void *,unsigned int,void *),void *pUserData)
    cdef int unqlite_kv_cursor_delete_entry(unqlite_kv_cursor *pCursor)
    cdef int unqlite_kv_cursor_reset(unqlite_kv_cursor *pCursor)

    cdef const char * unqlite_lib_version()
    cdef const char * unqlite_lib_signature()
    cdef const char * unqlite_lib_ident()
    cdef const char * unqlite_lib_copyright()

    #constant values (http://unqlite.org/c_api_const.html)
    #standard return values from Symisc public interfaces
    cdef int SXRET_OK = 0
    cdef int SXERR_MEM = -1
    cdef int SXERR_IO = -2
    cdef int SXERR_EMPTY = -3
    cdef int SXERR_LOCKED = -4
    cdef int SXERR_ORANGE = -5
    cdef int SXERR_NOTFOUND = -6
    cdef int SXERR_LIMIT = -7
    cdef int SXERR_MORE = -8
    cdef int SXERR_INVALID = -9
    cdef int SXERR_ABORT = -10
    cdef int SXERR_EXISTS = -11
    cdef int SXERR_SYNTAX = -12
    cdef int SXERR_UNKNOWN = -13
    cdef int SXERR_BUSY = -14
    cdef int SXERR_OVERFLOW = -15
    cdef int SXERR_WILLBLOCK = -16
    cdef int SXERR_NOTIMPLEMENTED = -17
    cdef int SXERR_EOF = -18
    cdef int SXERR_PERM = -19
    cdef int SXERR_NOOP = -20
    cdef int SXERR_FORMAT = -21
    cdef int SXERR_NEXT = -22
    cdef int SXERR_OS = -23
    cdef int SXERR_CORRUPT = -24
    cdef int SXERR_CONTINUE = -25
    cdef int SXERR_NOMATCH = -26
    cdef int SXERR_RESET = -27
    cdef int SXERR_DONE = -28
    cdef int SXERR_SHORT = -29
    cdef int SXERR_PATH = -30
    cdef int SXERR_TIMEOUT = -31
    cdef int SXERR_BIG = -32
    cdef int SXERR_RETRY = -33
    cdef int SXERR_IGNORE = -63

    #standard UnQLite return values and error codes
    cdef int UNQLITE_OK = SXRET_OK
    cdef int UNQLITE_NOMEM = SXERR_MEM
    cdef int UNQLITE_ABORT = SXERR_ABORT
    cdef int UNQLITE_IOERR = SXERR_IO
    cdef int UNQLITE_CORRUPT = SXERR_CORRUPT
    cdef int UNQLITE_LOCKED = SXERR_LOCKED
    cdef int UNQLITE_BUSY = SXERR_BUSY
    cdef int UNQLITE_DONE = SXERR_DONE
    cdef int UNQLITE_PERM = SXERR_PERM
    cdef int UNQLITE_NOTIMPLEMENTED = SXERR_NOTIMPLEMENTED
    cdef int UNQLITE_NOTFOUND = SXERR_NOTFOUND
    cdef int UNQLITE_NOOP = SXERR_NOOP
    cdef int UNQLITE_INVALID = SXERR_INVALID
    cdef int UNQLITE_EOF = SXERR_EOF
    cdef int UNQLITE_UNKNOWN = SXERR_UNKNOWN
    cdef int UNQLITE_LIMIT = SXERR_LIMIT
    cdef int UNQLITE_EXISTS = SXERR_EXISTS
    cdef int UNQLITE_EMPTY = SXERR_EMPTY
    cdef int UNQLITE_COMPILE_ERR = -70
    cdef int UNQLITE_VM_ERR = -71
    cdef int UNQLITE_FULL = -73
    cdef int UNQLITE_CANTOPEN = -74
    cdef int UNQLITE_READ_ONLY = -75
    cdef int UNQLITE_LOCKERR = -76

    #database config commands
    cdef int UNQLITE_CONFIG_JX9_ERR_LOG = 1
    cdef int UNQLITE_CONFIG_MAX_PAGE_CACHE = 2
    cdef int UNQLITE_CONFIG_ERR_LOG = 3
    cdef int UNQLITE_CONFIG_KV_ENGINE = 4
    cdef int UNQLITE_CONFIG_DISABLE_AUTO_COMMIT = 5
    cdef int UNQLITE_CONFIG_GET_KV_NAME = 6

    #open mode flags
    cdef int UNQLITE_OPEN_READONLY = 0x00000001
    cdef int UNQLITE_OPEN_READWRITE = 0x00000002
    cdef int UNQLITE_OPEN_CREATE = 0x00000004
    cdef int UNQLITE_OPEN_EXCLUSIVE = 0x00000008
    cdef int UNQLITE_OPEN_TEMP_DB = 0x00000010
    cdef int UNQLITE_OPEN_NOMUTEX = 0x00000020
    cdef int UNQLITE_OPEN_OMIT_JOURNALING = 0x00000040
    cdef int UNQLITE_OPEN_IN_MEMORY = 0x00000080
    cdef int UNQLITE_OPEN_MMAP = 0x00000100


###
### Wrapper
###
cdef class UnQLite(object):
    cdef unqlite *p_db
    cdef unqlite_kv_cursor *p_cur
    cdef int is_memory

    def __cinit__(self):
        """
        Initializes an instance of Unqlite class.
        """

        self.p_db = <unqlite *>0
        self.p_cur = <unqlite_kv_cursor *>0
        self.is_memory = 0

    def __dealloc__(self):
        """
        Invoked whent the instance is deallocating.
        """

        try:
            self.close()
        except:
            pass

    def open(self, file_name, mode=UNQLITE_OPEN_CREATE):
        """
        Opens a new database connection.
        """

        cdef int ret = unqlite_open(&self.p_db, file_name, mode)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

        if file_name == ':mem:':
            self.is_memory = 1
            return

        ret = unqlite_config(self.p_db, UNQLITE_CONFIG_DISABLE_AUTO_COMMIT)
        if ret != UNQLITE_OK:
            raise NotImplementedError

    def config(self, operation, *args):
        """
        Configures the database handle.
        """

        raise NotImplementedError

    def close(self):
        """
        Closes the databse handle.
        """

        cdef int ret

        if self.p_db != <unqlite *>0:
            if self.p_cur != <unqlite_kv_cursor *>0:
                unqlite_kv_cursor_release(self.p_db, self.p_cur)
                self.p_cur = <unqlite_kv_cursor *>0

            #because we clear UNQLITE_CONFIG_DISABLE_AUTO_COMMIT
            #unqlite_close will call unqlite_rollback automatic.
            #if I call rollback() in python there are not journal leave.
            #but if I call from pyx, this file leave...
            #so may be this function not call from __deallocate__!
            ret = unqlite_close(self.p_db)

            if ret != UNQLITE_OK:
                raise self._build_exception_for_error(ret)

            self.p_db = <unqlite *>0

    def append(self, key, data):
        '''
        Append data to record, if not exist will create a new record!
        '''

        cdef int ret = unqlite_kv_append(self.p_db,
                <const char *>key, len(key), <const char*>data, len(data))

        if ret != 0:
            raise self._build_exception_for_error(ret)

    def store(self, key, data):
        '''
        Stores records in the databse.
        '''

        cdef int ret = unqlite_kv_store(
            self.p_db, <const char *>key, len(key), <const char *>data, len(data))

        if ret != 0:
            raise self._build_exception_for_error(ret)

    def fetch(self, key):
        '''
        Fetches a record from the database.
        '''

        cdef char *buf = <char *>0
        cdef unqlite_int64 buf_size = 0
        cdef int ret

        ret = unqlite_kv_fetch(self.p_db,
                <char *>key, len(key), <void *>0, &buf_size)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

        try:
            buf = <char *>malloc(buf_size)

            ret = unqlite_kv_fetch(self.p_db,
                    <char *>key, len(key), <void *>buf, &buf_size)
            if ret != UNQLITE_OK:
                raise self._build_exception_for_error(ret)

            #will translate to:
            #   __Pyx_PyBytes_FromStringAndSize(buf, buf_size);
            #so make sure implicit declare buf_size, do not just return buf!
            return buf[:buf_size]

        finally:
            free(buf)

    def delete(self, key):
        '''
        Removes a record from the database.
        '''

        cdef int ret = unqlite_kv_delete(self.p_db, <char *>key, len(key))
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

    def _build_exception_for_error(self, status):
        '''
        Builds an exception for an error.
        '''

        exc_map = {
            UNQLITE_NOMEM: MemoryError,
            UNQLITE_IOERR: IOError,
            UNQLITE_LOCKERR: IOError,
            UNQLITE_NOTIMPLEMENTED: NotImplementedError,
            UNQLITE_NOTFOUND: KeyError,
            UNQLITE_NOOP: NotImplementedError,
            UNQLITE_EOF: IOError,
            UNQLITE_FULL: IOError,
            UNQLITE_CANTOPEN: IOError,
            UNQLITE_READ_ONLY: IOError,
            UNQLITE_LOCKERR: IOError,
        }

        exc_klass = exc_map.get(status, Exception)
        message = self._get_last_error()

        return exc_klass(message)

    def _get_last_error(self):
        '''
        Gets last error message.
        '''

        cdef int ret
        cdef int size
        cdef char *buf = <char *>malloc(1024)

        try:
            ret = unqlite_config(self.p_db, UNQLITE_CONFIG_ERR_LOG, &buf, &size)
            if ret != UNQLITE_OK: return None

            return buf[:size]

        finally:
            free(buf)

    #transaction interface-----------------------------begin
    def begin(self):
        cdef int ret

        if self.is_memory:
            return

        ret = unqlite_begin(self.p_db)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

    def commit(self):
        cdef int ret

        if self.is_memory:
            return

        unqlite_commit(self.p_db)

        ret = unqlite_begin(self.p_db)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

    def rollback(self):
        cdef int ret

        if self.is_memory:
            return

        unqlite_rollback(self.p_db)

        ret = unqlite_begin(self.p_db)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)
    #transaction interface-------------------------------end

    #dict-like interface-------------------------------begin
    def __getitem__(self, key):
        return self.fetch(key)

    def __setitem__(self, key, value):
        self.store(key, value)

    def __delitem__(self, key):
        self.delete(key)

    def __contains__(self, key):
        cdef char *buf = <char *>0
        cdef unqlite_int64 buf_size = 0
        cdef int ret

        ret = unqlite_kv_fetch(self.p_db,
                <char *>key, len(key), <void *>0, &buf_size)
        if ret == UNQLITE_NOTFOUND:
            return False
        elif ret == UNQLITE_OK:
            return True

        raise self._build_exception_for_error(ret)

    def __len__(self):
        raise NotImplementedError

    def __iter__(self):
        cdef int ret

        #release cursor if need
        if self.p_cur != <unqlite_kv_cursor *>0:
            unqlite_kv_cursor_release(self.p_db, self.p_cur)
            self.p_cur = <unqlite_kv_cursor *>0

        ret = unqlite_kv_cursor_init(self.p_db, &self.p_cur)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

        ret = unqlite_kv_cursor_last_entry(self.p_cur)

        return self

    def __next__(self):
        cdef char *buf = <char *>0
        cdef int buf_size = 0
        cdef int ret

        ret = unqlite_kv_cursor_valid_entry(self.p_cur)
        if ret == 0:
            unqlite_kv_cursor_release(self.p_db, self.p_cur)
            self.p_cur = <unqlite_kv_cursor *>0
            raise StopIteration()

        #get key size
        ret = unqlite_kv_cursor_key(self.p_cur, <void *>0, &buf_size)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)
        
        #get key value
        try:
            buf = <char *>malloc(buf_size)
            ret = unqlite_kv_cursor_key(self.p_cur, <void *>buf, &buf_size)

            if ret != UNQLITE_OK:
                raise self._build_exception_for_error(ret)

            #when it is last element, unqlite_kv_cursor_prev_entry return not
            #UNQLITE_OK, but we use unqlite_kv_cursor_valid_entry to check.
            unqlite_kv_cursor_prev_entry(self.p_cur)

            return buf[:buf_size]

        finally:
            free(buf)
    #dict-like interface--------------------------------end

def connect(fn = None):
    db = UnQLite()
    if not fn:
        db.open(':mem:')
    else:
        db.open(fn)
    return db

def version():
    return unqlite_lib_version()

def signature():
    return unqlite_lib_signature()

def ident():
    return unqlite_lib_ident()

def copyright():
    return unqlite_lib_copyright()


