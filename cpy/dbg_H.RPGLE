      //‚Module view information (header)
     D VEWL0100H       ds                  based(pVEWL0100H) qualified
     D  bytesReturned                10i 0
     D  bytesAvalaibl                10i 0
     D  elements                     10i 0
      //‚Module view information (detail)
     D VEWL0100D       ds                  based(pVEWL0100D) qualified
     D  MdlName                      10a
     D  ViewType                     10a
     D  CompilerID                   20a
     D  fMain                        10a
     D  viewts                       13a
     D  ViewDesc                     50a
     D  res                           3a
     D  ViewNO                       10i 0
     D  ViewNumbers                  10i 0
      //‚Start Source Debug
     D QteStartSourceDebug...
     D                 PR                  EXTPROC('QteStartSourceDebug')
     D  StopHandler                  20a   const
     D   ApiErr                            like(tApiErr)
      //‚End Source Debug
     D QteEndSourceDebug...
     D                 PR                  EXTPROC('QteEndSourceDebug')
     D   ApiErr                            like(tApiErr)
      //‚Register debug view
     D QteRegisterDebugView...
     D                 PR                  EXTPROC('QteRegisterDebugView')
     D   ViewID                      10i 0
     D   ViewLines                   10i 0
     D   PgmLibr                     10a
     D   TimeStamp                   13a
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     D  ViewNumber                   10i 0 const
     D   apiErr                             like(tApiErr)
      //‚Retrieve module views
     D QteRetrieveModuleViews...
     D                 PR                  EXTPROC('QteRetrieveModuleViews')
     D  RcvrDta                    1024a   const
     D  RcvrSiz                      10i 0 const
     D  RcvrFmt                       8a   const
     D  PgmQlfy                      20a   const
     D  PgmType                      10a   const
     D  MdlName                      10a   const
     D   PgmLibr                     10a
     D   ApiErr                             like(tApiErr)
      //‚Map view position
     D QteMapViewPosition...
     D                 PR                  EXTPROC('QteMapViewPosition')
     D  RcvrDta                    1024a
     D  RcvrSiz                      10i 0 const
     D  FmViewID                     10i 0 const
     D  FmLine                       10i 0 const
     D  Fmcolumn                     10i 0 const
     D  ToViewID                     10i 0 const
     D  ApiErr                              like(tApiErr)
      //‚next step
     D QteStep         pr                  EXTPROC('QteStep')
     D  ViewID                       10i 0 const
     D  StepCount                    10i 0 const
     D  StepType                     10a   const
     D   ApiErr                            like(tApiErr)
