
CXX    := clang++
CFLAGS += \
	-Dlinux \
	-Dstricmp=strcasecmp \
	-Dstrnicmp=strncasecmp \
	-include strings.h \
	-Wno-parentheses


all: cli #lib

cli: asar
cli: CFLAGS += -DINTERFACE_CLI

asar: src/*.cpp
	$(CXX) $(CFLAGS) -o $@ $^
