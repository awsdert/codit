#include <CoditFault.h>
#include <CoditBasic.h>
void*	CoditMemRequest( PAGES pages, ULONG flags, size_t size )
{
#ifdef _WIN32
	return HeapAlloc( pages, flags, size );
#else
	void *ptr = malloc( size );
	if ( flags & FLAG_MEM_CLEAR_MEMORY )
		return memset( ptr, 0, size );
	return ptr;
#endif
}
void*	CoditMemReplace( PAGES pages, ULONG flags, void *ptr, size_t size, size_t newSize )
{
#ifdef _WIN32
	return HeapReAlloc( pages, flags, ptr, newSize );
#else
	char *tmp = (char*)realloc( ptr, newSize );
	if ( !tmp )
		goto fail;
	if ( flags & FLAG_MEM_CLEAR_MEMORY && newSize > size )
		memset( &tmp[size], 0, newSize - size );
fail:
	return tmp;
#endif
}
void*	CoditMemRelease( PAGES pages, ULONG flags, void *ptr )
{
	if ( !pages || !ptr
#ifdef _WIN32
		|| HeapFree( pages, flags, ptr ) == FALSE
#endif
		// In theory this will never be reached
		) return ptr;
#ifndef _WIN32
	free( ptr );
#endif
	return NULL;
}