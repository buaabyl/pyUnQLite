pyUnQLite
=========

TODO
-------
* Add AES-256 support to unqlite.

TIPS
-------
If you don't like amalgamation style, I wrote a script to extract source code from unqlite.c: https://github.com/buaabyl/pyUnQLite/tree/master/unpack-unqlite

Introduction
-------
A UnQLite NoSQL DB for python. Using cython for adapter.

An this is unofficial python bindings for [UnQLite](http://unqlite.org/), an embeddable NoSQL database engine.

I don't like official python bindings, so decided to use new way.

This bindings support python buildin 'dict' interface, such as

```python
db['key'] = value
if 'key' in db:
    print '"key" exist'
for k in db:
    v = db[k]
    print k, v
    
if 'key' in db:
    del db['key']
````

Example 1 (original use)
-------

```python
import pyunqlite

db = pyunqlite.UnQLite()
db.open('/tmp/test.db')

db.store('foo', 'bar')
print db.fetch('foo')  # => 'bar'

db.delete('foo')

db.close()
```

Example 2 (dict like use)
-------

```python
import pyunqlite

#sqlite3 like
db = pyunqlite.connect('test.unqlite')

#dict like set and delete
db['exist'] = 'hello world'
db['notexist'] = '1'
db.commit()

del db['notexist']
print 'check "exist" in db:', 'exist' in db
print 'check "notexist" in db:', 'notexist' in db

#dict like iter
print 'ITER:'
for k in db:
    print k, ':', db[k]

db.rollback()

#dict like iter
print 'ITER:'
for k in db:
    print k, ':', db[k]

```

which will print out 

    check "exist" in db: True
    check "notexist" in db: False
    ITER:
    exist : hello world
    ITER:
    notexist : 1
    exist : hello world


Installation
------------

    $ # pip
    $ pip install cython
    $ # or setuptools
    $ easy_install -Z cython
    $
    $ cd path/to/pyunqlite/source/code/directory
    $ python setup.py build
    $ python setup.py install
    $


Files
-----

* __example.py__: original usage example of py-unqlite
* __pyunqlite.pyx__: UnQLite python wrapper written in [Cython](http://cython.org/)
* __unqlite.c__, __unqlite.h__: [UnQLite 1.1.6 source code](http://unqlite.org/downloads.html)


Credits
-------

### UnQLite

    /*
     * Copyright (C) 2012, 2013 Symisc Systems, S.U.A.R.L [M.I.A.G Mrad Chems Eddine <chm@symisc.net>].
     * All rights reserved.
     *
     * Redistribution and use in source and binary forms, with or without
     * modification, are permitted provided that the following conditions
     * are met:
     * 1. Redistributions of source code must retain the above copyright
     *    notice, this list of conditions and the following disclaimer.
     * 2. Redistributions in binary form must reproduce the above copyright
     *    notice, this list of conditions and the following disclaimer in the
     *    documentation and/or other materials provided with the distribution.
     *
     * THIS SOFTWARE IS PROVIDED BY SYMISC SYSTEMS ``AS IS'' AND ANY EXPRESS
     * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
     * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR
     * NON-INFRINGEMENT, ARE DISCLAIMED.  IN NO EVENT SHALL SYMISC SYSTEMS
     * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
     * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
     * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
     * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
     * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
     * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
     * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     */
     
I copy the original version from https://bitbucket.org/east301/py-unqlite, version 1f1e3ab-2013.07.06
the creator not update it, so I decided to maintain.
