#include <CoditProclst.h>
#include <stdio.h>

short VERSION_MAJOR = MK_VERSION_MAJOR;
short VERSION_MINOR = MK_VERSION_MINOR;
short VERSION_BUILD = MK_VERSION_BUILD;
long  LAST_COMMIT	= MK_LAST_COMMIT;

void listAllFile(void);
void listAllProc(void);
int main ( int argc, char *argv[] )
{
	char *txt = calloc( sizeof(argv[0]) + 15, 1 );
	sprintf( txt , "%s Version:%hi.%hi.%hi", argv[0],
		VERSION_MAJOR, VERSION_MINOR, VERSION_BUILD );
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
	if ( CoditFilelstPrepAPI() == FALSE )
		return EXIT_FAILURE;
	listAllFile();
	return EXIT_SUCCESS;
}

void listAllFile( void )
{
	char *name = NULL;
	int leng;
	char *path =
#ifdef _WIN32
		NULL, *temp;
	leng = 256;
	path = MREQUEST( NULL, leng );
	if ( !path ) return;
	while (	GetCurrentDirectoryA( leng, path ) == FALSE &&
		GetLastError() == ERROR_NOT_ENOUGH_MEMORY )
	{
		temp = (char*)MREQUEST( path, leng += 256 );
		if ( !temp )
		{
			MRELEASE( path );
			return;
		}
	}
#else
		getcwd();
#endif
	HFILELST hfl = CoditFilelstOpen( path );
	FILEENT fe = {0};
	if ( CoditFilelst1st( hfl, &fe ) == FALSE )
		goto failList;
	do
	{
		CoditFileentName( &fe, &name, &leng );
#if USE_IUP
		IupMessageBox( "File Entry", name );
#else
		fputs(name, stdout);
#endif
	}
	while ( CoditFilelstNxt( hfl, &fe ) == TRUE );
failList:
	// Safest way to force cleanup
	while ((hfl = CoditFilelstShut( hfl )));
}

void listAllProc( void )
{
	char *name = NULL;
	int leng = 0;
	HPROCLST hpl = CoditProclstOpen( 0 );
	if ( !hpl ) return;
	PROCENT pe = {0};
#ifdef _WIN32
	pe.dwSize = sizeof( PROCENT );
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
	} while ( CoditProclstNxt( hpl, &pe ) == TRUE );
done:
	while ( (hpl = CoditProclstShut( hpl )) );
}
