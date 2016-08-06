#include <Codit-Proclst.h>
BOOL CoditProceentName( PAGES pages, PPROCENT ppe, char **name, int *leng )
{
	if ( !ppe || !name || !leng )
		return FALSE;
	char *n = *name, *exe = NULL;
	void *tmp = NULL;
	int l = *leng, min =
#ifdef _WIN32
		CoditStrLen( (exe = ppe->szExeFile) ) + 1;
#else
		ppe->len + 1;
	exe = *ppe->comm;
#endif
	if ( min > l )
	{
		tmp = n ? CoditMemReplace( pages, 0, n, l, min ) :
			CoditMemRequest( pages, 0, min );
		if ( !tmp )
		{
			CoditDebugPuts( "CoditProceentName(): Could not allocate text" )
			return FALSE;
		}
		l = min;
		n = (char*)tmp;
	}
	if ( n )
	{
		MEMSET( n, 0, l );
		MEMCPY( n, exe, l );
		if ( leng ) *leng = name ? l : 0;
		if ( name ) *name = n;
		else
		{
			CoditDebugPuts( "CoditProceentName(): parameter <name> was NULL" )
			CoditMemRelease( pages, 0, n );
		}
		return TRUE;
	}
	return FALSE;
}




