/****** Script for SelectTopNRows command from SSMS  ******/

-- save current
UPDATE       BRS_CustomerFSC_History
SET
HIST_MarketClass = '', 
HIST_SegCd ='', 

HIST_MarketClass_New ='', 
HIST_SegCd_New ='', 

HIST_MarketClass_Old =HIST_MarketClass, 
HIST_SegCd_Old = HIST_SegCd
WHERE        (FiscalMonth BETWEEN 202001 AND 202101) AND (Shipto > 0)

-- save current to prod and new
UPDATE       BRS_CustomerFSC_History
SET
HIST_MarketClass = MarketClass, 
HIST_SegCd =SegCd, 

HIST_MarketClass_New = MarketClass, 
HIST_SegCd_New = SegCd
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_Customer AS c ON BRS_CustomerFSC_History.Shipto = c.ShipTo
WHERE        (BRS_CustomerFSC_History.FiscalMonth BETWEEN 202001 AND 202101) AND (BRS_CustomerFSC_History.Shipto > 0)

-- fix new (sales div reclass)
-- revert prod to old where sales div vs Market do not agree

