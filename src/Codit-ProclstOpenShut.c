#include <Codit-Proclst.h>
#ifdef _WIN32
HPROCLST CoditProclstOpen( int ppid )
{
	return CreateTH32Snapshot( TH32CS_SNAPPROCESS, ppid );
}
HPROCLST CoditProclstShut( HPROCLST hpl )
{
	if ( CloseHandle( hpl ) == TRUE )
		return NULL;
	return hpl;
}
#else
HPROCLST CoditProclstOpen( int ppid )
{
	HPROCLST hpl = calloc( sizeof( PROCLST ), 1 );
	if ( hpl )
	{
		hpl->proc = opendir( "/proc" );
		if ( !hpl->proc )
		{
			free( hpl );
			return NULL;
		}
		hpl->ppid = ppid;
	}
	return hpl;
}
HPROCLST CoditProclstShut( HPROCLST hpl )
{
	closedir( hpl->proc );
	free( hpl );
	return NULL;
}
#endif
