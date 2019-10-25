Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201001\") AND ((comm_transaction.sourc"
    "e_cd)=\"JDE\") AND ((comm_transaction.salesperson_key_id)<>\"Internal\") AND ((c"
    "omm_transaction.IMCLMJ) In (\"011\",\"023\",\"345\")))"
Having ="(((comm_transaction.item_comm_group_cd) In (\"ITMFO1\",\"ITMFO2\",\"ITMFO3\")))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_transaction.item_comm_group_cd"
    Alias ="total_sales_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="total_gp_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
    GroupLevel =0
    Expression ="comm_transaction.item_comm_group_cd"
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
Begin
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_sales_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_gp_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1559
    Bottom =1004
    Left =-1
    Top =-1
    Right =1536
    Bottom =646
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =43
        Top =101
        Right =600
        Bottom =435
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =648
        Top =12
        Right =1028
        Bottom =370
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
