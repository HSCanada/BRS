--drop TABLE [Integration].[F5554240_fg_redeem_finalize_Staging]

CREATE TABLE [Integration].[F5554240_fg_redeem_finalize_Staging](
	[ID] [int] NOT NULL,
	[CalMonthRedeem] [int] NOT NULL,
	[WK$SPC_supplier_code] [char](6) NOT NULL,
	[WKDOCO_salesorder_number] [int] NOT NULL,
	[WKSHAN_shipto] [int] NOT NULL,
	[WKLITM_item_number] [char](10) NOT NULL,
	[fg_redeem_ind] [char](1) NOT NULL,
	[fg_offer_id] [int] NOT NULL,
	[fg_exempt_cd] [char](6) NOT NULL,
	[fg_offer_note] [varchar](255) NOT NULL,
	[OriginalSalesOrderNumber] [int] NOT NULL,
	[WKECST_extended_cost] [money] NULL,
	[WKCRCD_currency_code] [char](3) NULL,
	[status_code] [smallint] NOT NULL,
 CONSTRAINT [Integration_F5554240_fg_redeem_finalize_Staging_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [Integration].[F5554240_fg_redeem_finalize_Staging] ADD  DEFAULT ((-1)) FOR [status_code]
GO


--

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	fg_offer_note2 varchar(255) NULL
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE fg.transaction_F5554240
set fg_offer_note2 = fg_offer_note

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240
	DROP COLUMN fg_offer_note
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
EXECUTE sp_rename N'fg.transaction_F5554240.fg_offer_note2', N'Tmp_fg_offer_note', 'COLUMN' 
GO
EXECUTE sp_rename N'fg.transaction_F5554240.Tmp_fg_offer_note', N'fg_offer_note', 'COLUMN' 
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
