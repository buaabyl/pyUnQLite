#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

import pyunqlite

# creates in-memory database
db = pyunqlite.UnQLite()
db.open(':mem:')

# key/value store
db.store('foo', 'bar')
print db.fetch('foo')

db.delete('foo')

# closes the database
db.close()
