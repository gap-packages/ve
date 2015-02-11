#!/bin/csh
switch ( `hostname` )
  case 'bert':
  case 'ernie':
  case 'samson':
  case 'tiffy':
    exec $0-dec-mips-ultrix $* ;
    breaksw ;
  case 'astoria':
  case 'beaker':
  case 'fozzy':
  case 'gonzo':
  case 'hobbes':
  case 'rowlf':
  case 'stadler':
  case 'waldorf':
    exec $0-ibm-i386-386bsd $* ;
    breaksw ;
  case 'bjerun':
    exec $0-next-m68k-mach $* ;
    breaksw ;
  case 'momo':
  case 'groover':
    exec $0-hp-hppa1.1-hpux $* ;
    breaksw ;
  case 'math':
    exec $0-hp-hppa1.0-hpux $* ;
    breaksw ;
  case 'willi':
    exec $0-mips-mips-bsd $* ;
    breaksw ;
  case 'messua':
  case 'pell':
    exec $0-sun-sparc-sunos $* ;
    breaksw ;
  default:
    echo "me/qme/zme: sorry, no executable exists for this machine" ;
    breaksw ;
endsw
