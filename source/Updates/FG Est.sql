SELECT
	t.FiscalMonth
	, t.WSDOCO_salesorder_number
	, t.WSLNID_line_number
	, t.WSSHAN_shipto
	, 'tbd' AS Practice_Name
	, t.WSLITM_item_number
	, t.WSDSC1_description
	, t.WS$SPC_supplier_code
	, (t.gp_ext_amt / -1.12) as gp_est
	, 'NEW EST' as src
	, t.ID
	, t.WSSOQS_quantity_shipped
	, t.transaction_amt
	, t.WSDCTO_order_type
	, t.WSLNTY_line_type
	, t.WSSRP1_major_product_class
	, t.WSASN__adjustment_schedule
	, t.WS$SPC_supplier_code
	, t.WSCYCL_cycle_count_category
	, t.WSSIC__speciality
	, t.WSAC10_division_code
	, t.source_cd

FROM
	comm.transaction_F555115 AS t 

	INNER JOIN BRS_DocType AS doc 
	ON t.WSDCTO_order_type = doc.DocType 

	INNER JOIN BRS_LineTypeOrder AS line_type 
	ON t.WSLNTY_line_type = line_type.LineTypeOrder 

	INNER JOIN BRS_ItemSupplier AS sup 
	ON t.WS$SPC_supplier_code = sup.Supplier 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON t.WSSRP1_major_product_class = mpc.MajorProductClass 

	INNER JOIN BRS_ItemLabel AS lbl
	ON t.WSCYCL_cycle_count_category = lbl.Label 

	INNER JOIN BRS_SalesDivision AS div 
	ON t.WSAC10_division_code = div.SalesDivision 

	INNER JOIN BRS_CustomerSpecialty AS spec 
	ON t.WSSIC__speciality = spec.Specialty 

	INNER JOIN BRS_CustomerVPA AS vpa 
	ON t.WSASN__adjustment_schedule = vpa.VPA 

WHERE        
	(t.source_cd = 'JDE') AND 
	(t.WSSOQS_quantity_shipped <> 0) AND 
	(t.transaction_amt = 0) AND 

	(doc.freegoods_exempt_cd=0) and
	(line_type.freegoods_exempt_cd=0) AND
	(sup.freegoods_exempt_cd =0) AND
	(mpc.freegoods_exempt_cd=0) AND
	(lbl.freegoods_exempt_cd=0) and
	(div.freegoods_exempt_cd=0) and 
	(spec.freegoods_exempt_cd=0) and
	(vpa.freegoods_exempt_cd=0) and


	(t.FiscalMonth = 202311)



-- ORG 33 106



-- select count(*) from [comm].[freegoods] where [FiscalMonth] = 202309 and SourceCode = 'EST'-- 
-- ORG 5674
/*
SELECT        top 100 *
FROM            comm.transaction_F555115 AS t
WHERE        (WSSOQS_quantity_shipped <> 0) AND (transaction_amt = 0) AND (FiscalMonth = 202309) and WSSO08_price_adjustment_line_indicator <> ''
*/