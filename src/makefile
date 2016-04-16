# Project Settings
TOPDIR:=..
SRCDIR:=$(TOPDIR)/src
OBJDIR:=$(TOPDIR)/obj/
OUTDIR:=$(TOPDIR)/out/
TAROBJDIR:=$(OBJDIR)/${.TARGET}
TAROUTDIR:=$(OUTDIR)/${.TARGET}
FILEOBJSRC:=CoditFileobjOpenShut.c CoditFileobjPutGet.c
FILELSTSRC:=CoditFilelstPrepAPI.c CoditFilelstOpenShut.c CoditFilelstNxt.c
PROCOBJSRC:=CoditProcobjOpenShut.c CoditProcobjPutGet.c CoditProcobjRun.c
PROCLSTSRC:=CoditProclstPrepAPI.c CoditProclstOpenShut.c CoditProclstNxt.c
PROCENTSRC:=CoditProcentName.c CoditProcentPid.c coditProcentStatus.c
# Tools & Compiler Details
CC_DIR:=C:\tools\mingw64
CC_BIN:=$(CC_DIR)\bin
CC_LIB:=$(CC_DIR)\lib
CC_INC:=$(CC_DIR)\include
CC:=$(CC_BIN)\x86_64-w64-mingw32-gcc.exe
RM:=del
# GCC Style Flags
Fc:=-c
Fo:=-o
Fl:=-l
FD:=-D
FI:=-I
FL:=-L
FWall:=-Wall

all: clean test

test: $(OBJDIR)/test/CoditTest.o
	$(CC) $(Fc) $< $(Fo) $(TAROUTDIR)/CoditTest.exe
	
clean:
	$(RM) $(OBJDIR)/test/* $(OUTDIR)/test/*.exe

$(OBJDIR)/test/CoditTest.o: $(SRCDIR)/CoditTest.c
	$(CC) $(FWall) $(Fc) $< $(Fo) $@

$(TAROBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(FWall) $(Fc) $< $(Fo) $@