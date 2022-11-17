Operation =1
Option =0
Where ="(((fg_exempt_supplier_rule.active_ind)=True))"
Begin InputTables
    Name ="fg_exempt_supplier_rule"
End
Begin OutputColumns
    Expression ="fg_exempt_supplier_rule.ChargebackContractNumber"
    Expression ="fg_exempt_supplier_rule.Supplier"
    Expression ="fg_exempt_supplier_rule.VPA"
    Expression ="fg_exempt_supplier_rule.fg_exempt_cd_target"
    Expression ="fg_exempt_supplier_rule.rule_name_txt"
    Expression ="fg_exempt_supplier_rule.active_ind"
    Expression ="fg_exempt_supplier_rule.sequence_num"
    Expression ="fg_exempt_supplier_rule.signoff_note_txt"
    Expression ="fg_exempt_supplier_rule.creation_dt"
    Expression ="fg_exempt_supplier_rule.exempt_supplier_rule_key"
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
        dbText "Name" ="fg_exempt_supplier_rule.creation_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.exempt_supplier_rule_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.ChargebackContractNumber"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.fg_exempt_cd_target"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.active_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.rule_name_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.sequence_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.signoff_note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1448
    Bottom =918
    Left =-1
    Top =-1
    Right =1432
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =62
        Top =76
        Right =541
        Bottom =448
        Top =0
        Name ="fg_exempt_supplier_rule"
        Name =""
    End
End
