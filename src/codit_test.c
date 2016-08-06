#include <Codit-Proclst.h>
#include <stdio.h>

unsigned short	VERSION_MAJOR = MK_VERSION_MAJOR;
unsigned short	VERSION_MINOR = MK_VERSION_MINOR;
unsigned short	VERSION_BUILD = MK_VERSION_BUILD;
unsigned long	LAST_COMMIT   = MK_LAST_COMMIT;

void listAllFile( PAGES pages );
void listAllProc( PAGES pages );
void SysErr2Str( int id, char *dst, size_t size );

int main ( int argc, char *argv[] )
{
	int result = EXIT_FAILURE, apiresult = 0;
	PAGES pages = CoditPageRequest( 0, 1, 1 );
	if ( !pages )
		goto fail;
	size_t size = CoditStrLen(argv[0]) +
		// Allow room for outer limits
		CoditStrLen(" Version:00000.000.000") + 1;
#ifdef _WIN32
	printf( "Attempting Text Allocation, %I64u\n", size );
#else
	printf( "Attempting Text Allocation, %zu\n", size );
#endif
	char *txt = (char*)CoditMemRequest( pages, FLAG_M_CLEAR_MEMORY, size );
	if ( !txt )
		goto fail_after_pages;
	CoditDebugPuts( "Success!" )
	snprintf( txt, size, "%s Version:%hu.%hu.%hu", argv[0],
		VERSION_MAJOR, VERSION_MINOR, VERSION_BUILD );
	puts( txt );
	// Need to ensure we dont' try to use NULL as a function
	if ( (apiresult = CoditProclstPrepAPI()) <= FALSE )
		goto fail_after_txt;
	listAllProc( pages );
	if ( (apiresult = CoditFilelstPrepAPI()) <= FALSE )
		goto fail_after_txt;
	listAllFile( pages );
	result = EXIT_SUCCESS;
fail_after_txt:
	SysErr2Str( SysGetFault(), txt, size );
	puts( txt );
	CoditMemRelease( pages, 0, txt );
#ifdef _DEBUG
	Sleep(5000);
#endif
fail_after_pages:
	CoditPageRelease( pages );
fail:
	return (result + apiresult);
}

void SysErr2Str( int id, char *dst, size_t size )
{
	if ( !dst )
		return;
	MEMSET( dst, 0, size );
#ifdef _WIN32
	FormatMessageA( FORMAT_MESSAGE_FROM_SYSTEM,
		NULL, id, 0, dst, size, NULL );
#endif
}

void listAllFile( PAGES pages )
{
	char *name = NULL;
	int leng = 256, newLeng;
	char *path =
#ifdef _WIN32
		CoditMemRequest( pages, 0, leng ), *temp;
	if ( !path )
		return;
	while (	GetCurrentDirectoryA( leng, path ) == FALSE &&
		GetLastError() == ERROR_NOT_ENOUGH_MEMORY )
	{
		newLeng = leng + 256;
		temp = (char*)CoditMemReplace( pages, 0, path, leng, newLeng );
		if ( !temp )
			goto fail_after_path;
		path = temp;
	}
#else
		getcwd();
#endif
	CoditDebugPuts( "listAllFile(): Path Success!" )
	HFILELST hfl = CoditFilelstOpen( path );
	if ( !hfl )
#ifdef _WIN32
		goto fail_after_path;
#else
		return;
#endif
	CoditDebugPuts( "listAllFile(): File List Success!" )
	FILEENT fe = {0};
	if ( CoditFilelst1st( hfl, &fe ) == FALSE )
		goto fail_after_list;
	CoditDebugPuts( "listAllFile(): File Entry Success!" )
	do
	{
		CoditFileentName( &fe, &name, &leng );
		puts( name );
	}
	while ( CoditFilelstNxt( hfl, &fe ) == TRUE );
fail_after_list:
	// Safest way to force cleanup
	while ((hfl = CoditFilelstShut( hfl )));
#ifdef _WIN32
fail_after_path:
	CoditMemRelease( pages, 0, path );
#endif
}

void listAllProc( PAGES pages )
{
	char *name = NULL;
	int leng = 0;
	CoditDebugPuts( "listAllProc(): Attempting to open process list snapshot" )
	HPROCLST hpl = CoditProclstOpen( 0 );
	if ( !hpl ) return;
	CoditDebugPuts( "listAllProc(): Process List Success!" )
	PROCENT pe = {0};
#ifdef _WIN32
	pe.dwSize = sizeof( PROCENT );
#endif
	if ( CoditProclst1st( hpl, &pe ) == FALSE )
		goto done;
	CoditDebugPuts( "listAllProc(): Process Entry Success!" )
	do
	{
		if ( CoditProceentName( pages, &pe, &name, &leng ) == TRUE )
			puts( name );
		else
			puts( "Cannot allocate enough characters" );
	} while ( CoditProclstNxt( hpl, &pe ) == TRUE );
done:
	while ( (hpl = CoditProclstShut( hpl )) );
}
