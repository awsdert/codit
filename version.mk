include $(TOPDIR)targets/user.mk
include $(TOPDIR)targets/test.mk
# The VERSION_* variables must be defined in target (target: VERSION_*=)
version=user test
version_o=$(USER_O) $(TEST_O)
version_vmk=$(USER_VMK) $(TEST_VMK)
$(version): VMK=$(TOPDIR)targets/$(TARGET_SMALL).vmk
$(version): VERSION_BUILD=$($(TARGET_LARGE)_VERSION_BUILD)
$(version): VERSION_MINOR=$($(TARGET_LARGE)_VERSION_MINOR)
$(version): VERSION_MAJOR=$($(TARGET_LARGE)_VERSION_MAJOR)
$(version): VERSION_NEXT_BUILD=$($(TARGET_LARGE)_VERSION_NEXT_BUILD)
$(version): VERSION_NEXT_MINOR=$($(TARGET_LARGE)_VERSION_NEXT_MINOR)
$(version): VERSION_NEXT_MAJOR=$($(TARGET_LARGE)_VERSION_NEXT_MAJOR)
$(version): VDEFS=$(FD)MK_BUILD_DATE=$$(date +'%Y%m%d')
$(version): VDEFS+= $(FD)MK_BUILD_TIME=$$(date +'%H%M%S')
$(version): VDEFS+= $(FD)MK_VERSION_BUILD=$(VERSION_BUILD)
$(version): VDEFS+= $(FD)MK_VERSION_MAJOR=$(VERSION_MAJOR)
$(version): VDEFS+= $(FD)MK_VERSION_MINOR=$(VERSION_MINOR)
$(version): VDEFS+= $(FD)MK_LAST_COMMIT=$(COMMIT_LOG_DATE_TIME)
$(version): OBJECTS+= $(O)$(TARGET_SMALL).o
$(version): SOURCES+= $(TOPDIR)targets/$(TARGET_SMALL).c
$(version): objects $(OUTPUT)
	@echo $(TARGET_LARGE)_VERSION_BUILD=$(VERSION_NEXT_BUILD)> "${VMK}"
	@echo $(TARGET_LARGE)_VERSION_MINOR=$(VERSION_NEXT_MINOR)> "${VMK}"
	@echo $(TARGET_LARGE)_VERSION_MAJOR=$(VERSION_NEXT_MAJOR)> "${VMK}"
	echo VERSION_BUILD=$(VERSION_BUILD)
	echo VERSION_MINOR=$(VERSION_MINOR)
	echo VERSION_MAJOR=$(VERSION_MAJOR)