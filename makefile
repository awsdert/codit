#Check if hosted by 64bit windows or 32bit alternative
ifeq ($(ProgramW6432), "")
	SYSBIT:=32
else
	SYSBIT:=64
endif

# Check if hosted by windows or linux variant
ifdef ProgramFiles
	SYSTEM:=windows
	# Specifies 32/64bit compiler to use
	THEBIT?=$(SYSBIT)
	THE_CC?=mingw
else
	SYSTEM?=linux
	# Specifies nothing so override
	THEBIT:=
	THE_CC?=gcc
endif

#Get compiler details
include host/$(SYSTEM)/$(THE_CC)$(THEBIT).mk

ifdef DEBUG
	DBG:=d_
	FLG:=$(Fgdb)
else
	DBG:=
	FLG:=$(FO)
endif

TARSYS?=$(SYSTEM)
TARBIT?=$(SYSBIT)

# Check what kind of executable will be generated
ifeq ($(TARSYS),windows)
	TAREXE:=.exe
	TARDLL:=.dll
	TARDIR:=win$(TARBIT)
	TARFLG:=$(FD)_WIN$(TARBIT)
else
	TAREXE:=
	TARDLL:=.so
	TARDIR:=linux
	TARFLG:=$(FD)__linux__
endif

#Directories
TOPDIR?=
SRCDIR:=$(TOPDIR)src
OBJDIR:=$(TOPDIR)obj
OUTDIR:=$(TOPDIR)build
PRJOUT:=$(OUTDIR)/$(TARDIR)
PRJOBJ:=$(OBJDIR)/$(TARDIR)
PRJINC:=$(FI) $(CC_INC) $(FI) $(SRCDIR)
PRJBIN=$(FL) $(CC_LIB) $(FL) $(PRJOUT)
PRJLIB=$(FL) $(CC_LIB)
B:=$(PRJOUT)/$(DBG)
O:=$(PRJOBJ)/$(DBG)
SOURCES:=$(wildcard $(SRCDIR)/*.c)
OBJECTS:=$(patsubst %.c,$(O)%.o,$(SOURCES))
#File handling
FILE_C:=$(wildcard $(SRCDIR)/coditfile*.c)
FILE_O:=$(patsubst %.c,$(O)%.o,$(FILE_C))
#Process handling
PROC_C:=$(wildcard $(SRCDIR)/coditproc*.c)
PROC_O:=$(PROC_C:.c=.o)
#Compiler Stuff
CFLAGS:=$(PRJINC) $(PRJLIB) $(FWall) $(TARFLG) $(FLG)

all: clean help test binary

objects: help $(OBJECTS)

help:
	@echo host/${SYSTEM}/${THE_CC}${THEBIT}.mk 
	@echo ${TARSYS} ${TARBIT}bit compile
	@echo B=${B}

test: objects $(O)CoditTest.o
	${CC} ${PRJBIN} ${Fc} $< ${Fo} ${B}CoditTest${TAREXE}

binary: objects $(O)codit.o
	${CC} ${Fc} $< ${Fo} ${B}codit${TAREXE}

clean:
	${RM} ${OBJDIR}/win32/* ${OUTDIR}/win32/*
	${RM} ${OBJDIR}/win64/* ${OUTDIR}/win64/*
	${RM} ${OBJDIR}/linux/* ${OUTDIR}/linux/*

#Mingw64 absolute paths, %MGW64% is a manually created enviroment variable on
#windows, an alternative variable to make is %MAKE% which just an absolute path
#to the default make.exe (I recommend setting it to the 1st path below)
#%MGW64%\bin\mingw32-make.exe
#c:\tools\mingw64\bin\mingw32-make.exe

$(O)%.o: %.c
	${CC} ${CFLAGS} ${Fc} $< ${Fo} $@