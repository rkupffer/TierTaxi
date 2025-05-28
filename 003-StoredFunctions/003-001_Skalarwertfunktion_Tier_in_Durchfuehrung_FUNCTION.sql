USE TierTaxi
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Funktion soll nur Tiere ausgeben, die sich
-- momentan nicht in Durchfuehrung befinden.
-- =============================================
CREATE OR ALTER FUNCTION sf_Tier_in_Durchfuehrung
(
	@Tier_ID int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @in_Durchfuehrung bit;
	DECLARE @hilfsvariable int;

	SET @hilfsvariable =
	(
	SELECT   dbo.tb_Auftraege.Auftragsstatus_ID 
	FROM     dbo.tb_Auftraege
	WHERE	 Tier_ID = @Tier_ID
	)

	-- T-SQL statements to compute the return value
	IF (@hilfsvariable = 3)
		SET @in_Durchfuehrung = 1
	ELSE
		SET @in_Durchfuehrung = 0

	-- Return the result of the function
	RETURN @in_Durchfuehrung

END
GO

