include $(TOPDIR)commit.mk
include $(S)test.vmk
ifeq ( 999, $(TEST_VERSION_BUILD) )
	TEST_VERSION_NEXT_BUILD:=0
	TEST_VERSION_NEXT_MINOR:=$(call domath,$(TEST_VERSION_MINOR) + 1)
else
	TEST_VERSION_NEXT_BUILD:=$(call domath,$(TEST_VERSION_BUILD) + 1)
	TEST_VERSION_NEXT_MINOR:=$(strip $(TEST_VERSION_MINOR))
endif

ifeq ( 1000, $(TEST_VERSION_NEXT_MINOR) )
	TEST_VERSION_NEXT_MINOR=0
	TEST_VERSION_NEXT_MAJOR=$(call domath,$(TEST_VERSION_MAJOR) + 1)
else
	TEST_VERSION_NEXT_MAJOR=$(strip $(TEST_VERSION_MAJOR))
endif

TEST_OUT:=$(B)codit_test$(TARGET_BIN_EXT)
test: TARGET_LARGE:=TEST
test: TARGET_LIBS:=$(BIN_LIBS) $(Fl)shell32
test: TARGET_OBJECTS:=$(OBJECTS) $(O)test.o
test: paths $(OBJECTS) $(O)test.o
$(O)test.o: TARGET_LIBS:=$(OBJ_LIBS) $(Fl)shell32
$(O)test.o: $(PROCLST_H)