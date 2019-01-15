
-- 20190115 marketing adjustment model

-- Label --

-- drop table BRS_ItemLabel


CREATE TABLE [dbo].[BRS_ItemLabel](
	[Label] [char](1) NOT NULL,
	[LabelDesc] [varchar](50) NOT NULL,
	[LabelClassKey] [int] IDENTITY(1,1) NOT NULL,
	ma_base_factor float NOT NULL

 CONSTRAINT [BRS_ItemLabel_c_pk] PRIMARY KEY CLUSTERED 
(
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- pop

INSERT INTO [dbo].[BRS_ItemLabel]
([Label], [LabelDesc], ma_base_factor)
select distinct [Label], '', 0 from [dbo].[BRS_Item]
GO

--

ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_ItemLabel FOREIGN KEY
	(
	Label
	) REFERENCES dbo.BRS_ItemLabel
	(
	Label
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- set
UPDATE 
	[dbo].[BRS_ItemLabel]
SET 
	[ma_base_factor] = 1.1,
	[LabelDesc] = 'Private Label'
WHERE
	[Label] = 'P'
GO

UPDATE 
	[dbo].[BRS_ItemLabel]
SET 
	[ma_base_factor] = 1.08,
	[LabelDesc] = 'XXX update this'
WHERE
	[Label] <> 'P'
GO

-- Stocking --

-- drop table BRS_ItemStocking

CREATE TABLE [dbo].[BRS_ItemStocking](
	[StockingType] [char](1) NOT NULL,
	[StockingTypeDesc] [varchar](50) NOT NULL,
	[StockingTypeClassKey] [int] IDENTITY(1,1) NOT NULL,
	ma_stocking_factor float NOT NULL

 CONSTRAINT [BRS_ItemItemStocking_c_pk] PRIMARY KEY CLUSTERED 
(
	[StockingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- pop

INSERT INTO [dbo].[BRS_ItemStocking]
([StockingType], [StockingTypeDesc], ma_stocking_factor)
select distinct [StockingType], '', 0 from [dbo].[BRS_Item]
GO

--

ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_ItemStocking FOREIGN KEY
	(
	[StockingType]
	) REFERENCES dbo.[BRS_ItemStocking]
	(
	[StockingType]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- set
UPDATE 
	[dbo].[BRS_ItemStocking]
SET 
	[ma_stocking_factor] =  0.100,
	[StockingTypeDesc] = 'Non-Stocking'
WHERE
	[StockingType] = 'N'
GO

-- set
UPDATE 
	[dbo].[BRS_ItemStocking]
SET 
	[ma_stocking_factor] =  0.00,
	[StockingTypeDesc] = 'XXX update this'
WHERE
	[StockingType] <> 'N'
GO

--

ALTER TABLE dbo.BRS_ItemSupplier ADD
	ma_supplier_factor float(53) NOT NULL CONSTRAINT DF_BRS_ItemSupplier_ma_supplier_factor DEFAULT 0
GO

-- set Vendor

UPDATE 
	[dbo].[BRS_ItemSupplier]
SET 
	[ma_supplier_factor]  =  0.050
WHERE
	[Supplier] in ('USENDO', 'BAINTE', 'ORTHOT')
GO


UPDATE 
	[dbo].[BRS_ItemSupplier]
SET 
	[ma_supplier_factor]  =  0.020
WHERE
	[Supplier] in ('AXISCA', 'KERRCA', 'PENCAD', 'SYBECA')
GO
	

-- add global 

ALTER TABLE dbo.BRS_Config ADD
	ma_heavy_thresh float(53) NOT NULL CONSTRAINT DF_BRS_Config_ma_heavy_thresh DEFAULT 0,
	ma_heavy_factor float(53) NOT NULL CONSTRAINT DF_BRS_Config_ma_heavy_factor DEFAULT 0
GO

-- set global 

UPDATE 
	[dbo].[BRS_Config]
SET
	ma_heavy_thresh = 1.04,
	ma_heavy_factor = 0.021


-- CALC

