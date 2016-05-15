include directories.mk
domath_str=$(shell $(sh_let) math_result="$(1)" $(sh_addcmd) $(sh_getlet) math_result)
domath=$(subst math_result=,,$(subst  ,,$(call domath_str,$(1))))