READ FILE = '0GeneralParameters.block';'..\..\0GeneralParameters.block'
READ FILE = '1ControlCenter.block';'..\..\1ControlCenter.block'

RUN PGM=MATRIX
FILEI MATI[1]="E:\Model\Model16\RTP2015\Round22\V8.1 Master - SE40Hwy40Trn40\4_ModeChoice\Mo\1a_Skims\skm_auto_Pk.mtx"
FILEI MATI[2]="E:\Model\Model16\RTP2015\Round22\V8.1 Master - SE40Hwy40Trn40\Temp\4_TmpMC\Best_Walk_Skims.mtx"
FILEO RECO[1]="autoskim.dbf" FIELDS=I,J,TIMEAUTO, TIMETRANSIT 

mw[1]=mi.1.1 + mi.1.5
MW[2] = (mi.2.INITWAIT + mi.2.T45678 + mi.2.xferwait + mi.2.Walktime)

JLOOP
RO.I=I
RO.J=J

IF (mi.1.5>0)
  RO.TIMEAUTO=MW[1]
ELSE
  RO.TIMEAUTO = 5000
ENDIF
IF (mi.2.T45678[J]>0)
  RO.TIMETRANSIT = mw[2]
ELSE
  RO.TIMETRANSIT = 5000

ENDIF
WRITE RECO=1
ENDJLOOP
ENDRUN
