/*


 



*/

SELECT     BRS_Transaction.*
FROM         BRS_Transaction
WHERE     (ExtChargebackAmt IS NULL) AND (FiscalMonth between 201701 and 201701) AND DocType <> 'AA' AND GLBU_Class <> 'FREIG'

-- PRE (58462 row(s) affected); post = (0 row(s) affected)
