if_eql=$(if $(filter-out $(1),$(2)),$(4),$(3))
if_neq=$(if $(filter-out $(1),$(2)),$(3),$(4))
if_has=$(if $(filter $(1),$(2)),$(3),$(4))
defined=$(if $(subst undefined,,$(flavor $(1))),1,0)
need=$($(call if_eql,$(call defined,$(1)),1,eval ,error $(2)))

$(call need,TOP_DIR,TOP_DIR must be set before including paths.mk)

include $(TOP_DIR)3rdparty.mk

$(call need,CODIT_DIR,CODIT_DIR must be set in $(TOP_DIR)3rdparty.mk)
$(call need,TARGET_SYS_DIR,TARGET_SYS_DIR must be set in $(TOP_DIR)3rdparty.mk)

CODIT_INC_DIR?=$(CODIT_DIR)include
CODIT_SRC_DIR?=$(CODIT_DIR)src
CODIT_BIN_DIR?=$(CODIT_DIR)bin
CODIT_DBG_DIR?=$(CODIT_DIR)dbg

CODIT__SRC_DIR:=$(if $(CODIT_SRC_DIR),$(subst //,/,$(CODIT_SRC_DIR)/),)

# Debuggable output?
CODIT_DEBUG:=$(if $(DEBUG),$(DEBUG),0)

# Output directories for dependencies, objects, libraries and executables
CODIT_OUT_DIR:=$(call if_eql,$(CODIT_DEBUG),1,$(CODIT_DBG_DIR),$(CODIT_BIN_DIR))
CODIT_DEP_DIR:=$(CODIT_OUT_DIR)/dep
CODIT_OBJ_DIR:=$(CODIT_OUT_DIR)/obj

# Target directories
CODIT_T_OUT_DIR:=$(CODIT_OUT_DIR)/$(TARGET_SYS_DIR)
CODIT_T_DEP_DIR:=$(CODIT_DEP_DIR)/$(TARGET_SYS_DIR)
CODIT_T_OBJ_DIR:=$(CODIT_OBJ_DIR)/$(TARGET_SYS_DIR)

# Directories defined in order of needed creation
define CODIT_ALL_DIRECTORIES
$(CODIT_OUT_DIR) $(CODIT_T_OUT_DIR)\
$(CODIT_DEP_DIR) $(CODIT_T_DEP_DIR)\
$(CODIT_OBJ_DIR) $(CODIT_T_OBJ_DIR)
endef

# Function to force create single directory
define _sh_mkdir
$(strip
$(eval $(0)_DIR=$(subst /,$(HOST_DIR_SEP),$(1)))
$(eval $(if $(wildcard $(1)),,$(call mkdir $($(0)_DIR))))
)$($(0)_DIR)
endef
# Function to force create wordlist of directories
sh_mkdir=$(foreach $(0)_DIR,$(1),$(call _mkdir,$($(0)_DIR)))

$(eval $(call sh_mkdir,$(CODIT_ALL_DIRECTORIES)))

define CODIT_VPATHS
$(CODIT_SRC_DIR)\
$(CODIT_INC_DIR)\
$(CODIT_T_OBJ_DIR)\
$(CODIT_T_OUT_DIR)
endef
VPATHS?=
VPATHS+= $(CODIT_VPATHS)