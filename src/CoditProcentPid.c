#include "CoditProcobj.h"
int CoditProcentPid( PPROCENT ppe )
{
#ifdef _WIN32
	return ppe->pid;
#else
#error CoditProcentPid() does nothing!
	return -1;
#endif
}
