# Create an auto-incrementing build number.

BUILD_NUMBER_FLAGS=$(FD)CODIT_BUILD_DATE=$$(date +'%Y%m%d')
BUILD_NUMBER_FLAGS+=$(FD)CODIT_BUILD_TIME=$$(time +'%H%M%S')
BUILD_NUMBER_FLAGS+=$(FD)CODIT_BUILD_NUMBER=$$(cat $(BUILD_NUMBER_FILE))

# Build number file.  Increment if any object file changes.
$(BUILD_NUMBER_FILE): $(SOURCES) codit.c CoditTest.c
    @if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
    @echo $(shell $(sh_let)math_result="${shell echo < ${BUILD_NUMBER_FILE}} + 1" $(sh_addcmd) $(sh_getlet) math_result) > $(BUILD_NUMBER_FILE)