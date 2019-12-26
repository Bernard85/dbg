     H DFTACTGRP(*NO) bnddir('DBG') actgrp('DBG')
     D dbgPgm          pi
     D  Reason                       10a
     D  PgmLst                      600
     D  PgmCnt                       10i 0
      /copy cpy,dbgutil_h
     D dbgStart        pr                  EXTPGM('DBGSTART')
     d view1           s             10i 0 inz(0)
       if     reason = '*START';
         dbg_setPgm(%subst(pgmLst:1:20));
         dbg_strsrcDbg('DBGSTART  *LIBL     ');
       elseif reason = '*DISPLAY';
         view1 =dbg_getView
               (%subst(pgmLst:1:20)
               :%subst(pgmlst:21:10)
               :%subst(pgmLst:1:10)
               :-1);
         dbg_step1(view1);
       elseIf reason = '*STOP';
         dbg_endSrcDbg();
         DBGSTART();
       endif;
       *inlr=*on;
