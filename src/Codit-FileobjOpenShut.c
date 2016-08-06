#include <Codit-FileObj.h>
HFILEOBJ CoditFileobjOpenEx(
	const char const *path,
	int access,
	int share,
	OSSAFETY *oss,
	int openas,
	int attr,
	HFILEOBJ template )
{
	HFILEOBJ hfo =
#ifdef _WIN32
		CreateFileA( path, access, share, oss, openas, attr, template );
#else
		calloc( sizeof( FILEOBJ ), 1 );
	if ( !hfo )
		goto done;
	if ( !(attr & FILEOBJ_ATTR_NOBUFF | FILEOBJ_ATTR_DIRECT) &&
		!( hfo->buf = malloc( BUFSIZ)) )
		goto fail;
	/* Mimic Windows an set this by default,
	rare that a user app would need otherwise and
	they can just use _open directly when they do */
	int pmode = _S_IREAD;
	if ( access & 0222 )
		pmode |= _S_IWRITE;
	hfo->fd = _open( path, access | openas | attr | share, pmode );
	if ( hfo->fd < 0 )
	{
		if ( hfo->buf )
			free( hfo->buf );
	fail:
		free( hfo );
		hfo = NULL;
	}
#endif
	return hfo;
}

HFILEOBJ CoditFileobjOpen( const char const *path, int access )
{
	return CoditFileobjOpenEx( path, access, 0, NULL,
		FILEOBJ_MKIFNONE, FILEOBJ_ATTR_NORMAL, NULL );
}

HFILEOBJ CoditFileobjShut( HFILEOBJ hfo )
{
#ifdef _WIN32
	CloseHandle( hfo );
#else
	_close( hfo->fd );
	if ( hfo->buf )
		free( hfo->buf );
	free( hfo );
#endif
	return NULL;
}
