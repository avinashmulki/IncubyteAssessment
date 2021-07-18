USE [LearningDB]
GO

/****** Object: SqlProcedure [dbo].[SP_002_INS_PatientData_To_Country_Tables] Script Date: 7/18/2021 7:59:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Procedure	: [dbo].[SP_002_INS_PatientData_To_Country_Tables]
-- Author		: Avinash
-- Create date	: 07/18/2021
-- Description	: Used to load patient data to country wise tables from staging table
-- Objects		: STG_Patient_Data_Full
-- =============================================

CREATE PROCEDURE [dbo].[SP_002_INS_PatientData_To_Country_Tables]
AS 
BEGIN
	DECLARE country_Cursor CURSOR
	FOR SELECT LTRIM(RTRIM(County)) FROM STG_Patient_Data_Full
	
	DECLARE @countryName VARCHAR(50),
			@SQLInsert NVARCHAR(max)
	
	OPEN country_Cursor
	FETCH NEXT FROM country_Cursor INTO @countryName
	WHILE @@FETCH_STATUS = 0  
	    BEGIN
	        
	         SET @SQLInsert='INSERT INTO Patient_Detail_'+@countryName+'
			(
				[Patient_Name],  
				[Patient_Id] ,   
				[Open_Dt],       
				[Consulted_Dt] , 
				[VAC_ID] ,       
				[Doc_Name],    
				[Patient_State], 
				[Patient_County],
				[Patient_DOB],
				[Flag]
			)
	
			SELECT 
				[Name],    
				[Cust_I],  
				CONVERT(DATETIME,[Open_Dt],112), 
				CONVERT(DATETIME,[Consul_Dt],112),
				[VAC_ID],  
				[DR_Name], 
				[State],    
				[County], 
				CONVERT(DATETIME,SUBSTRING([DOB],5,4)+SUBSTRING([DOB],1,2)+SUBSTRING([DOB],3,2),112),     
				[FLAG]
			FROM STG_Patient_Data_Full 
				WHERE LTRIM(RTRIM(County))= '''+@countryName+''''
	
	
	         EXEC (@SQLInsert)
	               
	        FETCH NEXT FROM country_Cursor INTO @countryName
	    END
	
	CLOSE country_Cursor
	DEALLOCATE country_Cursor
END
