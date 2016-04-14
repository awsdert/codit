#include "CoditProcobj.h"
#include <stdio.h>
#include <stdlib.h>
int main ( int argc, char *argv[] )
{
	char *txt = calloc( sizeof(argv[0]) + 15, 1 );
	sprintf( txt , "%s Version:%d.%d", argv[0],
		CODIT_VERSION_MAJOR, CODIT_VERSION_MINOR );
#if USE_IUP
	IupMessageBox( "Codit", txt );
#else
	fputs( txt, stdout );
#endif
	free( txt );
	// Need to ensure we dont' try to use NULL as a function
	if ( CoditProclstPrepAPI() == FALSE )
		return EXIT_FAILURE;
	listAllProc();
	return EXIT_SUCCESS;
}

void listAllProc( void )
{
	char *name = NULL;
	int leng = 0;
	HPROCLST hpl = CoditProclstOpen( 0 );
	if ( !hpl ) return;
	PROCENT pe = {0};
#ifdef _WIN32
	pe->dwSize = sizeof( PROCENT );
#endif
	if ( CoditProclst1st( hpl, &pe ) == FALSE )
		goto done;
	do
	{
		CoditProceentName( &pe, &name, &leng );
#if USE_IUP
		IupMessageBox( "Process Entry", name );
#else
		fputs( name, stdout );
#endif
	} while ( CoditProclstNxt( hpl, &hpe ) == TRUE );
done:
	while ( (hpl = CoditProclstShut( hpl )) );
}
