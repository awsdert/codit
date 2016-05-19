#Directories
TOPDIR?=
CDEFS?=
include $(TOPDIR)directories.mk
#Compiler Stuff
CFLAGS:=$(PRJINC) $(PRJLIB) $(FWall) $(Fstd_c99) $(TARFLG) $(FLG)
$(info CURDIR=$(CURDIR))
$(info WKSDIR=$(WKSDIR))

export PATH:=$(CC_BIN);$(PATH)

all: user test

include version.mk

.PHONY: clean

rebuild: clean all

objects: version directories $(OBJECTS) $(MAIN_O)

directories: $(DEPDIR)
	
#install: user
#	$(error Installation not yet supported)
#	$(INSTALL_CODIT)
#	$(INSTALL_ICONS)

clean:
	${RM} ${OBJDIR}* ${OUTDIR}*


#Mingw64 absolute paths, %MGW64% is a manually created enviroment variable on
#windows, an alternative variable to make is %MAKE% which just an absolute path
#to the default make.exe (I recommend setting it to the 1st path below)
#%MAKE%
#%MGW64%\bin\mingw32-make.exe
#c:\tools\mingw64\bin\mingw32-make.exe

#CoditConfig.h:
#	"#define CODIT_MAJOR ${COMPILE_MAJOR}"	> "${O}$@"
#	"#define CODIT_MINOR ${SYSTEM_NAME}}"	>> "${O}$@"
#	"#define CODIT_BUILD ${COMPILE_BUILD}"	>> "${O}$@"
#	"#define SYSTEM_NAME ${COMPILE_MAJOR}"	>> "${O}$@"
#	"#define SYSTEM_VERS ${SYSTEM_NAME}}"	>> "${O}$@"

$(O)%.o: $(TOPDIR)src/%.c
	${CC} ${CFLAGS} $(VDEFS) ${Fc} "$<" ${Fo} "$@"
	
$(DEPDIR):
	$(MKDIR) "${DEPDIR}"

executable:
	${CC} ${PRJBIN} ${Fc} $(OBJECTS) $(MAIN_O) ${Fo} ${B}$(OUT)