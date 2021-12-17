Operation =1
Option =0
Where ="(((BRS_Customer.comm_fsc_bonus_2_ind)=True))"
Begin InputTables
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_Customer.ShipTo"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_Customer.MarketClass"
End
Begin Joins
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
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbInteger "ColumnWidth" ="4005"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1614
    Bottom =946
    Left =-1
    Top =-1
    Right =1590
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =77
        Top =71
        Right =383
        Bottom =360
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =583
        Top =108
        Right =727
        Bottom =252
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
