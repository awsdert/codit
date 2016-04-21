#pragma once
#include "CoditBasic.h"
#include <stdint.h>
#ifdef _WIN32
typedef DWORD fsize_t;
typedef HANDLE HFILEOBJ;
typedef SECURITY_ATTRIBUTES OSSAFETY;
#define FILEOBJ_RECREATE	CREATE_ALWAYS
#define FILEOBJ_CREATION	CREATE_NEW
#define FILEOBJ_MKIFNONE	OPEN_ALWAYS
#define FILEOBJ_EXISTING	OPEN_EXISTING
#define FILEOBJ_TRUNCATE	TRUNCATE_EXISTING

#define FILEOBJ_ATTR_NORMAL FILE_ATTRIBUTE_NORMAL
#define FILEOBJ_ATTR_DIRECT FILE_WRITE_THROUGH
#define FILEOBJ_ATTR_NOBUFF FILE_NO_BUFFER
#define FILEOBJ_ATTR_SHARER FILE_SHARE_READ
#define FILEOBJ_ATTR_SHAREW FILE_SHARE_WRITE

#define FILEOBJ_SEEK_SET	FILE_BEGIN
#define FILEOBJ_SEEK_CUR	FILE_CURRENT
#define FILEOBJ_SEEK_END	FILE_END
#else
#include <io.h>
#ifndef BOOL
#define BOOL int
#endif

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

typedef unsigned int fsize_t;
typedef struct _FILEOBJ {
	int fd;
	char *buf;
} FILEOBJ, *HFILEOBJ;
// Function handlers will be provided later
typedef struct _OSSAFETY {
	int sid;
	int gid;
	void *dacl;
	void *sacl;
} OSSAFETY;

#define FILEOBJ_RECREATE	_O_CREAT | _O_TRUNC
#define FILEOBJ_CREATION	_O_CREAT | _O_EXCL
#define FILEOBJ_MKIFNONE	_O_CREAT
#define FILEOBJ_EXISTING	0
#define FILEOBJ_TRUNCATE	_O_TRUNC

#define FILEOBJ_ATTR_NORMAL 0
// These two are treated the same here
#define FILEOBJ_ATTR_DIRECT 1
#define FILEOBJ_ATTR_NOBUFF 2

#define FILEOBJ_SEEK_SET	SEEK_SET
#define FILEOBJ_SEEK_CUR	SEEK_CUR
#define FILEOBJ_SEEK_END	SEEK_END
#endif

HFILEOBJ CoditFileobjOpenEx(
	const char const *path,
	int access,
	int share,
	OSSAFETY *oss,
	int openas,
	int attr,
	HFILEOBJ template );
HFILEOBJ CoditFileobjOpen( const char const *path, int flags );
HFILEOBJ CoditFileobjShut( HFILEOBJ hfo );

fsize_t CoditFileobjGet(
	HFILEOBJ hfo,
	uintptr_t addr,
	void *buff,
	fsize_t size );

fsize_t CoditFileobjPut(
	HFILEOBJ hfo,
	uintptr_t addr,
	void const *buff,
	fsize_t size );
