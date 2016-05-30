#include <CoditProclst.h>
int CoditProcentPid( PPROCENT ppe )
{
#ifdef _WIN32
	return ppe->th32ProcessID;
#else
	return ppe->stat.pid;
#endif
}
