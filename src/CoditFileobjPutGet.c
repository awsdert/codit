#include <CoditFileobj.h>

// For private usage since not needed else at the moment
void CoditFileobjSeek( HFILEOBJ hfo, uint64_t addr )
{
#ifdef _WIN32
	LARGE_INTEGER i;
	if ( addr > INT64_MAX )
	{
		i.QuadPart = (LONGLONG)INT64_MAX;
		SetFilePointerEx( hfo, i, NULL, FILEOBJ_SEEK_SET );
		i.QuadPart = (LONGLONG)(addr - INT64_MAX);
		SetFilePointerEx( hfo, i, NULL, FILEOBJ_SEEK_CUR );
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

uint64_t CoditFileobjPut(
	HFILEOBJ hFt,
	uintptr_t addr,
	void const *buff,
	uint64_t size )
{
	CoditFileobjSeek( hFt, addr );
#ifdef _WIN32
	DWORD b = 0;
	WriteFile( hFt, buff, size, &b, NULL );
#else
	uint64_t b = 0;
	b = _write( hFt, buff, size );
#endif
	return b;
}

uint64_t CoditFileobjGet(
	HFILEOBJ hFt,
	uintptr_t addr,
	void *buff,
	uint64_t size )
{
	CoditFileobjSeek( hFt, addr );
#ifdef _WIN32
	DWORD b = 0;
	ReadFile( hFt, buff, size, &b, NULL );
#else
	uint64_t b = 0;
	b = _read( hFt, buff, size );
#endif
	return b;
}


