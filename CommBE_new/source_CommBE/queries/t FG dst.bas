Operation =1
Option =0
Having ="(((comm_freegoods.FiscalMonth)=202012))"
Begin InputTables
    Name ="comm_freegoods"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.SourceCode"
    Alias ="SumOfExtFileCostCadAmt"
    Expression ="Sum(comm_freegoods.ExtFileCostCadAmt)"
End
Begin Groups
    Expression ="comm_freegoods.FiscalMonth"
    GroupLevel =0
    Expression ="comm_freegoods.SourceCode"
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
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ItemDescription"
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
        dbText "Name" ="comm_freegoods.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.eps_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.eps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
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
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =73
        Top =57
        Right =521
        Bottom =464
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
End
