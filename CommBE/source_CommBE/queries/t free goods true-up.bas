Operation =1
Option =0
Where ="(((comm_free_goods_redeem.salesperson_ess_cd)<>\"\") AND ((comm_free_goods_redee"
    "m.SourceCode)=\"ACT\") AND ((comm_free_goods_redeem.process_status_cd)=3))"
Begin InputTables
    Name ="comm_free_goods_redeem"
    Name ="comm_salesperson_code_map"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_free_goods_redeem.*"
End
Begin Joins
    LeftTable ="comm_free_goods_redeem"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_free_goods_redeem.salesperson_ess_cd = comm_salesperson_code_map.salesperso"
        "n_cd"
    Flag =1
    LeftTable ="comm_salesperson_code_map"
    RightTable ="comm_salesperson_master"
    Expression ="comm_salesperson_code_map.salesperson_key_id = comm_salesperson_master.salespers"
        "on_key_id"
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
        dbText "Name" ="comm_free_goods_redeem.process_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SalesOrderNumber"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[zzFG-fix].SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.FiscalMonth_actual"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[zzFG-fix].FirstOfsalesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_ess_cd"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_ess_cd"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.special_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.group_equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfsalesperson_ess_cd"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzCustList.note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =800
    Left =-1
    Top =-1
    Right =1421
    Bottom =481
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =112
        Top =27
        Right =632
        Bottom =458
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
    Begin
        Left =729
        Top =26
        Right =1057
        Bottom =305
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =1121
        Top =57
        Right =1265
        Bottom =201
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
