USE TierTaxi
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Die Prozedur soll prüfen, ob das TAP abgelaufen ist
-- Falls abgelaufen --> aendern
-- =============================================
CREATE OR ALTER PROCEDURE sp_TAP_aktualisieren
		@Tier_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TAPaktuell bit;
	DECLARE @Tabellendatum DATETIME;

	SET @Tabellendatum = 
	(
	SELECT		dbo.tb_Tier.TapDatum
	FROM        dbo.tb_Tier 
	WHERE		dbo.tb_Tier.Tier_ID = @Tier_ID
	)
		
	IF DATEDIFF(month, @Tabellendatum, GETDATE()) > 12
		UPDATE [dbo].[tb_Tier]
		SET [Tap_ID]= 2
		WHERE Tier_ID = @Tier_ID;

END
GO


