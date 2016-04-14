#include "CoditFilelst.h"
HFILELST CoditFilelstOpen( const char const *path )
{
	HFILELST hfl = (HFILELST)
#ifdef _WIN32
		HeapAlloc( GetProcessHeap(), HEAP_ZERO_MEMORY, strlen(path) + 1 );
	if ( !hfl ) return NULL;
	(void)CopyMemory( hfl, path, strlen(path) );
#else
		calloc( strlen(path) + 1, 1 );
	if ( !hfl ) return NULL;
	memcpy( hfl, path, strlen(path) );
#endif
	return hfl;
}
HFILELST CoditFilelstShut( HFILELST hfl )
{
#ifdef _WIN32
	HeapFree( GetProcessHeap(), hfl );
#else
	free( hfl );
#endif
	return NULL;
}
