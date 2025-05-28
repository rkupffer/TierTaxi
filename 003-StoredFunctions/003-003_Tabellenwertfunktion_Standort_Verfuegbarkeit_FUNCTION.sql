USE TierTaxi
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Wenn ein Kunde ein Tier buchen will muss 
-- geprüft wernden, ob an dem Standort noch ein
-- Tier frei ist, das das Gewicht des Kunden 
-- transportieren kann.
-- =============================================
CREATE OR ALTER FUNCTION tf_Verfuegbarkeit_Tier
(	
	@Kunden_ID int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT  dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort',   
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort', 
		dbo.tb_Kunden.Kundengewicht, 
		dbo.tb_Kunden.Kunde_ID
FROM    dbo.tb_Tier 
			INNER JOIN
				dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID 
			CROSS JOIN
				dbo.tb_Kunden
WHERE	dbo.tb_Kunden.Kundengewicht < dbo.tb_Tierart.Mitnahmegewicht
AND		Kunde_ID = @Kunden_ID
AND		dbo.tb_Tier.Standort_ID =
		(
		SELECT 	dbo.tb_Kunden.Standort_ID
		FROM	[dbo].[tb_Kunden]
		WHERE	Kunde_ID = @Kunden_ID
		)
AND		dbo.tb_Tier.Tap_ID = 1
)
GO
