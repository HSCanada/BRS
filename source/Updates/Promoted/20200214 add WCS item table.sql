-- add wcs table, tmc, 15 Feb 20

-- drop table [pricing].[item_wcs_unique_fields_file_F5656]

-- truncate table [pricing].[item_wcs_unique_fields_file_F5656]

CREATE TABLE [pricing].[item_wcs_unique_fields_file_F5656](
	[QVITM__item_number_short] [numeric](8, 0) NOT NULL,

	[QVLITM_item_number] [char](10) NOT NULL,

	[QVAITM__3rd_item_number] [char](25) NOT NULL,
	[QV$AVC_availability_code] [char](1) NOT NULL,
	[QV$RQT_restricted_qty] [numeric](5, 0) NOT NULL,
	[QV$CCD_case_code] [char](1) NOT NULL,
	[QV$CCQ_case_qty] [numeric](5, 0) NOT NULL,
	[QV$ITH_item_height] [numeric](15, 1) NOT NULL,
	[QV$ITW_item_width] [numeric](15, 1) NOT NULL,
	[QV$ITL_item_length] [numeric](15, 1) NOT NULL,
	[QV$IDC_importdomestic] [char](1) NOT NULL,
	[QV$CLC_classification_code] [char](3) NOT NULL,
	[QV$PRI_pricing_info] [char](20) NOT NULL,
	[QV$MMC_mix_match_code] [char](1) NOT NULL,
	[QV$VCD_vendor_code] [char](6) NOT NULL,
	[QV$LCT_location_type] [char](2) NOT NULL,
	[QV$PPL_print_on_pickticket] [char](1) NOT NULL,
	[QV$BKD_backorder_date_JDT] [numeric](6, 0) NOT NULL,
	[QV$ABD_abbr_descr] [char](25) NOT NULL,
	[QV$ASR_abbreviated_strength] [char](7) NOT NULL,
	[QVUSER_user_id] [char](10) NOT NULL,
	[QVPID__program_id] [char](10) NOT NULL,
	[QVJOBN_work_station_id] [char](10) NOT NULL,
	[QVUPMJ_date_updated] [date] NULL,
	[QVTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_item_wcs_unique_fields_file_F5656] PRIMARY KEY CLUSTERED 
(
	[QVITM__item_number_short] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX item_wcs_unique_fields_file_F5656_u_idx_01 ON Pricing.item_wcs_unique_fields_file_F5656
	(
	QVLITM_item_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Pricing.item_wcs_unique_fields_file_F5656 ADD CONSTRAINT
	FK_item_wcs_unique_fields_file_F5656_BRS_Item FOREIGN KEY
	(
	QVLITM_item_number
	) REFERENCES Pricing.item_master_F4101
	(
	IMLITM_item_number
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.item_wcs_unique_fields_file_F5656 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--




INSERT INTO Pricing.item_wcs_unique_fields_file_F5656
                         (QVITM__item_number_short, QVLITM_item_number, QVAITM__3rd_item_number, QV$AVC_availability_code, QV$RQT_restricted_qty, QV$CCD_case_code, QV$CCQ_case_qty, QV$ITH_item_height, QV$ITW_item_width, 
                         QV$ITL_item_length, QV$IDC_importdomestic, QV$CLC_classification_code, QV$PRI_pricing_info, QV$MMC_mix_match_code, QV$VCD_vendor_code, QV$LCT_location_type, QV$PPL_print_on_pickticket, 
                         QV$BKD_backorder_date_JDT, QV$ABD_abbr_descr, QV$ASR_abbreviated_strength, QVUSER_user_id, QVPID__program_id, QVJOBN_work_station_id, QVUPMJ_date_updated, QVTDAY_time_of_day)
SELECT        QVITM__item_number_short, QVLITM_item_number, QVAITM__3rd_item_number, QV$AVC_availability_code, QV$RQT_restricted_qty, QV$CCD_case_code, QV$CCQ_case_qty, QV$ITH_item_height, QV$ITW_item_width, 
                         QV$ITL_item_length, QV$IDC_importdomestic, QV$CLC_classification_code, QV$PRI_pricing_info, QV$MMC_mix_match_code, QV$VCD_vendor_code, QV$LCT_location_type, QV$PPL_print_on_pickticket, 
                         QV$BKD_backorder_date_JDT, QV$ABD_abbr_descr, QV$ASR_abbreviated_strength, QVUSER_user_id, QVPID__program_id, QVJOBN_work_station_id, QVUPMJ_date_updated, QVTDAY_time_of_day
FROM            Integration.F5656_wcs_unique_fields_file_Staging AS s



UPDATE
	Pricing.item_wcs_unique_fields_file_F5656
SET
	QVAITM__3rd_item_number =s.QVAITM__3rd_item_number,
	QV$AVC_availability_code =s.QV$AVC_availability_code,
	QV$RQT_restricted_qty =s.QV$RQT_restricted_qty ,
	QV$CCD_case_code =s.QV$CCD_case_code ,
	QV$CCQ_case_qty =s.QV$CCQ_case_qty ,
	QV$ITH_item_height =s.QV$ITH_item_height ,

	QV$ITW_item_width =s.QV$ITW_item_width ,
	QV$ITL_item_length =s.QV$ITL_item_length ,
	QV$CLC_classification_code =s.QV$CLC_classification_code ,
	QV$PRI_pricing_info =s.QV$PRI_pricing_info ,
	QV$MMC_mix_match_code =s.QV$MMC_mix_match_code ,
	QV$VCD_vendor_code =s.QV$VCD_vendor_code ,
	QV$LCT_location_type =s.QV$LCT_location_type ,
	QV$PPL_print_on_pickticket =s.QV$LCT_location_type ,

	QV$BKD_backorder_date_JDT =s.QV$BKD_backorder_date_JDT ,
	QV$ABD_abbr_descr =s.QV$ABD_abbr_descr ,
	QV$ASR_abbreviated_strength =s.QV$ASR_abbreviated_strength ,
	QVUSER_user_id =s.QVUSER_user_id ,
	QVPID__program_id =s.QVPID__program_id ,
	QVJOBN_work_station_id =s.QVPID__program_id ,
	QVUPMJ_date_updated =s.QVPID__program_id ,
	QVTDAY_time_of_day =s.QVTDAY_time_of_day ,

	QV$IDC_importdomestic = s.QV$IDC_importdomestic

FROM            Pricing.item_wcs_unique_fields_file_F5656 INNER JOIN
                         Integration.F5656_wcs_unique_fields_file_Staging AS s ON Pricing.item_wcs_unique_fields_file_F5656.QVITM__item_number_short = s.QVITM__item_number_short

WHERE
	EXISTS
	(
		Select *
		FROM 
			(SELECT QVITM__item_number_short, CHECKSUM(*) csd FROM [Pricing].item_wcs_unique_fields_file_F5656) AS dd
			INNER JOIN (SELECT QVITM__item_number_short, CHECKSUM(*) css FROM Integration.F5656_wcs_unique_fields_file_Staging) AS ss
			ON dd.QVITM__item_number_short = ss.QVITM__item_number_short AND
				css<>csd AND
				(1=1)
	)
