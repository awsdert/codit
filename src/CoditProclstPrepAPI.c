#include <CoditProclst.h>
CreateTH32SnapShot_t CreateTH32SnapShot = NULL;
CloseTH32SnapShot_t CloseTH32SnapShot = NULL;
BOOL CoditProclstPrepAPI( void )
{
#ifdef _WIN32
	CreateTH32SnapShot = (CreateTH32SnapShot_t)GetProcAddress(
		GetCurrentProcess(), "CreateToolhelp32Snapshot" );
	CloseTH32SnapShot = (CloseTH32SnapShot_t)GetProcAddress(
		GetCurrentProcess(), "CloseToolhelp32Snapshot" );
	CoditProclst1st = (ProcNxt_t)GetProcAddress(
		GetCurrentProcess(), "Process32First" );
	CoditProclstNxt = (ProcNxt_t)GetProcAddress(
		GetCurrentProcess(), "Process32Next" );
	if ( !CreateTH32SnapShot || !CloseTH32SnapShot ||
		!CoditProclst1st || !CoditProclstNxt )
		return FALSE;
#endif
	return TRUE;
}
