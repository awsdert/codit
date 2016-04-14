#include "fileobj.h"


fsize_t CoditFileobjPut(
	HFILEOBJ hFt,
	uintptr_t addr,
	void const *buff,
	fsize_t size,
	int *syserr )
{
	fsize_t b = 0;
#ifdef _WIN32
	SetFilePointerEx( hFt, addr, NULL, FILEOBJ_SEEK_SET );
	WriteFileEx( hFt, buff, size, &b, NULL );
#else
	_seek( hFt, addr, FILEOBJ_SEEK_SET );
	b = _write( hFt, buff, size );
#endif
}

fsize_t CoditFileobjGet(
	HFILEOBJ hFt,
	uintptr_t addr,
	void *buff,
	fsize_t size,
	int *syserr )
{
	fsize_t b = 0;
#ifdef _WIN32
	SetFilePointerEx( hFt, addr, NULL, FILEOBJ_SEEK_SET );
	ReadFileEx( hFt, buff, size, &b, NULL );
#else
	_seek( hFt, addr, FILEOBJ_SEEK_SET );
	b = _read( hFt, buff, size );
#endif
}


