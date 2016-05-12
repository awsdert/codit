# Default directory used here is the one compatible with chocolately
# Tools & Compiler Details
CC_DIR:=C:/tools/mingw32
CC_BIN:=${CC_DIR}/bin
CC_LIB:=${CC_DIR}/lib
CC_INC:=${CC_DIR}/include
CC:="${CC_BIN}/mingw32-gcc.exe"
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
Fgdb:=-gdb
FMMD:=-MMD
FWall:=-Wall
Fstd_c99:=-std=c99