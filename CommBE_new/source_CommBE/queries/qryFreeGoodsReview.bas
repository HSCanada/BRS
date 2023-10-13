Operation =1
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202302))"
Begin InputTables
    Name ="comm_freegoods"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.SalesOrderNumber"
    Expression ="comm_freegoods.original_line_number"
    Expression ="comm_freegoods.SourceCode"
    Expression ="comm_freegoods.ShipTo"
    Expression ="comm_freegoods.PracticeName"
    Expression ="comm_freegoods.Item"
    Expression ="comm_freegoods.ItemDescription"
    Expression ="comm_freegoods.Supplier"
    Expression ="comm_freegoods.ExtFileCostCadAmt"
    Expression ="comm_freegoods.ID"
    Expression ="comm_freegoods.comm_note_txt"
    Expression ="comm_freegoods.ma_estimate_factor"
    Expression ="comm_freegoods.DocType"
    Expression ="comm_freegoods.cust_comm_group_cd"
    Expression ="comm_freegoods.item_comm_group_cd"
    Expression ="comm_freegoods.fsc_salesperson_key_id"
    Expression ="comm_freegoods.fsc_comm_group_cd"
    Expression ="comm_freegoods.fsc_code"
    Expression ="comm_freegoods.fg_fsc_comm_group_cd"
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
Begin
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.PracticeName"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ItemDescription"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ma_estimate_factor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1057
    Bottom =850
    Left =-1
    Top =-1
    Right =1033
    Bottom =533
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =107
        Top =91
        Right =802
        Bottom =619
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
End
