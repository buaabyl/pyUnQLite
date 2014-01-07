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
import os
import re
from hashlib import md5

regex_file = re.compile(r'^[ *]+File: ([0-9a-zA-Z_.-]+)\W*$')
regex_md5  = re.compile(r'^[ *]+MD5: ([0-9a-fA-F]+)\W*$')

def file_get_contents(fn):
    f = open(fn, 'r')
    d = f.read()
    f.close()
    return d

def file_put_contents(fn, d):
    f = open(fn, 'w')
    f.write(d)
    f.close()

if __name__ == '__main__':
    target_dir = sys.argv[2]
    v = file_get_contents(sys.argv[1])

    lines = v.split('\n')
    nr_lines = len(lines)

    fn = 'amalgamation.h'
    md5_value = ''
    lst_line = []

    print fn

    i = 0
    while i < nr_lines:
        line = lines[i]

        res = regex_file.match(line)
        if res:
            fn_new = res.groups()[0]

            line = lines[i + 1]
            res = regex_md5.match(line)
            if res:
                md5_value = res.groups()[0]
            else:
                print 'error'
                break

            i += 4

            lst_line.pop(-1)
            lst_line.pop(-1)

            if len(lst_line) > 0:
                text = '\n'.join(lst_line)
                file_put_contents(os.path.join(target_dir, fn), text)
                print '%s (wrote)' % (md5(text).hexdigest())

                del lst_line
                del text
                fn = fn_new
                lst_line = []

            print
            print fn_new
            print md5_value

            continue

        lst_line.append(line)

        i += 1
        pass

    if len(lst_line) > 0:
        text = '\n'.join(lst_line)
        file_put_contents(os.path.join(target_dir, fn), text)
        print '%s (wrote)' % (md5(text).hexdigest())
        del lst_line
        del text
        fn = fn_new
        lst_line = []



