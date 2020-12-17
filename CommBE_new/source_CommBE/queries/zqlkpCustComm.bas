Operation =1
Option =0
Where ="(((BRS_Customer.ShipTo) Is Null)) OR (((BRS_Customer.comm_status_cd)<>\"\"))"
Begin InputTables
    Name ="zzzShipto"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="zzzShipto.ST"
    Expression ="BRS_Customer.ShipTo"
    Expression ="BRS_Customer.comm_status_cd"
    Expression ="BRS_Customer.comm_note_txt"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_Customer"
    Expression ="zzzShipto.ST = BRS_Customer.ShipTo"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qlkpCustComm].[ST], [qlkpCustComm].[comm_status_cd]"
Begin
    Begin
        dbText "Name" ="BRS_Customer.comm_note_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3870"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Customer.comm_status_cd"
        dbInteger "ColumnWidth" ="1965"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.ST"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1087
    Bottom =584
    Left =-1
    Top =-1
    Right =1509
    Bottom =566
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =59
        Top =232
        Right =203
        Bottom =376
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =593
        Top =308
        Right =846
        Bottom =610
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
