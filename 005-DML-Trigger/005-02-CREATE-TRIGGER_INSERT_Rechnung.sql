-- ==================================================================================
-- Abschlussprojekt TierTaxi von Simone Möller, Theresa Dürbeck und Rebekka Kupffer
-- Informationen zu diesem Script: Trigger für wenn das Enddatum und Uhrzeit eingetragen wird, 
-- der Auftragsstatus auf 4 springt
-- Authorin(-nen): 
-- ==================================================================================
USE TierTaxi;
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
	--DECLARE @Futterkosten_ID int;
	--DECLARE @Kunden_ID int;
	--DECLARE @Gesamtdauer int;
	--SET @Futterkosten_ID = [dbo].[tb_Futterkosten].[Futterkosten_ID];
	--SET @Kunden_ID = [dbo].[tb_Auftraege].[Kunde_ID];
	--SET @Gesamtdauer = [dbo].[tb_Auftraege].[Gesamtdauer];

	IF UPDATE(DatumUhrzeitEnde) 
		BEGIN
			UPDATE dbo.tb_Auftraege
			SET Auftragsstatus_ID = 5
			WHERE UPDATE(DatumUhrzeitEnde)
		END
		
		BEGIN
			INSERT INTO dbo.tb_Rechnung
			([Auftragsstatus_ID])
			VALUES (5);
		END
END
GO
