Operation =1
Option =0
Where ="(((comm_item_group_rule.MinorProductClass) Like \"341*\"))"
Begin InputTables
    Name ="comm_item_group_rule"
End
Begin OutputColumns
    Expression ="comm_item_group_rule.MinorProductClass"
    Expression ="comm_item_group_rule.Supplier"
    Alias ="sub_minor"
    Expression ="Left([MinorProductClass],6)"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="comm_item_group_rule.comm_note_txt"
    Expression ="comm_item_group_rule.id"
    Expression ="comm_item_group_rule.confidence_rt"
End
Begin OrderBy
    Expression ="comm_item_group_rule.MinorProductClass"
    Flag =0
    Expression ="comm_item_group_rule.Supplier"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[CMB01_comm_sync_fix_rules].[MinorProductClass]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_item_group_rule.confidence_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="sub_minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1533
    Bottom =937
    Left =-1
    Top =-1
    Right =1116
    Bottom =600
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =103
        Top =42
        Right =487
        Bottom =287
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
End
