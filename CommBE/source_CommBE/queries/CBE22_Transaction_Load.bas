Operation =3
Name ="comm_transaction_stage"
Option =0
Begin InputTables
    Name ="qsubCommTransactionHsiStage"
End
Begin OutputColumns
    Name ="fiscal_yearmo_num"
    Expression ="qsubCommTransactionHsiStage.fiscal_yearmo_num"
    Name ="salesperson_cd"
    Expression ="qsubCommTransactionHsiStage.salesperson_cd"
    Name ="source_cd"
    Expression ="qsubCommTransactionHsiStage.source_cd"
    Name ="transaction_dt"
    Expression ="qsubCommTransactionHsiStage.transaction_dt"
    Name ="transaction_amt"
    Expression ="qsubCommTransactionHsiStage.transaction_amt"
    Name ="doc_key_id"
    Expression ="qsubCommTransactionHsiStage.doc_key_id"
    Name ="line_id"
    Expression ="qsubCommTransactionHsiStage.line_id"
    Name ="doc_id"
    Expression ="qsubCommTransactionHsiStage.doc_id"
    Name ="order_id"
    Expression ="qsubCommTransactionHsiStage.order_id"
    Name ="reference_order_txt"
    Expression ="qsubCommTransactionHsiStage.reference_order_txt"
    Name ="order_source_cd"
    Expression ="qsubCommTransactionHsiStage.order_source_cd"
    Name ="customer_nm"
    Expression ="qsubCommTransactionHsiStage.customer_nm"
    Name ="item_id"
    Expression ="qsubCommTransactionHsiStage.item_id"
    Name ="shipped_qty"
    Expression ="qsubCommTransactionHsiStage.shipped_qty"
    Name ="price_override_ind"
    Expression ="qsubCommTransactionHsiStage.price_override_ind"
    Name ="transaction_txt"
    Expression ="qsubCommTransactionHsiStage.transaction_txt"
    Name ="unit_price_cd"
    Expression ="qsubCommTransactionHsiStage.unit_price_cd"
    Name ="comm_amt"
    Expression ="qsubCommTransactionHsiStage.comm_amt"
    Name ="cost_unit_amt"
    Expression ="qsubCommTransactionHsiStage.cost_unit_amt"
    Name ="item_label_cd"
    Expression ="qsubCommTransactionHsiStage.item_label_cd"
    Name ="cost_ext_amt"
    Expression ="qsubCommTransactionHsiStage.cost_ext_amt"
    Name ="gp_ext_amt"
    Expression ="qsubCommTransactionHsiStage.gp_ext_amt"
    Name ="tax_pst_amt"
    Expression ="qsubCommTransactionHsiStage.tax_pst_amt"
    Name ="contact_nm"
    Expression ="qsubCommTransactionHsiStage.contact_nm"
    Name ="ship_via_txt"
    Expression ="qsubCommTransactionHsiStage.ship_via_txt"
    Name ="doc_type_cd"
    Expression ="qsubCommTransactionHsiStage.doc_type_cd"
    Name ="hsi_shipto_id"
    Expression ="qsubCommTransactionHsiStage.hsi_shipto_id"
    Name ="IMCLMJ"
    Expression ="qsubCommTransactionHsiStage.IMCLMJ"
    Name ="IMCLSJ"
    Expression ="qsubCommTransactionHsiStage.IMCLSJ"
    Name ="IMCLMC"
    Expression ="qsubCommTransactionHsiStage.IMCLMC"
    Name ="IMCLSM"
    Expression ="qsubCommTransactionHsiStage.IMCLSM"
    Name ="file_cost_ext_amt"
    Expression ="qsubCommTransactionHsiStage.file_cost_ext_amt"
    Name ="ess_salesperson_cd"
    Expression ="qsubCommTransactionHsiStage.ess_salesperson_cd"
    Name ="pmts_salesperson_cd"
    Expression ="qsubCommTransactionHsiStage.pmts_salesperson_cd"
    Name ="hsi_billto_id"
    Expression ="qsubCommTransactionHsiStage.hsi_billto_id"
    Name ="hsi_billto_nm"
    Expression ="qsubCommTransactionHsiStage.hsi_billto_nm"
    Name ="hsi_billto_div_cd"
    Expression ="qsubCommTransactionHsiStage.hsi_billto_div_cd"
    Name ="hsi_shipto_div_cd"
    Expression ="qsubCommTransactionHsiStage.hsi_shipto_div_cd"
    Name ="hsi_shipto_nm"
    Expression ="qsubCommTransactionHsiStage.hsi_shipto_nm"
    Name ="vpa_cd"
    Expression ="qsubCommTransactionHsiStage.vpa_cd"
    Name ="vpa_desc"
    Expression ="qsubCommTransactionHsiStage.vpa_desc"
    Name ="manufact_cd"
    Expression ="qsubCommTransactionHsiStage.manufact_cd"
    Name ="sales_category_cd"
    Expression ="qsubCommTransactionHsiStage.sales_category_cd"
    Name ="privileges_cd"
    Expression ="qsubCommTransactionHsiStage.privileges_cd"
    Name ="price_method_cd"
    Expression ="qsubCommTransactionHsiStage.price_method_cd"
    Name ="customer_po_num"
    Expression ="qsubCommTransactionHsiStage.customer_po_num"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbBoolean "UseTransaction" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.comm_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.order_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.reference_order_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.customer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.price_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.price_override_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.location_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.unit_price_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.audit_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.tax_pst_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.contact_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.ship_via_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.IMCLSJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.IMCLMC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.IMCLSM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.item_org_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.file_cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.pmts_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_billto_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_billto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.file_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.land_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.avg_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.comm_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.vpa_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.vpa_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.sales_category_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.privileges_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.price_method_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommTransactionHsiStage.customer_po_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr7"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr8"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1581
    Bottom =991
    Left =-1
    Top =-1
    Right =1549
    Bottom =247
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =38
        Top =6
        Right =414
        Bottom =278
        Top =0
        Name ="qsubCommTransactionHsiStage"
        Name =""
    End
End
