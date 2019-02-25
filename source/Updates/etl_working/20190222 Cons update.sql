-- refersh Schein Saver from SQ03

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

WHERE        (CAST('2019-02-22' AS DATETIME) BETWEEN EffDate AND Expired)



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

-- test
-- must be null
SELECT        i.ItemNumber, COUNT(d.RecID) AS deal_code
FROM            Redemptions_tbl_Main AS d INNER JOIN
                         Redemptions_tbl_Items AS i ON d.RecID = i.RecID
GROUP BY i.ItemNumber
HAVING        (COUNT(d.RecID) > 1) order by 2 desc


