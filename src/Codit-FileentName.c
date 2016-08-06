#include <Codit-Filelst.h>

BOOL CoditFileentName( PFILEENT pfe, char **name, int *leng )
{
	int l;
	char *d = NULL;
#ifdef _WIN32
	TCHAR *s = pfe->data.cFileName;
	for ( l = 0; *s ; ++s, ++l )
	{
		if ( *s > CHAR_MAX || *s < CHAR_MIN )
			goto done;
	}
	s = pfe->data.cFileName;
	d = (char*)MREQUEST( NULL, l + 1 );
	if ( !d )
		goto done;
	for ( int i = 0; i < l; ++i )
		d[i] = (char)s[i];
	d[l] = '\0';
done:
#else
	d = MREQUEST( NULL, (l = STRLEN( pfe->d_name )) );
	MEMCPY( d, pfe->d_name, l );
	d[l] = 0;
#endif
	if ( leng )
		*leng = d ? l : 0;
	if ( name )
	{
		*name = d;
		return d ? TRUE : FALSE;
	}
	else
		MRELEASE( d );
	return FALSE;
}
