#include "CoditFileobj.h"
HFILEOBJ CoditOpenFileobjEx(
	const char const *path,
	int access,
	int share,
	OSSAFETY *oss,
	int openas,
	int attr,
	HFILEOBJ template )
{
	int e = 0;
	HFILEOBJ hfo =
#ifdef _WIN32
		CreateFileA( path, access, share, fattr, openas, attr, template );
#else
		calloc( sizeof( FILEOBJ ), 1 );
	if ( !hfo )
		goto done;
	if ( !(attr & FILEOBJ_ATTR_NOBUFF | FILEOBJ_ATTR_DIRECT) &&
		!( hfo->buf = malloc( BUFSIZ)) )
		goto fail;
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
		goto done;
	}
#endif
done:
	return hfo;
}

HFILEOBJ CoditShutFileobj( HFILEOBJ hfo )
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
