-- Sicht ueber mehrere Tabellen mit Count
-- Tiere an den verfuegbaren Standorten zaehlen
USE [TierTaxi]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Count_Tier_per_Standort]
AS
SELECT   COUNT(dbo.tb_Tier.Tier_ID) AS 'Anzahl', dbo.tb_Standort.Standort
FROM     dbo.tb_Tier INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID
					INNER JOIN
                         dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID
GROUP BY dbo.tb_Standort.Standort;
GO