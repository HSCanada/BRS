-- backorder, tmc, 2 Sept 21

/*
SELECT 

    Top 500 
    "IMBUYR" AS IMBUYR_buyer_number, "QN$SPC" AS QN$SPC_supplier_code, "SDLITM" AS SDLITM_item_number, "SDDSC1" AS SDDSC1_description, "QV$PRI" AS QV$PRI_pricing_info, "QV$AVC" AS QV$AVC_availability_code, "QV$CLC" AS QV$CLC_classification_code, "SDUPRC" AS SDUPRC_unit_price, "SDUORG" AS SDUORG_quantity, "SDSOBK" AS SDSOBK_quantity_backordered, "SDLNTY" AS SDLNTY_line_type, "IMLNTY" AS IMLNTY_line_type, "QCAC10" AS QCAC10_division_code, "SDMCU" AS SDMCU__business_unit, "SDDOC" AS SDDOC__document_number, "SDDOCO" AS SDDOCO_salesorder_number, "SDDCTO" AS SDDCTO_order_type, "SDLNID" AS SDLNID_line_number, CONVERT(date,"QCTRDJ") AS QCTRDJ_order_date, "SDVR01" AS SDVR01_reference, "SDVR02" AS SDVR02_reference_2, "QCENTB" AS QCENTB_entered_by, "SDSHAN" AS SDSHAN_shipto, "SDSHAN01" AS SDSHAN01_mailing_name, "SDAN8" AS SDAN8__billto, "SDAN801" AS SDAN801_mailing_name, "GIADDZ" AS GIADDZ_postal_code, "GICTY1" AS GICTY1_city, "GICOUN" AS GICOUN_county, "GIADDS" AS GIADDS_state, "GICTR" AS GICTR__country, CONVERT(date,"SDRSDJ") AS SDRSDJ_promised_delivery, "SDNXTR" AS SDNXTR_status_code_next 

 INTO Integration.FBACKRPT1_backorder

FROM 
--    OPENQUERY (ESYS_PROD, '

	SELECT
		IMBUYR, QN$SPC, SDLITM, SDDSC1, QV$PRI, QV$AVC, QV$CLC
		, CAST((SDUPRC)/1.0 AS DEC(15,4)) AS SDUPRC
--		, CAST((SDUPRC)/10000.0 AS DEC(15,4)) AS SDUPRC
		, SDUORG, SDSOBK, SDLNTY, IMLNTY, QCAC10, SDMCU, SDDOC, SDDOCO, SDDCTO
		, CAST((SDLNID)/1.0 AS DEC(15,3)) AS SDLNID
--		, CAST((SDLNID)/1000.0 AS DEC(15,3)) AS SDLNID
		, QCTRDJ
--		, CASE WHEN QCTRDJ IS NOT NULL THEN DATE(DIGITS(DEC(QCTRDJ+ 1900000,7,0))) ELSE NULL END AS QCTRDJ
		, SDVR01, SDVR02, QCENTB, SDSHAN, SDSHAN01, SDAN8, SDAN801, GIADDZ, GICTY1, GICOUN, GIADDS, GICTR
		, SDRSDJ
--		, CASE WHEN SDRSDJ IS NOT NULL THEN DATE(DIGITS(DEC(SDRSDJ+ 1900000,7,0))) ELSE NULL END AS SDRSDJ
		, SDNXTR

	FROM
		HSIUSRFLE.FBACKRPT1
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

*/

--------------------------------------------------------------------------------
-- create Integration.FBACKRPT1_backorder
--------------------------------------------------------------------------------
-- drop table Integration.FBACKRPT1_backorder_Staging

CREATE TABLE [Integration].[FBACKRPT1_backorder_Staging](
	[IMBUYR_buyer_number] [numeric](8, 0) NOT NULL,
	[QN$SPC_supplier_code] [char](6) NOT NULL,
	[SDLITM_item_number] [char](10) NOT NULL,
	[SDDSC1_description] [char](20) NOT NULL,
	[QV$PRI_pricing_info] [char](20) NOT NULL,
	[QV$AVC_availability_code] [char](1) NOT NULL,
	[QV$CLC_classification_code] [char](3) NOT NULL,
	[SDUPRC_unit_price] [numeric](15, 4) NOT NULL,
	[SDUORG_quantity] [numeric](9, 0) NOT NULL,
	[SDSOBK_quantity_backordered] [numeric](15, 0) NOT NULL,
	[SDLNTY_line_type] [char](2) NOT NULL,
	[IMLNTY_line_type] [char](2) NOT NULL,
	[QCAC10_division_code] [char](3) NOT NULL,
	[SDMCU__business_unit] [char](12) NOT NULL,
	[SDDOC__document_number] [numeric](8, 0) NOT NULL,
	[SDDOCO_salesorder_number] [numeric](8, 0) NOT NULL,
	[SDDCTO_order_type] [char](2) NOT NULL,
	[SDLNID_line_number] [numeric](15, 3) NOT NULL,
	[QCTRDJ_order_date] [date] NULL,
	[SDVR01_reference] [char](25) NOT NULL,
	[SDVR02_reference_2] [char](25) NOT NULL,
	[QCENTB_entered_by] [char](10) NOT NULL,
	[SDSHAN_shipto] [numeric](8, 0) NOT NULL,
	[SDSHAN01_mailing_name] [char](20) NOT NULL,
	[SDAN8__billto] [numeric](8, 0) NOT NULL,
	[SDAN801_mailing_name] [char](30) NOT NULL,
	[GIADDZ_postal_code] [char](12) NOT NULL,
	[GICTY1_city] [char](25) NOT NULL,
	[GICOUN_county] [char](25) NOT NULL,
	[GIADDS_state] [char](3) NOT NULL,
	[GICTR__country] [char](3) NOT NULL,
	[SDRSDJ_promised_delivery] [date] NULL,
	[SDNXTR_status_code_next] [char](3) NOT NULL
) ON [USERDATA]
GO


