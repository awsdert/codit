define defined
	$(info Checkng existance of $(1))
	$(if ifeq "$(flavor $(1))" "undefined",0,1)
endef

ifeq ($(call defined,TOP_DIR),0)
TOP_DIR must be set before including paths.mk
endif

include $(TOP_DIR)3rdparty.mk

ifeq ($(call defined,CODIT_DIR),0)
CODIT_DIR must be set in $(TOP_DIR)3rdparty.mk
endif

ifeq ($(call defined,TARGET_SYS_DIR),0)
TARGET_SYS_DIR must be set in $(TOP_DIR)3rdparty.mk
endif

CODIT_INC_DIR?=$(CODIT_DIR)include
CODIT_SRC_DIR?=$(CODIT_DIR)src
CODIT_DEP_DIR?=$(CODIT_DIR)src
CODIT_BIN_DIR?=$(CODIT_DIR)bin
CODIT_DBG_DIR?=$(CODIT_DIR)dbg

vpath codit*.c $(CODIT_SRC_DIR)
vpath codit*.d $(CODIT_DEP_DIR)
vpath codit*.h $(CODIT_INC_DIR)

ifneq "$(CODIT_SRC_DIR)" ""
CODIT__SRC_DIR:=$(subst //,/,$(CODIT_SRC_DIR)/)
else
CODIT__SRC_DIR=
endif

ifneq "$(CODIT_DEP_DIR)" ""
CODIT__DEP_DIR:=$(subst //,/,$(CODIT_SRC_DIR)/)
else
CODIT__DEP_DIR=
endif

# Debuggable output?
ifeq ($(or $(DEBUG),0),1)
CODIT_OUT_DIR=$(CODIT_DBG_DIR)
else
CODIT_OUT_DIR=$(CODIT_BIN_DIR)
endif
CODIT_OBJ_DIR?=$(CODIT_OUT_DIR)/obj

# Target output directory 
ifeq ("$(CODIT_OUT_DIR)","")
CODIT_T_OUT_DIR=
else
CODIT_T_OUT_DIR=$(CODIT_OUT_DIR)/
endif
# Target object directory
ifeq ("$(CODIT_OBJ_DIR)","")
CODIT_T_OBJ_DIR=
else
CODIT_T_OBJ_DIR=$(CODIT_OBJ_DIR)/
endif

CODIT__OUT_DIR=$(CODIT_T_OUT_DIR)$(TARGET_SYS_DIR)
CODIT__OBJ_DIR=$(CODIT_T_OBJ_DIR)$(TARGET_SYS_DIR)

vpath codit*.o $(CODIT__OBJ_DIR)
vpath codit*.out $(CODIT__OUT_DIR)

CODIT_OBJ_STORES:=$(CODIT_OBJ_DIR) $(CODIT_T_OBJ_DIR) $(CODIT__OBJ_DIR)
CODIT_OUT_STORES:=$(CODIT_OUT_DIR) $(CODIT_T_OUT_DIR) $(CODIT__OUT_DIR)
CODIT_ALL_STORES:=$(CODIT_OBJ_STORES) $(CODIT_OUT_STORES) $(CODIT_DEP_DIR)

directories: $(CODIT_ALL_STORES)
$(ALL_STORES):
	$(MKDIR) "$@"