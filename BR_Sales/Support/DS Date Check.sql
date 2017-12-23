-- find inconsistencies with sales day vs Fiscal
SELECT        d.SalesDate, d.FiscalMonth, m.FiscalMonth, m.BeginDt, m.EndDt
FROM            BRS_SalesDay AS d CROSS JOIN
                         BRS_FiscalMonth AS m
where  d.SalesDate between m.BeginDt and m.EndDt and d.FiscalMonth <> M.FiscalMonth and m.FiscalMonth > 0

-- find trans sales day <> fiscal monthy

-- inspect
SELECT        t.SalesOrderNumberKEY, t.DocType, t.LineNumber, t.SalesDate, t.FiscalMonth, f.FiscalMonth AS ref_FiscalMonth
FROM            BRS_Transaction AS t INNER JOIN
                         BRS_SalesDay AS f ON t.SalesDate = f.SalesDate AND t.FiscalMonth <> f.FiscalMonth
--WHERE t.fiscalmonth = 201707

-- fix 
UPDATE       BRS_Transaction
SET                SalesDate = BRS_FiscalMonth.LastWorkingDt
FROM            BRS_Transaction INNER JOIN
                         BRS_SalesDay AS f ON BRS_Transaction.SalesDate = f.SalesDate AND BRS_Transaction.FiscalMonth <> f.FiscalMonth INNER JOIN
                         BRS_FiscalMonth ON BRS_Transaction.FiscalMonth = BRS_FiscalMonth.FiscalMonth
