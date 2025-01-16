-- canada_siebel_export_email, tmc, 23 Sept 24

-- drop table [integration].[siebel_export_email]

CREATE TABLE [integration].[siebel_export_email] (
[EMAIL_ADDRESS] nvarchar(255),
[JDE] nvarchar(255),
[BILL_TYPE] nvarchar(255),
[PRACTICE_NAME] nvarchar(255),
[MAIN_PHONE_NO] nvarchar(255),
[FIRST_NAME] nvarchar(255),
[LAST_NAME] nvarchar(255),
[PREFERRED_LANGUAGE] nvarchar(255),
[SALES_DIVISION] nvarchar(255),
[ADDR] nvarchar(255),
[CITY] nvarchar(255),
[PROVINCE] nvarchar(255),
[ZIP] nvarchar(255),
[CONTACT_TYPE] nvarchar(255),
[JOB_ID] nvarchar(255),
[SPECIALITY] nvarchar(255),
[ADS_AND_PROMOS] nvarchar(255),
[PRIV_NUM] nvarchar(255),
[CONTACT_CREATED] nvarchar(255),
[CONTACT_UPDATED] nvarchar(255),
[ID] int identity(1,1) NOT NULL
)
GO

BEGIN TRANSACTION
GO
ALTER TABLE Integration.siebel_export_email ADD CONSTRAINT
	PK_siebel_export_email PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.siebel_export_email SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


truncate table [integration].[siebel_export_email] 

select top 10 * from  [integration].[siebel_export_email] 


select EMAIL_ADDRESS, count(*) from  [integration].[siebel_export_email] 
group by EMAIL_ADDRESS
order by 2 desc