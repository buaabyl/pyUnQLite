/*
 * Symisc Jx9: A Highly Efficient Embeddable Scripting Engine Based on JSON.
 * Copyright (C) 2012-2013, Symisc Systems http://jx9.symisc.net/
 * Version 1.7.2
 * For information on licensing, redistribution of this file, and for a DISCLAIMER OF ALL WARRANTIES
 * please contact Symisc Systems via:
 *       legal@symisc.net
 *       licensing@symisc.net
 *       contact@symisc.net
 * or visit:
 *      http://jx9.symisc.net/
 */
/*
 * Copyright (C) 2012, 2013 Symisc Systems. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Redistributions in any form must be accompanied by information on
 *    how to obtain complete source code for the JX9 engine and any 
 *    accompanying software that uses the JX9 engine software.
 *    The source code must either be included in the distribution
 *    or be available for no more than the cost of distribution plus
 *    a nominal fee, and must be freely redistributable under reasonable
 *    conditions. For an executable file, complete source code means
 *    the source code for all modules it contains.It does not include
 *    source code for modules or files that typically accompany the major
 *    components of the operating system on which the executable file runs.
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
 * $SymiscID: jx9.c v1.7 UNIX|Win32/64 2013-01-04 09:00 stable <chm@symisc.net> $ 
 */
/* This file is an amalgamation of many separate C source files from JX9 version 1.7.2
 * By combining all the individual C code files into this single large file, the entire code
 * can be compiled as a single translation unit. This allows many compilers to do optimization's
 * that would not be possible if the files were compiled separately. Performance improvements
 * are commonly seen when JX9 is compiled as a single translation unit.
 *
 * This file is all you need to compile JX9. To use JX9 in other programs, you need
 * this file and the "jx9.h" header file that defines the programming interface to the 
 * JX9 engine.(If you do not have the "jx9.h" header file at hand, you will find
 * a copy embedded within the text of this file.Search for "Header file: <jx9.h>" to find
 * the start of the embedded jx9.h header file.) Additional code files may be needed if
 * you want a wrapper to interface JX9 with your choice of programming language.
 * To get the official documentation, please visit http://jx9.symisc.net/
 */
 /*
  * Make the sure the following directive is defined in the amalgamation build.
  */
 #ifndef JX9_AMALGAMATION
 #define JX9_AMALGAMATION
 #endif /* JX9_AMALGAMATION */
/*
 * Embedded header file for Jx9: <jx9.h>
 */