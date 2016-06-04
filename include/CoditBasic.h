#pragma once
#include "CoditBuild.h"
#include <stddef.h>
#ifdef _WIN32
#include <Windows.h>
#include <Objbase.h>
#define MREQUEST( POINTER, SIZE ) HeapReAlloc( GetProcessHeap(), 0, POINTER, SIZE )
#define MRELEASE( POINTER ) HeapFree( GetProcessHeap(), 0, POINTER )
#define MEMMOV MoveMemory
#define MEMCPY CopyMemory
#define MEMSET FillMemory
#define STRLEN lstrlen
#else
#include <stdlib.h>
#define MREQUEST realloc
#define MRELEASE free
#define MEMMOV memmove
#define MEMCPY memcpy
#define MEMSET memset
#define STRLEN strlen
#endif
