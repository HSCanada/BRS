-- refresh Schein Saver from SQ03



-- clear prod
truncate table Redemptions_tbl_Main
GO
truncate table Redemptions_tbl_Items
GO

-- clear stage
drop table Redemptions_tbl_Items_stage
GO
drop table Redemptions_tbl_Main_stage
GO

-- run package to pull data into pre-stage

-- migrate from pre-stage to stage
EXEC sp_rename 'tbl_Items', 'Redemptions_tbl_Items_stage'
GO
EXEC sp_rename 'tbl_Main', 'Redemptions_tbl_Main_stage'
GO


-- rename redemptions_tbl_Items_stage
-- rename redemptions_tbl_Items_stagetbl_Main_stage

INSERT INTO [dbo].[Redemptions_tbl_Main]
           ([RecID]
           ,[Buy]
           ,[Get])
     VALUES
           (0, '', '')
GO

-- set day today
INSERT INTO Redemptions_tbl_Main
                         (RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired)
SELECT        RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired

FROM            Redemptions_tbl_Main_stage

WHERE        (CAST('2019-03-20' AS DATETIME) BETWEEN EffDate AND Expired)



-- truncate table Redemptions_tbl_Items

INSERT INTO Redemptions_tbl_Items
	(RecID, ItemNumber, ItemID)
SELECT        
	(MIN(i.RecID)), i.ItemNumber, MAX(i.ItemID) AS ItemID
FROM            
	Redemptions_tbl_Items_stage AS i 

	INNER JOIN Redemptions_tbl_Main AS d 
	ON i.RecID = d.RecID 
	
	INNER JOIN BRS_Item AS ibr 
	ON i.ItemNumber = ibr.Item

GROUP BY 
	i.ItemNumber
--

-- test
-- must be null
SELECT        i.ItemNumber, COUNT(d.RecID) AS deal_code
FROM            Redemptions_tbl_Main AS d INNER JOIN
                         Redemptions_tbl_Items AS i ON d.RecID = i.RecID
GROUP BY i.ItemNumber
HAVING        (COUNT(d.RecID) > 1) order by 2 desc



---  STOP

--

-- move to prod
-- 25 Feb 19, tmc

-- START - prod move
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

-- END - Prod move