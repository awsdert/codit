include $(TOPDIR)syscheck.mk

#Get compiler details
include $(TOPDIR)host/$(SYSTEM)/$(THE_CC)$(THEBIT).mk

#Ensure windows.h etc know what type of executable/library is being produced
#DEBUG is to be set at command line level (eg DEBUG=1)
ifdef DEBUG
	DBG:=d_
	DBG_DEFS:=$(FD)_DEBUG $(Fgdb)
else
	DBG:=
	DBG_DEFS:=$(FD)NDEBUG $(FO)
endif

TARGET_SYS?=$(SYSTEM)
TARGET_BIT?=$(SYSBIT)

# Check what kind of executable will be generated
ifeq ($(TARGET_SYS),windows)
	TARGET_BIN_EXT:=.exe
	TARGET_LIB_EXT:=.dll
	TARGET_DIR:=win$(TARGET_BIT)
	TARGET_DEFS:=$(FD)_WIN$(TARGET_BIT)
	WINDOWS$(TARGET_BIT):=1
else
	TARGET_BIN_EXT:=
	TARGET_LIB_EXT:=.so
	TARGET_DIR:=linux
	TARGET_DEFS:=$(FD)__linux__
endif

ifdef WINDOWS64
	TARGET_DEFS+= $(FD)_WIN32
endif
CDEFS+=$(DBG_DEFS) $(TARGET_DEFS)
CFLAGS=$(FWall) $(Fstd_c99) $(CDEFS)