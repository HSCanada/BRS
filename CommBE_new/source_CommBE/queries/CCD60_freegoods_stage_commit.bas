Operation =3
Name ="CCB60_freegoods_stage_load"
Option =0
Where ="(((CCD60_freegoods_stage_load.CalMonth)=202010))"
Begin InputTables
    Name ="CCD60_freegoods_stage_load"
End
Begin OutputColumns
    Name ="FiscalMonth"
    Expression ="CCD60_freegoods_stage_load.CalMonth"
    Name ="SalesOrderNumber"
    Expression ="CCD60_freegoods_stage_load.SalesOrderNumber"
    Name ="original_line_number"
    Expression ="CCD60_freegoods_stage_load.ID"
    Name ="ShipTo"
    Expression ="CCD60_freegoods_stage_load.ShipTo"
    Name ="PracticeName"
    Expression ="CCD60_freegoods_stage_load.PracticeName"
    Name ="Item"
    Expression ="CCD60_freegoods_stage_load.Item"
    Name ="ItemDescription"
    Expression ="CCD60_freegoods_stage_load.ItemDescription"
    Name ="Supplier"
    Expression ="CCD60_freegoods_stage_load.Supplier"
    Name ="ExtFileCostCadAmt"
    Expression ="CCD60_freegoods_stage_load.ExtFileCostCadAmt"
    Name ="SourceCode"
    Expression ="CCD60_freegoods_stage_load.SourceCode"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="CCD60_freegoods_stage_load.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CCD60_freegoods_stage_load.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CCD60_freegoods_stage_load.SourceCode"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1391
    Bottom =937
    Left =-1
    Top =-1
    Right =1367
    Bottom =600
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =82
        Top =61
        Right =350
        Bottom =341
        Top =0
        Name ="CCD60_freegoods_stage_load"
        Name =""
    End
End
