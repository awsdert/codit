#pragma once

#ifndef MK_VERSION_MAJOR
#error MK_VERSION_* should be defined via compiler line in makefile
#define MK_VERSION_MAJOR 0
#define MK_VERSION_MINOR 0
#define MK_VERSION_BUILD 0
#define MK_LAST_COMMIT	 0
#endif

extern short VERSION_MAJOR;
extern short VERSION_MINOR;
extern short VERSION_BUILD;
extern long  LAST_COMMIT;