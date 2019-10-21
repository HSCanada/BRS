-- add comm_config data.sql, tmc, 21 Oct 19

-- migrate comm config to main config

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Config ADD
	comm_output_path_txt varchar(255) NOT NULL CONSTRAINT DF_BRS_Config_comm_output_path_txt DEFAULT '',
	comm_log_filepath_txt varchar(255) NOT NULL CONSTRAINT DF_BRS_Config_comm_log_filepath_txt DEFAULT ''
GO
ALTER TABLE dbo.BRS_Config SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

update dbo.BRS_Config
set comm_output_path_txt = 'S:\BR\CommBE\Publish', 
comm_log_filepath_txt = 'S:\BR\CommBE\Publish\CommBE_log.txt'




-- SELECT current_fiscal_yearmo_num, output_path_txt, log_filepath_txt FROM comm_configure

SELECT PriorFiscalMonth AS current_fiscal_yearmo_num, comm_output_path_txt AS output_path_txt, comm_log_filepath_txt AS log_filepath_txt FROM dbo.BRS_Config