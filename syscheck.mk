#Check if hosted by 64bit windows or 32bit alternative
ifeq ($(ProgramW6432), "")
	SYSBIT:=32
else
	SYSBIT:=64
endif

# Check if hosted by windows or linux variant
ifdef ProgramFiles
	SYSTEM:=windows
	# Ensure we are not using powershell
	SHELL:=cmd.exe
	RM:=del
	MKDIR:=mkdir
	PWD:=%cd%
	# Arithmetic, only set & let are usable here
	sh_let:=set /a
	sh_addcmd:=&
	sh_getlet:=set
	# Really?
	DIRSEP:=$(shell echo \)
	# Specifies 32/64bit compiler to use
	THEBIT?=$(SYSBIT)
	THE_CC?=mingw
	INSTALL_CODIT:=echo Find out how to copy ./bin/win$(SYSBIT) in shell
	INSTALL_ICONS:=echo Find out how to copy icons to %PROGRAMFILES%
else
	SYSTEM?=linux
	# Ensure we know what shell we're dealing with
	SHELL:=/bin/sh
	# Arithmetic, only set & let are usable here
	sh_let:=let
	sh_addcmd:=;
	sh_getlet:=echo $
	# Really?
	DIRSEP:=/
	# Specifies nothing so override
	THEBIT:=
	THE_CC?=gcc
	INSTALL_CODIT -m 0755 codit /usr/local/bin
	INSTALL_ICONS -m 0644 *.png $(prefix)/share/codit/icons
endif