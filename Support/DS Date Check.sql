SELECT        d.SalesDate, d.FiscalMonth, m.FiscalMonth, m.BeginDt, m.EndDt
FROM            BRS_SalesDay AS d CROSS JOIN
                         BRS_FiscalMonth AS m
where  d.SalesDate between m.BeginDt and m.EndDt and d.FiscalMonth <> M.FiscalMonth and m.FiscalMonth > 0