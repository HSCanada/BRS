
-- Step 1:  clear tables (run below)
/*
truncate table STAGE_BRS_Promotion 
truncate table STAGE_BRS_TransactionDW
*/
-- Step 2:  load tables via "S:\Business Reporting\_BR_Sales\Upload\BRS_TransactionDW_Load.bat"

-- Step 3:  run below script

-- Step 4:  run summary 

--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place

INSERT INTO BRS_TransactionDW
(
	SalesOrderNumber, 
	DocType, 
	LineNumber, 
	CalMonth, 
	Date, 
	Shipto, 
	Item, 
	EnteredBy, 
	OrderTakenBy, 
	OrderSourceCode, 
	CustomerPOText1, 
	PriceMethod, 
	VPA, 
	LineTypeOrder, 
	SalesDivision, 
	MajorProductClass, 
	ChargebackContractNumber, 
	GLBusinessUnit, 
	OrderFirstShipDate, 
	InvoiceNumber, 
	ShippedQty, 
	NetSalesAmt, 
	GPAmt, 
	GPAtFileCostAmt, 
	GPAtCommCostAmt, 
	ExtChargebackAmt, 
	ExtDiscAmt, 
	UnitListPrice,
	PromotionCode,
	OrderPromotionCode,
	BackorderInd,
	FreeGoodsEstInd

	)
	SELECT     
	s.JDEORNO AS SalesOrderNumber, 
	s.ORDOTYCD AS DocType, 
	ROUND(s.LNNO * 1000,0) AS LineNumber, 
	s.CMID AS CalMonth, 
	s.PDDT AS Date, 
	s.ADNOID AS Shipto, 
	s.ITLONO AS Item, 
	s.ENBYNA AS EnteredBy, 
	s.ORTKBYID AS OrderTakenBy, 
	s.ORSCCD AS OrderSourceCode, 
	LEFT(s.RF1TT,25) AS CustomerPOText1, 
	s.PRMDCD AS PriceMethod, 
	ISNULL(s.SPCDID,'') AS VPA, 
	s.LNTY AS LineTypeOrder, 
	s.HSDCDID AS SalesDivision, 
	s.MJPRCLID AS MajorProductClass, 
	ISNULL(s.CBCONTRNO,0) AS ChargebackContractNumber, 
	ISNULL(s.GLBUNO,'') AS GLBusinessUnit, 
	ISNULL(s.ORFISHDT, '1 Jan 1980') AS OrderFirstShipDate, 
	s.IVNO AS InvoiceNumber, 
	s.WJXBFS1 AS ShippedQty, 
	s.WJXBFS2 AS NetSalesAmt, 
	s.WJXBFS3 AS GPAmt, 
	s.WJXBFS4 AS GPAtFileCostAmt, 
	s.WJXBFS5 AS GPAtCommCostAmt, 
	s.WJXBFS6 AS ExtChargebackAmt, 

	CASE WHEN s.LNTY = 'CP' THEN (0 - s.WJXBFS2) ELSE s.WJXBFS7 END  AS ExtDiscAmt, 

	s.WJXBFS8 AS UnitListPrice, 
	ISNULL(p1.PMCD, '') AS PromotionCode, 
	ISNULL(p2.PMCD, '') AS OrderPromotionCode,

	CASE WHEN s.PDDT = s.ORFISHDT THEN 0 ELSE 1 END as BackorderInd,		
--	0 as BackorderInd,		
	CASE WHEN s.WJXBFS2 = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd
--	CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd


FROM         
	STAGE_BRS_TransactionDW AS s 

--	LEFT OUTER JOIN 
	LEFT OUTER JOIN STAGE_BRS_Promotion AS p2 
	ON s.OPMID = p2.PMID 

	LEFT OUTER JOIN STAGE_BRS_Promotion AS p1 
	ON s.PMID = p1.PMID

	LEFT OUTER JOIN BRS_DocType as dt
	ON s.ORDOTYCD = dt.DocType

	LEFT OUTER JOIN BRS_ItemMPC AS mpc 
	ON s.MJPRCLID = mpc.MajorProductClass

	LEFT OUTER JOIN BRS_BusinessUnit AS bu
	ON ISNULL(s.GLBUNO,'') = bu.BusinessUnit

	LEFT OUTER JOIN BRS_BusinessUnitClass as buc
	ON  bu.GLBU_Class = buc.GLBU_Class

--	12 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place


--If (@bDebug <> 0)
--Begin
	Print '------------------------------------------------------------------------------------------------------------'
	Print 'Free Goods P&G correction to remove free goods estimate for PROCGA >= 1 Sep 16'
	Print 'Once on the new sytem this will re revisited.  tmc, 13 Sep 16'
	Print '------------------------------------------------------------------------------------------------------------'
	Print ''
--End

--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place

--If (@nErrorCode = 0) 
--Begin

	UPDATE    
		BRS_TransactionDW
	SET              
--		AdjCode = '', 
		FreeGoodsEstInd = 0
	FROM         
		BRS_TransactionDW 
		
		INNER JOIN BRS_Item AS i 
		ON BRS_TransactionDW.Item = i.Item

	WHERE     
		(BRS_TransactionDW.CalMonth = (SELECT MIN(CMID) FROM STAGE_BRS_TransactionDW) ) AND 
		(i.Supplier = 'PROCGA') AND 
		(BRS_TransactionDW.Date > '1 Sep 2016') AND 
		(BRS_TransactionDW.FreeGoodsEstInd = 1) AND
		(1 = 1)

--	Set @nErrorCode = @@Error

-- End
--SELECT     MIN(CMID) FROM STAGE_BRS_TransactionDW

/*

-- run manual until History tables in place, 2 Feb 16

--------------------------------------------------------------------------------
Print 'Building DW Summary (BRS_AGG_IMD_Sales), used by Promo and Datamining...'
--------------------------------------------------------------------------------

INSERT INTO BRS_AGG_IMD_Sales
(
	Item,
	t.CalMonth, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode, 

	ShippedQty,
	NetSalesAmt, 
	GPAmt, 
	GPAtFileCostAmt, 
	GPAtCommCostAmt, 
	ExtChargebackAmt, 
	ExtDiscAmt, 

	FactCount
)
SELECT     
	Item,
	CalMonth, 
	SalesDivision, 

	FreeGoodsEstInd, 

	OrderSourceCode, 

	SUM(ShippedQty) AS ShippedQty,
	SUM(NetSalesAmt) AS SalesAmt, 
	SUM(GPAmt) AS GPAmt, 
	SUM(GPAtFileCostAmt) AS GPAtFileCostAmt, 
	SUM(GPAtCommCostAmt) AS GPAtCommCostAmt, 
	SUM(ExtChargebackAmt) AS ExtChargebackAmt, 
	SUM(ExtDiscAmt) AS ExtDiscAmt, 

	COUNT(*) AS FactCount

FROM         
	BRS_TransactionDW AS t
WHERE     
-- Manual load
	(t.CalMonth BETWEEN 201608 AND 201608)

GROUP BY 
	Item,
	CalMonth, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode

*/
