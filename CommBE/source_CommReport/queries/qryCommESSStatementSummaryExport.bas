Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.branch)=GetCurrentBranch()) And (([comm_backend_detail_ess].fs"
    "c_salesperson_key_id)<>\"internal\"))"
Begin InputTables
    Name ="comm_backend_detail_ess"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master"
    Alias ="comm_salesperson_master_1"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="[comm_backend_detail_ess].fiscal_yearmo_num"
    Alias ="branch_cd"
    Expression ="First(BRS_FSC_Rollup.Branch)"
    Alias ="fiscal_begin_dt"
    Expression ="First([comm_backend_detail_ess].fiscal_begin_dt)"
    Alias ="fiscal_end_dt"
    Expression ="First([comm_backend_detail_ess].fiscal_end_dt)"
    Alias ="ESS_nm"
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Alias ="customer_nm"
    Expression ="First([comm_backend_detail_ess].customer_nm)"
    Alias ="hsi_shipto_id"
    Expression ="First([comm_backend_detail_ess].hsi_shipto_id)"
    Alias ="transaction_dt"
    Expression ="First([comm_backend_detail_ess].transaction_dt)"
    Expression ="[comm_backend_detail_ess].doc_id"
    Alias ="FSC_nm"
    Expression ="First(comm_salesperson_master_1.salesperson_nm)"
    Alias ="transaction_amt"
    Expression ="Sum([comm_backend_detail_ess].transaction_amt)"
    Alias ="gp_ext_amt"
    Expression ="Sum([comm_backend_detail_ess].gp_ext_amt)"
    Alias ="comm_amt"
    Expression ="Sum([comm_backend_detail_ess].comm_amt)"
End
Begin Joins
    LeftTable ="comm_backend_detail_ess"
    RightTable ="comm_salesperson_master"
    Expression ="[comm_backend_detail_ess].salesperson_key_id=comm_salesperson_master.salesperson"
        "_key_id"
    Flag =1
    LeftTable ="comm_backend_detail_ess"
    RightTable ="comm_salesperson_master_1"
    Expression ="[comm_backend_detail_ess].fsc_salesperson_key_id=comm_salesperson_master_1.sales"
        "person_key_id"
    Flag =1
    LeftTable ="comm_salesperson_master_1"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_salesperson_master_1.master_salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
End
Begin OrderBy
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Flag =0
    Expression ="First([comm_backend_detail_ess].customer_nm)"
    Flag =0
    Expression ="First([comm_backend_detail_ess].transaction_dt)"
    Flag =0
End
Begin Groups
    Expression ="[comm_backend_detail_ess].fiscal_yearmo_num"
    GroupLevel =0
    Expression ="[comm_backend_detail_ess].doc_id"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbText "Description" ="x"
Begin
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
    Right =1560
    Bottom =956
    Left =-1
    Top =-1
    Right =1544
    Bottom =474
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
        Left =548
        Top =263
        Right =891
        Bottom =470
        Top =0
        Name ="comm_salesperson_master_1"
        Name =""
    End
    Begin
        Left =975
        Top =256
        Right =1119
        Bottom =400
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
