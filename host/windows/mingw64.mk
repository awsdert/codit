# Default directory used here is the one provided by chocolately
# Tools & Compiler Details
CC_DIR:=C:\tools\mingw64
CC_BIN:=${CC_DIR}\bin
CC_LIB:=${CC_DIR}\lib
CC_INC:=${CC_DIR}\include
CC:=${CC_BIN}\x86_64-w64-mingw32-gcc.exe
RM:=del
# GCC Style Flags
Fc:=-c
Fo:=-o
Fv:=-v
Fl:=-l
FD:=-D
FI:=-I
FL:=-L
FO:=-O
FO1:=-O1
FO2:=-O2
FO3:=-O3
Fgdb:=-gdb
FWall:=-Wall