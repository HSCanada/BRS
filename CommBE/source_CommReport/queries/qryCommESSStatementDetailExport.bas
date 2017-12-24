Operation =1
Option =0
Where ="(((comm_backend_detail_ess.salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_backend_detail_ess"
End
Begin OutputColumns
    Expression ="comm_backend_detail_ess.fiscal_yearmo_num"
    Expression ="comm_backend_detail_ess.salesperson_key_id"
    Expression ="comm_backend_detail_ess.salesperson_nm"
    Expression ="comm_backend_detail_ess.salesperson_cd"
    Expression ="comm_backend_detail_ess.hsi_shipto_id"
    Expression ="comm_backend_detail_ess.customer_nm"
    Expression ="comm_backend_detail_ess.transaction_dt"
    Expression ="comm_backend_detail_ess.doc_key_id"
    Expression ="comm_backend_detail_ess.item_id"
    Expression ="comm_backend_detail_ess.transaction_txt"
    Expression ="comm_backend_detail_ess.item_comm_group_cd"
    Expression ="comm_backend_detail_ess.transaction_amt"
    Expression ="comm_backend_detail_ess.gp_ext_amt"
    Expression ="comm_backend_detail_ess.shipped_qty"
    Expression ="comm_backend_detail_ess.IMCLMJ"
    Expression ="comm_backend_detail_ess.item_label_cd"
    Expression ="comm_backend_detail_ess.manufact_cd"
    Expression ="comm_backend_detail_ess.comm_amt"
    Expression ="comm_backend_detail_ess.fsc_salesperson_key_id"
    Expression ="comm_backend_detail_ess.SPM_StatusCd"
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
Begin
    Begin
        dbText "Name" ="comm_backend_detail_ess.fiscal_yearmo_num"
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
    Bottom =207
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_backend_detail_ess"
        Name =""
    End
End
