# distutils: sources = unqlite.c

from libc.stdlib cimport malloc, free


###
### Import
###

cdef extern from 'unqlite.h':
    # types (http://unqlite.org/c_api_object.html)
    cdef struct unqlite

    ctypedef signed long long int sxi64
    ctypedef unsigned long long int sxu64
    ctypedef sxi64 unqlite_int64

    # functions
    ## database engine handle
    cdef int unqlite_open(unqlite **ppDb, const char *zFilename, unsigned int iMode)
    cdef int unqlite_config(unqlite *pDb, int nOp, ...)
    cdef int unqlite_close(unqlite *pDb)

    ## key/value store interfaces
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

    # constant values (http://unqlite.org/c_api_const.html)
    ## Standard return values from Symisc public interfaces
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

    ## Standard UnQLite return values and error codes
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

    ## database config commands
    cdef int UNQLITE_CONFIG_JX9_ERR_LOG = 1
    cdef int UNQLITE_CONFIG_MAX_PAGE_CACHE = 2
    cdef int UNQLITE_CONFIG_ERR_LOG = 3
    cdef int UNQLITE_CONFIG_KV_ENGINE = 4
    cdef int UNQLITE_CONFIG_DISABLE_AUTO_COMMIT = 5
    cdef int UNQLITE_CONFIG_GET_KV_NAME = 6

    ## open mode flags
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

    def __cinit__(self):
        """
        Initializes an instance of Unqlite class.
        """

        self.p_db = <unqlite *>0

    def __deallocate__(self):
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
            ret = unqlite_close(self.p_db)

            if ret != UNQLITE_OK:
                raise self._build_exception_for_error(ret)

            self.p_db = <unqlite *>0

    def store(self, key, data):
        """
        Stores records in the databse.
        """

        cdef int ret = unqlite_kv_store(
            self.p_db, <const char *>key, len(key), <const char *>data, len(data))

        if ret != 0:
            raise self._build_exception_for_error(ret)

    def fetch(self, key):
        """
        Fetches a record from the database.
        """

        cdef char *buf = <char *>0
        cdef unqlite_int64 buf_size = 0
        cdef int ret

        ret = unqlite_kv_fetch(self.p_db, <char *>key, len(key), <void *>0, &buf_size)
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

        try:
            buf = <char *>malloc(buf_size)

            ret = unqlite_kv_fetch(self.p_db, <char *>key, len(key), <void *>buf, &buf_size)
            if ret != UNQLITE_OK:
                raise self._build_exception_for_error(ret)

            return buf[:buf_size]

        finally:
            free(buf)

    def delete(self, key):
        """
        Removes a record from the database.
        """

        cdef int ret = unqlite_kv_delete(self.p_db, <char *>key, len(key))
        if ret != UNQLITE_OK:
            raise self._build_exception_for_error(ret)

    def _build_exception_for_error(self, status):
        """
        Builds an exception for an error.
        """

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
        """
        Gets last error message.
        """

        cdef int ret
        cdef int size
        cdef char *buf = <char *>malloc(1024)

        try:
            ret = unqlite_config(self.p_db, UNQLITE_CONFIG_ERR_LOG, &buf, &size)
            if ret != UNQLITE_OK: return None

            return buf[:size]

        finally:
            free(buf)
