/*
 * Symisc unQLite: An Embeddable NoSQL (Post Modern) Database Engine.
 * Copyright (C) 2012-2013, Symisc Systems http://unqlite.org/
 * Version 1.1.6
 * For information on licensing, redistribution of this file, and for a DISCLAIMER OF ALL WARRANTIES
 * please contact Symisc Systems via:
 *       legal@symisc.net
 *       licensing@symisc.net
 *       contact@symisc.net
 * or visit:
 *      http://unqlite.org/licensing.html
 */
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
/*
 * $SymiscID: unqlite.c v1.1.6 Unix|Win32/64 2013-07-05 04:34:40 stable <chm@symisc.net> $ 
 */
/* This file is an amalgamation of many separate C source files from unqlite version 1.1.6
 * By combining all the individual C code files into this single large file, the entire code
 * can be compiled as a single translation unit. This allows many compilers to do optimization's
 * that would not be possible if the files were compiled separately. Performance improvements
 * are commonly seen when unqlite is compiled as a single translation unit.
 *
 * This file is all you need to compile unqlite. To use unqlite in other programs, you need
 * this file and the "unqlite.h" header file that defines the programming interface to the 
 * unqlite engine.(If you do not have the "unqlite.h" header file at hand, you will find
 * a copy embedded within the text of this file.Search for "Header file: <unqlite.h>" to find
 * the start of the embedded unqlite.h header file.) Additional code files may be needed if
 * you want a wrapper to interface unqlite with your choice of programming language.
 * To get the official documentation, please visit http://unqlite.org/
 */
 /*
  * Make the sure the following directive is defined in the amalgamation build.
  */
 #ifndef UNQLITE_AMALGAMATION
 #define UNQLITE_AMALGAMATION
 #define JX9_AMALGAMATION
 /* Marker for routines not intended for external use */
 #define JX9_PRIVATE static
 #endif /* UNQLITE_AMALGAMATION */
/*
 * Embedded header file for unqlite: <unqlite.h>
 */