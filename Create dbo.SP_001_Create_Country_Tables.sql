USE [LearningDB]
GO

/****** Object: SqlProcedure [dbo].[SP_001_Create_Country_Tables] Script Date: 7/18/2021 7:58:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Procedure	: [dbo].[SP_001_Create_Country_Tables]
-- Author		: Avinash
-- Create date	: 07/18/2021
-- Description	: Used to create Country wise tables to load patient details 
-- Objects		: STG_Patient_Data_Full
-- =============================================

CREATE PROCEDURE [dbo].[SP_001_Create_Country_Tables]
AS 
BEGIN
	DECLARE tableName_Cursor CURSOR
	FOR SELECT 'Patient_Detail_'+UPPER(LTRIM(RTRIM(County))) FROM STG_Patient_Data_Full
	
	DECLARE @tblName VARCHAR(50),
			@SQLCreate NVARCHAR(max)
	
	OPEN tableName_Cursor
	FETCH NEXT FROM tableName_Cursor INTO @tblName
	WHILE @@FETCH_STATUS = 0  
	    BEGIN
	        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = @tblName)
	            BEGIN
	                SET @SQLCreate='CREATE TABLE [dbo].['+@tblName+']
	                                (
	                                     [Patient_Name]   VARCHAR (255) NOT NULL,
	                                     [Patient_Id]     VARCHAR (18)  NOT NULL,
	                                     [Open_Dt]        DATETIME      NOT NULL,
	                                     [Consulted_Dt]   DATETIME      NULL,
	                                     [VAC_ID]         VARCHAR (5)   NULL,
	                                     [Doc_Name]       VARCHAR (255) NULL,
	                                     [Patient_State]  VARCHAR (5)   NULL,
	                                     [Patient_County] VARCHAR (5)   NULL,
	                                     [Patient_DOB]    DATETIME      NULL, 
										 [Flag]			  VARCHAR(55)	NULL,
	                                     CONSTRAINT [PK_'+@tblName+'] PRIMARY KEY ([Patient_Name])
	                                 )'
	                EXEC (@SQLCreate) 
	            END
	        FETCH NEXT FROM tableName_Cursor INTO @tblName
	    END
	
	CLOSE tableName_Cursor
	DEALLOCATE tableName_Cursor

END
