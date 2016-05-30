CDEFS?=
#Directories
TOPDIR?=
WKSDIR:=$(dir $(lastword $(MAKEFILE_LIST)))

# Applies all compile targets as a requirment of all before doing it's own
# rules
include $(TOPDIR)version.mk

#Compiler Stuff
$(info CURDIR=$(CURDIR))
$(info WKSDIR=$(WKSDIR))

.PHONY: clean rebuild

rebuild: clean all

#install: user
#	$(error Installation not yet supported)
#	$(INSTALL_CODIT)
#	$(INSTALL_ICONS)

clean:
	${RM} ${OBJDIR}* ${BINDIR}*