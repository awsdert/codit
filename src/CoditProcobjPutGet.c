#include <CoditProcobj.h>
uint64_t CoditProcobjSet( HPROCOBJ hpo,
	uintptr_t addr,
	void const *buff,
	uint64_t size )
{
#ifdef _WIN32
	SIZE_T b = 0;
	WriteProcessMemory( hpo, (void*)addr, buff, size, &b );
#else
	size_t b = 0;
	seterr( ENOEXEC );
#endif
	return b;
}
uint64_t CoditProcobjGet( HPROCOBJ hpo,
	uintptr_t addr,
	void *buff,
	uint64_t size )
{
#ifdef _WIN32
	SIZE_T b = 0;
	ReadProcessMemory( hpo, (void*)addr, buff, size, &b );
#else
	size_t b = 0;
	seterr( ENOEXEC );
#endif
	return b;
}
