
CREATE TABLE [Integration].[F4104_item_cross_reference_Staging](
	[IVAN8__billto] [numeric](8, 0)  NOT NULL,
	[IVXRT__cross_reference_type_code] [char](2) NOT NULL,
	[IVITM__item_number_short] [numeric](8, 0) NOT NULL,
	[IVEXDJ_expired_date] [date] NOT NULL,
	[IVEFTJ_effective_date] [date] NOT NULL,
	[IVMCU__business_unit] [char](12) NOT NULL,
	[IVCITM_customersupplier_item_number] [char](25) NOT NULL,
	[IVDSC1_description] [char](30) NOT NULL,
	[IVDSC2_description_2] [char](30) NOT NULL,
	[IVALN__search_text_compressed] [char](30) NOT NULL,
	[IVLITM_item_number] [char](25) NOT NULL,
	[IVAITM__3rd_item_number] [char](25) NOT NULL,
	[IVURCD_user_reserved_code] [char](2) NOT NULL,
	[IVURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[IVURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[IVURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[IVURRF_user_reserved_reference] [char](15) NOT NULL,
	[IVUSER_user_id] [char](10) NOT NULL,
	[IVPID__program_id] [char](10) NOT NULL,
	[IVJOBN_work_station_id] [char](10) NOT NULL,
	[IVUPMJ_date_updated] [date] NULL,
	[IVTDAY_time_of_day] [numeric](6, 0) NOT NULL
) ON [USERDATA]


ALTER TABLE Integration.F4104_item_cross_reference_Staging ADD CONSTRAINT
	F4104_item_cross_reference_Staging_pk PRIMARY KEY NONCLUSTERED 
	(
	IVITM__item_number_short
	,[IVXRT__cross_reference_type_code]
	,[IVAN8__billto]
	, [IVCITM_customersupplier_item_number]
	, [IVEXDJ_expired_date]

	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO

