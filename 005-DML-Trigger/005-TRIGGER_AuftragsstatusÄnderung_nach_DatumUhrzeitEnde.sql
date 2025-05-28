-- ==================================================================================
-- Abschlussprojekt TierTaxi von Simone Möller, Theresa Dürbeck und Rebekka Kupffer
-- Informationen zu diesem Script: 
-- Authorin(-nen): 
-- ==================================================================================USE FirmaUebung;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER [tr_AuftragsstatusUpdate] 
   ON [TierTaxi].[dbo].[tb_Auftraege] 
   FOR UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF UPDATE(DatumUhrzeitStart) 
		BEGIN
			UPDATE dbo.tb_Auftraege
			SET Auftragsstatus_ID = 4
			WHERE UPDATE(DatumUhrzeitStart)
		END
END
GO
