CDEFS?=
#Directories
TOPDIR?=
WKSDIR:=$(dir $(lastword $(MAKEFILE_LIST)))
include $(TOPDIR)directories.mk
#Compiler Stuff
CFLAGS:=$(FWall) $(Fstd_c99) $(TARGET_FLG) $(FLG)
$(info CURDIR=$(CURDIR))
$(info WKSDIR=$(WKSDIR))

export PATH:=$(CC_BIN);$(PATH)

all: user test

include version.mk

.PHONY: clean rebuild

rebuild: clean all

objects: directories $(OBJECTS)

directories: $(ALL_DIRECTORIES)

#install: user
#	$(error Installation not yet supported)
#	$(INSTALL_CODIT)
#	$(INSTALL_ICONS)

clean:
	${RM} ${OBJDIR}* ${BINDIR}*

#Mingw64 absolute paths, %MGW64% is a manually created enviroment variable on
#windows, an alternative variable to make is %MAKE% which just an absolute path
#to the default make.exe (I recommend setting it to the 1st path below)
#%MAKE%
#%MGW64%\bin\mingw32-make.exe
#c:\tools\mingw64\bin\mingw32-make.exe

# Tell make what headers are needed for each set of objects
BASIC_H:=CoditBasic.h CoditBuild.h
FAULT_H:=CoditFault.h $(BASIC_H)
FILEOBJ_H:=CoditFileobj.h $(FAULT_H)
$(SRCDIR)/CoditFileobj%.o: $(FILEOBJ_H)
FILELST_H:=CoditFilelst.h $(FILEOBJ_H)
$(SRCDIR)/CoditFilelst%.o $(SRCDIR)/CoditFileent%.o: $(FILELST_H)
PROCOBJ_H:=CoditProcobj.h $(FILELST_H)
$(SRCDIR)/CoditProcobj%.o: $(PROCOBJ_H)
PROCLST_H:=CoditProclst.h $(PROCOBJ_H)
$(SRCDIR)/CoditProclst%.o $(SRCDIR)/CoditProcent%.o: $(PROCLST_H)
$(T)/$(TARGET_SMALL).o: $(TARGET_SMALL).h $(PROCLST_H)

$(O)$(TARGET_SMALL).o: $(T)/$(TARGET_SMALL).c
	$(COMPILE_OBJ) $(CFLAGS) $(VDEFS) $(Fc) "$<" $(Fo) "$@"

$(O)%.o: $(SRCDIR)/%.c
	$(COMPILE_OBJ) $(CFLAGS) $(VDEFS) $(Fc) "$<" $(Fo) "$@"

$(ALL_DIRECTORIES):
	$(MKDIR) "$@"