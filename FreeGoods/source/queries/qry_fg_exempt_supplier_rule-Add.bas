Operation =3
Name ="fg_exempt_supplier_rule"
Option =0
Begin InputTables
    Name ="STAGE_fg_exempt_supplier_rule"
    Name ="STAGE_fg_exempt_supplier_rule-Template"
End
Begin OutputColumns
    Name ="ChargebackContractNumber"
    Expression ="STAGE_fg_exempt_supplier_rule.ChargebackContractNumber"
    Name ="Supplier"
    Expression ="STAGE_fg_exempt_supplier_rule.Supplier"
    Name ="VPA"
    Expression ="STAGE_fg_exempt_supplier_rule.VPA"
    Name ="fg_exempt_cd_target"
    Expression ="[STAGE_fg_exempt_supplier_rule-Template].fg_exempt_cd_target"
    Name ="rule_name_txt"
    Expression ="[STAGE_fg_exempt_supplier_rule-Template].rule_name_txt"
    Name ="active_ind"
    Expression ="[STAGE_fg_exempt_supplier_rule-Template].active_ind"
    Name ="sequence_num"
    Expression ="[STAGE_fg_exempt_supplier_rule-Template].sequence_num"
    Name ="signoff_note_txt"
    Expression ="[STAGE_fg_exempt_supplier_rule-Template].signoff_note_txt"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
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
        dbText "Name" ="fg_exempt_supplier_rule.fg_exempt_cd_target"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.sequence_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.exempt_supplier_rule_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.creation_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.ChargebackContractNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_fg_exempt_supplier_rule-Template].fg_exempt_cd_target"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_fg_exempt_supplier_rule-Template].rule_name_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_exempt_supplier_rule.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_fg_exempt_supplier_rule-Template].active_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_fg_exempt_supplier_rule-Template].sequence_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[STAGE_fg_exempt_supplier_rule-Template].signoff_note_txt"
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
    ColumnsShown =651
    Begin
        Left =93
        Top =64
        Right =237
        Bottom =208
        Top =0
        Name ="STAGE_fg_exempt_supplier_rule"
        Name =""
    End
    Begin
        Left =429
        Top =117
        Right =729
        Bottom =446
        Top =0
        Name ="STAGE_fg_exempt_supplier_rule-Template"
        Name =""
    End
End
