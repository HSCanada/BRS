-- updated 31 Jan 19


CREATE TABLE [nes].[order_ets](
	[ets_num] [char](6) NOT NULL,
	[note] [nvarchar](50) NOT NULL,
	[ets_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [nes_ets_c_pk] PRIMARY KEY CLUSTERED 
(
	[ets_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


-- drop table nes.[open_order_opordrpt]

CREATE TABLE nes.[open_order_opordrpt](
	[ets_num] [char](6) NOT NULL,
	[line_number] [int] NOT NULL,

	[d1_branch] [char](10) NOT NULL,
	[order_status] [char](2) NOT NULL,
	[work_order_num] [char](10) NOT NULL,
	[work_order_date] [date] NOT NULL,
	[shipto] [int] NOT NULL,
	[install_date] [date] NOT NULL,
	[item_status] [char](10) NOT NULL,
	[item] [char](10) NOT NULL,
	[supplier] [char](6) NOT NULL,

	[ess_code] [char](5) NOT NULL,
	[dts_code] [char](5) NOT NULL,
	[cps_code] [char](5) NOT NULL,
	[fsc_code] [char](5) NOT NULL,

	[order_qty] [int] NOT NULL,
	[received_qty] [int] NULL,
	[received_date] [date] NULL,

	[net_sales_amount] [money] NOT NULL,
	[extended_cost_amount] [money] NOT NULL

 CONSTRAINT [open_order_opordrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[ets_num] ASC,
	[line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


BEGIN TRANSACTION
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_order_ets FOREIGN KEY
	(
	ets_num
	) REFERENCES nes.order_ets
	(
	ets_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_branch FOREIGN KEY
	(
	d1_branch
	) REFERENCES nes.branch
	(
	branch_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_order_status FOREIGN KEY
	(
	order_status
	) REFERENCES nes.order_status
	(
	order_status_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_order FOREIGN KEY
	(
	work_order_num
	) REFERENCES nes.[order]
	(
	work_order_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_Customer FOREIGN KEY
	(
	shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_Item FOREIGN KEY
	(
	item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_ItemSupplier FOREIGN KEY
	(
	supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup FOREIGN KEY
	(
	ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup1 FOREIGN KEY
	(
	dts_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup2 FOREIGN KEY
	(
	cps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup3 FOREIGN KEY
	(
	fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



INSERT INTO nes.open_order_opordrpt
                         (ets_num, line_number, d1_branch, order_status, work_order_num, work_order_date, shipto, install_date, item_status, item, supplier, order_qty, received_qty, 
                         received_date, net_sales_amount, extended_cost_amount, ess_code, dts_code, cps_code, fsc_code)

SELECT        est_num, line_number, d1_branch, order_status, work_order_num, work_order_date, shipto, install_date, item_status, item, supplier, order_qty, received_qty, 
                         received_date, net_sales_amount, extended_cost_amount, ess_code, dts_code, cps_code, fsc_code
FROM            Integration.open_order_opordrpt s
WHERE
order_qty is null


-- data pull

SELECT        s.est_num, s.line_number, s.d1_branch, s.order_status, s.work_order_num, s.work_order_date, s.shipto, s.install_date, s.item_status, s.item, s.supplier, 
                         s.order_qty, s.received_qty, s.received_date, s.net_sales_amount, s.extended_cost_amount, s.ess_code, s.dts_code, s.cps_code, s.fsc_code, c.PracticeName, 
                         f.FSCName, f.Branch, e.FSCName AS ESSName, e.Branch as BranchESS
FROM            Integration.open_order_opordrpt AS s INNER JOIN
                         BRS_Customer AS c ON CAST(s.shipto AS int) = c.ShipTo 
						 INNER JOIN
                         BRS_FSC_Rollup AS f ON c.TerritoryCd = f.TerritoryCd 
						 
						 INNER JOIN
                         BRS_FSC_Rollup AS e ON s.ess_code = e.TerritoryCd