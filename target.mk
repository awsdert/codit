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

TARSYS?=$(SYSTEM)
TARBIT?=$(SYSBIT)

# Check what kind of executable will be generated
ifeq ($(TARSYS),windows)
	TAREXE:=.exe
	TARDLL:=.dll
	TARDIR:=win$(TARBIT)
	TARFLG:=$(FD)_WIN$(TARBIT)
	WINDOWS$(TARBIT):=1
else
	TAREXE:=
	TARDLL:=.so
	TARDIR:=linux
	TARFLG:=$(FD)__linux__
endif

ifdef WINDOWS64
	TARFLG+= $(FD)_WIN32
endif