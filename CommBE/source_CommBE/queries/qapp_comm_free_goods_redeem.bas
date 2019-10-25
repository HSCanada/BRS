Operation =3
Name ="comm_free_goods_redeem"
Option =0
Having ="(((comm_customer_free_goods_YTD.fiscal_yearmo_num) Between \"201901\" And \"2019"
    "12\"))"
Begin InputTables
    Name ="comm_customer_free_goods_YTD"
End
Begin OutputColumns
    Name ="CalMonth"
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Name ="SalesOrderNumber"
    Expression ="comm_customer_free_goods_YTD.doc_id"
    Alias ="DocType"
    Name ="DocType"
    Expression ="\"AA\""
    Name ="Item"
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Name ="SourceCode"
    Expression ="comm_customer_free_goods_YTD.Source"
    Alias ="MinOfhsi_shipto_id"
    Name ="ShipTo"
    Expression ="Min(comm_customer_free_goods_YTD.hsi_shipto_id)"
    Alias ="MinOfhsi_shipto_nm"
    Name ="PracticeName"
    Expression ="Min(comm_customer_free_goods_YTD.hsi_shipto_nm)"
    Alias ="MinOfitem_descr"
    Name ="ItemDescription"
    Expression ="Min(comm_customer_free_goods_YTD.item_descr)"
    Alias ="MinOfIMSUPL"
    Name ="Supplier"
    Expression ="Min(comm_customer_free_goods_YTD.IMSUPL)"
    Alias ="SumOffree_goods_CDN_ext_cost"
    Name ="ExtFileCostCadAmt"
    Expression ="Sum(comm_customer_free_goods_YTD.free_goods_CDN_ext_cost)"
    Alias ="MinOfsalesperson_cd"
    Name ="salesperson_cd"
    Expression ="Min(comm_customer_free_goods_YTD.salesperson_cd)"
    Alias ="MinOfsalesperson_ess_cd"
    Name ="salesperson_ess_cd"
    Expression ="Min(comm_customer_free_goods_YTD.salesperson_ess_cd)"
    Alias ="MinOfcomm_group_cd"
    Name ="comm_group_cd"
    Expression ="Min(comm_customer_free_goods_YTD.comm_group_cd)"
    Alias ="MinOfSM_comm_group_cd"
    Name ="fsc_comm_group_cd"
    Expression ="Min(comm_customer_free_goods_YTD.SM_comm_group_cd)"
    Alias ="Expr1"
    Name ="special_market_ind"
    Expression ="Min(IIf([CUST_SPM_StatusCd]=\"Y\",1,0))"
    Alias ="Expr2"
    Name ="equipment_opt_out_ind"
    Expression ="Min(IIf([CUST_SPM_EQOptOut]=\"Y\",1,0))"
    Alias ="Expr3"
    Name ="group_equipment_opt_out_ind"
    Expression ="Min(IIf([GRP_SPM_EQOptOut]=\"Y\",1,0))"
    Alias ="MinOfID"
    Name ="ID_legacy"
    Expression ="Min(comm_customer_free_goods_YTD.ID)"
End
Begin Groups
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_customer_free_goods_YTD.doc_id"
    GroupLevel =0
    Expression ="\"AA\""
    GroupLevel =0
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    GroupLevel =0
    Expression ="comm_customer_free_goods_YTD.Source"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DocType"
    End
    Begin
        dbText "Name" ="MinOfhsi_shipto_id"
    End
    Begin
        dbText "Name" ="MinOfhsi_shipto_nm"
    End
    Begin
        dbText "Name" ="MinOfitem_descr"
    End
    Begin
        dbText "Name" ="MinOfIMSUPL"
    End
    Begin
        dbText "Name" ="SumOffree_goods_CDN_ext_cost"
    End
    Begin
        dbText "Name" ="MinOfsalesperson_cd"
    End
    Begin
        dbText "Name" ="MinOfsalesperson_ess_cd"
    End
    Begin
        dbText "Name" ="MinOfcomm_group_cd"
    End
    Begin
        dbText "Name" ="MinOfSM_comm_group_cd"
    End
    Begin
        dbText "Name" ="Expr1"
    End
    Begin
        dbText "Name" ="Expr2"
    End
    Begin
        dbText "Name" ="Expr3"
    End
    Begin
        dbText "Name" ="MinOfID"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1482
    Bottom =853
    Left =-1
    Top =-1
    Right =1458
    Bottom =517
    Left =0
    Top =0
    ColumnsShown =655
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
End
