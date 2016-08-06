#pragma once
#include "Codit-Basic.h"
#ifdef _WIN32
#include <winerror.h>
#define SysGetFault()		GetLastError()
#define SysSetFault( VAL )	SetLastError( VAL )

#define FAULT_SYS_MEMORY ERROR_NOT_ENOUGH_MEMORY
#define FAULT_SYS_ACCESS ERROR_ACCESS_DENIED
#define FAULT_SYS_NOMAKE ERROR_FILE_EXISTS
#define FAULT_SYS_EXISTS ERROR_ALREADY_EXISTS
#define FAULT_SYS_PASSED 3
#define FAULT_SYS_FLIMIT ERROR_PIPE_BUSY
#define FAULT_SYS_ENTITY ERROR_FILE_NOT_FOUND
#define FAULT_SYS_SHAREV ERROR_SHARING_VIOLATION

#else
#include <errno.h>
#define SysGetFault()		errno
#define SysSetFault( VAL )	seterr( VAL )

#define FAULT_SYS_MEMORY ENOMEM
#define FAULT_SYS_ACCESS EACCES
#define FAULT_SYS_NOMAKE EEXIST
#define FAULT_SYS_EXISTS EEXIST
#define FAULT_SYS_PASSED EINVAL
#define FAULT_SYS_FLIMIT EMFILE
#define FAULT_SYS_ENTITY ENOENT
#define FAULT_SYS_SHAREV EACCES

#endif
