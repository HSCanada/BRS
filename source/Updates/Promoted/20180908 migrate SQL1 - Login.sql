-- logins

USE [master]
GO

/****** Object:  Login [CAHSI\CSchormann]    Script Date: 08-Sep-18 12:30:39 PM ******/
CREATE LOGIN [CAHSI\CSchormann] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

/****** Object:  Login [CAHSI\Gary.Winslow]    Script Date: 08-Sep-18 12:31:11 PM ******/
CREATE LOGIN [CAHSI\Gary.Winslow] FROM WINDOWS WITH DEFAULT_DATABASE=[BRSales], DEFAULT_LANGUAGE=[us_english]
GO

/****** Object:  Login [CAHSI\JLi]    Script Date: 08-Sep-18 12:31:26 PM ******/
CREATE LOGIN [CAHSI\JLi] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

/****** Object:  Login [CAHSI\kansell]    Script Date: 08-Sep-18 12:31:36 PM ******/
CREATE LOGIN [CAHSI\kansell] FROM WINDOWS WITH DEFAULT_DATABASE=[BRSales], DEFAULT_LANGUAGE=[us_english]
GO


/****** Object:  Login [CAHSI\khoa.nguyen]    Script Date: 08-Sep-18 12:31:47 PM ******/
CREATE LOGIN [CAHSI\khoa.nguyen] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

/****** Object:  Login [CAHSI\Lauren.Preston]    Script Date: 08-Sep-18 12:31:58 PM ******/
CREATE LOGIN [CAHSI\Lauren.Preston] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO


/****** Object:  Login [CAHSI\Tina.Duczmal]    Script Date: 08-Sep-18 12:32:08 PM ******/
CREATE LOGIN [CAHSI\Tina.Duczmal] FROM WINDOWS WITH DEFAULT_DATABASE=[BRSales], DEFAULT_LANGUAGE=[us_english]
GO


/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [sisense_user]    Script Date: 08-Sep-18 12:32:51 PM ******/
CREATE LOGIN [sisense_user] WITH PASSWORD=N'XXXX', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

ALTER LOGIN [sisense_user] DISABLE
GO

