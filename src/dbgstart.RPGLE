     H DFTACTGRP(*NO) bnddir('DBG':'U6') actgrp('DBG')
      //‚--------------------------------------------------------------------
      //‚main parameters
      //‚--------------------------------------------------------------------
     D dbgstart        pi
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     D  StopInf                      10a   const
     D  RcvrDta                    4096
     D  RcvrEnt                      10i 0 const
     D  Message                    4096
      //‚--------------------------------------------------------------------
      //‚copy books
      //‚--------------------------------------------------------------------
      /copy cpy,dbgutil_h
      //‚--------------------------------------------------------------------
      //‚Work variables
      //‚--------------------------------------------------------------------
     d  view1          s             10i 0
     d  view2          s             10i 0
      *
     D RcvVarHdr1      ds                  based(pRcvVarHdr1)
     D  Line1                        10i 0
      *
     d buffer          s          65535a   varying
     d hWrt            s             10i 0
      //‚--------------------------------------------------------------------
      //‚main
      //‚--------------------------------------------------------------------
       if %parms()>0;
         pRcvVarHdr1=%addr(RcvrDta);
         if dbg_getView2(pgmQlfy:pgmType:MdlName:view1:view2);
           outLines();
         endIf;
         dbg_step1(view1);
       else;
         dbg_print(buffer);
         dbg_printclose();
         dbg_endSrcDbg();
         *inlr=*on;
       endif;
       return;
      //‚--------------------------------------------------------------------
      //‚Out lines
      //‚--------------------------------------------------------------------
     poutLines         b
     d outLines        pi
     D  Line2          s             10i 0
       line2=dbg_mapviewpos(view1:Line1:view2);
       buffer+=%trim(%subst(pgmqlfy:1:10))+';'
              +%trim(mdlName)+';'
              +%char(View1)+';'
              +%char(View2)+';'
              +%char(Line1)+';'
              +%char(Line2)+';'
              +x'0d25';
          if %len(buffer)>65500;
           dbg_print(buffer);
           buffer='';
          endIf;
     p                 e
