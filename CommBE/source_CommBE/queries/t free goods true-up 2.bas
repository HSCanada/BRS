Operation =2
Name ="zzFG-fix"
Option =0
Where ="(((comm_free_goods_redeem.CalMonth)>=201901) AND ((comm_free_goods_redeem.Source"
    "Code)=\"act\") AND ((comm_free_goods_redeem.process_status_cd) Between 1 And 2))"
Begin InputTables
    Name ="comm_free_goods_redeem"
End
Begin OutputColumns
    Expression ="comm_free_goods_redeem.SalesOrderNumber"
    Expression ="comm_free_goods_redeem.DocType"
    Alias ="FirstOfShipTo"
    Expression ="First(comm_free_goods_redeem.ShipTo)"
    Alias ="FirstOfPracticeName"
    Expression ="First(comm_free_goods_redeem.PracticeName)"
    Alias ="FirstOfsalesperson_cd"
    Expression ="First(comm_free_goods_redeem.salesperson_cd)"
    Alias ="FirstOfsalesperson_ess_cd"
    Expression ="First(comm_free_goods_redeem.salesperson_ess_cd)"
    Alias ="FirstOfspecial_market_ind"
    Expression ="First(comm_free_goods_redeem.special_market_ind)"
    Alias ="FirstOfequipment_opt_out_ind"
    Expression ="First(comm_free_goods_redeem.equipment_opt_out_ind)"
    Alias ="FirstOfID_legacy"
    Expression ="First(comm_free_goods_redeem.ID_legacy)"
    Alias ="SumOfExtFileCostCadAmt"
    Expression ="Sum(comm_free_goods_redeem.ExtFileCostCadAmt)"
End
Begin Groups
    Expression ="comm_free_goods_redeem.SalesOrderNumber"
    GroupLevel =0
    Expression ="comm_free_goods_redeem.DocType"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="comm_free_goods_redeem.special_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfPracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.process_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.FiscalMonth_actual"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfspecial_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfequipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1471
    Bottom =825
    Left =-1
    Top =-1
    Right =1447
    Bottom =545
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =147
        Top =52
        Right =523
        Bottom =379
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
End
