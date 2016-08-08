#pragma once

#ifndef CODIT_CORE_MAJOR
#error CODIT_CORE_* should be defined via compiler line in makefile
#define CODIT_CORE_MAJOR	0
#define CODIT_CORE_MINOR	0
#define CODIT_CORE_BUILD	0
#define CODIT_LAST_COMMIT	0
#endif

// Check how to share functions as a shared library
#ifdef _WIN32
#define DLL_EXPORT __declspec(dllexport)
#define DLL_IMPORT __declspec(dllimport)
#else
#define DLL_EXPORT extern
#define DLL_IMPORT
#endif

// Check if we a shared library is involved or using inbuilt (default)
#ifdef CODIT_CORE_EXPORT
#define CODIT_CORE_API DLL_EXPORT
#elif defined( CODIT_CORE_IMPORT )
#define CODIT_CORE_API DLL_IMPORT
#else
#define CODIT_CORE_API
#endif

typedef   signed char	schar_t;
typedef unsigned char	uchar_t;
typedef unsigned short	ushort_t;
typedef unsigned int	uint_t;
typedef unsigned long	ulong_t;

extern const ushort_t codit_core_major;
extern const ushort_t codit_core_minor;
extern const ushort_t codit_core_build;
extern const ulong_t  codit_last_commit;