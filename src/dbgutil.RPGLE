     h nomain bnddir('U6')
      //‚copy book
      /copy cpy,dbg_h
      /copy cpy,u6ibm_h
      /copy cpy,u6ifs_h
      //‚Pgm to debug
     d  Pgm$           s             10a
      //‚Object meet
     d obj             ds                  qualified dim(20)
     d  ID                           20
     d  type                         10
     d  iMod                          3u 0 inz(0)
     d  ModView                            dim(20) likeDs(tModView)
     d iObj            s              3u 0 inz(0)
      //‚Module/view
     d tModView        ds                  qualified
     d  mod                          10
     d  view1                        10i 0 inz(0)
     d  view2                        10i 0 inz(0)
      //
     D  PgmQlfy$       s             20a
     D  MdlName$       s             10a
     d hWrt            s             10i 0 inz(-1)
      //‚--------------------------------------------------------------------
      //‚register pgm
      //‚--------------------------------------------------------------------
     pdbg_setPgm       b                   export
     d dbg_setPgm      pi
     d  Pgm                          10a   const
        pgm$=pgm;
     p                 e
      //‚--------------------------------------------------------------------
      //‚get view 2
      //‚--------------------------------------------------------------------
     pdbg_getView2     b                   export
     d dbg_getView2    pi              n
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     d  view1                        10i 0
     d  view2                        10i 0
      *
     d i               s              3u 0
     d p               s              3u 0
     d m               s              3u 0
     d pgmLibr         s             10a
     d w4228           s           4228a
       apierr.bytPrv=%size(apierr);
       if pgmQlfy=pgmQlfy$ and mdlName=mdlName$;
         return %subst(pgmQlfy:1:10)=pgm$;
       endIf;
       p=%lookup(pgmQlfy:obj(*).ID:1:iObj);
       if p>0;
         m=%lookup(mdlName:obj(p).modView(*).mod);
         if m>0;
           view1=obj(p).modView(m).view1;
           view2=obj(p).modView(m).view2;
           pgmQlfy$=pgmQlfy;
           mdlName$=mdlName;
           return %subst(pgmQlfy:1:10)=pgm$;
         endIf;
       endIf;
       iObj+=1;
       obj(iObj).ID  =pgmQlfy;
       obj(iObj).type=pgmType;
       QteRetrieveModuleViews
       (w4228
        :4228
        :'VEWL0100'
        :PgmQlfy
        :PgmType
        :'*ALL'
         :PgmLibr
         :ApiErr);
       pVEWL0100h=%addr(w4228);
       for i=0 to VEWL0100H.elements-1;
         pVEWL0100d=pVEWL0100h+%size(VEWL0100h)+i*%size(VEWL0100d);
         if VEWL0100d.ViewDesc='ILE RPG Source View'
         or VEWL0100d.ViewDesc='SQL Root Source View';
           obj(iObj).iMod+=1;
           obj(iObj).ModView(obj(iObj).iMod).Mod=VEWL0100d.mdlName;
           obj(iObj).ModView(obj(iObj).iMod).View2=
           dbg_getView(pgmQlfy:pgmType:VEWL0100d.mdlName:VEWL0100d.ViewNO);
         endIf;
       endFor;
       sorta %subarr(obj(iObj).ModView(*).Mod:1:obj(iObj).iMod);
       for i=1 to obj(iObj).iMod;
         obj(iObj).ModView(i).View1=
         dbg_getView(pgmQlfy:pgmType:obj(iObj).ModView(i).mod:-1);
       endFor;
       sorta %subarr(obj(*).ID:1:iObj);
       return dbg_getView2(pgmQlfy:pgmType:mdlName:view1:view2);
     p                 e
      //‚--------------------------------------------------------------------
      //‚Start source debug
      //‚--------------------------------------------------------------------
     pdbg_StrSrcDbg    b                   export
     d dbg_StrSrcDbg   pi
     d  dbgHandler                   20a   const
       apierr.bytPrv=%size(apierr);
       QteStartSourceDebug(dbgHandler:apierr);
     p                 e
      //‚--------------------------------------------------------------------
      //‚End source debug
      //‚--------------------------------------------------------------------
     pdbg_EndSrcDbg    b                   export
       apierr.bytPrv=%size(apierr);
       QteEndSourceDebug(apierr);
     p                 e
      //‚--------------------------------------------------------------------
      //‚get debug View ID
      //‚--------------------------------------------------------------------
     pdbg_getView      b                   export
     d dbg_getView     pi            10i 0
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     D  ViewNO                       10i 0 const
      *
     D View            s             10i 0
     D ViewLines       s             10i 0
     D PgmLibr         s             10a
     D TimeStamp       s             13a
       apierr.bytPrv=%size(apierr);
         QteRegisterDebugView
         ( View
          :ViewLines
          :pgmlibr
          :TimeStamp
         :pgmqlfy
         :pgmtype
         :mdlname
         :viewNO
          :ApiErr);
       return View;
     p                 e
      //‚--------------------------------------------------------------------
      //‚get debug View NO
      //‚--------------------------------------------------------------------
     pdbg_getViewNO    b                   export
     d dbg_getViewNO   pi            10i 0
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
      *
     d w4228           s           4228a
     D PgmLibr         s             10a
     d i               s              3u 0
       apierr.bytPrv=%size(apierr);
         QteRetrieveModuleViews
         (w4228
          :4228
          :'VEWL0100'
          :PgmQlfy
          :PgmType
          :MdlName
           :PgmLibr
           :ApiErr);
         pVEWL0100h=%addr(w4228);
         for i=0 to VEWL0100H.elements-1;
           pVEWL0100d=pVEWL0100h+%size(VEWL0100h)+i*%size(VEWL0100d);
           if VEWL0100d.ViewDesc='ILE RPG Source View';
             return VEWL0100d.viewNo;
           endIf;
         endFor;
       return 0;
     p                 e
      //‚--------------------------------------------------------------------
      //‚goto next line
      //‚--------------------------------------------------------------------
     pdbg_step1        b                   export
     d dbg_step1       pi
     d  View                         10i 0 const
       apierr.bytPrv=%size(apierr);
         qteStep(View:1:'*INTO':apiErr);
     p                 e
      //‚--------------------------------------------------------------------
      //‚Map position
      //‚--------------------------------------------------------------------
     pdbg_mapViewPos   b                   export
     d dbg_mapViewPos  pi            10i 0
     d  View1                        10i 0
     d  Line1                        10i 0
     d  View2                        10i 0
      *
     D map             ds                  based(pMap) qualified
     D                               10i 0
     D                               10i 0
     D                               10i 0
     D  Line2                        10i 0
     D  Column                       10i 0
      *
     d w4228           s           4228a
         QteMapViewPosition
         (w4228
         :4228
         :View1
         :Line1
         :1
         :View2
         :ApiErr);
         pMap=%addr(w4228);
         return map.line2;
     p                 e
      //‚--------------------------------------------------------------------
      //‚console for debugging
      //‚--------------------------------------------------------------------
     pdbg_print        b                   export
     d dbg_print       pi
     d  string                    65535A   varying const
       if hWrt=-1;
         hWrt=ifs_openForWrite('dta/console.txt');
       endIf;
       ifs_print(hWrt:string);
     p                 e
      //‚--------------------------------------------------------------------
      //‚close console
      //‚--------------------------------------------------------------------
     pdbg_printclose   b                   export
     d dbg_printclose  pi
       ifs_close(hWrt);
     p                 e
