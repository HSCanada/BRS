
/*
Trans Now -> Trans Then; missing 3 days

-> Summarized **
*/

select  * from BRS_AGG_CDBGAD_Sales 
where 
salesDate between '2022-12-23' and '2022-12-31' 


SELECT * 
FROM BRS_DS_Day_Yoy 
where 
salesDate_LY between '2022-12-23' and '2022-12-31' and
--FiscalMonth in(202312) and
(1=1)


-- ID area from source
select  * from BRS_AGG_CDBGAD_Sales 
where 
salesDate between '2022-12-23' and '2022-12-31' 


-- move to temp
SELECT        SalesDate, Branch, GLBU_Class, AdjCode, SalesDivision, Shipto, FreeGoodsEstInd, OrderSourceCode, SalesAmt, GPAmt, GP_Org_Amt, ExtChargebackAmt, FactCount, HIST_Specialty, HIST_MarketClass, HIST_TerritoryCd, 
                         HIST_VPA, ID_MAX, HIST_SegCd, CategoryRollupPPE
INTO              BRS_AGG_CDBGAD_Sales_temp
FROM            BRS_AGG_CDBGAD_Sales
WHERE        (SalesDate BETWEEN '2022-12-23' AND '2022-12-31')

-- delete source
DELETE FROM BRS_AGG_CDBGAD_Sales
WHERE        (SalesDate BETWEEN '2022-12-23' AND '2022-12-31')


-- reagg back

SELECT
--SalesDate
cast('2022-12-23' as datetime) SalesDate

,FreeGoodsEstInd
,Shipto
,GLBU_Class
,CategoryRollupPPE
,Branch
,AdjCode
,SalesDivision
,OrderSourceCode

,sum(SalesAmt) SalesAmt
,sum(GPAmt) GPAmt
,sum(GP_Org_Amt) GP_Org_Amt
,sum(ExtChargebackAmt) ExtChargebackAmt
,sum(FactCount) FactCount

,max(HIST_Specialty) HIST_Specialty
,max(HIST_MarketClass) HIST_MarketClass
,max(HIST_TerritoryCd) HIST_TerritoryCd
,max(HIST_VPA) HIST_VPA
,max(ID_MAX) ID_MAX
,max(HIST_SegCd) HIST_SegCd

FROM
BRS_AGG_CDBGAD_Sales_temp

group by 
--	[SalesDate] ,
	[FreeGoodsEstInd] ,
	[Shipto] ,
	[GLBU_Class] ,
	[CategoryRollupPPE] ,
	[Branch] ,
	[AdjCode] ,
	[SalesDivision] ,
	[OrderSourceCode] 
--


INSERT INTO BRS_AGG_CDBGAD_Sales
                         (SalesDate, FreeGoodsEstInd, Shipto, GLBU_Class, CategoryRollupPPE, Branch, AdjCode, SalesDivision, OrderSourceCode, SalesAmt, GPAmt, GP_Org_Amt, ExtChargebackAmt, FactCount, HIST_Specialty, HIST_MarketClass, 
                         HIST_TerritoryCd, HIST_VPA, ID_MAX, HIST_SegCd)
SELECT        CAST('2022-12-23' AS datetime) AS SalesDate, FreeGoodsEstInd, Shipto, GLBU_Class, CategoryRollupPPE, Branch, AdjCode, SalesDivision, OrderSourceCode, SUM(SalesAmt) AS SalesAmt, SUM(GPAmt) AS GPAmt, 
                         SUM(GP_Org_Amt) AS GP_Org_Amt, SUM(ExtChargebackAmt) AS ExtChargebackAmt, SUM(FactCount) AS FactCount, MAX(HIST_Specialty) AS HIST_Specialty, MAX(HIST_MarketClass) AS HIST_MarketClass, 
                         MAX(HIST_TerritoryCd) AS HIST_TerritoryCd, MAX(HIST_VPA) AS HIST_VPA, MAX(ID_MAX) AS ID_MAX, MAX(HIST_SegCd) AS HIST_SegCd
FROM            BRS_AGG_CDBGAD_Sales_temp
GROUP BY FreeGoodsEstInd, Shipto, GLBU_Class, CategoryRollupPPE, Branch, AdjCode, SalesDivision, OrderSourceCode

