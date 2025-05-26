USE [TierTaxi]
GO

/****** Object:  View [dbo].[View_Tiere_Standort_Gewicht]    Script Date: 26.05.2025 17:08:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Tiere_Standort_Gewicht]
AS
SELECT        dbo.tb_Standort.Standort, dbo.tb_Tier.Tier, dbo.tb_Tierart.Mitnahmegewicht, dbo.tb_Kunden.KundenVorname, dbo.tb_Kunden.Kundengewicht
FROM            dbo.tb_Standort INNER JOIN
                         dbo.tb_Tier ON dbo.tb_Standort.Standort_ID = dbo.tb_Tier.Standort_ID INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID
GO