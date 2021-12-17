Operation =1
Option =0
Where ="(((BRS_ItemHistory.FiscalMonth)=202107) AND ((BRS_ItemHistory.HIST_comm_group_cd"
    ")<>[comm_group_cd]))"
Begin InputTables
    Name ="BRS_Item_20210607"
    Name ="BRS_ItemHistory"
End
Begin OutputColumns
    Expression ="BRS_Item_20210607.Item"
    Expression ="BRS_Item_20210607.comm_group_cd"
    Expression ="BRS_Item_20210607.comm_note_txt"
    Expression ="BRS_ItemHistory.FiscalMonth"
    Expression ="BRS_ItemHistory.HIST_comm_group_cd"
End
Begin Joins
    LeftTable ="BRS_Item_20210607"
    RightTable ="BRS_ItemHistory"
    Expression ="BRS_Item_20210607.Item = BRS_ItemHistory.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_ItemHistory.HIST_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item_20210607.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item_20210607.comm_group_cd"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item_20210607.Item"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1560
    Bottom =938
    Left =-1
    Top =-1
    Right =1536
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =145
        Top =20
        Right =289
        Bottom =164
        Top =0
        Name ="BRS_Item_20210607"
        Name =""
    End
    Begin
        Left =376
        Top =51
        Right =659
        Bottom =410
        Top =0
        Name ="BRS_ItemHistory"
        Name =""
    End
End
