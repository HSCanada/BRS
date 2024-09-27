SELECT   t.ID, t.CalMonth, t.SalesOrderNumber, t.DocType, ext.NoteTxt, t.OrderPromotionCode, t.PromotionCode, ext.PromotionTrackingCode, t.SalesDivision, c.ShipTo, c.PracticeName, c.MarketClass_New, c.Specialty, c.VPA, c.AccountType, fsc.Branch, comm.salesperson_master.master_salesperson_cd, comm.salesperson_master.salesperson_nm, 
             comm.salesperson_master.comm_plan_id, c.CreateDate, i.Item, i.ItemDescription, i.SalesCategory, i.Supplier, t.ShippedQty, t.NetSalesAmt
FROM     BRS_TransactionDW AS t INNER JOIN
             BRS_TransactionDW_Ext AS ext ON t.DocType = ext.DocType AND t.SalesOrderNumber = ext.SalesOrderNumber INNER JOIN
             BRS_Item AS i ON t.Item = i.Item INNER JOIN
             BRS_Customer AS c ON t.Shipto = c.ShipTo INNER JOIN
             BRS_FSC_Rollup AS fsc ON c.TerritoryCd = fsc.TerritoryCd INNER JOIN
             comm.salesperson_master ON fsc.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
             BRS_FSC_Rollup AS fsc2 ON comm.salesperson_master. = fsc2.TerritoryCd INNER JOIN
WHERE   (t.CalMonth IN (202210, 202211, 202212, 202310, 202311, 202312)) AND (ext.PromotionTrackingCode = 'D1') AND (t.SalesDivision IN ('AAD', 'AAL'))
--WHERE   (t.CalMonth IN (202309, 202310, 202311, 202312)) AND (ext.PromotionTrackingCode = 'D1') AND (t.SalesDivision IN ('AAD', 'AAL')) and Branch  in ('HALFX', 'NWFLD')--