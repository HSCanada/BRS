Operation =1
Option =0
Where ="(((comm_transaction.item_id)=\"5824850\") AND ((comm_transaction.hsi_shipto_id)="
    "2613275) AND ((comm_transaction.fiscal_yearmo_num)=\"201409\")) OR (((comm_trans"
    "action.item_id)=\"7019509\") AND ((comm_transaction.hsi_shipto_id)=1820279) AND "
    "((comm_transaction.fiscal_yearmo_num)=\"201409\")) OR (((comm_transaction.item_i"
    "d)=\"6521103\") AND ((comm_transaction.hsi_shipto_id)=2281740) AND ((comm_transa"
    "ction.fiscal_yearmo_num)=\"201409\")) OR (((comm_transaction.item_id)=\"9498563\""
    ") AND ((comm_transaction.hsi_shipto_id)=1677570) AND ((comm_transaction.fiscal_y"
    "earmo_num)=\"201409\")) OR (((comm_transaction.item_id)=\"2907051\") AND ((comm_"
    "transaction.hsi_shipto_id)=1530356) AND ((comm_transaction.fiscal_yearmo_num)=\""
    "201409\"))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
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
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1450
    Bottom =997
    Left =-1
    Top =-1
    Right =1418
    Bottom =674
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =596
        Bottom =636
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
