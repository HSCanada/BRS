-- \\CAHSIONNLSQ03\Backups

USE [master]
RESTORE DATABASE [AccData] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\AccData_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'AccData_Data' TO N'D:\SQLData\AccData_Data.MDF',  MOVE N'AccData_Log' TO N'E:\SQLData\AccData_Log.LDF',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [ar_forms] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\ar_forms_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'ar_forms_Data' TO N'D:\SQLData\ar_forms_Data.MDF',  MOVE N'ar_forms_Log' TO N'E:\SQLData\ar_forms_Log.LDF',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [Asset_Tracker] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\Asset_Tracker_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'Asset_Tracker' TO N'D:\SQLData\Asset_Tracker.mdf',  MOVE N'Asset_Tracker_log' TO N'E:\SQLData\Asset_Tracker_log.ldf',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [AttendanceTracker] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\AttendanceTracker_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'AttendanceTracker' TO N'D:\SQLData\AttendanceTracker.mdf',  MOVE N'AttendanceTracker_log' TO N'E:\SQLData\AttendanceTracker_log.ldf',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [BGAPISettings] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\BGAPISettings_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'BGAPISettings' TO N'D:\SQLData\BGAPISettings.mdf',  MOVE N'BGAPISettings_log' TO N'E:\SQLData\BGAPISettings_log.LDF',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [BGSessions] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\BGSessions_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'BGSessions' TO N'D:\SQLData\BGSessions.mdf',  MOVE N'BGSessions_log' TO N'E:\SQLData\BGSessions_log.LDF',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [DentaCAD] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\DentaCAD_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'DentaCAD' TO N'D:\SQLData\DentaCAD.mdf',  MOVE N'DentaCAD_log' TO N'E:\SQLData\DentaCAD_log.ldf',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [help_desk] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\help_desk_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'help_desk_Data' TO N'D:\SQLData\help_desk_data.mdf',  MOVE N'help_desk_Log' TO N'E:\SQLData\help_desk_log.ldf',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [lansweeperdb] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\lansweeperdb_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'lansweeperdb' TO N'D:\SQLData\lansweeperdb.mdf',  MOVE N'lansweeperdb_log' TO N'E:\SQLData\lansweeperdb_log.LDF',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [MSDSCompare] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\MSDSCompare_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'MSDSCompare' TO N'D:\SQLData\MSDSCompare.mdf',  MOVE N'MSDSCompare_log' TO N'E:\SQLData\MSDSCompare_log.ldf',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [neo_dev] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\neo_dev_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'neo_dev' TO N'D:\SQLData\neo_dev.mdf',  MOVE N'neo_dev_log' TO N'E:\SQLData\neo_dev_log.ldf',  NOUNLOAD,  STATS = 5

GO



USE [master]
RESTORE DATABASE [Offline] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\Offline_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'Offline' TO N'D:\SQLData\Offline.mdf',  MOVE N'Offline_log' TO N'E:\SQLData\Offline_log.ldf',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [Privileges] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\Privileges_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'Privileges' TO N'D:\SQLData\Privileges.mdf',  MOVE N'Privileges_log' TO N'E:\SQLData\Privileges_log.ldf',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [Redemptions] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\Redemptions_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'Redemptions' TO N'D:\SQLData\Redemptions.mdf',  MOVE N'Redemptions_log' TO N'E:\SQLData\Redemptions_log.ldf',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [SmartborderTools] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\SmartborderTools_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'SmartborderTools' TO N'D:\SQLData\SmartborderTools.mdf',  MOVE N'SmartborderTools_log' TO N'E:\SQLData\SmartborderTools_log.ldf',  NOUNLOAD,  STATS = 5

GO


USE [master]
RESTORE DATABASE [SPankyBE] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\SPankyBE_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'SPankyBE_Data' TO N'D:\SQLData\SPankyBE_Data.MDF',  MOVE N'SPankyBE_Log' TO N'E:\SQLData\SPankyBE_Log.LDF',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [Traffic] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\Traffic_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'Traffic' TO N'D:\SQLData\Traffic.mdf',  MOVE N'Traffic_log' TO N'E:\SQLData\Traffic_log.ldf',  NOUNLOAD,  STATS = 5

GO

USE [master]
RESTORE DATABASE [WebApps] FROM  DISK = N'\\CAHSIONNLSQ03\Backups\WebApps_backup_201809081531.bak' WITH  FILE = 1,  MOVE N'WebApps' TO N'D:\SQLData\WebApps.mdf',  MOVE N'WebApps_log' TO N'E:\SQLData\WebApps_log.ldf',  NOUNLOAD,  STATS = 5

GO





