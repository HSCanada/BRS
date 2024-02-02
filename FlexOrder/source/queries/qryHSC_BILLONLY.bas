Operation =1
Option =0
Begin InputTables
    Name ="FFB12_IMP_review"
End
Begin OutputColumns
    Expression ="FFB12_IMP_review.A_Ship_To"
    Expression ="FFB12_IMP_review.B_Document_Type"
    Expression ="FFB12_IMP_review.C_Item_number"
    Expression ="FFB12_IMP_review.D_Line_Type"
    Expression ="FFB12_IMP_review.E_Qty"
    Expression ="FFB12_IMP_review.F_Unit_Price"
    Expression ="FFB12_IMP_review.G_Line_price_Override"
    Expression ="FFB12_IMP_review.H_Customer_PO"
    Expression ="FFB12_IMP_review.I_Refer_order"
    Expression ="FFB12_IMP_review.J_Order_Taken_By"
    Expression ="FFB12_IMP_review.K_Ordered_By"
    Expression ="FFB12_IMP_review.L_Refer_Order"
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
        dbText "Name" ="FFB12_IMP_review.A_Ship_To"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.B_Document_Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.I_Refer_order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.H_Customer_PO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.C_Item_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.F_Unit_Price"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.E_Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.D_Line_Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.G_Line_price_Override"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.J_Order_Taken_By"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.K_Ordered_By"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FFB12_IMP_review.L_Refer_Order"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1582
    Bottom =798
    Left =-1
    Top =-1
    Right =1566
    Bottom =317
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =181
        Top =154
        Right =325
        Bottom =298
        Top =0
        Name ="FFB12_IMP_review"
        Name =""
    End
End
