#include "CoditFileobj.h"

void CoditFileobjSeek( HFILEOBJ hfo, uintptr_t addr )
{
#ifdef _WIN32
	LARGE_INTEGER i;
	if ( addr > INT64_MAX )
	{
		i.QuadPart = (LONGLONG)(UINT64_MAX - addr);
		SetFilePointerEx( hfo, i, NULL, FILEOBJ_SEEK_END );
	}
	else
	{
		i.QuadPart = (LONGLONG)addr;
		SetFilePointerEx( hfo, i, NULL, FILEOBJ_SEEK_SET );
	}
#else
	_seek( hfo, addr, FILEOBJ_SEEK_SET );
#endif
}

fsize_t CoditFileobjPut(
	HFILEOBJ hFt,
	uintptr_t addr,
	void const *buff,
	fsize_t size )
{
	fsize_t b = 0;
	CoditFileobjSeek( hFt, addr );
#ifdef _WIN32
	WriteFile( hFt, buff, size, &b, NULL );
#else
	b = _write( hFt, buff, size );
#endif
	return b;
}

fsize_t CoditFileobjGet(
	HFILEOBJ hFt,
	uintptr_t addr,
	void *buff,
	fsize_t size )
{
	fsize_t b = 0;
	CoditFileobjSeek( hFt, addr );
#ifdef _WIN32
	ReadFile( hFt, buff, size, &b, NULL );
#else
	b = _read( hFt, buff, size );
#endif
	return b;
}


