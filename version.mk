version=user test
all: $(version)

include $(TOPDIR)paths.mk
include $(S)user.mk
include $(S)test.mk
# The VERSION_* variables must be defined in target (target: VERSION_*=)
include $(TOPDIR)datetime.mk

$(version): VMK=$(S)$@.vmk
$(version): VERSION_BUILD=$($(TARGET_LARGE)_VERSION_BUILD)
$(version): VERSION_MINOR=$($(TARGET_LARGE)_VERSION_MINOR)
$(version): VERSION_MAJOR=$($(TARGET_LARGE)_VERSION_MAJOR)
$(version): VERSION_NEXT_BUILD=$($(TARGET_LARGE)_VERSION_NEXT_BUILD)
$(version): VERSION_NEXT_MINOR=$($(TARGET_LARGE)_VERSION_NEXT_MINOR)
$(version): VERSION_NEXT_MAJOR=$($(TARGET_LARGE)_VERSION_NEXT_MAJOR)
$(version): VDEFS=$(FD)MK_BUILD_DATE=$(DATE_Y)$(DATE_M)$(DATE_D)
$(version): VDEFS+= $(FD)MK_BUILD_TIME=$(TIME_H)$(TIME_M)$(TIME_S)
$(version): VDEFS+= $(FD)MK_VERSION_BUILD=$(VERSION_BUILD)
$(version): VDEFS+= $(FD)MK_VERSION_MAJOR=$(VERSION_MAJOR)
$(version): VDEFS+= $(FD)MK_VERSION_MINOR=$(VERSION_MINOR)
$(version): VDEFS+= $(FD)MK_LAST_COMMIT=$(COMMIT_LOG_DATE_TIME)
$(version): SOURCES+= $(S)$@.c
$(version):
	@echo VERSION_BUILD=$(VERSION_BUILD)
	@echo VERSION_MINOR=$(VERSION_MINOR)
	@echo VERSION_MAJOR=$(VERSION_MAJOR)
	echo:$(TARGET_LARGE)_VERSION_BUILD=$(VERSION_NEXT_BUILD) > $(VMK)
	echo:$(TARGET_LARGE)_VERSION_MINOR=$(VERSION_NEXT_MINOR) >> $(VMK)
	echo:$(TARGET_LARGE)_VERSION_MAJOR=$(VERSION_NEXT_MAJOR) >> $(VMK)
	$(CC) $(CFLAGS) $(TARGET_LIBS) $(Fo) "${${TARGET_LARGE}_OUT}" $(TARGET_OBJECTS)

# General linker files
$(O)Codit%.o: TARGET_LIBS:=$(OBJ_LIBS)
$(O)CoditFileobj%.o: $(FILEOBJ_H)
$(O)CoditFilelst%.o $(O)CoditFileent%.o: $(FILELST_H)
$(O)CoditProcobj%.o: $(PROCOBJ_H)
$(O)CoditProclst%.o $(O)CoditProcent%.o: $(PROCLST_H)

# Produce linker files
$(O)%.o: $(S)%.c
	$(CC) $(CFLAGS) $(VDEFS) $(TARGET_LIBS) $(Fo) $@ $(Fc) $<