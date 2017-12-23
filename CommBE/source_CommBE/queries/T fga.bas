Operation =3
Name ="STAGE_BRS_FreeGoodsRedeem"
Option =0
Where ="(((comm_customer_free_goods_YTD.Source)=\"ACT\"))"
Begin InputTables
    Name ="comm_customer_free_goods_YTD"
End
Begin OutputColumns
    Name ="FiscalMonth"
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Name ="Item"
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Name ="SalesOrderNumber"
    Expression ="comm_customer_free_goods_YTD.doc_id"
    Name ="ShipTo"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id"
    Name ="Supplier"
    Expression ="comm_customer_free_goods_YTD.IMSUPL"
    Name ="ExtFileCostAmt"
    Expression ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
End
Begin OrderBy
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Flag =0
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Flag =0
    Expression ="comm_customer_free_goods_YTD.doc_id"
    Flag =0
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
        dbText "Format" ="Fixed"
        dbByte "DecimalPlaces" ="8"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.OrderSourceCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =16
    Top =18
    Right =1547
    Bottom =969
    Left =-1
    Top =-1
    Right =1499
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =163
        Top =39
        Right =755
        Bottom =285
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
End
