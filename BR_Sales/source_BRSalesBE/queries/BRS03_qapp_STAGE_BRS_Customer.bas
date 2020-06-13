Operation =3
Name ="STAGE_BRS_Customer"
Option =0
Begin InputTables
    Name ="lnkBRSCustomer"
End
Begin OutputColumns
    Name ="CUID"
    Expression ="lnkBRSCustomer.CUID"
    Name ="ADNOID"
    Expression ="lnkBRSCustomer.ADNOID"
    Name ="BTCUID"
    Expression ="lnkBRSCustomer.BTCUID"
    Name ="BTADNO"
    Expression ="lnkBRSCustomer.BTADNO"
    Name ="SPCDID"
    Expression ="lnkBRSCustomer.SPCDID"
    Name ="SPCCDID"
    Expression ="lnkBRSCustomer.SPCCDID"
    Name ="AFTRCD"
    Expression ="lnkBRSCustomer.AFTRCD"
    Name ="AFLV02CD"
    Expression ="lnkBRSCustomer.AFLV02CD"
    Name ="CUEFDTID"
    Expression ="lnkBRSCustomer.CUEFDTID"
    Name ="CUEFDT"
    Expression ="lnkBRSCustomer.CUEFDT"
    Name ="CUEFDTID0"
    Expression ="lnkBRSCustomer.CUEFDTID0"
    Name ="CUEFDT0"
    Expression ="lnkBRSCustomer.CUEFDT0"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbBoolean "UseTransaction" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="lnkBRSCustomer.CUEFDT0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.CUID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.ADNOID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.BTCUID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.BTADNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.SPCDID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.SPCCDID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.AFTRCD"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.AFLV02CD"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.CUEFDTID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.CUEFDT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkBRSCustomer.CUEFDTID0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1602
    Bottom =1005
    Left =-1
    Top =-1
    Right =1578
    Bottom =439
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =409
        Bottom =367
        Top =0
        Name ="lnkBRSCustomer"
        Name =""
    End
End
