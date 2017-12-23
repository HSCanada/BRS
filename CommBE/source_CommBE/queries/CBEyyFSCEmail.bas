Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"fsc*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"FSCDP00\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.GETKBY03"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.email_address_nm"
    Expression ="comm_salesperson_master.esend_setup_ind"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBEyyFSCEmail].[esend_setup_ind]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3495"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.email_address_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3810"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.esend_setup_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.GETKBY03"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1592
    Bottom =1008
    Left =-1
    Top =-1
    Right =1573
    Bottom =203
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =447
        Top =23
        Right =796
        Bottom =210
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
