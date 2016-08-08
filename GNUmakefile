TOP_DIR?=

CODIT_TARGETS:=main test

# Ensure no unwanted compiles occur by accident
all: $(CODIT_TARGETS)
include $(TOP_DIR)3rdparty.mk
include $(CODIT_DIR)build.mk
include $(CODIT_DIR)paths.mk
include $(CODIT_DIR)math.fmk

CODIT_T_CFLAGS.c=$(CC_CFLAGS) $(FI)"$(CODIT_INC_DIR)"
CODIT_T_LFLAGS.c=$(CC_LFLAGS)

ifeq ("$(TARGET_SYS_DIR)","windows")
ifeq ("$(TARGET_SYS_DIR)","windows")
CODIT_T_CFLAGS.c+= $(FD)_WIN64
endif
CODIT_T_CFLAGS.c+= $(FD)_WIN32
CODIT_T_LFLAGS.c+= $(Fl)kernerl32 $(Fl)shell32
endif

ifeq ("$(TARGET_SYS_DIR)","linux")
CODIT_T_CFLAGS.c+= $(FD)__linux__
endif

CODIT_SRC:=$(sort $(notdir $(wildcard $(CODIT__SRC_DIR)*.c)))
CODIT_OBJ:=$(CODIT_SRC:.c=.o)
CODIT_DEP:=$(CODIT_SRC:.c=.d)
CODIT_OUT:=$(addprefix codit_,$(CODIT_TARGETS:=.out))
CODIT_VMK:=$(CODIT_OUT:.out=.vmk)

#$(call *,FileToCheck, FileToAppendVariableTo, VariableToSet)
NIX_STAT_MODIFIED=echo $$(stat -c %Y $(1))
NIX_STAT_MODIFIED_STRIP=$(1)
NIX_STAT_CHANGED=echo $$(stat -c %Z $(1))
OSX_STAT_MODIFIED=echo $$(stat -c %m $(1))
OSX_STAT_MODIFIED_STRIP=$(1)
OSX_STAT_CHANGED=echo $$(stat -c %c $(1))
MSW_STAT_MODIFIED=dir /T:W $(subst /,\,$(1))
MSW_STAT_MODIFIED_STRIP=$(word 15,$(1));$(word 16,$(1))

CODIT_SYS=$(if ifeq $(call defined,COMSPEC) "1",MSW,NIX)

define STAT_MODIFIED
$(strip
$(eval $(0)_SH=$(call $(CODIT_SYS)_$(0),$(1)))
$(eval $(0)_FAIL=0)
$(eval $(0)_VAL=$(if $(wildcard $(1)),SH,FAIL))
$(eval $(0)_RESULT=$(call $(CODIT_SYS)_$(0)_STRIP,$(shell $($(0)_$($(0)_VAL)))))
)$($(0)_RESULT)
endef

space:= 
space+= 
hash:=\#

define newline

endef

fslash:=/
bslash:=ignore\ignore
bslash:=$(subst ignore,,$(bslash))
colon:=:
comma:=,
openp:=(
shutp:=)
openb:={
shutb:=}
openc:=<
shutc:=>
quote:="
dollar:=$

# TODO: Need linux versions as well
_NOTFOUND=0
MSW_PATH_SEP=$(subst $(fslash),$(bslash),$(1))
NIX_PATH_SEP=$(1)
FULL_PATH_SEP=$(call $(CODIT_SYS)_PATH_SEP,$(realpath $(1)))
PART_PATH_SEP=$(call $(CODIT_SYS)_PATH_SEP,$(1))
PATH2TEXT_SEP="$(subst $(bslash),$(bslash)$(bslash),$(call $(1)_PATH_SEP,$(2)))"

FILE_FULL_RD=$$(shell more < $$(call PATH2TEXT_SEP,FULL,$(1)))
FIND_LINE_IN=$$(filter $(1),$$(call FILE_FULL_RD,$(2)))

# Read/Write Last Modified to dependency file
define CODIT_SRC_MOD_RD
$(strip $($(if $(wilcard $(1).prevmod),subst $(1).prevmod=,eval 0)
,,$(call FIND_LINE_IN,$(1).prevmod=%,$(CODIT_T_DEP_DIR)/$(1).prevmod)))
endef
CODIT_SRC_MOD_WR=$(shell echo $(1).prevmod=$(2) > $(CODIT_T_DEP_DIR)/$(1).prevmod)

