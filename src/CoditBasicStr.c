#include <CoditFault.h>
#include <CoditBasic.h>
#ifdef _DEBUG
#include <stdio.h>
void coditDebugPuts( char const * const txt )
{
	puts( txt );
}
#endif
#ifdef _WIN32
size_t CoditStrLen( char *str )
{
	if ( !str ) return 0;
	size_t c = 0;
	for ( ; (*str) != 0; ++str, ++c );
	return c;
}
#endif