Operation =1
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202107) AND ((comm_freegoods.fsc_salesperson_key_"
    "id)=\"JACK.FREEBORN\") AND ((BRS_FSC_Rollup.Branch)=\"OTTWA\"))"
Begin InputTables
    Name ="comm_freegoods"
    Name ="BRS_Item"
    Name ="BRS_ItemMPC"
    Name ="comm_salesperson_master"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.ShipTo"
    Expression ="comm_freegoods.PracticeName"
    Expression ="comm_freegoods.SalesOrderNumber"
    Expression ="comm_freegoods.Item"
    Expression ="comm_freegoods.ItemDescription"
    Expression ="comm_freegoods.Supplier"
    Expression ="comm_freegoods.ExtFileCostCadAmt"
    Expression ="comm_freegoods.SourceCode"
    Expression ="comm_freegoods.ID"
    Expression ="comm_freegoods.ID_redeem_xref"
    Expression ="comm_freegoods.comm_note_txt"
    Expression ="comm_freegoods.fsc_salesperson_key_id"
    Expression ="comm_freegoods.fsc_comm_group_cd"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_ItemMPC.MajorProductClassDesc"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Customer.VPA"
End
Begin Joins
    LeftTable ="comm_freegoods"
    RightTable ="BRS_Item"
    Expression ="comm_freegoods.Item = BRS_Item.Item"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemMPC"
    Expression ="BRS_Item.MajorProductClass = BRS_ItemMPC.MajorProductClass"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="comm_salesperson_master"
    Expression ="comm_freegoods.fsc_salesperson_key_id = comm_salesperson_master.salesperson_key_"
        "id"
    Flag =1
    LeftTable ="comm_salesperson_master"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_salesperson_master.master_salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="BRS_Customer"
    Expression ="comm_freegoods.ShipTo = BRS_Customer.ShipTo"
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
        dbText "Name" ="comm_freegoods.Item"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.ShipTo"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1530"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID_redeem_xref"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1935"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2190"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.ID"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="810"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_ItemMPC.MajorProductClassDesc"
        dbInteger "ColumnWidth" ="3150"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.DocType"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1215"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1650"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.PracticeName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3315"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.ItemDescription"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.Supplier"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1200"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.comm_note_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods_1.ID_redeem_xref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods_1.SalesOrderNumber"
        dbInteger "ColumnWidth" ="4095"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.eps_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods_1.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ma_estimate_factor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods_1.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fg_eps_comm_group_cd"
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
        dbText "Name" ="BRS_ItemCategory.major_desc"
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
    Bottom =550
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =126
        Top =60
        Right =328
        Bottom =397
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =457
        Top =305
        Right =876
        Bottom =644
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =887
        Top =86
        Right =1031
        Bottom =230
        Top =0
        Name ="BRS_ItemMPC"
        Name =""
    End
    Begin
        Left =1197
        Top =151
        Right =1442
        Bottom =295
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =1007
        Top =461
        Right =1151
        Bottom =605
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =475
        Top =14
        Right =797
        Bottom =295
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
