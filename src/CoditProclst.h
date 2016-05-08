#pragma once
#include "CoditProcobj.h"

#ifdef _WIN32
typedef HANDLE HPROCLST;
typedef PROCESSENTRY32 PROCENT, *PPROCENT;
typedef HANDLE (WINAPI *CreateTH32SnapShot_t)( DWORD, DWORD );
typedef BOOL (WINAPI *CloseTH32SnapShot_t)( HANDLE );
typedef BOOL (WINAPI *ProcNxt_t)( HANDLE, LPPROCESSENTRY32 );
extern CreateTH32SnapShot_t CreateTH32SnapShot;
extern CloseTH32SnapShot_t CloseTH32SnapShot;
extern ProcNxt_t CoditProclstNxt;
#else
typedef struct _PROCLST {
	int ppid;
	DIR *proc;
} PROCLST, *HPROCLST;
typedef struct _PROCSTAT {
	int pid;
	char *comm;
	long leng;
	char state;
	int ppid;
	int pgrp;
	int session;
	int tty_nr;
	int tpgid;
	unsigned int flags;
} PROCSTAT, *PPROCSTAT;
BOOL coditProcessStat( HPROCOBJ hProc, PROCSTAT *stat );
void coditProcessStatFree( PROCSTAT *stat );
typedef struct _PROCENT {
	PROCSTAT stat;
	struct dirent *ent;
} PROCENT;
typedef BOOL (*ProcNxt_t)( HPROCLST, PPROCENT );
BOOL CoditProclstNxt( HPROCLST hpl, PPROCENT ppe );
#endif
extern ProcNxt_t CoditProclst1st;
BOOL CoditProclstPrepAPI( void );
HPROCLST CoditProclstOpen( int parent );
HPROCLST CoditProclstShut( HPROCLST hpl );
BOOL CoditProceentName( PPROCENT ppe, char **name, int *leng );
