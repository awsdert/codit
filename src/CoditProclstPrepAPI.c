#include "CoditProcobj.h"

BOOL CoditProclstPrepAPI( void )
{
#ifdef _WIN32
	CreateTH32SnapShot = (CreateTH32SnapShot_t)ProcessFindAddress(
		GetCurrentProcess(), "CreateToolhelp32Snapshot" );
	CoditProcobj1st = (ProcNxt_t)ProcessFindAddress(
		GetCurrentProcess(), "Process32First" );
	CoditProcobjNxt = (ProcNxt_t)ProcessFindAddress(
		GetCurrentProcess(), "Process32Next" );
	if ( !CreateTH32SnapShot || !CoditProcess1st || !CoditProcessNxt )
		return FALSE;
#endif
	return TRUE;
}
