#include <CoditFault.h>
#include <CoditBasic.h>
PAGES	CoditPageRequest( ULONG flags, schar pages, schar maxPages )
{
#ifdef _WIN32
	size_t size = pages * CoditPageSize();
	size_t maxSize = maxPages * CoditPageSize(); 
	size_t *ptr = (size_t*)HeapCreate( flags, size, maxSize );
	if ( !ptr )
		goto fail;
	/* Store the sizing information for easy access,
	unlikely to ever find a system where page size is smaller than this */
	ptr[0] = size;
	ptr[1] = maxSize;
fail:
	return ptr;
#else
	SetSysFault(0);
	// Pointer is not used so make it easy to identify as false pointer
	return (void*)-1;
#endif
}
schar	CoditPagesCanUse( PAGES pages )
{
	if ( !pages || pages == (void*)-1 )
		return 0;
#ifdef _WIN32
	return ((size_t*)pages)[1] / CoditPageSize();
#else
	// For now this should not be reached
	return 1;
#endif
}
PAGES	CoditPageRelease( PAGES pages )
{
#ifdef _WIN32
	if ( HeapDestroy(pages) == FALSE )
		return pages;
#endif
	SysSetFault(0);
	return NULL;
}
size_t	CoditPageSize( void )
{
#ifdef _WIN32
	SYSTEM_INFO si;
	GetSystemInfo(&si);
	return si.dwPageSize;
#else
	return sysconf(_SC_PAGESIZE);
#endif
}