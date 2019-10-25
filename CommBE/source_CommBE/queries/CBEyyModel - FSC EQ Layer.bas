Operation =1
Option =0
Where ="(((comm_transaction.manufact_cd)=\"BIOLAS\") AND ((comm_transaction.item_comm_gr"
    "oup_cd) In (\"ITMFO1\",\"ITMFO2\",\"ITMFO3\")) AND ((comm_transaction.source_cd)"
    "=\"JDE\") AND ((comm_transaction.salesperson_key_id)<>\"Internal\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
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
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
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
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_sales_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1965"
        dbBoolean "ColumnHidden" ="0"
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
    Right =1584
    Bottom =1004
    Left =-1
    Top =-1
    Right =1561
    Bottom =582
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =43
        Top =13
        Right =187
        Bottom =157
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =273
        Top =34
        Right =830
        Bottom =368
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =938
        Top =16
        Right =1318
        Bottom =374
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
