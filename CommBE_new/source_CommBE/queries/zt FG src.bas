Operation =1
Option =0
Having ="((([comm_free_goods_redeem-PROD].CalMonth)=202012))"
Begin InputTables
    Name ="comm_free_goods_redeem-PROD"
End
Begin OutputColumns
    Expression ="[comm_free_goods_redeem-PROD].CalMonth"
    Expression ="[comm_free_goods_redeem-PROD].SourceCode"
    Alias ="SumOfExtFileCostCadAmt"
    Expression ="Sum([comm_free_goods_redeem-PROD].ExtFileCostCadAmt)"
End
Begin Groups
    Expression ="[comm_free_goods_redeem-PROD].CalMonth"
    GroupLevel =0
    Expression ="[comm_free_goods_redeem-PROD].SourceCode"
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
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =12
    Top =81
    Right =1492
    Bottom =926
    Left =-1
    Top =-1
    Right =1526
    Bottom =567
    Left =0
    Top =0
    ColumnsShown =543
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
