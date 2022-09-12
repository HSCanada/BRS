-- refresh Schein Saver from Redemptions DB
-- updated 3 Apr 19


-------------------------------------------------------------------------------
-- BEGIN
-------------------------------------------------------------------------------


print '1. clear prod'

truncate table Redemptions_tbl_Main
GO
truncate table Redemptions_tbl_Items
GO

INSERT INTO [dbo].[Redemptions_tbl_Main]
           ([RecID]
           ,[Buy]
           ,[Get])
     VALUES
           (0, '', '')
GO

-- 

print '2. add deals'

INSERT INTO Redemptions_tbl_Main
	(
	RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired
	,Setleader
	,VendorID
	,SetLeader_Name
	,AutoAdd
	)
SELECT        RecID, Div, Buy, Get, VendorName, Redeem, Quarter, Note, EffDate, Expired
	,Setleader
	,VendorID
	,SetLeader_Name
	,AutoAdd
FROM            
	Redemptions..tbl_Main
WHERE        
	-- update date
	( (SELECT [SalesDateLastWeekly] FROM [dbo].[BRS_Config]) BETWEEN EffDate AND Expired) AND
	--	RecID = 7889 AND
	--	(CAST('2020-10-20' AS DATETIME) BETWEEN EffDate AND Expired) AND
	(1=1)
GO


print '3. add items'

INSERT INTO Redemptions_tbl_Items
	(RecID, ItemNumber, ItemID)
SELECT        
	(MIN(i.RecID)), ibr.Item, MAX(ibr.ItemKey) AS ItemID
FROM            
	Redemptions..tbl_Items AS i 

	INNER JOIN Redemptions_tbl_Main AS d 
	ON i.RecID = d.RecID 
	
	INNER JOIN BRS_Item AS ibr 
	ON i.ItemNumber = ibr.Item
WHERE 
--	(i.RecID IN (30310, 30311, 30312, 30313, 30314, 30315, 30316, 30317)) AND
--	(i.ItemNumber = '1263888') AND
	(1=1)
GROUP BY 
	ibr.Item

--

print 'test:  below must be zero rows'
SELECT        i.ItemNumber, COUNT(d.RecID) AS deal_code
FROM            Redemptions_tbl_Main AS d INNER JOIN
                         Redemptions_tbl_Items AS i ON d.RecID = i.RecID
GROUP BY i.ItemNumber
HAVING        (COUNT(d.RecID) > 1) order by 2 desc


-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------

---  

--

-- move to prod, on hold, waiting for Free goods project
-- 25 Feb 19, tmc
/*
-- START - prod move
--drop table [Redemptions_tbl_Items]
GO

SELECT        
	(i.RecID), ibr.Item, ibr.ItemKey AS ItemID
FROM            
	Redemptions..tbl_Items AS i 

	INNER JOIN Redemptions_tbl_Main AS d 
	ON i.RecID = d.RecID 
	
	INNER JOIN BRS_Item AS ibr 
	ON i.ItemNumber = ibr.Item
WHERE 
--	(i.RecID IN (30310, 30311, 30312, 30313, 30314, 30315, 30316, 30317)) AND
	(i.ItemNumber = '1263888') AND
	(1=1)


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

*/

print '4. add new chargback'

INSERT INTO [fg].[chargeback]
(
[cb_contract_num]
,[note_txt]
)
select distinct [ChargebackContractNumber], 'init' from [dbo].[BRS_TransactionDW] dw where [ChargebackContractNumber] > 0 and 
	not exists (select * from  [fg].[chargeback] cb where cb.cb_contract_num = dw.ChargebackContractNumber)
GO
