Operation =3
Name ="STAGE_BRS_Transaction"
Option =0
Begin InputTables
    Name ="lnkBRSales"
End
Begin OutputColumns
    Name ="SHDOCO"
    Expression ="lnkBRSales.SHDOCO"
    Name ="SHDCTO"
    Expression ="lnkBRSales.SHDCTO"
    Name ="SDLNID"
    Expression ="lnkBRSales.SDLNID"
    Name ="SDAN8"
    Expression ="lnkBRSales.SDAN8"
    Name ="SDSHAN"
    Expression ="lnkBRSales.SDSHAN"
    Name ="SDLITM"
    Expression ="lnkBRSales.SDLITM"
    Name ="SDDOC"
    Expression ="lnkBRSales.SDDOC"
    Name ="SDDCT"
    Expression ="lnkBRSales.SDDCT"
    Name ="QCAC10"
    Expression ="lnkBRSales.QCAC10"
    Name ="QCAC08"
    Expression ="lnkBRSales.QCAC08"
    Name ="QCAC04"
    Expression ="lnkBRSales.QCAC04"
    Name ="QC$OSC"
    Expression ="lnkBRSales.[QC$OSC]"
    Name ="SDLNTY"
    Expression ="lnkBRSales.SDLNTY"
    Name ="SDSRP1"
    Expression ="lnkBRSales.SDSRP1"
    Name ="SDGLC"
    Expression ="lnkBRSales.SDGLC"
    Name ="SHMCU"
    Expression ="lnkBRSales.SHMCU"
    Name ="SHMCU01"
    Expression ="lnkBRSales.SHMCU01"
    Name ="SDMCU"
    Expression ="lnkBRSales.SDMCU"
    Name ="SDMCU01"
    Expression ="lnkBRSales.SDMCU01"
    Name ="SDEMCU"
    Expression ="lnkBRSales.SDEMCU"
    Name ="SDEMCU01"
    Expression ="lnkBRSales.SDEMCU01"
    Name ="GLANI"
    Expression ="lnkBRSales.GLANI"
    Name ="GMDL01"
    Expression ="lnkBRSales.GMDL01"
    Name ="GLAA"
    Expression ="lnkBRSales.GLAA"
End
Begin OrderBy
    Expression ="lnkBRSales.SHDOCO"
    Flag =0
    Expression ="lnkBRSales.SHDCTO"
    Flag =0
    Expression ="lnkBRSales.SDLNID"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="lnkBRSales.GLAA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SHDOCO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SHDCTO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDLNID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDAN8"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDSHAN"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDLITM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDDOC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDDCT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.QCAC10"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.QCAC08"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.QCAC04"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.[QC$OSC]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDLNTY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDSRP1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDGLC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SHMCU"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SHMCU01"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDMCU"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDMCU01"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDEMCU"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.SDEMCU01"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.GLANI"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSales.GMDL01"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1060
    Bottom =993
    Left =-1
    Top =-1
    Right =1036
    Bottom =662
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =338
        Bottom =547
        Top =0
        Name ="lnkBRSales"
        Name =""
    End
End
