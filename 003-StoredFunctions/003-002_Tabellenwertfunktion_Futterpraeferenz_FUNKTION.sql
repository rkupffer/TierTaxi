USE TierTaxi
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- TierID eingeben und Futterpraeferenz ausgeben
-- =============================================
CREATE OR ALTER FUNCTION tf_Futterpraeferenz
(	
	@Tierart nchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT		dbo.tb_Tier.Tier_ID, 
				dbo.tb_Tier.Tier, 
				dbo.tb_Tierart.Tierart, 
				dbo.tb_Futtertyp.Futtertyp
	FROM         dbo.tb_Tierart INNER JOIN
                         dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID INNER JOIN
                         dbo.tb_Futterkosten ON dbo.tb_Tierart.Futterkosten_ID = dbo.tb_Futterkosten.Futterkosten_ID INNER JOIN
                         dbo.tb_Futtertyp ON dbo.tb_Futterkosten.Futtertyp_ID = dbo.tb_Futtertyp.Futtertyp_ID
	WHERE dbo.tb_Tierart.Tierart = @Tierart
)
GO
