Operation =1
Option =0
Where ="(((fg_transaction_F5554240.CalMonthRedeem)=202110) AND ((comm_freegoods.ID_sourc"
    "e_ref) Is Null))"
Begin InputTables
    Name ="comm_freegoods"
    Name ="fg_transaction_F5554240"
End
Begin OutputColumns
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    Alias ="SumOfWKECST_extended_cost"
    Expression ="Sum(fg_transaction_F5554240.WKECST_extended_cost)"
End
Begin Joins
    LeftTable ="comm_freegoods"
    RightTable ="fg_transaction_F5554240"
    Expression ="comm_freegoods.ID_source_ref = fg_transaction_F5554240.ID_source_ref"
    Flag =3
End
Begin Groups
    Expression ="fg_transaction_F5554240.fg_exempt_cd"
    GroupLevel =0
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
        dbText "Name" ="ext_cost"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.fg_exempt_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.CalMonthRedeem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKLNNO_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID_source_ref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_transaction_F5554240.WKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfWKECST_extended_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfID_source_ref"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1620
    Bottom =918
    Left =-1
    Top =-1
    Right =1604
    Bottom =350
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =63
        Top =15
        Right =374
        Bottom =285
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =495
        Top =21
        Right =754
        Bottom =232
        Top =0
        Name ="fg_transaction_F5554240"
        Name =""
    End
End
