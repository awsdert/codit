#include "CoditProcobj.h"

PPROCESS CoditProcobjOpen( int access, int pid, int *syserr )
{
	int e = 0;
	PPROCESS hPt =
#ifdef _WIN32
		OpenProcess( access, FALSE, pid );
#else
		calloc( sizeof( PROCESS ), 1 );
	if ( !hPt )
		goto done;
	hPt->pid = pid;
	hPt->mem = _open( path, _O_BINARY | access, _S_RDWR );
#endif
done:
	if ( syserr )
	{
		*syserr = SysGetFault;
		SysSetFault(0);
	}
	return hProc;
}

PPROCESS CoditProcobjShut( PPROCESS hPt )
{
#ifdef _WIN32
	CloseHandle( hPt );
#else
	_close( hPt->mem );
	free( hPt );
#endif
	return NULL;
}