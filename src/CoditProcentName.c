#include "CoditProclst.h"
BOOL CoditProceentName( PPROCENT ppe, char **name, int *leng )
{
	char *n = name ? *name : NULL, *exe = NULL;
	void *tmp = NULL;
	int l = leng ? *leng : (n ? strlen(n) : 0), min =
#ifdef _WIN32
		lstrlen( (exe = ppe->szExe) ) + 1;
#else
		ppe->len + 1;
	exe = *ppe->comm;
#endif
	if ( min > l )
	{
		tmp = VREQUEST( NULL, min );
		if ( !tmp ) return FALSE;
		l = min;
		n = (char*)tmp;
	}
	if ( n )
	{
		MEMSET( n, 0, l );
		MEMCPY( n, ppe->szExe, l );
		if ( leng ) *leng = l;
		if ( name ) *name = n;
		else VRELEASE( name );
		return TRUE;
	}
	return FALSE;
}