_UPTODATE=$(info $(1) is upto date: $(5).)
define _UPDATECC
$(info $(0),$(1),$(2),$(3),$(4),$(5))
$(call CODIT_SRC_MOD_WR,$(notdir $(1)),$(5))
endef

define CODIT_GEN_DEP
$(eval $(0)_SRC=$(CODIT__SRC_DIR)$(1:.d=$(2)))
$(eval $(0)_DEP=$(CODIT_T_DEP_DIR)/$(1))
$(eval $(0)_CFLAGS=$(CODIT_T_CFLAGS) $(CODIT_T_LFLAGS))
$(eval $(0)_LASTMOD=$(call STAT_MODIFIED,$($(0)_SRC)))
$(eval $(0)_PREVMOD=$(call CODIT_SRC_DEP_RD,$($(0)_SRC)))
$(eval $(0)_CALL=$(call if_eql,$($(0)_PREVMOD),$($(0)_LASTMOD),_UPTODATE,_UPDATECC))
$(call $($(0)_CALL),$($(0)_SRC),$($(0)_DEP),$(1:.d=.o),$($(0)_CFLAGS),$($(0)_LASTMOD))
endef

DEP_FILE=$(CODIT_DIR)dependencies.mk

define PRINT_INC_FILTER
$(subst $(hash)include_,,$(filter $(hash)include_%,$(subst $(space)$(1),_,$(subst $(2),,$(3)))))
endef

PRINT_INCLUDES=

define PRINT_INC
$(strip
$(eval $(0)_SRC=$(call FILE_FULL_RD,$(1)))
$(eval $(0)_VAL:=$(call PRINT_INC_FILTER,$(openc),$(shutc),$($(0)_SRC)))
$(eval $(0)_VAL+= $(call PRINT_INC_FILTER,$(quote),$(quote),$($(0)_SRC)))
$(eval $(0)_SRC=$(filter Codit%,$($(0)_VAL))$(filter codit%,$($(0)_VAL)))
$(eval $(0)LUDES+=$($(0)_SRC))
$(shell >>$(DEP_FILE) echo $(hash) State $(1) dependencies)
$(shell >>$(DEP_FILE) echo $(2): $(filter Codit%,$($(0)_SRC)))
)
endef

$(shell >$(DEP_FILE) echo $(hash) DO NOT MODIFY! Generated on the fly)
$(foreach src,$(CODIT_SRC),$(call PRINT_INC,$(CODIT__SRC_DIR)$(src),$(patsubst %.c,%.o,$(src))))
$(eval PRINT_INCLUDES:=$(sort $(PRINT_INCLUDES)))
$(foreach header,$(PRINT_INCLUDES),$(shell >>$(DEP_FILE) echo $(header)$(colon)))
include $(DEP_FILE)

core: codit_core.out
include $(CODIT__SRC_DIR)codit_core.vmk
codit_core_CFLAGS:=$(CODIT_T_CFLAGS.c)
codit_core_CFLAGS+= $(FD)CODIT_CORE_MAJOR=$(codit_core_MAJOR)
codit_core_CFLAGS+= $(FD)CODIT_CORE_MINOR=$(codit_core_MINOR)
codit_core_CFLAGS+= $(FD)CODIT_CORE_BUILD=$(codit_core_BUILD)
codit_core_LFLAGS:=$(CODIT_T_LFLAGS.c)
codit_core_c:=$(wildcard $(CODIT__SRC_DIR)*-*.c) $(CODIT__SRC_DIR)codit_core.c
codit_core_o:=$(notdir $(codit_core_c:.c=.o))
codit_core_3rdparty:=$(FD)CODIT_CORE_EXPORT
codit_core_prefix:=$(TARGET_DLL_PREFIX)
codit_core_suffix:=$(TARGET_DLL_SUFFIX)
codit_core.out codit_core.vmk: $(eval CODIT_T=codit_core)

main: codit_main.out
include $(CODIT__SRC_DIR)codit_main.vmk
codit_main_CFLAGS:=$(codit_core_CFLAGS)
codit_main_CFLAGS+= $(FD)CODIT_MAIN_MAJOR=$(codit_main_MAJOR)
codit_main_CFLAGS+= $(FD)CODIT_MAIN_MINOR=$(codit_main_MINOR)
codit_main_CFLAGS+= $(FD)CODIT_MAIN_BUILD=$(codit_main_BUILD)
codit_main_LFLAGS:=$(CODIT_T_LFLAGS.c)
codit_main_c:=$(wildcard $(CODIT__SRC_DIR)*-*.c) $(CODIT__SRC_DIR)codit_main.c
codit_main_o:=$(notdir $(codit_main_c:.c=.o))
codit_main_3rdparty:=
codit_main_prefix:=
codit_main_suffix:=$(TARGET_EXE_SUFFIX)
codit_main.out: codit_core.out
codit_main.out codit_main.vmk: $(eval CODIT_T=codit_main)

