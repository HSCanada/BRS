-- HSPS comm plan updates, tmc 07 Nov 25

-- linke HSPS default to FSA (forward sort area)

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer_FSA ADD
	hsps_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_Customer_FSA_hsps_salesperson_key_id DEFAULT ''
GO
ALTER TABLE dbo.BRS_Customer_FSA ADD CONSTRAINT
	FK_BRS_Customer_FSA_salesperson_master FOREIGN KEY
	(
	hsps_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer_FSA SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add new HSPS accounts

SELECT TOP (1000) [employee_num]
      ,[master_salesperson_cd]
      ,[salesperson_key_id]
      ,[salesperson_nm]
      ,[comm_plan_id]
      ,[territory_start_dt]
      ,[creation_dt]
      ,[salesperson_master_key]
      ,[note_txt]
      ,[flag_ind]
      ,[CostCenter]
      ,[tracker_ind]
      ,[salary_draw_amt]
      ,[deficit_amt]
      ,[FiscalMonth]
  FROM [comm].[salesperson_master] where comm_plan_id like 'eps%' order by 2

SELECT   employee_num, master_salesperson_cd, salesperson_key_id, salesperson_nm, comm_plan_id, territory_start_dt, creation_dt, note_txt, flag_ind, CostCenter, tracker_ind, salary_draw_amt, deficit_amt, FiscalMonth, sf_adpt_login_score, sf_adpt_created_opps_score, sf_adpt_activity_score, sf_adpt_pastdue_opps_score, 
             sf_adpt_closed_opps_score, sf_opps_equipment_technology_cnt, sf_opps_equipment_technology_amt, sf_opps_cadcam_digitial_imaging_cnt, sf_opps_cadcam_digitial_imaging_amt, sf_opps_merchandise_cnt, sf_opps_merchandise_amt, sf_opps_other_cnt, sf_opps_other_amt, sf_note_dt, adhoc_model_1_text, adhoc_model_2_text, 
             adhoc_model_3_text
FROM     comm.salesperson_master
WHERE   (comm_plan_id = 'EPSGP') AND employee_num not in (3475, 4472) AND (master_salesperson_cd = 'EPWES')

INSERT INTO comm.salesperson_master
             (employee_num, master_salesperson_cd, salesperson_key_id, salesperson_nm, comm_plan_id, territory_start_dt, creation_dt, note_txt, flag_ind, CostCenter, tracker_ind, salary_draw_amt, deficit_amt, FiscalMonth, sf_adpt_login_score, sf_adpt_created_opps_score, sf_adpt_activity_score, sf_adpt_pastdue_opps_score, 
             sf_adpt_closed_opps_score, sf_opps_equipment_technology_cnt, sf_opps_equipment_technology_amt, sf_opps_cadcam_digitial_imaging_cnt, sf_opps_cadcam_digitial_imaging_amt, sf_opps_merchandise_cnt, sf_opps_merchandise_amt, sf_opps_other_cnt, sf_opps_other_amt, sf_note_dt, adhoc_model_1_text, adhoc_model_2_text, 
             adhoc_model_3_text)
SELECT   99914 AS employee_num, 'HSBCW' AS master_salesperson_cd, 'hsps.west' AS salesperson_key_id, 'Willen Sun' as salesperson_nm, comm_plan_id, territory_start_dt, creation_dt, note_txt, flag_ind, CostCenter, tracker_ind, salary_draw_amt, deficit_amt, FiscalMonth, sf_adpt_login_score, sf_adpt_created_opps_score, sf_adpt_activity_score, sf_adpt_pastdue_opps_score, 
             sf_adpt_closed_opps_score, sf_opps_equipment_technology_cnt, sf_opps_equipment_technology_amt, sf_opps_cadcam_digitial_imaging_cnt, sf_opps_cadcam_digitial_imaging_amt, sf_opps_merchandise_cnt, sf_opps_merchandise_amt, sf_opps_other_cnt, sf_opps_other_amt, sf_note_dt, adhoc_model_1_text, adhoc_model_2_text, 
             adhoc_model_3_text
FROM     comm.salesperson_master AS salesperson_master_1
WHERE   (comm_plan_id = 'EPSGP') AND (employee_num NOT IN (3475, 4472)) AND (master_salesperson_cd = 'EPWES')


SELECT   TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup
WHERE   (TerritoryCd = 'EPWES')

-- add new HSPS codes

INSERT INTO BRS_FSC_Rollup
             (TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by)
SELECT   'HSBCW' AS TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup AS BRS_FSC_Rollup_1
WHERE   (TerritoryCd = 'EPWES')
GO

INSERT INTO BRS_FSC_Rollup
             (TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by)
SELECT   'HSBCW' AS TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup AS BRS_FSC_Rollup_1
WHERE   (TerritoryCd = 'EPWES')

INSERT INTO BRS_FSC_Rollup
             (TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by)
SELECT   'HSBCW' AS TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup AS BRS_FSC_Rollup_1
WHERE   (TerritoryCd = 'EPWES')

INSERT INTO BRS_FSC_Rollup
             (TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by)
SELECT   'HSBCW' AS TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup AS BRS_FSC_Rollup_1
WHERE   (TerritoryCd = 'EPWES')

INSERT INTO BRS_FSC_Rollup
             (TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by)
SELECT   'HSBCW' AS TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup AS BRS_FSC_Rollup_1
WHERE   (TerritoryCd = 'EPWES')

INSERT INTO BRS_FSC_Rollup
             (TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by)
SELECT   'HSBCW' AS TerritoryCd, FSCName, Branch, FSCStatusCode, LastReviewDate, StatusCd, AddedDt, FSCRollup, CategoryCode, NoteTxt, FSCNameShort, TS_CategoryCd, group_type, order_taken_by
FROM     BRS_FSC_Rollup AS BRS_FSC_Rollup_1
WHERE   (TerritoryCd = 'EPWES')


  EPWES, EPALB, EPONT, EPTOR, EPQUE, EPJBR, EPWES
  99914, 99912, 99906, 99905, 99911, 99917, 99910

  HSBCW, HSMWP, HSONW, HSONE, HSQBO, HSATL, HSNOR


