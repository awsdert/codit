#include <CoditProclst.h>
#include <stdio.h>

CreateTH32Snapshot_t CreateTH32Snapshot = NULL;
BOOL CoditProclstPrepAPI( void )
{
	BOOL result = FALSE;
#ifdef _WIN32
	HANDLE k32 = GetModuleHandleA("kernel32");
	CoditDebugPuts( "Attempting to get Process pointers" )
	if ( !(CreateTH32Snapshot = CreateToolhelp32Snapshot) &&
		!(CreateTH32Snapshot = (CreateTH32Snapshot_t)
			GetProcAddress( k32, "CreateToolhelp32Snapshot" )) )
	{
		CoditDebugPuts( "Failed CreateToolhelp32Snapshot" )
		goto fail;
	}
	if ( !(CoditProclst1st = Process32First) &&
		!(CoditProclst1st =	(ProcNxt_t)
			GetProcAddress( k32, "Process32First" )) )
	{
		CoditDebugPuts( "Failed Process32First" )
		--result;
		goto fail;
	}
	if ( !(CoditProclstNxt = Process32Next) &&
		!(CoditProclstNxt =	(ProcNxt_t)
			GetProcAddress( k32, "Process32Next" )) )
	{
		CoditDebugPuts( "Failed Process32Next" )
		result -= 2;
		goto fail;
	}
	result = TRUE;
#endif
fail:
	return result;
}
