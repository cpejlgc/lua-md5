MD5_VERSION = 1.0.3
LUA_VERSION =   5.3

# See http://lua-users.org/wiki/BuildingModules for platform specific
# details.

## Linux/BSD
PREFIX ?=          ../skynet/3rd/lua
LDFLAGS +=         -shared

## OSX (Macports)
#PREFIX ?=          /opt/local
#LDFLAGS +=         -bundle -undefined dynamic_lookup

LUA_INCLUDE_DIR ?= $(PREFIX)/
LUA_LIB_DIR ?=     ../skynet/luaclib/

# Some versions of Solaris are missing isinf(). Add -DMISSING_ISINF to
# CFLAGS to work around this bug.

#CFLAGS ?=          -g -Wall -pedantic -fno-inline
CFLAGS ?=          -g -O3 -Wall -pedantic
override CFLAGS += -fpic -I$(LUA_INCLUDE_DIR) -DVERSION=\"$(MD5_VERSION)\"

INSTALL ?= install

.PHONY: all clean install package

all: md5.so

md5.so: lua-md5.o ngx_md5.o
	$(CC) $(LDFLAGS) -o $@ $^

install:
	$(INSTALL) md5.so $(LUA_LIB_DIR) 

clean:
	rm -f *.o *.so

package:
	git archive --prefix="lua-cjson-$(CJSON_VERSION)/" master | \
		gzip -9 > "lua-cjson-$(CJSON_VERSION).tar.gz"
	git archive --prefix="lua-cjson-$(CJSON_VERSION)/" \
		-o "lua-cjson-$(CJSON_VERSION).zip" master
