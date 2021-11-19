Operation =4
Option =0
Begin InputTables
    Name ="STAGE_fg_exempt_supplier_rule"
    Name ="fg_exempt_supplier_rule"
End
Begin OutputColumns
    Name ="fg_exempt_supplier_rule.active_ind"
    Expression ="1"
    Name ="fg_exempt_supplier_rule.signoff_note_txt"
    Expression ="\"KD20211116\""
End
Begin Joins
    LeftTable ="STAGE_fg_exempt_supplier_rule"
    RightTable ="fg_exempt_supplier_rule"
    Expression ="STAGE_fg_exempt_supplier_rule.ChargebackContractNumber = fg_exempt_supplier_rule"
        ".ChargebackContractNumber"
    Flag =1
    LeftTable ="STAGE_fg_exempt_supplier_rule"
    RightTable ="fg_exempt_supplier_rule"
    Expression ="STAGE_fg_exempt_supplier_rule.Supplier = fg_exempt_supplier_rule.Supplier"
    Flag =1
    LeftTable ="STAGE_fg_exempt_supplier_rule"
    RightTable ="fg_exempt_supplier_rule"
    Expression ="STAGE_fg_exempt_supplier_rule.VPA = fg_exempt_supplier_rule.VPA"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.signoff_note_txt"
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
        dbText "Name" ="STAGE_fg_exempt_supplier_rule.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_fg_exempt_supplier_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_fg_exempt_supplier_rule.ChargebackContractNumber"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1316
    Bottom =918
    Left =-1
    Top =-1
    Right =1300
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =77
        Top =70
        Right =221
        Bottom =214
        Top =0
        Name ="STAGE_fg_exempt_supplier_rule"
        Name =""
    End
    Begin
        Left =306
        Top =100
        Right =720
        Bottom =415
        Top =0
        Name ="fg_exempt_supplier_rule"
        Name =""
    End
End
