Operation =1
Option =0
Begin InputTables
    Name ="comm_item_group_rule"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Expression ="comm_item_group_rule.MinorProductClass"
    Expression ="comm_item_group_rule.Supplier"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="comm_item_group_rule.comm_note_txt"
    Expression ="comm_item_group_rule.id"
    Expression ="comm_item_group_rule.confidence_rt"
    Expression ="BRS_ItemCategory.CategoryRollup"
End
Begin Joins
    LeftTable ="comm_item_group_rule"
    RightTable ="BRS_ItemCategory"
    Expression ="comm_item_group_rule.MinorProductClass = BRS_ItemCategory.MinorProductClass"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[qryEQRuleSet].[comm_group_cd]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_item_group_rule.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.confidence_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_group_rule2.SubMajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_group_rule2.comm_group_cd_new"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_group_rule2.comm_note_txt_new"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_group_rule2.confidence_rt_new"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1625
    Bottom =946
    Left =-1
    Top =-1
    Right =717
    Bottom =512
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =82
        Top =47
        Right =390
        Bottom =343
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
    Begin
        Left =499
        Top =84
        Right =799
        Bottom =345
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
