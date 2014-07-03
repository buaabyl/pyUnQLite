/*
 *  Copyright 2013 buaa.byl@gmail.com
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to
 *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unqlite.h>

int main(int argc, char* argv[])
{
    int i,rc;
    unqlite *pDb;

    char zKey[12];
    char zData[1024];
    const char *zBuf;
    int iLen;
    unqlite_int64 len = 0;

    //rc = unqlite_open(&pDb, ":mem:",UNQLITE_OPEN_CREATE);
    rc = unqlite_open(&pDb, "test.unqlite",UNQLITE_OPEN_CREATE);
    if ( rc != UNQLITE_OK ) {
        return;
    }

    rc = unqlite_kv_store(pDb,"test",-1,"Hello World",11); //test => 'Hello World'
    if ( rc != UNQLITE_OK ) {
        return;
    }

    rc = unqlite_kv_store_fmt(pDb,"date",-1,"Current date: %d:%d:%d",2013,06,07);
    if ( rc != UNQLITE_OK ) {
        return;
    }

    rc = unqlite_kv_store(pDb,"msg",-1,"*",1);
    rc = unqlite_kv_append(pDb,"msg",-1,"Hello, ",7);
    if ( rc == UNQLITE_OK ) {
        rc = unqlite_kv_append(pDb,"msg",-1,"Current time is: ",17);
        if ( rc == UNQLITE_OK ) {
            rc = unqlite_kv_append_fmt(pDb,"msg",-1,"%d:%d:%d.",10,16,53);
        }
    }

    memset(zData, 0, sizeof(zData));
    len = sizeof(zData);
    rc = unqlite_kv_fetch(pDb, "msg", -1, zData, &len);
    if (rc == UNQLITE_OK) {
        printf("%s:\"%s\"\n", "msg", zData);
    }

    unqlite_kv_delete(pDb,"test",-1);

    if ( rc != UNQLITE_OK ) {
        unqlite_config(pDb,UNQLITE_CONFIG_ERR_LOG,&zBuf,&iLen);
        if ( iLen > 0 ) {
            puts(zBuf);
        }
        if ( rc != UNQLITE_BUSY && rc != UNQLITE_NOTIMPLEMENTED ) {
            printf("Error\n");
        }
    }

    printf("all done\n");

    unqlite_close(pDb);

    return 0;
}

