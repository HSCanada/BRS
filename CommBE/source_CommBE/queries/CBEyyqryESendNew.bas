Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"ess*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"ESSP00\") AND ((comm_salesperson_master.esend_setup_ind)=0)"
    ") OR (((comm_salesperson_master.comm_plan_id) Like \"fsc*\" And (comm_salesperso"
    "n_master.comm_plan_id)<>\"FSCDP00\") AND ((comm_salesperson_master.esend_setup_i"
    "nd)=0))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.GETKBY03"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.email_address_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.territory_start_dt"
    Expression ="comm_salesperson_master.hsi_salesperson_cd"
    Expression ="comm_salesperson_master.esend_setup_ind"
End
Begin OrderBy
    Expression ="comm_salesperson_master.comm_plan_id"
    Flag =0
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
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2730"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.esend_setup_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.GETKBY03"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.email_address_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4440"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.hsi_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1571
    Bottom =1004
    Left =-1
    Top =-1
    Right =1548
    Bottom =662
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =652
        Bottom =422
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
