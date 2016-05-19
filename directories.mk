HERE:=$(dir $(lastword $(MAKEFILE_LIST)))
include $(TOPDIR)target.mk
CURDIR:=$(shell echo $(PWD))$(DIRSEP)
WKSDIR:=$(shell cd "$(CURDIR)$(TOPDIR)" $(sh_addcmd) echo $(PWD))$(DIRSEP)
OBJDIR:=obj
OUTDIR:=build
PRJOUT:=$(OUTDIR)/$(TARDIR)
PRJOBJ:=$(OBJDIR)/$(TARDIR)
B:=$(PRJOUT)/$(DBG)
O:=$(PRJOBJ)/$(DBG)
DEPDIR:=$(OUTDIR) $(PRJOUT) $(OBJDIR) $(PRJOBJ)
PRJINC:=$(FI)"$(CC_INC)" $(FI)"src" $(FI)"$(O)"
PRJBIN:=$(FL)"$(CC_LIB)" $(FL)"$(PRJOUT)"
PRJLIB:=$(FL)"$(CC_LIB)"
SOURCES:=$(wildcard $(TOPDIR)src/*.c)
OBJECTS:=$(patsubst $(TOPDIR)src/%.c,$(O)%.o,$(SOURCES))