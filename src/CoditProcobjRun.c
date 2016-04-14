#include "CoditProcobj.h"

PPROCESS CoditProcobjRun( char *path, char *options )
{
	PPROCESS hPt =
#ifdef _WIN32
		CreateProcess( path, options );
#else
		malloc( sizeof(PROCESS) );
#endif
}
