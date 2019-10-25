Operation =1
Option =0
Where ="(((comm_salesperson_master.salesperson_key_id)=\"\"))"
Begin InputTables
    Name ="comm_salesperson_master_stage"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master_stage.*"
    Expression ="comm_salesperson_master_stage.*"
    Expression ="comm_salesperson_master_stage.salesperson_nm"
    Expression ="comm_salesperson_master_stage.salesperson_key_id"
    Alias ="FIX_master_salesperson_cd"
    Expression ="comm_salesperson_master_stage.master_salesperson_cd"
    Expression ="comm_salesperson_master_stage.comm_plan_id"
    Expression ="comm_salesperson_master.salesperson_key_id"
End
Begin Joins
    LeftTable ="comm_salesperson_master_stage"
    RightTable ="comm_salesperson_master"
    Expression ="comm_salesperson_master_stage.salesperson_key_id = comm_salesperson_master.sales"
        "person_key_id"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="New or missing FSC data?"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5130"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5835"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5175"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FIX_master_salesperson_cd"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.fsc_comm_merch_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.SALD30_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.exception_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.fsc_comm_teeth_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.STMPBA_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.record_exists"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.cost_centre_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.employee_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1410
    Bottom =960
    Left =-1
    Top =-1
    Right =1378
    Bottom =216
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =16
        Top =13
        Right =445
        Bottom =285
        Top =0
        Name ="comm_salesperson_master_stage"
        Name =""
    End
    Begin
        Left =525
        Top =13
        Right =876
        Bottom =300
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
