include $(CODIT_DIR)math.fmk

COMMIT_LOG_PATH:=$(TOPDIR).git$(DIRSEP)logs$(DIRSEP)HEAD
COMMIT_LOG_COUNT_STR:=$(shell find /c " +" $(COMMIT_LOG_PATH))
# % ignores case so we don't need to go out of our way to convert our path to
# uppercase however it only works in patsubst which ignores the ----------
# before the path so we get subst to remove the left over leaving the number we
# wanted
COMMIT_LOG_COUNT:=$(subst ---------- ,,$(patsubst %:,,$(COMMIT_LOG_COUNT_STR)))
COMMIT_LOG_FROM_LINE:=$(call sh_math,$(COMMIT_LOG_COUNT) - 1)
COMMIT_LOG_LAST_LINE:=$(shell more +$(COMMIT_LOG_FROM_LINE) $(COMMIT_LOG_PATH))
COMMIT_LOG_DATE_TIME:=$(or $(word 5,$(COMMIT_LOG_LAST_LINE)),0)