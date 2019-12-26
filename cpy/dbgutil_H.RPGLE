      //‚set program eligible to debug
     ddbg_setPgm       pr
     d  pgm                          10a   const
      //‚Start source debug
     d dbg_StrSrcDbg   pr
     d  dbgHandler                   20a   const
      //‚End source debug
     ddbg_EndSrcDbg    pr
      //‚get debug View 2
     d dbg_getView2    pr              n
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     D  View1                        10i 0
     D  View2                        10i 0
      //‚get debug View
     d dbg_getView     pr            10i 0
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     D  ViewNO                       10i 0 const
      //‚get debug View NO
     d dbg_getViewNO   pr            10i 0
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
      //‚goto next line
     d dbg_step1       pr
     d  View                         10i 0 const
      //‚Map position
     d dbg_mapViewPos  pr            10i 0
     d  View1                        10i 0
     d  Line1                        10i 0
     d  View2                        10i 0
      //‚console for debugging
     d dbg_print       pr
     d  string                    65535A   varying const
      //‚close console
     d dbg_printclose  pr