test: codit_test.out
include $(CODIT__SRC_DIR)codit_test.vmk
codit_test_CFLAGS:=$(codit_core_CFLAGS)
codit_test_CFLAGS+= $(FD)CODIT_TEST_MAJOR=$(codit_test_MAJOR)
codit_test_CFLAGS+= $(FD)CODIT_TEST_MINOR=$(codit_test_MINOR)
codit_test_CFLAGS+= $(FD)CODIT_TEST_BUILD=$(codit_test_BUILD)
codit_test_LFLAGS:=$(CODIT_T_LFLAGS.c)
codit_test_c:=$(wildcard $(CODIT__SRC_DIR)*-*.c) $(CODIT__SRC_DIR)codit_test.c
codit_test_o:=$(notdir $(codit_test_c:.c=.o))
codit_test_3rdparty:=
codit_test_prefix:=
codit_test_suffix:=$(TARGET_EXE_SUFFIX)
codit_test.out: codit_core.out
codit_test.out codit_test.vmk: $(eval CODIT_T=codit_test)

export PATH=$(CC_PATH)

$(CODIT_OUT): $(eval OBJECTS=$($(CODIT_T)_o))
$(CODIT_OUT): %.out: %.vmk $(OBJECTS)
	$(eval PREFIX=$($(CODIT_T)_prefix))
	$(eval SUFFIX=$($(CODIT_T)_suffix))
	$(eval OUTPUT=$(CODIT_T_OUT_DIR)/$(PREFIX)$(CODIT_T)$(SUFFIX))
	$(eval SOURCE=$(addprefix $(CODIT_T_OBJ_DIR),$(OBJECTS)))
	$(eval LFLAGS=$($(CODIT_T)_LFLAGS))
	$(CC) $(LFLAGS) $(SOURCE) $(Fo) $(OUTPUT)

# General linker files
$(CODIT_OBJ): %.o: $(CODIT__SRC_DIR)%.c
	$(info OBJ $@: $<)
	$(eval OUTPUT=$(CODIT_T_OBJ_DIR)/$@)
	$(eval SOURCE=$<)
	$(eval CFLAGS=$($(CODIT_T)_3rdparty) $($(CODIT_T)_CFLAGS))
	$(eval LFLAGS=$($(CODIT_T)_LFLAGS))
	$(CC) $(CFLAGS) $(LFLAGS) $(SOURCE) $(Fo) $(OUTPUT)

$(CODIT_VMK): $($(CODIT_T)_c)
	$(eval OUTPUT=$(CODIT__SRC_DIR)$@)
	$(eval VER=$(CODIT_T)_)
	$(eval _BUILD=$(call sh_math,+1))
	$(eval __MINOR=$(call sh_math,$($(VER)BUILD)+1))
	$(eval _MINOR=$(call sh_lss,$(_BUILD),10000,$($(VER)MINOR),$(__MINOR)))
	$(eval _MAJOR=$(call sh_math,$($(VER)MAJOR)+1))
	$(eval BUILD=$(call sh_lss,$(_BUILD),10000,$(_BUILD),0))
	$(eval MINOR=$(call sh_lss,$(_MINOR),100,$(_MINOR),0))
	$(eval MAJOR=$(call sh_lss,$(_MINOR),100,$($(VER)MAJOR),$(_MAJOR)))
	>$(OUTPUT) echo $(hash) $(CODIT_T) version file
	>>$(OUTPUT) echo ${VER}BUILD=${BUILD}
	>>$(OUTPUT) echo ${VER}MINOR=${MINOR}
	>>$(OUTPUT) echo ${VER}MAJOR=${MAJOR}

# Codit specific installation instructions
install: codit_install
ifeq ($(CODIT_MSW),1)
# XP users need to install this:
# https://www.microsoft.com/en-us/download/details.aspx?id=17657
codit_install:
	robocopy $(CODIT_T_OUT_DIR)/* $(PROGRAMFILES)Codit /e /i
else
codit_install:
	-m 0755 codit /usr/local/bin
	-m 0644 *.png /share/codit/icons
endif