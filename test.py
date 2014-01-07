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
import pyunqlite
import random
import gc

print dir(pyunqlite)

print pyunqlite.version()
print pyunqlite.ident()
print pyunqlite.signature()

#Transaction:
# only file-based database have transaction
# memory-based just return.
#
#the file 'unqlite_joury' is delete when commit
#and some of rollback

db = pyunqlite.connect('test.unqlite')
#db = pyunqlite.connect()

print 'ITER begin:'
for k in db:
    print k, ':', db[k]
print 'ITER end'


#db.begin()
rvalue = str(random.random())
print 'set exist=', rvalue
db['exist'] = rvalue
db['notexist'] = '1'
del db['notexist']
print 'check "exist" in db:', 'exist' in db
print 'check "notexist" in db:', 'notexist' in db

#db.rollback()

print 'ROLLBACK'

print 'ITER begin:'
for k in db:
    print k, ':', db[k]
print 'ITER end'

#db.close()
#db.rollback()
#db.commit()

del db
gc.collect()

