USE [LearningDB]
GO

/****** Object: Table [dbo].[STG_Patient_Data_Full] Script Date: 7/18/2021 7:57:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[STG_Patient_Data_Full] (
    [Name]      VARCHAR (255) NULL,
    [Cust_I]    VARCHAR (18)  NULL,
    [Open_Dt]   VARCHAR (15)  NULL,
    [Consul_Dt] VARCHAR (15)  NULL,
    [VAC_ID]    VARCHAR (5)   NULL,
    [DR_Name]   VARCHAR (255) NULL,
    [State]     VARCHAR (5)   NULL,
    [County]    VARCHAR (5)   NULL,
    [DOB]       VARCHAR (15)  NULL,
    [FLAG]      VARCHAR (1)   NULL
);