--------------------------------------------------------------------------------
BEGIN TRANSACTION
GO
ALTER TABLE Integration.FBACKRPT1_backorder_Staging ADD CONSTRAINT
	FBACKRPT1_backorder_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	SDDOCO_salesorder_number,
	SDDCTO_order_type,
	SDLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.FBACKRPT1_backorder_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
SELECT        TOP (500) IMBUYR AS IMBUYR_buyer_number, QN$SPC AS QN$SPC_supplier_code, SDLITM AS SDLITM_item_number, SDDSC1 AS SDDSC1_description, QV$PRI AS QV$PRI_pricing_info, QV$AVC AS QV$AVC_availability_code,
                          QV$CLC AS QV$CLC_classification_code, SDUPRC AS SDUPRC_unit_price, SDUORG AS SDUORG_quantity, SDSOBK AS SDSOBK_quantity_backordered, SDLNTY AS SDLNTY_line_type, IMLNTY AS IMLNTY_line_type, 
                         QCAC10 AS QCAC10_division_code, SDMCU AS SDMCU__business_unit, SDDOC AS SDDOC__document_number, SDDOCO AS SDDOCO_salesorder_number, SDDCTO AS SDDCTO_order_type, SDLNID AS SDLNID_line_number, 
                         CONVERT(date, QCTRDJ) AS QCTRDJ_order_date, SDVR01 AS SDVR01_reference, SDVR02 AS SDVR02_reference_2, QCENTB AS QCENTB_entered_by, SDSHAN AS SDSHAN_shipto, SDSHAN01 AS SDSHAN01_mailing_name, 
                         SDAN8 AS SDAN8__billto, SDAN801 AS SDAN801_mailing_name, GIADDZ AS GIADDZ_postal_code, GICTY1 AS GICTY1_city, GICOUN AS GICOUN_county, GIADDS AS GIADDS_state, GICTR AS GICTR__country, CONVERT(date, 
                         SDRSDJ) AS SDRSDJ_promised_delivery, SDNXTR AS SDNXTR_status_code_next
