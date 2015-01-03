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
import os

data = '''\
amalgamation.h
unqlite.h
jx9.h
jx9Int.h
unqliteInt.h
api.c
bitvec.c
jx9_lib.c
lhash_kv.c
mem_kv.c
os.c
os_unix.c
os_win.c
pager.c
'''

def file_get_contents(fn):
    f = open(fn)
    d = f.read()
    f.close()
    return d

def file_put_contents(fn, d):
    f = open(fn, "w")
    f.write(d)
    f.close()

l = []
for fn in data.split('\n'):
    if len(fn) == 0:
        continue
    print fn
    d = file_get_contents(fn)
    l.append(d)

if os.path.isfile('unqlite.c'):
    print '"unqlite.c" already exist! skip...'
    sys.exit(-1)

amal = '\n'.join(l)
file_put_contents('unqlite.c', amal)
print 'wrote %d bytes to "unqlite.c".' % len(amal)

