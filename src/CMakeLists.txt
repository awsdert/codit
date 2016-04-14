cmake_minimum_required (VERSION 2.6)
set (CODIT_DIR ${CMAKE_SOURCE_DIR})
set (DRIVE_DIR ${CODIT_DIR}/../..)
set (Codit_VERSION_MAJOR 1)
set (Codit_VERSION_MINOR 0)
file(GLOB fileobj "CoditFileobj*.c" "CoditFilelst*.c" "CoditFileent*.c")
file(GLOB procobj "CoditProcobj*.c" "CoditProclst*.c" "CoditProcent*.c")
#message("F=${fileobj}")
#message("P=${procobj}")
#foreach(item IN LISTS fileobj procobj)
#	message("Item=${item}")
#endforeach(item)
#return()
#cmake complains about programs if this not set before project
if (CMAKE_HOST_WIN32)
	set(ENV{PATH} "ENV{PATH};${CMAKE_FIND_ROOT_PATH}/bin")
	find_program(CMAKE_MAKE_PROGRAM mingw32-make.exe make.exe )
	find_program(CMAKE_CXX_COMPILER mingw32-g++.exe g++.exe )
	find_program(CMAKE_C_COMPILER mingw32-gcc.exe gcc.exe )
	option (Use_IUP "Use IUP Framework" OFF)
	option (Use_IUP32_W4 "Use IUP based on 32bit MinGW4" OFF)
	option (Use_IUP32_W4 "Use IUP based on 64bit MinGW4" OFF)
endif (CMAKE_HOST_WIN32)
project (codit)

if (Use_IUP32_W4)
	include_directories ("${PROJECT_SOURCE_DIR}/iup_win32_w4")
	add_subdirectory (iup_win32_w4)
	set (EXTRA_LIBS ${EXTRA_LIBS} iup_win32_w4)
endif (Use_IUP32_W4)

if (Use_IUP64_W4)
	include_directories ("${PROJECT_SOURCE_DIR}/iup_win64_w4")
	add_subdirectory (iup_win64_w4)
	set (EXTRA_LIBS ${EXTRA_LIBS} iup_win64_w4)
endif (Use_IUP64_W4)

# configure a header file to pass some of the CMake settings
# to the source code
configure_file (
	"${PROJECT_SOURCE_DIR}/CoditConfig.h.in"
	"${PROJECT_BINARY_DIR}/CoditConfig.h"
	)

# add the binary tree to the search path for include files
# so that we will find TutorialConfig.h
include_directories("${PROJECT_BINARY_DIR}")

# add the executable

add_executable(codit codit.c ${fileobj} ${procobj})
target_link_libraries (codit ${EXTRA_LIBS})

# add the install targets
if (Use_IUP32_W4)
	install (TARGETS iup_win32_w4 DESTINATION bin)
	#install (FILES iup_win32_w4.h DESTINATION include)
endif (Use_IUP32_W4)
if (Use_IUP64_W4)
	install (TARGETS iup_win64_w4 DESTINATION bin)
	#install (FILES iup_win32_w4.h DESTINATION include)
endif (Use_IUP64_W4)
install (TARGETS codit DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/CoditConfig.h" DESTINATION include)
