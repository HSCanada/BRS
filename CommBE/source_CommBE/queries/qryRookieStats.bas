Operation =1
Option =0
Where ="(((comm_salesperson_master.salesperson_key_id) In (\"BLAIR.HOKANSON\",\"BLAKE.GO"
    "ODALL\",\"BRENDAN.DU.VALL\",\"Elena.Lamont\",\"ERICA.PICARD\",\"JAMIE.MCMURDO\","
    "\"MICHELE.SEGUIN\",\"PAIGE.OGRODNICK\",\"ROBERT.PIERCY\",\"SHANNON.AARTS\")))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Alias ="salesperson_nm"
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Expression ="comm_salesperson_master.territory_start_dt"
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
    GroupLevel =0
    Expression ="comm_salesperson_master.territory_start_dt"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryRookieStats].[salesperson_nm]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_nm"
        dbInteger "ColumnWidth" ="2730"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.territory_start_dt"
        dbInteger "ColumnWidth" ="2010"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1499
    Bottom =1004
    Left =-1
    Top =-1
    Right =1476
    Bottom =473
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =384
        Top =12
        Right =984
        Bottom =538
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
