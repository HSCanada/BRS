Operation =1
Option =0
Where ="(((BRS_CustomerFSC_History.HIST_TerritoryCd)=\"WZ118\" Or (BRS_CustomerFSC_Histo"
    "ry.HIST_TerritoryCd)=\"CZ1TT\") AND ((BRS_CustomerFSC_History.FiscalMonth)=20230"
    "4))"
Begin InputTables
    Name ="BRS_CustomerFSC_History"
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_CustomerFSC_History.Shipto"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Customer.TerritoryCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_CustomerFSC_History.HIST_TerritoryCd"
    Expression ="BRS_CustomerFSC_History.FiscalMonth"
End
Begin Joins
    LeftTable ="BRS_CustomerFSC_History"
    RightTable ="BRS_Customer"
    Expression ="BRS_CustomerFSC_History.Shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.Shipto"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =12
    Top =43
    Right =1495
    Bottom =853
    Left =-1
    Top =-1
    Right =1455
    Bottom =115
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =187
        Top =11
        Right =403
        Bottom =245
        Top =0
        Name ="BRS_CustomerFSC_History"
        Name =""
    End
    Begin
        Left =562
        Top =50
        Right =706
        Bottom =194
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =768
        Top =34
        Right =912
        Bottom =178
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
