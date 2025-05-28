USE TierTaxi
GO
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Hat Tier X den letzten TAP bestanden?
-- =============================================
CREATE OR ALTER FUNCTION sf_Tap_bestanden
(
	@Tier_ID int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable
	DECLARE @bestanden bit;

	-- T-SQL statements to compute the return value
	SET @bestanden =
	(
	SELECT   dbo.tb_Tierarztprotokoll.Tap
	FROM     dbo.tb_Tierarztprotokoll INNER JOIN
                     dbo.tb_Tier ON dbo.tb_Tierarztprotokoll.Tap_ID = dbo.tb_Tier.Tap_ID
	WHERE Tier_ID = @Tier_ID
	);

	-- Return the result of the function
	RETURN @bestanden

END
GO

