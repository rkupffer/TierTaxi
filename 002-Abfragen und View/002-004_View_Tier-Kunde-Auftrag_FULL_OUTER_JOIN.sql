USE [TierTaxi]
GO

/****** Object:  View [dbo].[View_Tier-Auftraege]    Script Date: 28.05.2025 17:22:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_Tier-Auftraege]
AS
SELECT  dbo.tb_Kunden.KundenVorname, dbo.tb_Kunden.KundenNachname, dbo.tb_Tier.Tier AS 'TierName', dbo.tb_Auftraege.DatumUhrzeitStart, dbo.tb_Auftraege.DatumUhrzeitEnde
FROM    dbo.tb_Kunden INNER JOIN
                 dbo.tb_Auftraege ON dbo.tb_Kunden.Kunde_ID = dbo.tb_Auftraege.Kunde_ID FULL OUTER JOIN
		         dbo.tb_Tier ON dbo.tb_Auftraege.Tier_ID = dbo.tb_Tier.Tier_ID
GO


