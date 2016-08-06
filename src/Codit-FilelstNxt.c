#include <Codit-Filelst.h>

BOOL CoditFilelst1st( HFILELST hfl, PFILEENT pfe )
{
	if ( !hfl || !pfe ) return FALSE;
#ifdef _WIN32
	pfe->ent = FindFirstFile( hfl, &pfe->data );
#else
	pfe->ent = readdir( hfl );
#endif
	return pfe->ent ? TRUE : FALSE;
}

BOOL CoditFilelstNxt( HFILELST hfl, PFILEENT pfe )
{
	if ( !hfl || !pfe ) return FALSE;
#ifdef _WIN32
	if ( FindNextFile( pfe->ent, &pfe->data ) == TRUE )
		return TRUE;
	FindClose( pfe->ent );
	return FALSE;
#else
	pfe->ent = readdir( hfl );
	return pfe->ent ? TRUE : FALSE;
#endif
}
