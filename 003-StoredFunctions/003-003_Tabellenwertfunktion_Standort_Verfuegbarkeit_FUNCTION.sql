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
-- Tier frei ist, dass das Gewicht des Kunden 
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
SELECT  dbo.tb_Kunden.Kunden_ID, 
		dbo.tb_Kunden.Kundengewicht, 
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort',
		dbo.tb_Standort.Standort, 
		dbo.tb_Tier.Tier, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort', 
		dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tierart.Tierart, 
        dbo.tb_Tierart.Arbeitszeit_Max
FROM         dbo.tb_Kunden INNER JOIN
                         dbo.tb_Standort ON dbo.tb_Kunden.Standort_ID = dbo.tb_Standort.Standort_ID INNER JOIN
                         dbo.tb_Tier ON dbo.tb_Standort.Standort_ID = dbo.tb_Tier.Standort_ID INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID
WHERE	dbo.tb_Kunden.Kunden_ID = @Kunden_ID
AND		dbo.tb_Kunden.Kundengewicht < dbo.tb_Tierart.Mitnahmegewicht
)
GO
