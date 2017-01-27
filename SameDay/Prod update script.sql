-- dump from DW
-- copy & load

-- update 5 min / 6 mo
UPDATE    BRS_TransactionDW
SET

	[OriginalSalesOrderNumber]		= CASE WHEN s.OORNO = 0 THEN s.JDEORNO					ELSE s.OORNO  END,
	[OriginalOrderDocumentType]		= CASE WHEN s.OORNO = 0 THEN s.ORDOTYCD					ELSE s.OORTY  END,
	[OriginalOrderLineNumber]		= CASE WHEN s.OORNO = 0 THEN ROUND(s.LNNO * 1000, 0)	ELSE ROUND(ISNULL(s.OORLINO,0) * 1000, 0)  END,

	[PricingAdjustmentLine]			= ISNULL(s.PCADLINO,''),
	[SalesOrderBilltoNumber]		= ISNULL(s.BTADNO,0),
	[EssCode]						= ISNULL(s.ESSCD,''),
	[CcsCode]						= ISNULL(s.CCSCD,''),
	[EstCode]						= ISNULL(s.ESTCD,0),
	[TssCode]						= ISNULL(s.TSSCD,''),
	[CagCode]						= ISNULL(s.CAGREPCD,''),
	[EquipmentOrderNumber]			= ISNULL(s.EQORDNO,''),
	[EquipmentOrderType]			= ISNULL(s.EQORDTYCD,'')

FROM         STAGE_BRS_TransactionDWfix AS s INNER JOIN
                      BRS_TransactionDW ON s.JDEORNO = BRS_TransactionDW.SalesOrderNumber AND s.ORDOTYCD = BRS_TransactionDW.DocType AND ROUND(s.LNNO * 1000, 0) 
                      = BRS_TransactionDW.LineNumber

-- clear
truncate table STAGE_BRS_TransactionDWfix

-- test
select count(*)  from dbo.STAGE_BRS_TransactionDWfix
