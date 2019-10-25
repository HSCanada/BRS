Operation =1
Option =0
Begin InputTables
    Name ="comm_salesperson_master_stage"
End
Begin OutputColumns
    Expression ="comm_salesperson_master_stage.fiscal_yearmo_num"
    Expression ="comm_salesperson_master_stage.employee_num"
    Expression ="comm_salesperson_master_stage.cost_centre_cd"
    Expression ="comm_salesperson_master_stage.salesperson_nm"
    Expression ="comm_salesperson_master_stage.master_salesperson_cd"
    Expression ="comm_salesperson_master_stage.territory_start_dt"
    Expression ="comm_salesperson_master_stage.comm_plan_id"
    Expression ="comm_salesperson_master_stage.SALD30_amt"
    Expression ="comm_salesperson_master_stage.STMPBA_amt"
    Alias ="email_ind"
    Expression ="comm_salesperson_master_stage.note_txt"
    Expression ="comm_salesperson_master_stage.salesperson_key_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbText "Description" ="Load FSC data"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE23_Salesperson_Load].[salesperson_key_id]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master_stage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.employee_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.cost_centre_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.SALD30_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.STMPBA_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="email_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1549
    Bottom =1004
    Left =-1
    Top =-1
    Right =1517
    Bottom =322
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =262
        Top =28
        Right =691
        Bottom =300
        Top =0
        Name ="comm_salesperson_master_stage"
        Name =""
    End
End
