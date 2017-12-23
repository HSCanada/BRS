Operation =1
Option =0
Where ="(((comm_summary.comm_group_cd) In (\"ITMSND\",\"CUSINS\")))"
Begin InputTables
    Name ="comm_summary"
End
Begin OutputColumns
    Expression ="comm_summary.salesperson_key_id"
    Alias ="merch_amt"
    Expression ="Sum(comm_summary.sales_curr_amt)"
End
Begin Groups
    Expression ="comm_summary.salesperson_key_id"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
Begin
    Begin
        dbText "Name" ="comm_summary.salesperson_key_id"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="merch_amt"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1280
    Bottom =880
    Left =-1
    Top =-1
    Right =1277
    Bottom =144
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =38
        Top =6
        Right =274
        Bottom =113
        Top =0
        Name ="comm_summary"
        Name =""
    End
End
