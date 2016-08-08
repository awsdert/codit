#include <Codit-ProcLst.h>

#ifdef _WIN32
BOOL WINAPI DllMain( HINSTANCE instance )
{
	return TRUE;
}
#else
int main( void )
{
	return EXIT_SUCCESS;
}
#endif