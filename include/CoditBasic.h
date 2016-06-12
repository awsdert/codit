#pragma once
#include "CoditBuild.h"
#include <stddef.h>
typedef   signed char schar;
typedef unsigned char uchar;
#ifdef _WIN32
#include <Windows.h>
#include <Objbase.h>
typedef HANDLE PAGES;
#define FLAG_P_NEED_EXECUTE HEAP_CREATE_ENABLE_EXECUTE
#define FLAG_P_REPORT_FAULT HEAP_GENERATE_EXCEPTIONS
#define FLAG_P_NO_SERIALIZE HEAP_NO_SERIALIZE
#define FLAG_M_REPORT_FAULT HEAP_GENERATE_EXCEPTIONS
#define FLAG_M_NO_SERIALIZE HEAP_NO_SERIALIZE
#define FLAG_M_CLEAR_MEMORY HEAP_ZERO_MEMORY
#define FLAG_M_MUST_NOT_MOV HEAP_REALLOC_IN_PLACE_ONLY
#define MEMMOV MoveMemory
#define MEMCPY CopyMemory
#define MEMSET FillMemory
size_t CoditStrLen( char *str );
#else
#include <stdlib.h>
#include <unistd.h>
typedef         void* PAGES;
typedef unsigned long ULONG;
// Temporary
#define FLAG_P_NEED_EXECUTE 0x40000
#define FLAG_P_REPORT_FAULT 0x4
#define FLAG_P_NO_SERIALIZE 0x1
#define FLAG_M_MUST_NOT_MOV 0x10
#define FLAG_M_CLEAR_MEMORY 0x8
#define FLAG_M_REPORT_FAULT 0x4
#define FLAG_M_NO_SERIALIZE 0x1
#define MEMMOV memmove
#define MEMCPY memcpy
#define MEMSET memset
#define CoditStrLen strlen
#endif
#ifdef _DEBUG
void	coditDebugPuts( char const * const txt );
#define CoditDebugPuts( TXT ) coditDebugPuts( TXT );
#else
#define CoditDebugPuts( NOT_USED_IN_NON_DEBUG_BINARY )
#endif
size_t	CoditPageSize( void );
PAGES	CoditPageRequest( ULONG flags, schar pages, schar maxPages );
schar	CoditPagesCanUse( PAGES pages );
PAGES	CoditPageRelease( PAGES pages );
void*	CoditMemRequest( PAGES pages, ULONG flags, size_t size );
void*	CoditMemReplace(
	PAGES pages, ULONG flags, void *ptr, size_t size, size_t newSize );
void*	CoditMemRelease( PAGES pages, ULONG flags, void *ptr );