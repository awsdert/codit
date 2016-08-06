TOP_DIR?=

CODIT_TARGETS:=main test

# Ensure no unwanted compiles occur by accident
all: $(CODIT_TARGETS)
include $(TOP_DIR)3rdparty.mk
include $(CODIT_DIR)build.mk
include $(CODIT_DIR)paths.mk
include $(CODIT_DIR)math.fmk

ifeq ("$(TARGET_SYS_DIR)","win32")
CODIT_T_CFLAGS.c=$(FD)_WIN32
CODIT_T_LFLAGS.c=$(Fl)kernerl32 $(Fl)shell32
endif

ifeq ("$(TARGET_SYS_DIR)","win64")
CODIT_T_CFLAGS.c=$(FD)_WIN64 $(FD)_WIN32
CODIT_T_LFLAGS.c=$(Fl)kernerl32 $(Fl)shell32
endif

ifeq ("$(TARGET_SYS_DIR)","linux")
CODIT_T_CFLAGS.c=$(FD)__linux__
CODIT_T_LFLAGS.c=
endif

CODIT_SRC:=$(sort $(notdir $(wildcard $(CODIT__SRC_DIR)*.c)))
CODIT_OBJ:=$(CODIT_patsubst %.c,%.o)
CODIT_DEP:=$(CODIT_patsubst %.c,%.d)
CODIT_OUT:=$(CODIT_TARGETS:=.out)
CODIT_VMK:=$(CODIT_TARGETS:=.vmk)

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
$(eval $(0)_REMOTE=$(call PRINT_INC_FILTER,$(openc),$(shutc),$($(0)_SRC)))
$(eval $(0)_WSPACE=$(call PRINT_INC_FILTER,$(quote),$(quote),$($(0)_SRC)))
$(eval $(0)_SRC=0)
$(eval $(0)LUDES+=$($(0)_REMOTE) $($(0)_WSPACE))
$(shell >>$(DEP_FILE) echo $(hash) State $(1) dependencies)
$(shell >>$(DEP_FILE) echo $(2): $(filter Codit%,$($(0)_REMOTE) $($(0)_WSPACE)))
)
endef

$(shell >$(DEP_FILE) echo $(hash) DO NOT MODIFY! Generated on the fly)
$(foreach src,$(CODIT_SRC),$(call PRINT_INC,$(CODIT__SRC_DIR)$(src),$(patsubst %.c,%.o,$(src))))
$(eval PRINT_INCLUDES:=$(filter Codit%,$(sort $(PRINT_INCLUDES))))
$(foreach header,$(PRINT_INCLUDES),$(shell >>$(DEP_FILE) echo $(header)$(colon)))
#$(info $(hash) Begin compiling dependencies)
#$(eval $(foreach codit_d,$(CODIT_DEP),$(call CODIT_GEN_DEP,$(codit_d),.c)))
include $(DEP_FILE)

main: codit_main
include $(CODIT__SRC_DIR)codit_main.vmk
codit_main_CFLAGS:=$(CODIT_T_CFLAGS)
codit_main_LFLAGS:=$(CODIT_T_LFLAGS)
codit_main_c:=$(wildcard $(CODIT__SRC_DIR)Codit-*.c) $(CODIT__SRC_DIR)codit_main.c
codit_main_o:=$(main_c:=.c=.o)
codit_main_out:=$(TARGET_BIN_EXT)
codit_main.o: Codit-ProcLst.h
codit_main.out codit_main.vmk: CODIT_T=codit_main

test: codit_test
include $(CODIT__SRC_DIR)codit_test.vmk
codit_test_CFLAGS:=$(CODIT_T_CFLAGS)
codit_test_LFLAGS:=$(CODIT_T_LFLAGS)
codit_test_c:=$(wildcard $(CODIT__SRC_DIR)Codit-*.c) $(CODIT__SRC_DIR)codit_test.c
codit_test_o:=$(test_c:=.c=.o)
codit_test_out:=$(TARGET_BIN_EXT)
codit_test.o: Codit-ProcLst.h
codit_test.out codit_test.vmk: CODIT_T=codit_test

$(CODIT_OUT): LFLAGS=$($(CODIT_T)_LFLAGS)
$(CODIT_OUT): OBJ=$($(CODIT_T)_o)
$(CODIT_OUT): %.out : %.vmk directories $(OBJ)
	$(eval PATH=$(CC_PATH))
	$(eval DOT_OUT=$(CODIT__OUT_DIR)$@
	$(eval BIN_OUT=$(subst .out,$($(CODIT_T)_out),$(DOT_OUT))))
	$(CC) $(LFLAGS) $(Fo) $(DOT_OUT) $(OBJ)
	copy $(DOT_OUT) $(BIN_OUT)

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

# General linker files
Codit-FileObj.h: Codit-Fault.h
Codit-FileLst.h: Codit-FileObj.h
Codit-ProcObj.h: Codit-FileLst.h
Codit-ProcLst.h: Codit-ProcObj.h
Codit-Basic%.o: CoditFault.h
Codit-FileObj%.o: CoditFileObj.h
Codit-FileLst%.o CoditFileent%.o: CoditFileLst.h
Codit-ProcObj%.o: CoditProcObj.h
Codit-ProcLst%.o CoditProcent%.o: CoditProcLst.h
$(CODIT_OBJ): LFLAGS=$($(CODIT_T)_LFLAGS)
$(CODIT_OBJ): CFLAGS=$($(CODIT_T)_CFLAGS)
$(CODIT_OBJ): %.o: $(CODIT__SRC_DIR)%.c
	$(eval SRC=$<)
	$(eval OBJ=$(CODIT__OBJ_DIR)$@)
	$(eval PATH=$(CC_PATH))
	$(CC) $(CFLAGS) $(LFLAGS) $(Fo) $(OBJ) $(Fc) $(SRC)

$(CODIT_VMK): $($(CODIT_T)_c)
	$(eval VMK=$(CODIT__SRC_DIR)$@)
	$(eval VER=codit_$(CODIT_T)_)
	$(eval PRVBUILD=$(subst  ,,$($(VER)BUILD)))
	$(eval PRVMINOR=$(subst  ,,$($(VER)MINOR)))
	$(eval PRVMAJOR=$(subst  ,,$($(VER)MAJOR)))
	$(eval _BUILD=$(call sh_math,+1))
	$(eval __MINOR=$(call sh_math,$(PRVMINOR)+1))
	$(eval _MINOR=$(call sh_lss,$(_BUILD),10000,$(PRVMINOR),$(__MINOR)))
	$(eval _MAJOR=$(call sh_math,$(PRVMAJOR)+1))
	$(eval BUILD=$(call sh_lss,$(_BUILD),10000,$(_BUILD),0))
	$(eval MINOR=$(call sh_lss,$(_MINOR),100,$(_MINOR),0))
	$(eval MAJOR=$(call sh_lss,$(_MINOR),100,$(PRVMAJOR),$(_MAJOR)))
	>$(VMK) echo(# ${B2BT} version file
	>>$(VMK) echo(${VER}BUILD=${BUILD}
	>>$(VMK) echo(${VER}MINOR=${MINOR}
	>>$(VMK) echo(${VER}MAJOR=${MAJOR}