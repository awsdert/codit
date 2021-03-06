#pragma once
#include "Codit-FileObj.h"

#ifdef _WIN32
typedef char  *HFILELST;
typedef struct FILEENT_
{
	WIN32_FIND_DATA data;
	HANDLE ent;
} FILEENT, *PFILEENT;
#else
#include <dirent.h>
typedef DIR *HFILELST;
typedef struct dirent *PFILEENT;
#endif
BOOL CoditFilelstPrepAPI( void );
HFILELST CoditFilelstOpen( const char const *path );
HFILELST CoditFilelstShut( HFILELST hfl );
BOOL CoditFilelst1st( HFILELST hfl, PFILEENT pfe );
BOOL CoditFilelstNxt( HFILELST hfl, PFILEENT pfe );
BOOL CoditFileentName( PFILEENT pfe, char **name, int *leng );
