include mkfunc/domath.mk
COMMIT_LOG_PATH:=$(WKSDIR).git$(DIRSEP)logs$(DIRSEP)HEAD
COMMIT_LOG_COUNT_STR:=$(shell find /c " +" $(COMMIT_LOG_PATH))
# % ignores case so we don't need to go out of our way to convert our path to
# uppercase however it only works in patsubst which ignores the ----------
# before the path so we get subst to remove the left over leaving the number we
# wanted
COMMIT_LOG_COUNT:=$(subst ---------- ,,$(patsubst %:,,$(COMMIT_LOG_COUNT_STR)))
COMMIT_LOG_FROM_LINE:=$(call domath,$(COMMIT_LOG_COUNT) - 1)
COMMIT_LOG_LAST_LINE:=$(shell more +$(COMMIT_LOG_FROM_LINE) $(COMMIT_LOG_PATH))
COMMIT_LOG_DATE_TIME:=$(or $(word 5,$(COMMIT_LOG_LAST_LINE)),0)
# The VERSION_* variables must be defined in target (target: VERSION_*=)
version: VDEFS=$(FD)BUILD_DATE=$$(date +'%Y%m%d')
version: VDEFS+= $(FD)BUILD_TIME=$$(date +'%H%M%S')
version: VDEFS+= $(FD)VERSION_BUILD=$(VERSION_BUILD)
version: VDEFS+= $(FD)VERSION_MAJOR=$(VERSION_MAJOR)
version: VDEFS+= $(FD)VERSION_MINOR=$(VERSION_MINOR)
version: VDEFS+= $(FD)LAST_COMMIT=$(COMMIT_LOG_DATE_TIME)
version: $(VERSION_FILE)
    echo VERSION_BUILD=$(VERSION_BUILD)
    echo VERSION_MINOR=$(VERSION_MINOR)
    echo VERSION_MAJOR=$(VERSION_MAJOR)

$(VERSION_FILE): $(SOURCES) $(MAIN_C)
	@echo $(VERSION_PREPEND)_VERSION_BUILD=$(VERSION_NEXT_BUILD)> $@
    @echo $(VERSION_PREPEND)_VERSION_MINOR=$(VERSION_NEXT_MINOR)> $@
    @echo $(VERSION_PREPEND)_VERSION_MAJOR=$(VERSION_NEXT_MAJOR)> $@