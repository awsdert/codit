#include "CoditProclst.h"
#ifdef _WIN32
ProcNxt_t CoditProclstNxt = NULL;
#else
BOOL CoditProclstNxt( HPROCLST hpl, PPROCENT ppe )
{
	if ( !ppe ) return FALSE;
	if ( !hpl ) goto fail;
	ppe->ent = readdir( hpl->proc );
	if ( hpl->ppid <= 0 )
		return TRUE;
	if ( coditProcentStatAlloc( ppe->ent, &ppe->stat ) == FALSE )
		goto fail;
	BOOL result = FALSE;
	if ( ppe->stat.ppid == hpl->ppid )
		result = TRUE;
fail:
	coditProcentStatFree( &ppe->stat );
	return result;
}
#endif

ProcNxt_t CoditProclst1st =
#ifdef _WIN32
	NULL;
#else
	CoditProclstNxt;
#endif
