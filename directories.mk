HERE:=$(dir $(lastword $(MAKEFILE_LIST)))
include $(TOPDIR)target.mk
CURDIR:=$(shell echo $(PWD))$(DIRSEP)
# Directories
PREPARE:=set tmp
REPLACE:=%tmp:teh=the%
$(shell chdir $(CURDIR)$(TOPDIR))
WKSDIR:=$(shell echo $(PWD))$(DIRSEP)
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
SOURCES:=$(wildcard src/*.c)
OBJECTS:=$(patsubst src/%.c,$(O)%.o,$(SOURCES))