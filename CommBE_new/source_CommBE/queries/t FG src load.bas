Operation =3
Name ="comm_freegoods"
Option =0
Where ="((([comm_free_goods_redeem-PROD].CalMonth)=202012) AND (([comm_free_goods_redeem"
    "-PROD].SourceCode)=\"ACT\"))"
Begin InputTables
    Name ="comm_free_goods_redeem-PROD"
End
Begin OutputColumns
    Name ="FiscalMonth"
    Expression ="[comm_free_goods_redeem-PROD].CalMonth"
    Name ="SalesOrderNumber"
    Expression ="[comm_free_goods_redeem-PROD].SalesOrderNumber"
    Name ="DocType"
    Expression ="[comm_free_goods_redeem-PROD].DocType"
    Name ="Item"
    Expression ="[comm_free_goods_redeem-PROD].Item"
    Name ="SourceCode"
    Expression ="[comm_free_goods_redeem-PROD].SourceCode"
    Name ="ShipTo"
    Expression ="[comm_free_goods_redeem-PROD].ShipTo"
    Name ="PracticeName"
    Expression ="[comm_free_goods_redeem-PROD].PracticeName"
    Name ="ItemDescription"
    Expression ="[comm_free_goods_redeem-PROD].ItemDescription"
    Name ="Supplier"
    Expression ="[comm_free_goods_redeem-PROD].Supplier"
    Name ="ExtFileCostCadAmt"
    Expression ="[comm_free_goods_redeem-PROD].ExtFileCostCadAmt"
    Name ="original_line_number"
    Expression ="[comm_free_goods_redeem-PROD].ID"
    Name ="fsc_code"
    Expression ="[comm_free_goods_redeem-PROD].salesperson_cd"
    Alias ="Expr1"
    Name ="ess_code"
    Expression ="Nz([salesperson_ess_cd],\"\")"
    Name ="item_comm_group_cd"
    Expression ="[comm_free_goods_redeem-PROD].comm_group_cd"
    Name ="status_code"
    Expression ="[comm_free_goods_redeem-PROD].process_status_cd"
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
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].process_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].FiscalMonth_actual"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].special_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].group_equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1550
    Bottom =946
    Left =-1
    Top =-1
    Right =1526
    Bottom =601
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =102
        Top =71
        Right =452
        Bottom =459
        Top =0
        Name ="comm_free_goods_redeem-PROD"
        Name =""
    End
End
