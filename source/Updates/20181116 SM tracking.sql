
-- add Sales Tracking flags for Business Reviews
-- updated 16 Nov 18

ALTER TABLE dbo.BRS_CustomerVPA ADD
	ReviewTrackingInd bit NOT NULL CONSTRAINT DF_BRS_CustomerVPA_ReviewTrackingInd DEFAULT 0
GO

ALTER TABLE [dbo].[BRS_CustomerBT] ADD
	ReviewTrackingInd bit NOT NULL CONSTRAINT DF_BRS_BRS_CustomerBT_ReviewTrackingInd DEFAULT 0
GO


UPDATE BRS_CustomerVPA
SET ReviewTrackingInd = 1
WHERE VPA = 'DENCORP'

UPDATE BRS_CustomerBT
SET ReviewTrackingInd = 1
WHERE BillTo = 1676214

