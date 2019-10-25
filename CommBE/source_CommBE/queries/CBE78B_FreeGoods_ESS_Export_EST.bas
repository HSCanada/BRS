Operation =1
Option =0
Where ="(((comm_free_goods_redeem.SourceCode)=\"EST\"))"
Having ="(((comm_free_goods_redeem.CalMonth)=201908) AND ((comm_free_goods_redeem.comm_gr"
    "oup_cd)<>\"ITMSND\") AND ((comm_free_goods_redeem.salesperson_ess_cd)<>\"\"))"
Begin InputTables
    Name ="comm_free_goods_redeem"
End
Begin OutputColumns
    Alias ="fiscal_yearmo_num"
    Expression ="comm_free_goods_redeem.CalMonth"
    Expression ="comm_free_goods_redeem.comm_group_cd"
    Expression ="comm_free_goods_redeem.salesperson_ess_cd"
    Alias ="vend"
    Expression ="\"FREEGD\""
    Alias ="chqno"
    Expression ="\"NA\""
    Alias ="line_no"
    Expression ="0"
    Alias ="trans_dt"
    Expression ="Now()"
    Alias ="details"
    Expression ="\"FREE GOODS-ESS-EST\""
    Alias ="trans_amt"
    Expression ="0"
    Alias ="GP"
    Expression ="Sum(comm_free_goods_redeem.ExtFileCostCadAmt)"
    Alias ="comm_amt"
    Expression ="0"
End
Begin Groups
    Expression ="comm_free_goods_redeem.CalMonth"
    GroupLevel =0
    Expression ="comm_free_goods_redeem.comm_group_cd"
    GroupLevel =0
    Expression ="comm_free_goods_redeem.salesperson_ess_cd"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="vend"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="chqno"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="line_no"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="trans_dt"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Medium Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="details"
        dbInteger "ColumnWidth" ="2190"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="trans_amt"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GP"
        dbInteger "ColumnWidth" ="3765"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfspecial_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfgroup_equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_grp"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.special_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.group_equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =817
    Left =-1
    Top =-1
    Right =1421
    Bottom =381
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =207
        Top =25
        Right =486
        Bottom =258
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
End
