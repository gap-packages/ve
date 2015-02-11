# makefile includes for all versions of module enumerator
ifeq ($(ARCH),HP)
CC =c89
CFLAGS=-O
else
CC = gcc
CFLAGS = -O2  -finline-functions -DSYS_IS_USG -DSYS_HAS_TIME_PROTO -DSYS_HAS_SIGNAL_PROT
#CFLAGS = -g
endif

CPPFLAGS = $(VFLAG) -I../.. -I/local/gregory/include -Darch_$(ARCH)


LFLAGS= -L/local/gregory/lib
BISON=bison
VPATH=../..


#vpath %.a /home/maths1/sal/lib/$(ARCH)

ifeq ($(ARCH),HP)
sysobjs = alloca.o
else
sysobjs=
endif

objs1= myalloc.o global.o

objs2= 	pack.o allocs.o out.o push.o comline.o qinput.o\
     memain.o me.o coin.o vector.o 

objs3=  scanner.o input.o input.tab.o


objects= $(objs1) $(objs2) $(objs3) $(XTRAOBJS) $(sysobjs)

%.d : %.c 
	$(CC) -M $(CPPFLAGS) $< | sed 's:$*.o:& $@:g' > $@

%.c : %.y

%.s : %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -S $<

../../%.tab.c ../../%.tab.h: %.y
	$(BISON) -d $^ -o ../../$(*).tab.c

../../bin/$(ARCH)/$(PROGNAME) : $(objects)
	$(CC) $(CFLAGS) $(LFLAGS) -o $@ $(objects) -lm $(ARITHLIB)

.PHONY  : distclean

distclean : 
	$(RM) *.d *.tab* ../*.tab* *.o

input.tab.d : ../../input.tab.c ../../input.tab.h
	$(CC) -M $(CPPFLAGS) $< |  sed 's:input.tab.o:& $@:g' > $@

input.tab.o : ../../input.tab.c ../../input.tab.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ 

ifeq ($(ARCH),HP)


$(objects) : ../../global.h ../../myalloc.h

$(objs2) $(objs3) $(XTRAOBJS) : ../../meint.h $(XTRAGDEPS)

$(objs3) : ../../input.h ../../input.tab.h

$(XTRAOBJS) : $(XTRADEPS)

else 
include $(subst .o,.d,$(objects))

scanner.d : ../../input.tab.h
endif

