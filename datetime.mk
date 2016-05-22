include $(TOPDIR)syscheck.mk
ifeq ($(SYSTEM),windows)
	DATE_LOCAL:=$(subst /, ,$(shell echo %date%))
	TIME_LOCAL:=$(subst :, ,$(shell echo %time%))
else
	DATE_LOCAL:=$(shell echo date +'DD MM YYYY')
	TIME_LOCAL:=$(shell echo time +'HH MM SS')
endif
DATE_D:=$(word 1,$(DATE_LOCAL))
DATE_M:=$(word 2,$(DATE_LOCAL))
DATE_Y:=$(word 3,$(DATE_LOCAL))
TIME_H:=$(word 1,$(TIME_LOCAL))
TIME_M:=$(word 2,$(TIME_LOCAL))
TIME_S:=$(word 3,$(TIME_LOCAL))