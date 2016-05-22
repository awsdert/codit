include $(TOPDIR)syscheck.mk

#Get compiler details
include $(TOPDIR)host/$(SYSTEM)/$(THE_CC)$(THEBIT).mk

#Ensure windows.h etc know what type of executable/library is being produced
#DEBUG is to be set at command line level (eg DEBUG=1)
ifdef DEBUG
	DBG:=d_
	FLG:=$(FD)_DEBUG $(Fgdb)
else
	DBG:=
	FLG:=$(FD)NDEBUG $(FO)
endif

TARGET_SYS?=$(SYSTEM)
TARGET_BIT?=$(SYSBIT)

# Check what kind of executable will be generated
ifeq ($(TARGET_SYS),windows)
	TARGET_EXE:=.exe
	TARGET_DLL:=.dll
	TARGET_DIR:=win$(TARGET_BIT)
	TARGET_FLG:=$(FD)_WIN$(TARGET_BIT)
	WINDOWS$(TARGET_BIT):=1
else
	TARGET_EXE:=
	TARGET_DLL:=.so
	TARGET_DIR:=linux
	TARGET_FLG:=$(FD)__linux__
endif

ifdef WINDOWS64
	TARGET_FLG+= $(FD)_WIN32
endif