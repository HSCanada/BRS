-- Considator updates
-- 10 Jan 19

-- SET TS rollup for mapping


-- set Jen for testing
UPDATE       BRS_Employee
SET                isrRollupCd = null
--SET                isrRollupCd = 'ZTSJE'
WHERE        (LoginId = N'CAHSI\Julie.Emery')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = null
--SET                isrRollupCd = 'ZTSJE'
WHERE        (LoginId = N'CAHSI\Gary.Winslow')
GO



UPDATE       BRS_Employee
--SET                isrRollupCd = null
SET                isrRollupCd = 'ZTSJE'
WHERE        (LoginId = N'CAHSI\JLi')
GO


-- set top 15 rates

UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0510 WHERE  [CategoryRollup] = 'ANSTHC'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0430 WHERE  [CategoryRollup] = 'CEMENT'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0540 WHERE  [CategoryRollup] = 'ROTARY'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.1660 WHERE  [CategoryRollup] = 'RSTRTV'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.01 WHERE  [CategoryRollup] = 'COSMTC'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0890 WHERE  [CategoryRollup] = 'CROBRG'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0440 WHERE  [CategoryRollup] = 'DSPSBL'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0360 WHERE  [CategoryRollup] = 'ENDODN'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.190 WHERE  [CategoryRollup] = 'FINPOL'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0810 WHERE  [CategoryRollup] = 'GLOVES'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0470 WHERE  [CategoryRollup] = 'DENINS'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0450 WHERE  [CategoryRollup] = 'HANPCE'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0890 WHERE  [CategoryRollup] = 'IMPRES'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0930 WHERE  [CategoryRollup] = 'INFCON'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0260 WHERE  [CategoryRollup] = 'PRVMBR'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0260 WHERE  [CategoryRollup] = 'PRVPBR'
GO
UPDATE       [BRS_ItemCategoryRollup] SET  [CategorySharePercent] = 0.0660 WHERE  [CategoryRollup] = 'PRVNTV'
GO
	

--

-- Deals

--drop table [Redemptions_tbl_Items]
GO


CREATE TABLE [dbo].[Redemptions_tbl_Items](
	[ItemNumber] [nvarchar](12) NOT NULL,
	[ItemID] [int] NOT NULL,
	[RecID] [int] NOT NULL,
 CONSTRAINT [PK_Redemptions_tbl_Items] PRIMARY KEY CLUSTERED 
(
	[ItemNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


--drop table [dbo].[Redemptions_tbl_Main]
GO

CREATE TABLE [dbo].[Redemptions_tbl_Main](
	[RecID] [int] NOT NULL,
	[Div] [varchar](25) NULL,
	[Buy] [ntext] NULL,
	[Get] [ntext] NULL,
	[VendorName] [nvarchar](50) NULL,
	[Redeem] [nvarchar](1000) NULL,
	[Quarter] [nvarchar](255) NULL,
	[Note] [ntext] NULL,
	[EffDate] [datetime] NULL,
	[RedeemDate] [datetime] NULL,
	[Expired] [datetime] NULL,
 CONSTRAINT [PK_Redemptions_tbl_Main] PRIMARY KEY CLUSTERED 
(
	[RecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
GO

truncate table Redemptions_tbl_Main
GO

INSERT INTO [dbo].[Redemptions_tbl_Main]
           ([RecID]
           ,[Buy]
           ,[Get])
     VALUES
           (0, '', '')
GO

INSERT INTO Redemptions_tbl_Main
                         (RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired)
SELECT        RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired
FROM            Redemptions_tbl_Main_stage
WHERE        (CAST('2019-01-15' AS DATETIME) BETWEEN EffDate AND Expired)



-- truncate table Redemptions_tbl_Items

INSERT INTO Redemptions_tbl_Items
	(RecID, ItemNumber, ItemID)
SELECT        
	(MAX(i.RecID)), i.ItemNumber, MAX(i.ItemID) AS ItemID
FROM            
	Redemptions_tbl_Items_stage AS i 
	INNER JOIN Redemptions_tbl_Main AS d 
	ON i.RecID = d.RecID 
	
	INNER JOIN BRS_Item AS ibr 
	ON i.ItemNumber = ibr.Item

GROUP BY 
	i.ItemNumber
--

-- must be zero
SELECT        i.ItemNumber, COUNT(d.RecID) AS deal_code
FROM            Redemptions_tbl_Main AS d INNER JOIN
                         Redemptions_tbl_Items AS i ON d.RecID = i.RecID
GROUP BY i.ItemNumber
HAVING        (COUNT(d.RecID) > 1) order by 2 desc


-- Add Deal to Dimension
SELECT
	RecID deal_code,
	CASE 
		WHEN d.RecID = 0
		THEN ''
		ELSE LEFT('D-' + CAST(d.RecID as char(10)) + CAST(d.Buy AS VARCHAR(255)) + ' >> ' +  CAST(d.Get AS VARCHAR(255)), 255) 
	END AS deal
FROM            Redemptions_tbl_Main as d
                         

--
SELECT 
top 10
	i.[ItemKey],
	i.[Item],
	i.[SalesCategory],
	i.[CategoryRollup],
	i.[Major],
	i.[SubMajor],
	i.[ItemCode],
	i.[ItemStatus],
	i.[Brand],
	i.[Label],
	i.[Current_BasePrice],
	i.Top15,

	ISNULL(ideal.recID, 0) deal_code,
	
	CASE 
		WHEN isub.ItemKey = 1 
		THEN ''
		ELSE isub.Item
	END AS SubstItem

FROM 
	[Dimension].[Item] i

	LEFT JOIN Redemptions_tbl_Items AS ideal
	ON i.ItemCode = ideal.[ItemNumber]

	-- add subst ...
	INNER JOIN [Dimension].[Item] isub
	ON i.[CompetitiveMatchKey] = isub.[ItemKey]

WHERE 
	i.SalesCategoryCode in ('MERCH', 'SMEQU') and
--	RecID <> 0 AND
--	isub.itemkey <> 1 AND
	1=1


