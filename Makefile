

##  shell to use to execute the commands.
SHELL     = /bin/sh

##  global options, used only for packing the GAP distribution
GAP_PATH    = ..
PKG_PATH    = ${GAP_PATH}/pkg
SRCDISTFILE = pkg

##  set this to point to the include directory containing 'gmp.h'.
INCDIRGMP = /usr/local/include

##  set this to point to the library directory containing 'libgmp.a'.
LIBDIRGMP = /usr/local/lib

#############################################################################
##
#T  Targets . . . . .  targets of the form <vendor>-<cpu>-<system>-<compiler>
##
##  Following are the targets that the user can specify.
##
unknown:
	@echo "usage: 'make <target>' where target is one of"
	@echo "'atari-m68k-tos-gcc2'   for Atari ST under TOS with GNU cc 2"
	@echo "'dec-mips-ultrix-gcc2'  for DECstation under Ultrix with GNU cc 2"
	@echo "'dec-mips-ultrix-cc'    for DECstation under Ultrix with cc"
	@echo "'hp-hppa1.0-hpux-cc'    for HP 9000/800 under HP-UX with cc"
	@echo "'hp-hppa1.1-hpux-cc'    for HP 9000/700 under HP-UX with cc"
	@echo "'ibm-power-aix-cc'      for IBM RS/6000 under AIX with cc"
	@echo "'ibm-i386-386bsd-gcc2'  for IBM PC under 386BSD with GNU cc 2"
	@echo "'ibm-i386-386bsd-cc'    for IBM PC under 386BSD with cc (GNU)"
	@echo "'ibm-i386-linux-gcc2'   for IBM PC under Linux with GNU cc 2"
	@echo "'ibm-i386-msdos-djgpp'  for IBM PC under MSDOS with DJ GNU cc"
	@echo "'ibm-i386-os2-emx'      for IBM PC under OS/2 with EMX GNU cc"
	@echo "'mips-mips-bsd-cc'      for MIPS under RISC/os Berkeley with cc"
	@echo "'mips-mips-sysv-cc'     for MIPS under RISC/os System V with cc"
	@echo "'next-m68k-mach-gcc2'   for NeXT under Mach with GNU cc 2"
	@echo "'next-m68k-mach-cc'     for NeXT under Mach with cc (GNU)"
	@echo "'sequent-i386-dynix-cc' for Sequent Symmetry under Dynix with cc"
	@echo "'sgi-mips-irix-gcc2'    for SGI under Irix with GNU cc 2"
	@echo "'sgi-mips-irix-cc'      for SGI under Irix with cc"
	@echo "'sun-m68k-sunos-gcc2'   for SUN 3 under SunOs with GNU cc 2"
	@echo "'sun-m68k-sunos-cc'     for SUN 3 under SunOS with cc"
	@echo "'sun-sparc-sunos-gcc2'  for SUN 4 under SunOs with GNU cc 2"
	@echo "'sun-sparc-sunos-cc'    for SUN 4 under SunOS with cc"
	@echo "'bsd'                   for others under Berkeley UNIX with cc"
	@echo "'usg'                   for others under System V UNIX with cc"
	@echo "   targets are listed according to preference, i.e.,"
	@echo "   'sun-sparc-sunos-gcc2' is better than 'sun-sparc-sunos-cc'."
	@echo "   additional C compiler and linker flags can be passed with"
	@echo "   'make <target> CFLAGS=<compiler-opts> LOPTS=<linker-opts>',"
	@echo "   i.e., 'make sun-sparc-sunos-gcc2 CFLAGS=-g LOPTS=-g.'"

gcc     :
	$(MAKE) CC="gcc" CFLAGS="-O2 -finline-functions" all

cc      :
	$(MAKE) CC="cc"  CFLAGS="-O" all

dos 	:
	$(MAKE) CC="cross-gcc" CFLAGS="-O2 -finline-functions" all

all     : me qme

