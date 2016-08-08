# Ensure we have global test variables
ifdef ComSpec
COMSPEC:=$(ComSpec)
endif
ifdef COMSPEC
ifndef ComSpec
ComSpec:=$(COMSPEC)
endif
endif
# Set UNAME_P & UNAME_S
ifndef COMSPEC
UNAME_S:=$(shell uname -s)
UNAME_P:=$(shell uname -p)
endif

ifdef COMSPEC
ifdef OS
UNAME_S:=$(OS)
endif
ifndef OS
UNAME_S=Windows
endif
ifdef ProgramW6432
UNAME_P=AMD64
endif
ifndef ProgramW6432
ifeq ($(filter $(COMSPEC)),cmd.exe)
UNAME_P=IA32
else
$(error UNAME_P incorrectly set on WIN16 variants)
UNAME_P=
endif
endif
endif

ifeq ($(filter AMD64,$(UNAME_P)),AMD64)
HOST_SYS_BIT=64
endif

ifndef HOST_SYS_BIT
HOST_SYS_BIT=$(if $(filter x86,$(UNAME_P)),32,16)
endif

ifeq ($(UNAME_S),Windows)
SHELL:=cmd.exe
RM=del
HOST_MSW=1
HOST_EXE_SUFFIX:=.exe
HOST_DLL_PREFIX:=
HOST_DLL_SUFFIX:=.dll
HOST_SYS_DEF:=_WIN
HOST_SYS_DIR:=windows
HOST_DIR_SEP:=$(word 1,\)
endif

ifndef HOST_MSW
ifeq ($(UNAME_S),Windows_NT)
SHELL:=cmd.exe
RM=del
HOST_MSW=1
HOST_EXE_SUFFIX:=.exe
HOST_DLL_PREFIX:=
HOST_DLL_SUFFIX:=.dll
HOST_SYS_DEF:=_WIN
HOST_SYS_DIR:=windows
HOST_DIR_SEP:=$(word 1,\)
else
SHELL:=/bin/sh
RM=rm -f
HOST_MSW=0
HOST_EXE_SUFFIX:=
HOST_DLL_PREFIX:=lib
HOST_DLL_SUFFIX:=.so
HOST_SYS_DEF?=__linux__
HOST_SYS_DIR?=linux
HOST_DIR_SEP:=/
endif
endif