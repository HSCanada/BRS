Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201401\") AND ((comm_transaction.sales"
    "person_key_id)<>\"Internal\") AND ((comm_transaction.item_comm_group_cd) Not In "
    "(\"ITMSER\",\"ITMPAR\",\"ITMEQ0\")) AND ((comm_salesperson_master.branch_cd)=\"M"
    "EDIC\") AND ((comm_transaction.source_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_plan"
    Name ="comm_customer_master_ISR"
    Name ="comm_transaction_ISR"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.comm_plan_id"
    Expression ="comm_transaction.ess_salesperson_key_id"
    Alias ="Inside Sales Rep"
    Expression ="comm_customer_master_ISR.isr_salesperson_cd"
    Alias ="TS Promo"
    Expression ="IIf(IsNull([entered_by_cd]),\"\",\"TS\")"
    Expression ="comm_transaction.order_source_cd"
    Expression ="comm_transaction.reference_order_txt"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Alias ="gp_free_goods_amt"
    Expression ="IIf([shipped_qty]<>0 And [comm_transaction]![transaction_amt]=0 And [IMCLMJ]<>\""
        "908\" And [IMCLMJ]<>\"Y18\",-[gp_ext_amt],0)"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.IMITEM"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_transaction_ISR.entered_by_cd"
    Expression ="comm_customer_master_ISR.isr_fscpartner_cd"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.doc_type_cd"
    Expression ="comm_transaction.hsi_shipto_div_cd"
    Expression ="comm_customer_master.ship_postal_num"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_plan"
    Expression ="comm_transaction.comm_plan_id = comm_plan.comm_plan_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master_ISR"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master_ISR.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_transaction_ISR"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_transaction_ISR.fiscal_yearmo_num"
    Flag =2
    LeftTable ="comm_transaction"
    RightTable ="comm_transaction_ISR"
    Expression ="comm_transaction.doc_id = comm_transaction_ISR.doc_id"
    Flag =2
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master_ISR"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_customer_master_ISR.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1800"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_ISR.entered_by_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_ISR.isr_fscpartner_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.reference_order_txt"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TS Promo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="gp_free_goods_amt"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Inside Sales Rep"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.ship_postal_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1565
    Bottom =1005
    Left =-1
    Top =-1
    Right =1460
    Bottom =540
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =633
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =441
        Top =373
        Right =703
        Bottom =517
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =437
        Top =85
        Right =581
        Bottom =229
        Top =0
        Name ="comm_plan"
        Name =""
    End
    Begin
        Left =813
        Top =301
        Right =1073
        Bottom =570
        Top =0
        Name ="comm_customer_master_ISR"
        Name =""
    End
    Begin
        Left =750
        Top =155
        Right =894
        Bottom =299
        Top =0
        Name ="comm_transaction_ISR"
        Name =""
    End
    Begin
        Left =600
        Top =35
        Right =885
        Bottom =433
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
