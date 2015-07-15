lua-md5 

封装nginx/src/core/ 里面的md5模块代码

使用方法:

local md5 = require "md5"

local result = md5.update("hello world")

print(result)


编译只需要修改Makefile

PREFIX ?=          ../skynet/3rd/lua               #改成你的lua include
LDFLAGS +=         -shared

LUA_INCLUDE_DIR ?= $(PREFIX)/
LUA_LIB_DIR ?=     ../skynet/luaclib/              #改成你要的安装目录



联系方式:
e-mail:myfishlgc#163.com