#Check if hosted by 64bit windows or 32bit alternative
ifeq ($(ProgramW6432), "")
	SYSBIT:=32
else
	SYSBIT:=64
endif

# Check if hosted by windows or linux variant
ifdef ProgramFiles
	SYSTEM:=windows
	DIRSEP:=$(shell echo \)
	# Specifies 32/64bit compiler to use
	THEBIT?=$(SYSBIT)
	THE_CC?=mingw
	INSTALL_CODIT:=echo Find out how to copy ./bin/win$(SYSBIT) in shell
	INSTALL_ICONS:=echo Find out how to copy icons to %PROGRAMFILES%
else
	SYSTEM?=linux
	DIRSEP:=/
	# Specifies nothing so override
	THEBIT:=
	THE_CC?=gcc
	INSTALL_CODIT -m 0755 codit /usr/local/bin
	INSTALL_ICONS -m 0644 *.png $(prefix)/share/codit/icons
endif