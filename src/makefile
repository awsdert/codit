# Project Settings
TARGET:=${.TARGET}
TOPDIR:=..
SRCDIR:=${TOPDIR}/src
OBJDIR:=${TOPDIR}/obj
OUTDIR:=${TOPDIR}/out
TARDIR:=default
FILEOBJ_C:=CoditFileobjOpenShut.c CoditFileobjPutGet.c
FILELST_C:=CoditFilelstPrepAPI.c CoditFilelstOpenShut.c CoditFilelstNxt.c
FILE_C:=${FILEOBJ_C} ${FILELST_C}
FILE_O:=${FILE_C:.c=.o}
PROCOBJ_C:=CoditProcobjOpenShut.c CoditProcobjPutGet.c CoditProcobjRun.c
PROCLST_C:=CoditProclstPrepAPI.c CoditProclstOpenShut.c CoditProclstNxt.c
PROCENT_C:=CoditProcentName.c CoditProcentPid.c coditProcentStatus.c
PROC_C:=${PROCOBJ_C} ${PROCLST_C} ${PROCENT_C}
PROC_O:=${PROC_C:.c=.o}
# Tools & Compiler Details
CC_DIR:=C:\tools\mingw64
CC_BIN:=${CC_DIR}\bin
CC_LIB:=${CC_DIR}\lib
CC_INC:=${CC_DIR}\include
CC:=${CC_BIN}\x86_64-w64-mingw32-gcc.exe
RM:=del
# GCC Style Flags
Fc:=-c
Fo:=-o
Fl:=-l
FD:=-D
FI:=-I
FL:=-L
FO:=-O
FO1:=-O1
FO2:=-O2
FO3:=-O3
Fgdb:=-gdb
FWall:=-Wall

all: clean test

#${OBJDIR}/${TARDIR}/win32.o
win32: win32_o
	@echo "eeeeeh!? $<"
	${CC} ${Fc} $< ${Fo} ${OUTDIR}/${TARDIR}/codit32.exe

test: win32_o ${OBJDIR}/${TARDIR}/CoditTest.o
	@echo "eh? $<"
	${CC} ${Fc} $< ${Fo} ${OUTDIR}/${TARDIR}/CoditTest.exe
	
clean:
	@echo "wtf!? $<"
	${RM} ${OBJDIR}/windows/* ${OUTDIR}/windows/*.exe
	
win32_o:TARDIR:=windows
win32_o:FILE_O:=${patsubst %.c,${OBJDIR}/${TARDIR}/%.o,${FILE_C}}
win32_o:PROC_O:=${patsubst %.c,${OBJDIR}/${TARDIR}/%.o,${PROC_C}}
win32_o: ${FILE_O} ${PROC_O}
		@echo "Windows 32bit Compile"
		@echo "FILE_O = ${FILE_O}"
		@echo "PROC_O = ${PROC_O}"

${OBJDIR}/${TARDIR}/%.o: %.c
	@echo "1 = $< ; 2 = $@"
	${CC} ${FWall} ${Fc} $< ${Fo} $@