clean   :
	( cd src ; rm -f int/*.o ve/*.o rat/*.o )

me      :
	( cd src ; $(MAKE) PROGNAME="me" PROGDEF="-DME" OBJSDIR="ve" \
	OBJECTX="scrut.o" INCLUDEX="" MEFLAGS="$(MEFLAGS)" \
	CC="$(CC)" CFLAGS="$(CFLAGS)" INCDIRS="" \
	LD="$(CC)" LFLAGS="$(LFLAGS)" LIBDIRS="" LIBFILES="-lm" \
	BISON="bison" -f ../Makefile ../bin/me.exe )

qme     :
	( cd src ; $(MAKE) PROGNAME="qme" PROGDEF="-DQME" OBJSDIR="rat" \
	OBJECTX="scrut.o" INCLUDEX="" MEFLAGS="$(MEFLAGS)" \
	CC="$(CC)" CFLAGS="$(CFLAGS)" INCDIRS="-I$(INCDIRGMP)" \
	LD="$(CC)" LFLAGS="$(LFLAGS)" LIBDIRS="-L$(LIBDIRGMP)" \
        LIBFILES="-lm -lgmp" \
	BISON="bison" -f ../Makefile ../bin/qme.exe )

zme     :
	( cd src ; $(MAKE) PROGNAME="zme" PROGDEF="-DZME" OBJSDIR="int" \
	OBJECTX="lattice.o" INCLUDEX="../latt.h" MEFLAGS="$(MEFLAGS)" \
	CC="$(CC)" CFLAGS="$(CFLAGS)" INCDIRS="-I$(INCDIRGMP)" \
	LD="$(CC)" LFLAGS="$(LFLAGS)" LIBDIRS="-L$(LIBDIRGMP)" \
        LIBFILES="-lm -lgmp" \
	BISON="bison" -f ../Makefile ../bin/zme.exe )

# 'unistd.h' claims 'sbrk' has first argument 'size_t' (UNIX says 'int')
atari-m68k-tos-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_TOS_GCC2 -DSYS_HAS_MISC_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_TOS_GCC2 -DSYS_HAS_MISC_PROTO"

dec-mips-ultrix-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD"

dec-mips-ultrix-gcc2-debug:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS) -g -ansi -Wall -pedantic" MEFLAGS="-DSYS_IS_BSD"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS) -g -ansi -Wall -pedantic" MEFLAGS="-DSYS_IS_BSD"

# Ultrix is a almost ANSI (but does not support 'const')
dec-mips-ultrix-cc:
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_ANSI=1"
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_ANSI=1"

# HP-UX is almost ANSI
# 'sys/times.h' claims 'times' returns 'clock_t' (how shall it return -1?)
hp-hppa1.0-hpux-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_ANSI=1 -DSYS_HAS_CONST=const -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_ANSI=1 -DSYS_HAS_CONST=const -DSYS_HAS_TIME_PROTO"

# HP-UX is almost ANSI
# 'sys/times.h' claims 'times' returns 'clock_t' (how shall it return -1?)
hp-hppa1.1-hpux-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_ANSI=1 -DSYS_HAS_CONST=const -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_ANSI=1 -DSYS_HAS_CONST=const -DSYS_HAS_TIME_PROTO"

ibm-power-aix-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_SIG_T=int -DSYS_HAS_SIGNAL_PROTO -DSYS_HAS_STRING_PROTO"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_SIG_T=int -DSYS_HAS_SIGNAL_PROTO -DSYS_HAS_STRING_PROTO"

# 'stdio.h' claims 'fgets' has second argument 'size_t' (ANSI says 'int')
# 'sys/ioctl.h' claims 'ioctl' has third argument '...' (UNIX says 'char*')
# 'sys/signal.h' claims 'kill' has first argument 'pid_t' (UNIX says 'int')
ibm-i386-386bsd-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_STDIO_PROTO -DSYS_HAS_IOCTL_PROTO -DSYS_HAS_SIGNAL_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_STDIO_PROTO -DSYS_HAS_IOCTL_PROTO -DSYS_HAS_SIGNAL_PROTO"

# 'stdio.h' claims 'fgets' has second argument 'size_t' (ANSI says 'int')
# 'sys/ioctl.h' claims 'ioctl' has third argument '...' (UNIX says 'char*')
# 'sys/signal.h' claims 'kill' has first argument 'pid_t' (UNIX says 'int')
ibm-i386-386bsd-cc:
	@$(MAKE) me  CC=cc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_STDIO_PROTO -DSYS_HAS_IOCTL_PROTO -DSYS_HAS_SIGNAL_PROTO"
	@$(MAKE) qme CC=cc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_STDIO_PROTO -DSYS_HAS_IOCTL_PROTO -DSYS_HAS_SIGNAL_PROTO"

ibm-i386-linux-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO -DSYS_HAS_SIG_T=void"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO -DSYS_HAS_SIG_T=void"

# 'std.h' claims 'strncat' has third argument 'int' (ANSI says 'size_t')
# 'stdio.h' claims 'setbuf' has return type 'int' (UNIX says 'void')
# 'std.h' claims 'sbrk' has return type 'void*' (UNIX says 'char*')
ibm-i386-msdos-djgpp:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_MSDOS_DJGPP -DSYS_HAS_STRING_PROTO -DSYS_HAS_STDIO_PROTO -DSYS_HAS_MISC_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_MSDOS_DJGPP -DSYS_HAS_STRING_PROTO -DSYS_HAS_STDIO_PROTO -DSYS_HAS_MISC_PROTO"

ibm-i386-os2-emx:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_OS2_EMX -DSYS_HAS_STDIO_PROTO -DSYS_HAS_TIME_PROTO -DSYS_HAS_MISC_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_OS2_EMX -DSYS_HAS_STDIO_PROTO -DSYS_HAS_TIME_PROTO -DSYS_HAS_MISC_PROTO"

# 'sys/signal.h' claims signal handlers return 'int' (in SysV 'void')
mips-mips-bsd-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_SIG_T=int -systype bsd43"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD -DSYS_HAS_SIG_T=int -systype bsd43"

mips-mips-sysv-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -systype sysv"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -systype sysv"

next-m68k-mach-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_MACH"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_MACH"

next-m68k-mach-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_MACH"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_MACH"

sequent-i386-dynix-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD"

sgi-mips-irix-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_STRING_PROTO -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_STRING_PROTO -DSYS_HAS_TIME_PROTO"

sgi-mips-irix-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_STRING_PROTO -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_STRING_PROTO -DSYS_HAS_TIME_PROTO"

# 'sys/times.h' claims 'times' returns 'clock_t' (how shall it return -1?)
sun-m68k-sunos-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO"

# 'sys/times.h' claims 'times' returns 'clock_t' (how shall it return -1?)
sun-m68k-sunos-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO"

# 'sys/times.h' claims 'times' returns 'clock_t' (how shall it return -1?)
sun-sparc-sunos-gcc2:
	@$(MAKE) me  CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO -DSYS_HAS_SIGNAL_PROTO"
	@$(MAKE) qme CC=gcc  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO -DSYS_HAS_SIGNAL_PROTO"

# 'sys/times.h' claims 'times' returns 'clock_t' (how shall it return -1?)
sun-sparc-sunos-cc:
	@$(MAKE) me  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO"
	@$(MAKE) qme CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG -DSYS_HAS_TIME_PROTO"

bsd:
	@$(MAKE) me  CC=$(CC)  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD"
	@$(MAKE) qme CC=$(CC)  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_BSD"

usg:
	@$(MAKE) me  CC=$(CC)  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG"
	@$(MAKE) qme CC=$(CC)  CFLAGS="$(CFLAGS)" MEFLAGS="-DSYS_IS_USG"

#############################################################################
##
##  Must be called with the following arguments:
##  PROGNAME=<name of program to build>
##  PROGDEF=<define for this program, e.g., -DME>
##  OBJECTX=<additional object>
##  INCLUDEX=<additional dependency>
##  CC=<C compiler to use>
##  CFLAGS=<options for the compiler, e.g., -O>
##  INCDIRS=<additional directories to search for include files -I...>
##  LD=<linker to use>
##  LFLAGS=<options for the linker>
##  LIBDIRS=<additional directories to search for library files -L...>
##  LIBFILES=<additional libraries to link -l...>
##

#############################################################################
##
##  Command to link the executable.
##
OBJECTS1 = $(OBJSDIR)/myalloc.o $(OBJSDIR)/global.o
OBJECTS2 = $(OBJSDIR)/pack.o    $(OBJSDIR)/allocs.o $(OBJSDIR)/out.o \
           $(OBJSDIR)/push.o    $(OBJSDIR)/comline.o $(OBJSDIR)/qinput.o \
           $(OBJSDIR)/memain.o  $(OBJSDIR)/me.o $(OBJSDIR)/coin.o \
           $(OBJSDIR)/vector.o
OBJECTS3 = $(OBJSDIR)/scanner.o $(OBJSDIR)/inputfun.o $(OBJSDIR)/input.tab.o
OBJECTS4 = $(OBJSDIR)/$(OBJECTX)
OBJECTS  = $(OBJECTS1) $(OBJECTS2) $(OBJECTS3) $(OBJECTS4)

../bin/$(PROGNAME).exe : $(OBJECTS)
	$(LD) $(LFLAGS) $(LIBDIRS) -o ../bin/$(PROGNAME).exe \
	      $(OBJECTS) $(LIBFILES)

#############################################################################
##
##  Commands to compile the sources and dependencies.
##
INCLUDE1 = global.h myalloc.h
INCLUDE2 = meint.h
INCLUDE3 = input.h input.tab.h

$(OBJSDIR)/myalloc.o   : myalloc.c   $(INCLUDE1)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c myalloc.c   -o $(OBJSDIR)/myalloc.o
$(OBJSDIR)/global.o    : global.c    $(INCLUDE1)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c global.c    -o $(OBJSDIR)/global.o

$(OBJSDIR)/pack.o      : pack.c      $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c pack.c      -o $(OBJSDIR)/pack.o
$(OBJSDIR)/allocs.o    : allocs.c    $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c allocs.c    -o $(OBJSDIR)/allocs.o
$(OBJSDIR)/out.o       : out.c       $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c out.c       -o $(OBJSDIR)/out.o
$(OBJSDIR)/push.o      : push.c      $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c push.c      -o $(OBJSDIR)/push.o
$(OBJSDIR)/comline.o   : comline.c   $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c comline.c   -o $(OBJSDIR)/comline.o
$(OBJSDIR)/qinput.o    : qinput.c    $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c qinput.c    -o $(OBJSDIR)/qinput.o
$(OBJSDIR)/memain.o    : memain.c    $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c memain.c    -o $(OBJSDIR)/memain.o
$(OBJSDIR)/me.o        : me.c        $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(MEFLAGS) $(PROGDEF) -I. $(INCDIRS) -c me.c        -o $(OBJSDIR)/me.o
$(OBJSDIR)/coin.o      : coin.c      $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c coin.c      -o $(OBJSDIR)/coin.o
$(OBJSDIR)/vector.o    : vector.c    $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c vector.c    -o $(OBJSDIR)/vector.o

$(OBJSDIR)/scanner.o   : scanner.c   $(INCLUDE1) $(INCLUDE2) $(INCLUDEX) $(INCLUDE3)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c scanner.c   -o $(OBJSDIR)/scanner.o
$(OBJSDIR)/inputfun.o     : inputfun.c     $(INCLUDE1) $(INCLUDE2) $(INCLUDEX) $(INCLUDE3)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c inputfun.c -o $(OBJSDIR)/inputfun.o

$(OBJSDIR)/input.tab.o : input.tab.c input.tab.h
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c input.tab.c -o $(OBJSDIR)/input.tab.o
input.tab.c input.tab.h : input.y
	$(BISON) -d input.y -o input.tab.c

$(OBJSDIR)/scrut.o     : scrut.c     $(INCLUDE1) $(INCLUDE2) $(INCLUDEX)
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c scrut.c     -o $(OBJSDIR)/scrut.o
$(OBJSDIR)/lattice.o   : lattice.c   $(INCLUDE1) $(INCLUDE2) $(INCLUDEX) ilatt.h
	$(CC) $(CFLAGS) $(PROGDEF) -I. $(INCDIRS) -c lattice.c   -o $(OBJSDIR)/lattice.o


# for GAP distribution
src_dist:
	@(cmp ${PKG_PATH}/ve/docs/ve.tex ${GAP_PATH}/doc/ve.tex \
         || echo \
         "*** WARNING: current 've.tex' and 'docs/ve.tex' differ ***")
	@zoo ah ${SRCDISTFILE}.zoo \
                ${PKG_PATH}/ve/Makefile \
                ${PKG_PATH}/ve/README \
                ${PKG_PATH}/ve/bin/me \
                ${PKG_PATH}/ve/bin/me.sh \
                ${PKG_PATH}/ve/bin/qme \
                ${PKG_PATH}/ve/bin/qme.sh \
                ${PKG_PATH}/ve/bin/zme \
                ${PKG_PATH}/ve/bin/zme.sh \
                ${PKG_PATH}/ve/docs/nme.txi \
                ${PKG_PATH}/ve/docs/ve.tex \
                `find ${PKG_PATH}/ve/gap -name "*.g" -print` \
                ${PKG_PATH}/ve/init.g \
                `find ${PKG_PATH}/ve/examples -print` \
                ${PKG_PATH}/ve/src/GNUmakefile \
                ${PKG_PATH}/ve/src/Makefile.inc \
                ${PKG_PATH}/ve/src/build.sh \
                ${PKG_PATH}/ve/src/input.y \
                ${PKG_PATH}/ve/src/int/Makefile \
                ${PKG_PATH}/ve/src/int/GNUmakefile \
                ${PKG_PATH}/ve/src/rat/Makefile \
                ${PKG_PATH}/ve/src/rat/GNUmakefile \
                ${PKG_PATH}/ve/src/ve/Makefile \
                ${PKG_PATH}/ve/src/ve/GNUmakefile \
                `find ${PKG_PATH}/ve/src -name "*.h" -print` \
                `find ${PKG_PATH}/ve/src -name "*.c" -print` 
	@zoo PE ${SRCDISTFILE}.zoo

bin_dist:
	@( test \! -r ${PKG_PATH}/ve/bin.orig || ( echo \
         "*** WARNING: 've/bin.orig' exists ***";  exit 1 ) )
	( cd ${PKG_PATH}/ve ; mv bin bin.orig ; mkdir bin ; \
          cp bin.orig/me.sh bin/me.sh ; \
          cp bin.orig/qme.sh bin/qme.sh ; \
          cp bin.orig/zme.sh bin/zme.sh ; \
          cp bin.orig/me-${EXT} bin/me ; \
          cp bin.orig/qme-${EXT} bin/qme ; \
          cp bin.orig/zme-${EXT} bin/zme )
	@zoo ah ${SRCDISTFILE}-${EXT}.zoo \
                ${PKG_PATH}/ve/bin/me.sh \
                ${PKG_PATH}/ve/bin/qme.sh \
                ${PKG_PATH}/ve/bin/zme.sh \
                ${PKG_PATH}/ve/bin/me \
                ${PKG_PATH}/ve/bin/qme \
                ${PKG_PATH}/ve/bin/zme
	@zoo PE ${SRCDISTFILE}-${EXT}.zoo
	( cd ${PKG_PATH}/ve ; rm -rf bin.old ; mv bin bin.old ; \
          mv bin.orig bin )


