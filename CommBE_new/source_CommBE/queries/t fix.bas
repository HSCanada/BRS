Operation =1
Option =0
Where ="(((comm_item_group_rule.Supplier)=\"3SHAPE\") AND ((comm_item_group_rule_1.Suppl"
    "ier)=\"3SHAAS\") AND ((comm_item_group_rule_1.comm_group_cd)=\"\")) OR (((comm_i"
    "tem_group_rule.Supplier)=\"HSONEC\") AND ((comm_item_group_rule_1.Supplier)=\"HS"
    "ONEU\") AND ((comm_item_group_rule_1.comm_group_cd)=\"\")) OR (((comm_item_group"
    "_rule.Supplier)=\"SHAPEM\") AND ((comm_item_group_rule_1.Supplier)=\"SHAPMD\") A"
    "ND ((comm_item_group_rule_1.comm_group_cd)=\"\")) OR (((comm_item_group_rule.Sup"
    "plier)=\"SHAPES\") AND ((comm_item_group_rule_1.Supplier)=\"SHAPUS\") AND ((comm"
    "_item_group_rule_1.comm_group_cd)=\"\"))"
Begin InputTables
    Name ="comm_item_group_rule"
    Name ="comm_item_group_rule"
    Alias ="comm_item_group_rule_1"
End
Begin OutputColumns
    Expression ="comm_item_group_rule.id"
    Expression ="comm_item_group_rule.MinorProductClass"
    Expression ="comm_item_group_rule.Supplier"
    Expression ="comm_item_group_rule_1.Supplier"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="comm_item_group_rule_1.comm_group_cd"
    Expression ="comm_item_group_rule.comm_note_txt"
    Expression ="comm_item_group_rule_1.comm_note_txt"
End
Begin Joins
    LeftTable ="comm_item_group_rule"
    RightTable ="comm_item_group_rule_1"
    Expression ="comm_item_group_rule.MinorProductClass = comm_item_group_rule_1.MinorProductClas"
        "s"
    Flag =1
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
        dbText "Name" ="BRS_ItemHistory.HIST_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.Supplier"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.confidence_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfItem"
        dbInteger "ColumnWidth" ="1635"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule_1.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule_1.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule_1.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1631
    Bottom =938
    Left =-1
    Top =-1
    Right =1607
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =75
        Top =39
        Right =468
        Bottom =372
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
    Begin
        Left =577
        Top =50
        Right =721
        Bottom =194
        Top =0
        Name ="comm_item_group_rule_1"
        Name =""
    End
End
