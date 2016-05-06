#HERE:=$(dir $(lastword $(MAKEFILE_LIST)))
include $(TOPDIR)target.mk
CURDIR:=$(shell echo $(PWD))/
# Directories
PREPARE:=set tmp
REPLACE:=%tmp:teh=the%
DIRCHANGEDIR:=$(shell echo $(PWD) "$(TOPDIR)")
WKSDIR:=$(shell echo $(PWD))/
SRCDIR:=$(TOPDIR)src
OBJDIR:=$(TOPDIR)obj
OUTDIR:=$(TOPDIR)build
PRJOUT:=$(OUTDIR)/$(TARDIR)
PRJOBJ:=$(OBJDIR)/$(TARDIR)
B:=$(PRJOUT)/$(DBG)
O:=$(PRJOBJ)/$(DBG)
DEPDIR:=$(OUTDIR) $(PRJOUT) $(OBJDIR) $(PRJOBJ) $(O)src
PRJINC:=$(FI)"$(CC_INC)" $(FI)"$(SRCDIR)" $(FI)"$(O)"
PRJBIN:=$(FL)"$(CC_LIB)" $(FL)"$(PRJOUT)"
PRJLIB:=$(FL)"$(CC_LIB)"
SOURCES:=$(wildcard $(SRCDIR)/*.c)
OBJECTS:=$(patsubst %.c,$(O)%.o,$(SOURCES))