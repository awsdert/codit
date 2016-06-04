#include <CoditProclst.h>
CreateTH32Snapshot_t CreateTH32Snapshot = NULL;
CloseTH32Snapshot_t CloseTH32Snapshot = NULL;
BOOL CoditProclstPrepAPI( void )
{
#ifdef _WIN32
	CreateTH32Snapshot = (CreateTH32Snapshot_t)GetProcAddress(
		GetCurrentProcess(), "CreateToolhelp32Snapshot" );
	CloseTH32Snapshot = (CloseTH32Snapshot_t)GetProcAddress(
		GetCurrentProcess(), "CloseToolhelp32Snapshot" );
	CoditProclst1st = (ProcNxt_t)GetProcAddress(
		GetCurrentProcess(), "Process32First" );
	CoditProclstNxt = (ProcNxt_t)GetProcAddress(
		GetCurrentProcess(), "Process32Next" );
	if ( !CreateTH32Snapshot || !CloseTH32Snapshot ||
		!CoditProclst1st || !CoditProclstNxt )
		return FALSE;
#endif
	return TRUE;
}