FROM            OPENQUERY(ESYS_PROD, 
                         '

	SELECT
		IMBUYR, QN$SPC, SDLITM, SDDSC1, QV$PRI, QV$AVC, QV$CLC
		, CAST((SDUPRC)/1.0 AS DEC(15,4)) AS SDUPRC
		, SDUORG, SDSOBK, SDLNTY, IMLNTY, QCAC10, SDMCU, SDDOC, SDDOCO, SDDCTO
		, CAST((SDLNID)/1.0 AS DEC(15,3)) AS SDLNID
		, QCTRDJ
		, SDVR01, SDVR02, QCENTB, SDSHAN, SDSHAN01, SDAN8, SDAN801, GIADDZ, GICTY1, GICOUN, GIADDS, GICTR
		, SDRSDJ
		, SDNXTR
	FROM
		HSIUSRFLE.FBACKRPT1
')

--
--------------------------------------------------------------------------------
-- create Integration.FBACKRPT1_backorder
--------------------------------------------------------------------------------
--drop TABLE [fg].[backorder_FBACKRPT1_history]
CREATE TABLE [fg].[backorder_FBACKRPT1_history](
	[SalesDay] [date] NOT NULL,
	[SDDOCO_salesorder_number] [int] NOT NULL,
	[SDDCTO_order_type] [char](2) NOT NULL,
	[SDLNID_line_number] [int] NOT NULL,

	[SDDOC__document_number] [numeric](8, 0) NOT NULL,
	[SDSHAN_shipto] [int] NOT NULL,
	[SDLITM_item_number] [char](10) NOT NULL,
	[QN$SPC_supplier_code] [char](6) NOT NULL,
	[QCTRDJ_order_date] [date] NOT NULL,
	[SDUPRC_unit_price] [money] NOT NULL,
	[SDSOBK_quantity_backordered] [int] NOT NULL,
	[SDUORG_quantity] [int] NOT NULL,
	[IMBUYR_buyer_number] [int] NOT NULL,
	[SDDSC1_description] [varchar](20) NOT NULL,
	[QV$PRI_pricing_info] [varchar](20) NOT NULL,
	[QV$AVC_availability_code] [char](1) NOT NULL,
	[QV$CLC_classification_code] [char](3) NOT NULL,
	[SDSHAN01_mailing_name] [varchar](20) NOT NULL,
	[GIADDZ_postal_code] [char](10) NOT NULL,
	[GICTY1_city] [varchar](25) NOT NULL,
	[GIADDS_state] [char](3) NOT NULL,
	[GICTR__country] [char](3) NOT NULL,
	[QCAC10_division_code] [char](3) NOT NULL,
	[SDLNTY_line_type] [char](2) NOT NULL,
	[IMLNTY_line_type] [char](2) NOT NULL,
	[SDMCU__business_unit] [char](12) NOT NULL,
	[SDVR01_reference] [varchar](25) NOT NULL,
	[SDVR02_reference_2] [varchar](25) NOT NULL,
	[QCENTB_entered_by] [char](10) NOT NULL,
	[SDRSDJ_promised_delivery] [date] NULL,
	[SDNXTR_status_code_next] [char](3) NOT NULL
	,[ID] [int] IDENTITY(1,1) NOT NULL
) ON [USERDATA]
GO
--
BEGIN TRANSACTION
GO
ALTER TABLE fg.backorder_FBACKRPT1_history ADD CONSTRAINT
	fg_backorder_FBACKRPT1_history_c_pk PRIMARY KEY CLUSTERED 
	(
	SalesDay,
	SDDOCO_salesorder_number,
	SDDCTO_order_type,
	SDLNID_line_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
CREATE UNIQUE NONCLUSTERED INDEX fg_backorder_FBACKRPT1_history_idx_1 ON fg.backorder_FBACKRPT1_history
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE fg.backorder_FBACKRPT1_history SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- RI
BEGIN TRANSACTION
GO
ALTER TABLE fg.backorder_FBACKRPT1_history ADD CONSTRAINT
	FK_backorder_FBACKRPT1_history_BRS_SalesDay FOREIGN KEY
	(
	SalesDay
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDay
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.backorder_FBACKRPT1_history ADD CONSTRAINT
	FK_backorder_FBACKRPT1_history_BRS_TransactionDW_Ext FOREIGN KEY
	(
	SDDOCO_salesorder_number,
	SDDCTO_order_type
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber,
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.backorder_FBACKRPT1_history ADD CONSTRAINT
	FK_backorder_FBACKRPT1_history_BRS_Customer FOREIGN KEY
	(
	SDSHAN_shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.backorder_FBACKRPT1_history ADD CONSTRAINT
	FK_backorder_FBACKRPT1_history_BRS_Item FOREIGN KEY
	(
	SDLITM_item_number
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.backorder_FBACKRPT1_history ADD CONSTRAINT
	FK_backorder_FBACKRPT1_history_BRS_ItemSupplier FOREIGN KEY
	(
	QN$SPC_supplier_code
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.backorder_FBACKRPT1_history SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/*
-- prod ready format (add ID after)
SELECT

	(SELECT MAX(QCTRDJ_order_date) FROM Integration.FBACKRPT1_backorder_Staging) AS SalesDay
	,SDDOCO_salesorder_number
	,SDDCTO_order_type
	,SDLNID_line_number
	,SDDOC__document_number

	,SDSHAN_shipto
	,SDLITM_item_number
	,QN$SPC_supplier_code
	,QCTRDJ_order_date

	,SDUPRC_unit_price
	,SDSOBK_quantity_backordered
	,SDUORG_quantity

	,IMBUYR_buyer_number
	,SDDSC1_description
	,QV$PRI_pricing_info
	,QV$AVC_availability_code
	,QV$CLC_classification_code

	,SDSHAN01_mailing_name
	,GIADDZ_postal_code
	,GICTY1_city
	,GIADDS_state
	,GICTR__country
	,QCAC10_division_code

	,SDLNTY_line_type
	,IMLNTY_line_type
	,SDMCU__business_unit
	,SDVR01_reference
	,SDVR02_reference_2
	,QCENTB_entered_by
	,SDRSDJ_promised_delivery
	,SDNXTR_status_code_next

	INTO fg.backorder_FBACKRPT1_history
FROM
	Integration.FBACKRPT1_backorder_Staging

WHERE
	(SDSOBK_quantity_backordered <> 0) AND
	(SDLNTY_line_type <> 'MS') AND
	(QCAC10_division_code <> 'AZA') AND
	(1=1)

*/

--truncate table fg.backorder_FBACKRPT1_history
-- populdate (test)

-- prod ready format (add ID after)

INSERT INTO BRS_TransactionDW_Ext
                         (SalesOrderNumber, DocType)
SELECT DISTINCT SDDOCO_salesorder_number, SDDCTO_order_type
FROM            Integration.FBACKRPT1_backorder_Staging AS s
WHERE
	(SDSOBK_quantity_backordered <> 0) AND 
	(SDLNTY_line_type <> 'MS') AND 
	(QCAC10_division_code <> 'AZA') AND 
--	(1=1)
	(NOT EXISTS
				(SELECT        *
				FROM            BRS_TransactionDW_Ext AS d
				WHERE        (s.SDDOCO_salesorder_number = d.SalesOrderNumber) AND (s.SDDCTO_order_type = d.DocType))
	) 
GO

SELECT
	distinct SDDOCO_salesorder_number, SDDCTO_order_type
FROM
	Integration.FBACKRPT1_backorder_Staging s

WHERE
	(SDSOBK_quantity_backordered <> 0) AND
	(SDLNTY_line_type <> 'MS') AND
	(QCAC10_division_code <> 'AZA') AND
	NOT EXISTS (SELECT * FROM [dbo].[BRS_TransactionDW_Ext] d where s.SDDOC__document_number = d.SalesOrderNumber AND s.SDDCTO_order_type = d.DocType) AND
	(1=1)

-- fix priv -- add this to cust full load
INSERT INTO nes.[privileges]
(privileges_code, privileges_descr)
SELECT DISTINCT PrivilegesCode, ''
FROM            STAGE_BRS_CustomerFull AS s
WHERE        (PrivilegesCode IS NOT NULL) AND (NOT EXISTS
                             (SELECT        privileges_code, privileges_descr, privileges_key, priority_code, pma_ind
                               FROM            nes.[privileges] AS d
                               WHERE        (privileges_code = s.PrivilegesCode)))

SELECT
	distinct s.PrivilegesCode
FROM
	[dbo].[STAGE_BRS_CustomerFull] s
where s.PrivilegesCode is not null and not exists(select * from [nes].[privileges] d where d.privileges_code = s.PrivilegesCode)

--truncate table fg.backorder_FBACKRPT1_history
INSERT INTO fg.backorder_FBACKRPT1_history
                         (SalesDay, SDDOCO_salesorder_number, SDDCTO_order_type, SDLNID_line_number, SDDOC__document_number, SDSHAN_shipto, SDLITM_item_number, QN$SPC_supplier_code, QCTRDJ_order_date, SDUPRC_unit_price, 
                         SDSOBK_quantity_backordered, SDUORG_quantity, IMBUYR_buyer_number, SDDSC1_description, QV$PRI_pricing_info, QV$AVC_availability_code, QV$CLC_classification_code, SDSHAN01_mailing_name, 
                         GIADDZ_postal_code, GICTY1_city, GIADDS_state, GICTR__country, QCAC10_division_code, SDLNTY_line_type, IMLNTY_line_type, SDMCU__business_unit, SDVR01_reference, SDVR02_reference_2, QCENTB_entered_by, 
                         SDRSDJ_promised_delivery, SDNXTR_status_code_next)
SELECT        (SELECT        MAX(QCTRDJ_order_date) AS SalesDay
                          FROM            Integration.FBACKRPT1_backorder_Staging) AS SalesDay, SDDOCO_salesorder_number, SDDCTO_order_type, SDLNID_line_number * 1000, SDDOC__document_number, SDSHAN_shipto, SDLITM_item_number, 
                         QN$SPC_supplier_code, QCTRDJ_order_date, SDUPRC_unit_price, SDSOBK_quantity_backordered, SDUORG_quantity, IMBUYR_buyer_number, SDDSC1_description, QV$PRI_pricing_info, QV$AVC_availability_code, 
                         QV$CLC_classification_code, SDSHAN01_mailing_name, GIADDZ_postal_code, GICTY1_city, GIADDS_state, GICTR__country, QCAC10_division_code, SDLNTY_line_type, IMLNTY_line_type, SDMCU__business_unit, 
                         SDVR01_reference, SDVR02_reference_2, QCENTB_entered_by, SDRSDJ_promised_delivery, SDNXTR_status_code_next
FROM            Integration.FBACKRPT1_backorder_Staging AS FBACKRPT1_backorder_Staging_1
WHERE        (SDSOBK_quantity_backordered <> 0) AND (SDLNTY_line_type <> 'MS') AND (QCAC10_division_code <> 'AZA') AND (1 = 1)
--





