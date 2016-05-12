#Directories
TOPDIR?=
include $(TOPDIR)directories.mk
BUILD_NUMBER_FILE=buildnumber.txt
#include buildnumber.mk
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

rebuild: clean test dobuild

objects: directories $(OBJECTS)

directories: $(DEPDIR)

test: objects $(O)CoditTest.o
	${CC} ${PRJBIN} ${Fc} $(OBJECTS) $(O)CoditTest.o ${Fo} ${B}CoditTest${TAREXE}

dobuild: objects $(O)codit.o
	${CC} ${Fc} $< ${Fo} ${B}codit${TAREXE}
	
install: dobuild
	$(error Installation not yet supported)
	$(INSTALL_CODIT)
	$(INSTALL_ICONS)

.PHONY: clean src/CoditBuild.c src/CoditHEAD.c $(BUILD_NUMBER_FILE)
clean:
	${RM} ${OBJDIR}* ${OUTDIR}*

#Mingw64 absolute paths, %MGW64% is a manually created enviroment variable on
#windows, an alternative variable to make is %MAKE% which just an absolute path
#to the default make.exe (I recommend setting it to the 1st path below)
#%MAKE%
#%MGW64%\bin\mingw32-make.exe
#c:\tools\mingw64\bin\mingw32-make.exe

domath_str=$(shell $(sh_let) math_result="$(1)" $(sh_addcmd) $(sh_getlet) math_result)
$(info domath_str=$(domath_str))
domath=$(subst math_result=,,$(subst  ,,$(call domath_str,$(1))))
$(info domath=$(domath))
HEAD_PATH:=$(WKSDIR).git$(DIRSEP)logs$(DIRSEP)HEAD
#$(info PATH=$(HEAD_PATH))
HEAD_SAFEP:=$(subst \,\\,$(HEAD_PATH))
#$(info SAFEP=$(HEAD_SAFEP))
HEAD_COUNT_STR:=$(shell find /c " +" $(HEAD_PATH))
#$(info COUNT_STR=$(HEAD_COUNT_STR))
# % ignores case so we don't need to go out of our way to convert our path to
# uppercase however it only works in patsubst which ignores the ----------
# before the path so we get subst to remove the left over leaving the number we
# wanted
HEAD_COUNT:=$(subst ---------- ,,$(patsubst %:,,$(HEAD_COUNT_STR)))
#$(info COUNT=$(HEAD_COUNT))
HEAD_NMONE:=$(call domath,$(HEAD_COUNT) - 1)
$(info NMONE=$(HEAD_NMONE))
HEAD_LASTL:=$(shell more +$(HEAD_NMONE) $(HEAD_PATH))
#$(info LASTL=$(HEAD_LASTL))
BUILD_NUMBER:=$(shell more $(BUILD_NUMBER_FILE))
ifeq ("${BUILD_NUMBER}","")
	BUILD_NUMBER:=0
endif
NEXT_BUILD_NUMBER:=$(call domath,$(BUILD_NUMBER) + 1)
$(info BUILD_NUMBER=$(BUILD_NUMBER))
$(info NEXT_BUILD_NUMBER=$(NEXT_BUILD_NUMBER))

$(BUILD_NUMBER_FILE):
	echo $(NEXT_BUILD_NUMBER)> $@

src/CoditBuild.c: $(BUILD_NUMBER_FILE)
	echo #include "CoditBuild.h"> $@
	@echo /* This file is generated during build,>> $@
	@echo do not bother modifying*/>> $@
	echo const long CODIT_MAJOR = ${TARGET_MAJOR};>> $@
	echo const long CODIT_MINOR = ${TARGET_MINOR};>> $@
	echo const long CODIT_CDATE = 0;>> $@
	echo const long CODIT_CTIME = 0;>> $@

src/CoditHEAD.c:
	echo #include "CoditBuild.h"> $@
	@echo /* This file is generated during build,>> $@
	@echo do not bother modifying*/>> $@
	echo const long CODIT_HDATE = 0;>> $@
	echo const long CODIT_HTIME = 0;>> $@

#CoditConfig.h:
#	"#define CODIT_MAJOR ${COMPILE_MAJOR}"	> "${O}$@"
#	"#define CODIT_MINOR ${SYSTEM_NAME}}"	>> "${O}$@"
#	"#define CODIT_BUILD ${COMPILE_BUILD}"	>> "${O}$@"
#	"#define SYSTEM_NAME ${COMPILE_MAJOR}"	>> "${O}$@"
#	"#define SYSTEM_VERS ${SYSTEM_NAME}}"	>> "${O}$@"

$(O)codit.o: codit.c
	${CC} ${CFLAGS} ${Fc} "$<" ${Fo} "$@"

$(O)CoditTest.o: CoditTest.c
	${CC} ${CFLAGS} ${Fc} "$<" ${Fo} "$@"

$(O)%.o: src/%.c
	${CC} ${CFLAGS} ${Fc} "$<" ${Fo} "$@"
	
$(DEPDIR):
	$(MKDIR) "${DEPDIR}"