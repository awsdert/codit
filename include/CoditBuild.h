#pragma once

#ifndef MK_VERSION_MAJOR
#error MK_VERSION_* should be defined via compiler line in makefile
#define MK_VERSION_MAJOR 0
#define MK_VERSION_MINOR 0
#define MK_VERSION_BUILD 0
#define MK_LAST_COMMIT	 0
#endif

extern unsigned short VERSION_MAJOR;
extern unsigned short VERSION_MINOR;
extern unsigned short VERSION_BUILD;
extern unsigned long  LAST_COMMIT;