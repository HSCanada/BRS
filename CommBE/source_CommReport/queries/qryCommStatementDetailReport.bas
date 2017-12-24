Operation =1
Option =0
Where ="((([comm_backend_detail_fsc].salesperson_key_id)=GetCurrentFSC()) And (([comm_ba"
    "ckend_detail_fsc].source_cd) In (\"JDE\",\"import\")) And (([comm_backend_detail"
    "_fsc].item_comm_group_cd)<>\"SFFFIN\"))"
Begin InputTables
    Name ="comm_backend_detail_fsc"
End
Begin OutputColumns
    Expression ="[comm_backend_detail_fsc].record_id"
    Expression ="[comm_backend_detail_fsc].salesperson_key_id"
    Expression ="[comm_backend_detail_fsc].source_cd"
    Expression ="[comm_backend_detail_fsc].salesperson_nm"
    Expression ="[comm_backend_detail_fsc].salesperson_cd"
    Expression ="[comm_backend_detail_fsc].comm_plan_id"
    Expression ="[comm_backend_detail_fsc].comm_plan_nm"
    Expression ="[comm_backend_detail_fsc].fiscal_yearmo_num"
    Expression ="[comm_backend_detail_fsc].fiscal_begin_dt"
    Expression ="[comm_backend_detail_fsc].fiscal_end_dt"
    Expression ="[comm_backend_detail_fsc].comm_group_desc"
    Expression ="[comm_backend_detail_fsc].doc_key_id"
    Expression ="[comm_backend_detail_fsc].line_id"
    Expression ="[comm_backend_detail_fsc].doc_id"
    Expression ="[comm_backend_detail_fsc].order_id"
    Expression ="[comm_backend_detail_fsc].transaction_dt"
    Expression ="[comm_backend_detail_fsc].hsi_shipto_id"
    Expression ="[comm_backend_detail_fsc].customer_nm"
    Expression ="[comm_backend_detail_fsc].item_id"
    Expression ="[comm_backend_detail_fsc].transaction_txt"
    Expression ="[comm_backend_detail_fsc].item_comm_group_cd"
    Expression ="[comm_backend_detail_fsc].item_comm_rt"
    Expression ="[comm_backend_detail_fsc].transaction_amt"
    Expression ="[comm_backend_detail_fsc].comm_amt"
    Expression ="[comm_backend_detail_fsc].gp_ext_amt"
    Expression ="[comm_backend_detail_fsc].manufact_cd"
    Expression ="[comm_backend_detail_fsc].order_source_cd"
    Expression ="[comm_backend_detail_fsc].item_label_cd"
    Expression ="[comm_backend_detail_fsc].IMCLMJ"
    Expression ="[comm_backend_detail_fsc].shipped_qty"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbText "Description" ="x"
Begin
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
    Bottom =314
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =578
        Bottom =387
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
