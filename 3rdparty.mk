# Just a snippet to stop executing under other make(1) commands
# that won't understand these lines
ifneq (,)
This makefile requires GNU Make.
endif

# We assume DEBUG conditions but ensure DEBUG can be set to 0 on releases
DEBUG?=1

# Required: Tells Codit whether to use debug symbols/code, 1 or 0 expected
ifdef DEBUG
CODIT_DEBUG?=$(DEBUG)
endif
ifndef DEBUG
CODIT_DEBUG=0
endif
# Required: This informs codit makefiles where to look for it's source
CODIT_DIR:=$(TOP_DIR)
# Required: TARGET_SYS_DIR is used to prevent name
# conflicts on differently compiled binaries
# We give a default here based on the system hosting the chosen compiler
include $(CODIT_DIR)build.mk
TARGET_ARCH?=x86
TARGET_SYS_BIT?=$(HOST_SYS_BIT)
TARGET_SYS_DIR?=$(HOST_SYS_DIR)
TARGET_EXE_SUFFIX?=$(HOST_EXE_SUFFIX)
# Optional: Default directories are assumed if not defined
CODIT_INC_DIR:=$(CODIT_DIR)include
CODIT_SRC_DIR:=$(CODIT_DIR)src
# The out directory is set as %bin% or %dbg%
# The dep directory is set as %out%/dep
# The obj directory is set as %out%/obj
# Further variables are defined with %out%/%host%, %dep%/%host%, %obj%/%host%
CODIT_BIN_DIR:=$(CODIT_DIR)bin
CODIT_DBG_DIR:=$(CODIT_DIR)dbg
# CC related variables (Fc Fstd_c99 to define flags)
CC_HOST_DIR:=$(CODIT_DIR)build/$(HOST_SYS_DIR)/
# Sets GNU,CLANG,MGW32,MGW64 & CYGWIN variants
include $(TOP_DIR)gcc.cmk
# Sets just MSC variant
#include $(CC_HOST_DIR)/msc.mk 
# Comment/Uncomment as nessesary
#CC_PREFIX=MSC
#CC_PREFIX=GNU
#CC_PREFIX=CLANG
CC_PREFIX:=MGW$(HOST_SYS_BIT)
#CC_PREFIX=CYGWIN
CC_BIN_DIR:=$($(CC_PREFIX)_BIN_DIR)
CC_LIB_DIR:=$($(CC_PREFIX)_LIB_DIR)
CC_INC_DIR:=$($(CC_PREFIX)_INC_DIR)
CC_PATH:=$(CC_BIN_DIR);$(CC_LIB_DIR);$(PATH)
CC_LFLAGS:=$(subst \,\\,$(addsuffix ",$(addprefix $(FL)",$(CC_LIB_DIR))))
CC_CFLAGS:=$(subst \,\\,$(addsuffix ",$(addprefix $(FL)",$(CC_INC_DIR))))
CC_CFLAGS+=$(FWall) $(FWerror)
CC:="$(subst \,\\,$($(CC_PREFIX)_CC))"

# Required: Needed for wildcards
VPATHS=$(CC_VPATHS) $(TOP_DIR)