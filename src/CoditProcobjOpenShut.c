#include <CoditProcobj.h>

HPROCOBJ CoditProcobjOpen( int access, int pid )
{
	HPROCOBJ hpo =
#ifdef _WIN32
		OpenProcess( access, FALSE, pid );
#else
		calloc( sizeof( PROCESS ), 1 );
	if ( !hpo )
		return NULL;
	hpo->pid = pid;
	hpo->mem = _open( path, _O_BINARY | access, _S_RDWR );
#endif
	return hpo;
}

HPROCOBJ CoditProcobjShut( HPROCOBJ hpo )
{
#ifdef _WIN32
	CloseHandle( hpo );
#else
	_close( hpo->mem );
	free( hpo );
#endif
	return NULL;
}
