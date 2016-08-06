#include <Codit-Proclst.h>
#ifndef _WIN32
BOOL coditProcobjStatAlloc( struct dirent *ent, PROCSTAT *stat )
{
	char const *formatpath = "/proc/%s/stat";
	char *path = (char*)calloc( strlen(formatpath) + strlen(ent->d_name), 1 );
	if ( !path ) return FALSE;
	sprintf( path, formatpath, ent->d_name );
	BOOL result = FALSE;
	FILE *file = fopen( path );
	if ( !file ) goto failFile;
	fseek( file, 0, SEEK_END );
	// Safest way to ensure comm has enough space
	long leng = ftell( file ) - ((sizeof(int) * 7) + 1);
	if ( stat->leng < leng )
	{
		char *comm = (char*)realloc( stat->comm, leng + 1 ); 
		if ( !comm )
			goto failComm;
		memset( comm, 0, leng + 1 );
		stat->comm = comm;
		stat->leng = leng;
	}
	fseek( file, 0, SEEK_SET );
	if ( fscanf( "%d%s%c%d%d%d%d%d%u", &stat->pid, stat->comm,
		&stat->state, &stat->ppid, &stat->pgrp, &stat->session,
		&stat->tty_nr, &stat->tpgid, &stat->flags ) == 9 )
		result = TRUE;
failComm:
	fclose( file );
failFile:
	free( path );
	return result;
}
void coditProcobjStatFree( PROCSTAT *stat )
{
	if ( stat && stat->comm )
	{
		free( stat->comm );
		stat->comm = NULL;
		stat->len = 0;
	}
}
#endif
