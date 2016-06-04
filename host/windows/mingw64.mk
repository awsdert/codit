# Default directory used here is the one provided by chocolately
# GCC Style Flags
Fc:=-c
Fo:=-o
Fv:=-v
Fl:=-l
FD:=-D
FI:=-I
FL:=-L
FO:=-O
FMF:=-MF
FMP:=-MP
FO1:=-O1
FO2:=-O2
FO3:=-O3
FOs:=-Os
FOfast:=-Ofast
Fggdb:=-ggdb
FMMD:=-MMD
FWall:=-Wall
Fstd_c99:=-std=c99
# Tools & Compiler Details
CC_DIR:=C:/tools/mingw64
CC_SUBDIR:=x86_64-w64-mingw32
CC_BIN:=$(CC_DIR)/bin
CC_LIB:=$(FL)"$(CC_DIR)/$(CC_SUBDIR)/lib" $(FL)"$(CC_DIR)/lib"
CC_INC:=$(FI)"$(CC_DIR)/$(CC_SUBDIR)/include" $(FI)"$(CC_DIR)/include"
CC:="$(CC_BIN)/$(CC_SUBDIR)-gcc.exe"