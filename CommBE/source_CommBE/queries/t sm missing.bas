Operation =1
Option =0
Where ="(((comm_customer_master.SPM_StatusCd)=\"y\") AND ((zzzCustList.hsi_customer_id) "
    "Is Null))"
Begin InputTables
    Name ="zzzCustList"
    Name ="comm_customer_master"
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="comm_customer_master.customer_nm"
    Expression ="comm_customer_master.SPM_StatusCd"
    Expression ="comm_customer_master.SPM_EQOptOut"
    Expression ="comm_customer_master.SPM_ReasonTxt"
    Expression ="zzzCustList.hsi_customer_id"
    Expression ="BRS_Customer.Est12MoMerch"
    Expression ="BRS_Customer.VPA"
    Expression ="BRS_Customer.AccountType"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="BRS_Customer.MarketClass"
End
Begin Joins
    LeftTable ="zzzCustList"
    RightTable ="comm_customer_master"
    Expression ="zzzCustList.hsi_customer_id = comm_customer_master.hsi_shipto_id"
    Flag =3
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
dbMemo "OrderBy" ="[Query1].[Est12MoMerch] DESC"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_master.SPM_ReasonTxt"
        dbInteger "ColumnWidth" ="4410"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzCustList.hsi_customer_id"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoMerch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AccountType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
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
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1567
    Bottom =984
    Left =-1
    Top =-1
    Right =1543
    Bottom =425
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =479
        Top =49
        Right =623
        Bottom =193
        Top =0
        Name ="zzzCustList"
        Name =""
    End
    Begin
        Left =102
        Top =68
        Right =245
        Bottom =212
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =283
        Top =118
        Right =427
        Bottom =262
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =700
        Top =213
        Right =844
        Bottom =357
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
