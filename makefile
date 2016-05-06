#Directories
TOPDIR?=
include $(TOPDIR)directories.mk

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

export PATH:=$(PATH);$(CC_BIN)

rebuild: clean test dobuild

objects: directories $(OBJECTS) CoditConfig.h

directories: $(DEPDIR)

test: objects $(O)CoditTest.o
	${CC} ${PRJBIN} ${Fc} $< ${Fo} ${B}CoditTest${TAREXE}

dobuild: objects $(O)codit.o
	${CC} ${Fc} $< ${Fo} ${B}codit${TAREXE}
	
install: dobuild
	$(error Installation not yet supported)
	$(INSTALL_CODIT)
	$(INSTALL_ICONS)

clean:
	${RM} ${OBJDIR}* ${OUTDIR}*

#Mingw64 absolute paths, %MGW64% is a manually created enviroment variable on
#windows, an alternative variable to make is %MAKE% which just an absolute path
#to the default make.exe (I recommend setting it to the 1st path below)
#%MAKE%
#%MGW64%\bin\mingw32-make.exe
#c:\tools\mingw64\bin\mingw32-make.exe

src/CoditBuild.c: .git/logs/HEAD
	"#include \"CoditBuild.h\"" > $@
	"const long CODIT_MAJOR = ${TARGET_MAJOR};" >> $@
	"const long CODIT_MINOR = ${TARGET_MINOR};" >> $@
	while read -r $<; do echo read
	"const long CODIT_HDATE = 0;" >> $@
	"const long CODIT_HTIME = 0;" >> $@
	"const long CODIT_CDATE = 0;" >> $@
	"const long CODIT_CTIME = 0;" >> $@

CoditConfig.h:
	"#define CODIT_MAJOR ${COMPILE_MAJOR}"	>> "${O}$@"
	"#define CODIT_MINOR ${SYSTEM_NAME}}"	>> "${O}$@"
	"#define CODIT_BUILD ${COMPILE_BUILD}"	>> "${O}$@"
	"#define SYSTEM_NAME ${COMPILE_MAJOR}"	>> "${O}$@"
	"#define SYSTEM_VERS ${SYSTEM_NAME}}"	>> "${O}$@"

$(O)codit.o: codit.c
	${CC} ${CFLAGS} ${Fc} "${TOPDIR}$<" ${Fo} "$@"

$(O)CoditTest.o: CoditTest.c
	${CC} ${CFLAGS} ${Fc} "${TOPDIR}$<" ${Fo} "$@"

$(O)%.o: %.c
	${CC} ${CFLAGS} ${Fc} "${TOPDIR}$<" ${Fo} "$@"
	
$(DEPDIR):
	$(MKDIR) "${DEPDIR}"