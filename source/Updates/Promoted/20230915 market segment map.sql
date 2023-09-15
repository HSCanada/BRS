--market segment map, tmc 15 Sep 23


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSegment ADD
	SegCd_map char(20) NOT NULL CONSTRAINT DF_BRS_CustomerSegment_SegCd_map DEFAULT ''
GO
ALTER TABLE dbo.BRS_CustomerSegment ADD CONSTRAINT
	FK_BRS_CustomerSegment_BRS_CustomerSegment FOREIGN KEY
	(
	SegCd_map
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerSegment SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- map new seg to Market
UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'ANIMAL', [SegCd_map]='VET' WHERE [SegCd] = 'VET'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'ELITE', [SegCd_map]='LRGDSO'  WHERE [SegCd] = 'LRGDSO'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'INSTIT', [SegCd_map]='DFED'  WHERE [SegCd] = 'DFED'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'INSTIT', [SegCd_map]='DI'  WHERE [SegCd] = 'DI'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'INSTIT', [SegCd_map]='DSH'  WHERE [SegCd] = 'DSH'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'INSTIT', [SegCd_map]='PDS'  WHERE [SegCd] = 'PDS'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'INSTIT', [SegCd_map]='PHC'  WHERE [SegCd] = 'PHC'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'MEDICL', [SegCd_map]='MED'  WHERE [SegCd] = 'MED'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'MIDMKT', [SegCd_map]='EMRGDSO'  WHERE [SegCd] = 'EMRGDSO'
GO


UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'MIDMKT', [SegCd_map]='PGP'  WHERE [SegCd] = 'PGP'
GO


UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'PVTPRC', [SegCd_map]='PP'  WHERE [SegCd] = 'PP'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'ZAHN', [SegCd_map]='LAB'  WHERE [SegCd] = 'LAB'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'ZAHNSM', [SegCd_map]='ZDSO'  WHERE [SegCd] = 'ZDSO'
GO

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'ZZEXCL', [SegCd_map]='ZTA'  WHERE [SegCd] = 'ZTA'
GO

-- map old seg to new seg

UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'ELITE', [SegCd_map]='LRGDSO'  WHERE [SegCd] = 'NDSO'
GO


UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'MIDMKT', [SegCd_map]='EMRGDSO'  WHERE [SegCd] = 'RDSO'
GO


UPDATE [dbo].[BRS_CustomerSegment] SET [MarketClass_map] = 'MIDMKT', [SegCd_map]='PGP'  WHERE [SegCd] = 'DSO'
GO

-- test map missing

SELECT        ShipTo, [Billto],[SalesDivisionCode], MarketClassCode, [MarketClassNewCode], [SegmentCode], [SegmentCodeNew]
FROM            Dimension.Customer
where [SegmentCodeNew] = ''


SELECT        [SalesDivisionCode], [MarketClassNewCode], [SegmentCodeNew]
FROM            Dimension.Customer
group by [SalesDivisionCode], [MarketClassNewCode], [SegmentCodeNew]
order by 1,2

select distinct [FocusCd] from [dbo].[BRS_CustomerVPA]


-- set focus

update [dbo].[BRS_CustomerVPA]
set [FocusCd] = ''
where [FocusCd] <> ''
GO

update [dbo].[BRS_CustomerVPA]
set [FocusCd] = 'TOP40'
where [VPA] in (
'MCMANA01'
,'ASHIVJI'
,'MCA01'
,'CORUS'
,'ELAWOUR'
,'SMILES01'
,'MAZAREH1'
,'PASSDEN'
,'SHERGHIN'
,'RONDINEL'
,'NACH05'
,'JAFFER01'
,'CDSC'
,'DENSAND'
,'STRSMILE'
,'CHOICE'
,'REDMOND1'
,'OAKDNTL'
,'GSD01'
,'VTRAN'
,'GUP01'
,'CHAGGER1'
,'TRILL01'
,'ALDABB06'
,'DAVEORTH'
,'KUMAR'
,'SHUHEND'
,'KAVAROS'
,'ALLIANCE'
,'SWAIDA01'
,'HTL01'
,'SODHI01'
,'SHIVJI'
,'NEWTON'
,'HUSSIAN'
,'CHAU01'
,'ALEXYEH'
,'RAJ01'
,'EASTKOOT'
,'YOUNAN'
)

update [dbo].[BRS_CustomerVPA]
set [FocusCd] = 'BUYGP'
where [VPA] in (
'BREAKAWA'
,'KLEAR'
,'DNTLSTOR'
,'RID01'
,'DBN01'
,'TEETH1ST'
,'QUEBCGRP'
,'ALPHAO'
)

 


