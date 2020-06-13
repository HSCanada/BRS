Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.Branch)=GetCurrentBranch()) AND ((comm_ess_statement_detail.fs"
    "c_salesperson_key_id)<>\"internal\"))"
Begin InputTables
    Name ="comm_ess_statement_detail"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master"
    Alias ="comm_salesperson_master_1"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="comm_ess_statement_detail.fiscal_yearmo_num"
    Alias ="branch_cd"
    Expression ="First(BRS_FSC_Rollup.Branch)"
    Alias ="fiscal_begin_dt"
    Expression ="First(comm_ess_statement_detail.fiscal_begin_dt)"
    Alias ="fiscal_end_dt"
    Expression ="First(comm_ess_statement_detail.fiscal_end_dt)"
    Alias ="ESS_nm"
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Alias ="customer_nm"
    Expression ="First(comm_ess_statement_detail.customer_nm)"
    Alias ="hsi_shipto_id"
    Expression ="First(comm_ess_statement_detail.hsi_shipto_id)"
    Alias ="transaction_dt"
    Expression ="First(comm_ess_statement_detail.transaction_dt)"
    Expression ="comm_ess_statement_detail.doc_id"
    Alias ="FSC_nm"
    Expression ="First(comm_salesperson_master_1.salesperson_nm)"
    Alias ="transaction_amt"
    Expression ="Sum(comm_ess_statement_detail.transaction_amt)"
    Alias ="gp_ext_amt"
    Expression ="Sum(comm_ess_statement_detail.gp_ext_amt)"
    Alias ="comm_amt"
    Expression ="Sum(comm_ess_statement_detail.comm_amt)"
End
Begin Joins
    LeftTable ="comm_ess_statement_detail"
    RightTable ="comm_salesperson_master"
    Expression ="comm_ess_statement_detail.salesperson_key_id = comm_salesperson_master.salespers"
        "on_key_id"
    Flag =1
    LeftTable ="comm_ess_statement_detail"
    RightTable ="comm_salesperson_master_1"
    Expression ="comm_ess_statement_detail.fsc_salesperson_key_id = comm_salesperson_master_1.sal"
        "esperson_key_id"
    Flag =1
    LeftTable ="comm_salesperson_master_1"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_salesperson_master_1.master_salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
End
Begin OrderBy
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Flag =0
    Expression ="First(comm_ess_statement_detail.customer_nm)"
    Flag =0
    Expression ="First(comm_ess_statement_detail.transaction_dt)"
    Flag =0
End
Begin Groups
    Expression ="comm_ess_statement_detail.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_ess_statement_detail.doc_id"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbText "Description" ="x"
dbMemo "OrderBy" ="[qryCommESSStatementSummaryExport].[fiscal_yearmo_num]"
Begin
    Begin
        dbText "Name" ="comm_ess_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FSC_nm"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ESS_nm"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_nm"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1800"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fiscal_end_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fiscal_begin_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="branch_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1343
    Bottom =797
    Left =-1
    Top =-1
    Right =1327
    Bottom =539
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =374
        Bottom =280
        Top =0
        Name ="comm_ess_statement_detail"
        Name =""
    End
    Begin
        Left =435
        Top =32
        Right =678
        Bottom =245
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =533
        Top =285
        Right =876
        Bottom =492
        Top =0
        Name ="comm_salesperson_master_1"
        Name =""
    End
    Begin
        Left =996
        Top =226
        Right =1140
        Bottom =370
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
