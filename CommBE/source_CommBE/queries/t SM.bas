Operation =1
Option =0
Where ="(((comm_customer_master.SPM_StatusCd)=\"Y\"))"
Begin InputTables
    Name ="comm_customer_master"
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="comm_customer_master.hsi_billto_id"
    Expression ="BRS_Customer.Specialty"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Customer.VPA"
    Expression ="comm_customer_master.customer_nm"
    Expression ="BRS_Customer.PhoneNo"
    Expression ="comm_customer_master.SPM_StatusCd"
    Expression ="comm_customer_master.SPM_EQOptOut"
    Expression ="comm_customer_master.SPM_ReasonTxt"
    Expression ="BRS_Customer.CustGrpWrk"
    Expression ="BRS_Customer.Est12MoMerch"
End
Begin Joins
    LeftTable ="comm_customer_master"
    RightTable ="BRS_Customer"
    Expression ="comm_customer_master.hsi_shipto_id = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
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
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_ReasonTxt"
        dbInteger "ColumnWidth" ="3930"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrk"
        dbInteger "ColumnWidth" ="2190"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PhoneNo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoMerch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1171
    Bottom =999
    Left =-1
    Top =-1
    Right =1147
    Bottom =634
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =361
        Bottom =394
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =483
        Top =14
        Right =789
        Bottom =439
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =920
        Top =56
        Right =1064
        Bottom =200
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
