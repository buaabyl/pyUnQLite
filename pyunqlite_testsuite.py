#!/bin/python
# -*- coding:utf-8 -*-
#  
#  Copyright 2013 buaa.byl@gmail.com
#
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; see the file COPYING.  If not, write to
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#
import sys
#always use newest library!
sys.path.insert(0, 'build\lib.win32-2.7')

import os
import random
import gc

#
# important: transaction is turn on by default!
# and auto-commit is disable.
#
# if you want to store json value,
# just using python library json to serialize values
# then using kv store to save json string.
# 
# I don't need jx9 json interface, so document-interface is not implement.
#
import pyunqlite

import unittest

class TestTransaction(unittest.TestCase):
    '''
    Transaction: only file-based database have transaction,
    memory-based just return. The file 'unqlite_joury' is deleted
    when commit or rollback(default action when close).
    '''
    def setUp(self):
        if os.path.isfile('testdb.tmp'):
            os.remove('testdb.tmp')

        self.db = pyunqlite.connect('testdb.tmp')
        pass

    def tearDown(self):
        self.db.close()
        os.remove('testdb.tmp')
        pass

    def testCommit(self):
        #set test value
        rvalue1 = str(random.random())
        rvalue2 = str(random.random())
        self.db['keyC1'] = rvalue1
        self.db['keyC2'] = rvalue2

        self.assertTrue('keyC1' in self.db)
        self.assertTrue('keyC2' in self.db)
        self.assertEqual(self.db['keyC1'], rvalue1)
        self.assertEqual(self.db['keyC2'], rvalue2)

        #commit changes
        self.db.commit()

        #delete key2 and not commit, so other user
        #must find that 'key2' still in db!
        del self.db['keyC2']

        #make sure this db not foud 'key2'
        self.assertTrue('keyC1' in self.db)
        self.assertFalse('keyC2' in self.db)
        self.assertEqual(self.db['keyC1'], rvalue1)

        #open and other instance and check 'key2' exist
        try:
            tmpdb = pyunqlite.connect('testdb.tmp')

            self.assertTrue('keyC1' in tmpdb)
            self.assertTrue('keyC2' in tmpdb)
            self.assertEqual(self.db['keyC1'], rvalue1)

        finally:
            tmpdb.close()

    def testRollback(self):
        #set test value
        rvalue1 = str(random.random())
        rvalue2 = str(random.random())
        self.db['keyR1'] = rvalue1
        self.db['keyR2'] = rvalue2

        self.assertTrue('keyR1' in self.db)
        self.assertTrue('keyR2' in self.db)
        self.assertEqual(self.db['keyR1'], rvalue1)
        self.assertEqual(self.db['keyR2'], rvalue2)

        self.db.commit()

        #del key2
        rvalue3 = str(random.random())
        self.db['keyR3'] = rvalue3
        del self.db['keyR2']

        self.assertTrue('keyR3' in self.db)
        self.assertEqual(self.db['keyR3'], rvalue3)
        self.assertFalse('keyR2' in self.db)

        #rollback and check again
        self.db.rollback()
        self.assertFalse('keyR3' in self.db)
        self.assertTrue('keyR2' in self.db)
        self.assertEqual(self.db['keyR2'], rvalue2)

class TestBaseInterface(unittest.TestCase):
    def setUp(self):
        self.db = pyunqlite.connect(':mem:')

    def tearDown(self):
        self.db.close()

    def testStoreDelete(self):
        self.db.store('key', 'value')
        self.assertEqual(self.db.fetch('key'), 'value')

        self.db.delete('key')

        try:
            self.db.fetch('key')
            self.assertTrue(False)
        except KeyError:
            self.assertTrue(True)
            return

    def testStoreFetchOneOp(self):
        self.db.store('key', 'value')
        self.assertEqual(self.db.fetch('key'), 'value')

    def testStoreFetchMultiOps(self):
        map_expect = {}
        for i in xrange(1000):
            map_expect[str(i)] = str(random.random())

        for k, v in map_expect.iteritems():
            self.db.store(k, v)

        for k, v in map_expect.iteritems():
            self.assertEqual(self.db.fetch(k), v)

    def testAppendFetchOp(self):
        self.db.store('key', 'value')
        self.assertEqual(self.db.fetch('key'), 'value')

        self.db.append('key', 'value')
        self.assertEqual(self.db.fetch('key'), 'valuevalue')

class TestDictInterface(unittest.TestCase):
    def setUp(self):
        self.db = pyunqlite.connect(':mem:')

    def tearDown(self):
        self.db.close()

    def testOneOp(self):
        self.db['key'] = 'value'
        self.assertEqual(self.db['key'], 'value')

    def testMultiOps(self):
        map_expect = {}
        for i in xrange(1000):
            map_expect[str(i)] = str(random.random())

        for k, v in map_expect.iteritems():
            self.db[k] = v

        for k, v in map_expect.iteritems():
            self.assertEqual(self.db[k], v)

    def testIterOp(self):
        map_expect = {}
        for i in xrange(1000):
            map_expect[str(i)] = str(random.random())

        for k, v in map_expect.iteritems():
            self.db[k] = v

        for k in self.db:
            self.assertTrue(k in map_expect)
            self.assertEqual(map_expect[k], self.db[k])

    def testLen(self):
        len(self.db)

if __name__ == '__main__':
    print 'version  :', pyunqlite.version()
    print 'ident    :', pyunqlite.ident()
    print 'signature:', pyunqlite.signature()
    print
    unittest.main()

    #print dir(pyunqlite)
    #print dir(pyunqlite.UnQLite)


