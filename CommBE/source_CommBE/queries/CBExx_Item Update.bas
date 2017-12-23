Operation =4
Option =0
Begin InputTables
    Name ="comm_item_master"
    Name ="STAGE_NPFIMS01"
End
Begin OutputColumns
    Name ="comm_item_master.item_master_desc"
    Expression ="[STAGE_NPFIMS01]![IMDESC]"
    Name ="comm_item_master.hsi_manuf_cd"
    Expression ="[STAGE_NPFIMS01]![IMSUPL]"
    Name ="comm_item_master.vendor_item_num"
    Expression ="[STAGE_NPFIMS01]![IMVITM]"
    Name ="comm_item_master.supplier_cost_amt"
    Expression ="[STAGE_NPFIMS01]![IMACST]"
    Name ="comm_item_master.hsi_class_major_cd"
    Expression ="[STAGE_NPFIMS01]![IMCLMJ]"
    Name ="comm_item_master.hsi_class_submajor_cd"
    Expression ="[STAGE_NPFIMS01]![IMCLSJ]"
    Name ="comm_item_master.hsi_class_minor_cd"
    Expression ="[STAGE_NPFIMS01]![IMCLMC]"
    Name ="comm_item_master.hsi_class_subminor_cd"
    Expression ="[STAGE_NPFIMS01]![IMCLSM]"
    Name ="comm_item_master.MinorCd"
    Expression ="[STAGE_NPFIMS01]![MinorCd]"
    Name ="comm_item_master.IMAVLC"
    Expression ="[STAGE_NPFIMS01]![IMAVLC]"
    Name ="comm_item_master.IMSIZE"
    Expression ="[STAGE_NPFIMS01]![IMSIZE]"
    Name ="comm_item_master.IMSTRN"
    Expression ="[STAGE_NPFIMS01]![IMSTRN]"
    Name ="comm_item_master.IMVEND"
    Expression ="[STAGE_NPFIMS01]![IMVEND]"
    Name ="comm_item_master.IMPUCD"
    Expression ="[STAGE_NPFIMS01]![IMPUCD]"
End
Begin Joins
    LeftTable ="comm_item_master"
    RightTable ="STAGE_NPFIMS01"
    Expression ="comm_item_master.item_id=STAGE_NPFIMS01.IMITEM"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="comm_item_master.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_manuf_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.vendor_item_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.MinorCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMDESC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMVITM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMACST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMCLSJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.MinorCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMAVLC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMVEND"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMPUCD"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMSIZE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMSTRN"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMCLMC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMCLSM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_NPFIMS01.IMPCL1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.IMSIZE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.IMSTRN"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.IMVEND"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.IMPUCD"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_class_major_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_class_submajor_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_class_minor_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_class_subminor_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.IMAVLC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.supplier_cost_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1584
    Bottom =1004
    Left =-1
    Top =-1
    Right =1561
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =658
        Top =19
        Right =1134
        Bottom =414
        Top =0
        Name ="STAGE_NPFIMS01"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =569
        Bottom =474
        Top =0
        Name ="comm_item_master"
        Name =""
    End
End
