USE [TierTaxi]
GO

/****** Object:  View [dbo].[View_Tier-Eigenschaften]    Script Date: 26.05.2025 17:05:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Tier-Eigenschaften]
AS
SELECT        dbo.tb_Tier.Tier, dbo.tb_Tierart.Tierart, dbo.tb_Tierart.Geschwindigkeit, dbo.tb_Tierart.Mitnahmegewicht, dbo.tb_Tierart.Arbeitszeit_Max, dbo.tb_Transportwege.Transportweg, dbo.tb_Standort.Standort
FROM            dbo.tb_Tier INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID INNER JOIN
                         dbo.tb_Transportwege ON dbo.tb_Tierart.Transportweg_ID = dbo.tb_Transportwege.Transportwege_ID INNER JOIN
                         dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID

GO