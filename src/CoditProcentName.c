#include "CoditProclst.h"
BOOL CoditProceentName( PPROCENT ppe, char **name, int *leng )
{
	char *n = name ? *name : NULL, *exe = NULL;
	void *tmp = NULL;
	int l = leng ? *leng : (n ? strlen(n) : 0), min =
#ifdef _WIN32
		STRLEN( (exe = ppe->szExeFile) ) + 1;
#else
		ppe->len + 1;
	exe = *ppe->comm;
#endif
	if ( min > l )
	{
		tmp = MREQUEST( NULL, min );
		if ( !tmp ) return FALSE;
		l = min;
		n = (char*)tmp;
	}
	if ( n )
	{
		MEMSET( n, 0, l );
		MEMCPY( n, exe, l );
		if ( leng ) *leng = l;
		if ( name ) *name = n;
		else MRELEASE( name );
		return TRUE;
	}
	return FALSE;
}




