#include <lua.h>
#include <lauxlib.h>

#include <time.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "ngx_md5.h"


void md5_to_hex(char *dst, char *src) {
    int i = 0;
    for (i = 0; i < 16; i++) {
        u_int a = (u_char) src[i];
        sprintf(dst + (2 * i), "%02x", a); 
    }
}

static int 
md5_update(lua_State *L) {
    size_t sz = 0;
    char tmp[16];
    char result[32];
    char *buffer = tmp; 
    ngx_md5_t md5;

    const uint8_t * text = (const uint8_t *)luaL_checklstring(L, 1, &sz);
    ngx_md5_init(&md5);
    ngx_md5_update(&md5, (void *)text, (size_t) sz);
    ngx_md5_final((u_char *)buffer, &md5);
    md5_to_hex(result, buffer);
    lua_pushlstring(L, result, 32);
    return 1;
}

static struct luaL_Reg md5_lib[] =
{
    { "update", md5_update},
    { NULL, NULL }     
};

int
luaopen_md5(lua_State *L) {
    luaL_checkversion(L);
    luaL_newlib(L,md5_lib);
    return 1;
}