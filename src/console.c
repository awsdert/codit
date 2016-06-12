#ifdef _WIN32
#include <windows.h>
#else
#include <stdio.h>
#endif
_Bool CoditSetConsoleCodePageUTF( int is7_8_16_32, char endian )
{
#ifdef _WIN32
	int cp = 0;
	switch ( is7_8_16_32 )
	{
	case  7: cp = 65000; endian = 'l'; break;
	case  8: cp = 65001; endian = 'l'; break;
	case 16: cp =  1200; break;
	case 32: cp = 12000; break;
	// Ensure we don't accidently try to change codepage using invalid values
	default: return 0;
	}
	switch ( endian )
	{
		// 0x0D0C0B0A
		case 'l': case 'L': break;
		// 0x0A0B0C0D
		case 'b': case 'B': ++c; break;
		// 0x0B0A0D0C
		case 'm': case 'M':
		case 'p': case 'P':
		return 0;
		// 0x0C0D0A0B, u here stands for unkown
		case 'u': case 'U':
		// Prevemt invalid endian
		default:
		return 0;
	}
	SetConsoleCP( 12000 );
	return 1;
#else
	return 0;
#endif
}
void CoditPutChr( int chr )
{
#ifdef _WIN32
	WriteConsole( GetStdHandle( STD_OUTPUT_HANDLE ), &chr, 1, NULL, NULL );
#else
	putchar( chr );
#endif
}
void CoditPutStr( char *str )
{
	if ( !str )
		return;
#ifdef _WIN32
	size_t len = CoditStrLen( str );
	str[len] = '\n';
	WriteConsole( GetStdHandle( STD_OUTPUT_HANDLE ), str, len, NULL, NULL );
	str[len] = 0;
#else
	puts( str );
#endif
}
