include $(TOPDIR)target.mk
CURDIR:=$(shell echo $(PWD))$(DIRSEP)
SRCDIR:=$(TOPDIR)src
OBJDIR:=$(TOPDIR)obj
BINDIR:=$(TOPDIR)bin
INCDIR:=$(TOPDIR)include
TARGET_BINDIR:=$(BINDIR)/$(TARGET_DIR)
TARGET_OBJDIR:=$(OBJDIR)/$(TARGET_DIR)
B:=$(TARGET_BINDIR)/$(DBG)
O:=$(TARGET_OBJDIR)/$(DBG)
S:=$(SRCDIR)/
I:=$(INCDIR)/
OBJ_DIRECTORIES:=$(OBJDIR) $(TARGET_OBJDIR)
OUT_DIRECTORIES:=$(BINDIR) $(TARGET_BINDIR)
ALL_DIRECTORIES:=$(OBJ_DIRECTORIES) $(OUT_DIRECTORIES)
CFLAGS+=$(CC_INC) $(FI)"$(INCDIR)"
OUT_LIBS:=$(CC_LIB) $(FL)"$(TARGET_BINDIR)" $(CC_LIBS)
OBJ_LIBS:=$(CC_LIB) $(FL)"$(TARGET_OBJDIR)" $(CC_LIBS)
SOURCES:=$(wildcard $(S)Codit*.c)
OBJECTS:=$(patsubst $(S)%.c,$(O)%.o,$(SOURCES))
#Headers
BASIC_H=$(I)CoditBasic.h $(I)CoditBuild.h
FAULT_H=$(I)CoditFault.h $(BASIC_H)
FILEOBJ_H=$(I)CoditFileobj.h $(FAULT_H)
FILELST_H=$(I)CoditFilelst.h $(FILEOBJ_H)
PROCOBJ_H=$(I)CoditProcobj.h $(FILELST_H)
PROCLST_H=$(I)CoditProclst.h $(PROCOBJ_H)

export PATH:=$(CC_BIN);$(PATH)

paths: $(ALL_DIRECTORIES)

$(ALL_DIRECTORIES):
	$(MKDIR) "$@"