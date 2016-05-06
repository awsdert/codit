#include "CoditProcobj.h"
fsize_t CoditProcobjSet( HPROCOBJ hpo,
	uintptr_t addr,
	void const *buff,
	fsize_t size )
{
	fsize_t b = 0;
#ifdef _WIN32
	WriteProcessMemory( hpo, (void*)addr, buff, size, &b );
#else
	seterr( ENOEXEC );
#endif
	return b;
}
fsize_t CoditProcobjGet( HPROCOBJ hpo,
	uintptr_t addr,
	void *buff,
	fsize_t size )
{
	fsize_t b = 0;
#ifdef _WIN32
	ReadProcessMemory( hpo, (void*)addr, buff, size, &b );
#else
	seterr( ENOEXEC );
#endif
	return b;
}
