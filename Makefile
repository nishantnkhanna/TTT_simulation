#
# OMNeT++/OMNEST Makefile for TTT_project
#
# This file was generated with the command:
#  opp_makemake -f --deep -O out -L../queueinglib/out/$$\(CONFIGNAME\) -lqueueinglib -DQUEUEING_IMPORT -KQUEUEINGLIB_PROJ=../queueinglib
#

# Name of target to be created (-o option)
TARGET = TTT_project$(EXE_SUFFIX)

# User interface (uncomment one) (-u option)
USERIF_LIBS = $(ALL_ENV_LIBS) # that is, $(TKENV_LIBS) $(CMDENV_LIBS)
#USERIF_LIBS = $(CMDENV_LIBS)
#USERIF_LIBS = $(TKENV_LIBS)

# C++ include paths (with -I)
INCLUDE_PATH = -I. -Ihtdocs -Iresults -Isrc

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L../queueinglib/out/$(CONFIGNAME)  -lqueueinglib
LIBS += -Wl,-rpath,`abspath ../queueinglib/out/$(CONFIGNAME)`

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc and .msg files
OBJS = \
    $O/ExtTelnetClient.o \
    $O/Cloud.o \
    $O/ExtHttpClient.o \
    $O/HttpServer.o \
    $O/SocketRTScheduler.o \
    $O/HttpClient.o \
    $O/TelnetClient.o \
    $O/TelnetServer.o \
    $O/QueueBase.o \
    $O/HttpMsg_m.o \
    $O/NetPkt_m.o \
    $O/TelnetPkt_m.o

# Message files
MSGFILES = \
    HttpMsg.msg \
    NetPkt.msg \
    TelnetPkt.msg

# Other makefile variables (-K)
QUEUEINGLIB_PROJ=../queueinglib

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppmain$D $(USERIF_LIBS) $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS) -DQUEUEING_IMPORT $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)

# we want to recompile everything if COPTS changes,
# so we store COPTS into $COPTS_FILE and have object
# files depend on it (except when "make depend" was called)
COPTS_FILE = $O/.last-copts
ifneq ($(MAKECMDGOALS),depend)
ifneq ("$(COPTS)","$(shell cat $(COPTS_FILE) 2>/dev/null || echo '')")
$(shell $(MKPATH) "$O" && echo "$(COPTS)" >$(COPTS_FILE))
endif
endif

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $O/$(TARGET)
	$(Q)$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	@echo Creating executable: $@
	$(Q)$(CXX) $(LDFLAGS) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(AS_NEEDED_OFF) $(WHOLE_ARCHIVE_ON) $(LIBS) $(WHOLE_ARCHIVE_OFF) $(OMNETPP_LIBS)

.PHONY: all clean cleanall depend msgheaders

.SUFFIXES: .cc

$O/%.o: %.cc $(COPTS_FILE)
	@$(MKPATH) $(dir $@)
	$(qecho) "$<"
	$(Q)$(CXX) -c $(CXXFLAGS) $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(qecho) MSGC: $<
	$(Q)$(MSGC) -s _m.cc $(MSGCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

clean:
	$(qecho) Cleaning...
	$(Q)-rm -rf $O
	$(Q)-rm -f TTT_project TTT_project.exe libTTT_project.so libTTT_project.a libTTT_project.dll libTTT_project.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h
	$(Q)-rm -f htdocs/*_m.cc htdocs/*_m.h
	$(Q)-rm -f results/*_m.cc results/*_m.h
	$(Q)-rm -f src/*_m.cc src/*_m.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc htdocs/*.cc results/*.cc src/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/Cloud.o: Cloud.cc \
	NetPkt_m.h
$O/ExtHttpClient.o: ExtHttpClient.cc \
	HttpMsg_m.h \
	NetPkt_m.h \
	SocketRTScheduler.h
$O/ExtTelnetClient.o: ExtTelnetClient.cc \
	NetPkt_m.h \
	SocketRTScheduler.h \
	TelnetPkt_m.h
$O/HttpClient.o: HttpClient.cc \
	HttpMsg_m.h \
	NetPkt_m.h
$O/HttpMsg_m.o: HttpMsg_m.cc \
	HttpMsg_m.h \
	NetPkt_m.h
$O/HttpServer.o: HttpServer.cc \
	HttpMsg_m.h \
	HttpServer.h \
	NetPkt_m.h \
	QueueBase.h \
	SocketRTScheduler.h
$O/NetPkt_m.o: NetPkt_m.cc \
	NetPkt_m.h
$O/QueueBase.o: QueueBase.cc \
	QueueBase.h
$O/SocketRTScheduler.o: SocketRTScheduler.cc \
	SocketRTScheduler.h
$O/TelnetClient.o: TelnetClient.cc \
	NetPkt_m.h \
	TelnetPkt_m.h
$O/TelnetPkt_m.o: TelnetPkt_m.cc \
	NetPkt_m.h \
	TelnetPkt_m.h
$O/TelnetServer.o: TelnetServer.cc \
	NetPkt_m.h \
	QueueBase.h \
	TelnetPkt_m.h \
	TelnetServer.h

