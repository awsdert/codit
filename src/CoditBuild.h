#pragma once

#ifdef LAST_COMMIT
#define CODIT_VER_MAJOR   VERSION_MAJOR
#define CODIT_VER_MINOR   VERSION_MINOR
#define CODIT_VER_BUILD   VERSION_BUILD
#define CODIT_LAST_COMMIT LAST_COMMIT
#else
#error No version information passed on
// Not supposed to reach here but just in case silence 'undefined' errors
#define CODIT_VER_MAJOR   0
#define CODIT_VER_MINOR   0
#define CODIT_VER_BUILD   0
#define CODIT_LAST_COMMIT 0
#endif