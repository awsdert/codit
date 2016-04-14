#include "CoditProcobj.h"
fsize_t CoditProcobjSet( PPROCESS hPt,
	uintptr_t addr,
	void const *buff,
	fsize_t size,
	int *syserr )
{
	fsize_t b = 0;
#ifdef _WIN32
	WriteProcessMemory( hPt, (void*)addr, buff, size, &b );
#else
	seterr( ENOEXEC );
#endif
done:
	if ( syserr )
	{
		*syserr = SysGetFault;
		SysSetFault(0);
	}
	return b;
}
fsize_t CoditProcobjGet( PPROCESS hPt,
	uintptr_t addr,
	void *buff,
	fsize_t size,
	int *syserr )
{
	fsize_t b = 0;
#ifdef _WIN32
	ReadProcessMemory( hPt, (void*)addr, buff, size, &b );
#else
	seterr( ENOEXEC );
#endif
done:
	if ( syserr )
	{
		*syserr = SysGetFault;
		SysSetFault(0);
	}
	return b;
}
