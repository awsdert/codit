cmake_minimum_required (VERSION 2.6)
message("CMAKE_PATH=${CMAKE_COMMAND}")
if(!TOPDIR)
	set(TOPDIR ${CMAKE_CURRENT_SOURCE_DIR})
endif(!TOPDIR)
set (MAKE_CODIT_VERSION_MAJOR 1)
set (MAKE_CODIT_VERSION_MINOR 0)
file(GLOB fileobj "CoditFileobj*.c" "CoditFilelst*.c" "CoditFileent*.c")
file(GLOB procobj "CoditProcobj*.c" "CoditProclst*.c" "CoditProcent*.c")
set(ENV{PATH} "ENV{PATH};${CMAKE_FIND_ROOT_PATH}/bin")
#message("F=${fileobj}")
#message("P=${procobj}")
#foreach(item IN LISTS fileobj procobj)
#	message("Item=${item}")
#endforeach(item)
#return()
#cmake complains about programs if this not set before project
if (CMAKE_HOST_WIN32)
	set(TARDIR windows)
	find_program(CMAKE_MAKE_PROGRAM mingw32-make.exe make.exe )
	find_program(CMAKE_CXX_COMPILER mingw32-g++.exe g++.exe )
	find_program(CMAKE_C_COMPILER mingw32-gcc.exe gcc.exe )
	option (MAKE_USE_ALLEGRO "Use ALLEGRO Framework" OFF)
else (CMAKE_HOST_WIN32)
	set(TARDIR unix)
	set(CMAKE_MAKE_PROGRAM make )
	set(CMAKE_CXX_COMPILER g++ )
	set(CMAKE_C_COMPILER gcc )
	option (MAKE_USE_ALLEGRO "Use ALLEGRO Framework" OFF)
endif (CMAKE_HOST_WIN32)
project (codit)
set(PROJECT_BINARY_DIR ${TOPDIR}/build/${TARDIR})
set(PROJECT_OBJECT_DIR ${TOPDIR}/obj/${TARDIR})
set(PROJECT_SOURCE_DIR ${TOPDIR}/src)
message("BINARY=${PROJECT_BINARY_DIR}")
return()

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
install (TARGETS codit DESTINATION out)
install (FILES "${PROJECT_BINARY_DIR}/CoditConfig.h" DESTINATION include)
