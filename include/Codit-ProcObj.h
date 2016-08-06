#pragma once
#include "Codit-FileLst.h"
#ifdef _WIN32
#include <tlhelp32.h>
typedef HANDLE HPROCOBJ;

#define PROCESS_ACCESS_ALL PROCESS_ALL_ACCESS
#define PROCESS_ACCESS_VOP PROCESS_VM_OPERATION
#define PROCESS_ACCESS_VRD PROCESS_VM_READ
#define PROCESS_ACCESS_VRW (PROCESS_VM_READ | PROCESS_VM_WRITE)

#else

#define PROCESS_ACCESS_ALL (_O_EXEC | _O_RDWR)
#define PROCESS_ACCESS_VOP _O_EXEC
#define PROCESS_ACCESS_VRD _O_RDONLY
#define PROCESS_ACCESS_VRW _O_RDWR
typedef struct _PROCOBJ {
	int pid;
	int mem;
	int len;
	char *path;
} PROCOBJ, *HPROCOBJ;
#endif

HPROCOBJ CoditProcobjOpen( int pid, int flags );
HPROCOBJ CoditProcobjShut( HPROCOBJ hpo );

uint64_t CoditProcobjCpy(
	HPROCOBJ hpo,
	uintptr_t addr,
	void *buff,
	uint64_t size );

uint64_t CoditProcobjSet(
	HPROCOBJ hpo,
	uintptr_t addr,
	void const *buff,
	uint64_t size );
	
