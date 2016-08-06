#include <Codit-ProcObj.h>

HPROCOBJ CoditProcobjRun( char *path, char *options )
{
	
#ifdef _WIN32
		NULL;
	PROCESS_INFORMATION pi = {0};
	//pi.dwSize = sizeof(PROCESS_INFORMATION);
	if ( CreateProcessA( path, options, NULL, NULL, FALSE,
			0, // TODO: provide flags support
			NULL, NULL, NULL, &pi ) == TRUE )
		return pi.hProcess;
	return NULL;
#else
	HPROCOBJ hpo = calloc( sizeof(PROCOBJ), 1 );
	if ( !hpo )
		return NULL;
#error Linux/OSX version of CoditProcobjRun does not try and execute path
	free( hpo );
	hpo = NULL;
	return hpo;
#endif
}
