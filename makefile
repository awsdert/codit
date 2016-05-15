#Directories
TOPDIR?=
CDEFS?=
MAIN_C=codit.c
MAIN_O=codit.o
include $(TOPDIR)directories.mk
include mkfunc/domath.mk
include builddata.mk
#Compiler Stuff
CFLAGS:=$(PRJINC) $(PRJLIB) $(FWall) $(Fstd_c99) $(TARFLG) $(FLG)

#$(info HERE=$(HERE))
$(info CURDIR=$(CURDIR))
$(info WKSDIR=$(WKSDIR))
$(info host/$(SYSTEM)/$(THE_CC)$(THEBIT).mk) 
$(info $(TARSYS) $(TARBIT)bit compile)
#$(info B=$(B))
#$(info O=$(O))
#$(info SOURCES=$(SOURCES))
#$(info OBJECTS=$(OBJECTS))
#$(error Build cancelled by force)

export PATH:=$(CC_BIN);$(PATH)

all: user test

# Only stable code should be used in this one
include user.mk
# Any experimtental code should be tested here, may be distributed for public
# testing
include test.mk

.PHONY: clean src/CoditBuild.c src/CoditHEAD.c $(TEST_VERSION_FILE) $(USER_VERSION_FILE)

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

$(O)%.o: src/%.c
	${CC} ${CFLAGS} $(VDEFS) ${Fc} "$<" ${Fo} "$@"
	
$(DEPDIR):
	$(MKDIR) "${DEPDIR}"
	
executable:
	${CC} ${PRJBIN} ${Fc} $(OBJECTS) $(MAIN_O) ${Fo} ${B}$(MAIN_FILE)t${TAREXE}