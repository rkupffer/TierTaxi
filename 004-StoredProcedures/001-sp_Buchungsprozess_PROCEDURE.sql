USE TierTaxi;
GO

-- =============================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================

CREATE OR ALTER PROCEDURE sp_Buchungsprozess
	@KundenID int,
--	@TierID int,
--	@AuftragsID int,
	-----
	@Erfolg bit OUTPUT, -- geklappt oder nicht
--	@vorhanden bit OUTPUT, -- Tier am Standort oder nicht
	@Feedback NVARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	-- Hilfsvariable definieren
	-- DECLARE @CheckResult AS bit;
	DECLARE @counter int;
	DECLARE @tier_id int;
	DECLARE @CheckResult bit;

	BEGIN TRY 
		-- ========================================================================
		-- Ist der Kunde vorhanden?
		-- Falls nicht, wirf einen Fehler
		-- ========================================================================
		
		SET @CheckResult =
		(
		SELECT Kunden_ID
		FROM tb_Kunden
		WHERE Kunden_ID = @KundenID
		)

		IF @CheckResult IS NULL

			THROW 50001,'FEHLER: Diese KundenID ist uns nicht bekannt!',1;

		-- ========================================================================
		-- Ist das Tier vorhanden?
		-- Auftragsstatus 2: genehmigt oder Auftragsstatus 7: abgelehnt 
		-- ========================================================================

		-- auf Tabellenwertfunktion zugreifen und ueberpruefen, wie viele Tiere am Standort verfuegbar sind
		SET @counter =
		(
		SELECT COUNT(Tier)
		FROM tf_Verfuegbarkeit_Tier(@KundenID)
		)

		SET @tier_id =
		(
		SELECT TOP (1) Tier_ID
		FROM tf_Verfuegbarkeit_Tier(@KundenID)
		)

		IF @counter=0 -- kein Tier verfuegbar -> Auftrag ablehnen
			INSERT INTO dbo.tb_Auftraege
			([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
			VALUES (@KundenID, 7, NULL, NULL, NULL);

		ELSE
			INSERT INTO dbo.tb_Auftraege
			([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
			VALUES (@KundenID, 2, @tier_id, NULL, NULL);
		
	END TRY 

	BEGIN CATCH
		SET @Erfolg = 0; -- nicht geklappt--
		-- 	@Feedback text OUTPUT --Fehlermeldungen etc.
		SET @Feedback = 
			ERROR_MESSAGE() + CHAR(10)-- Zeilenumbruch
			+ 'Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER()) + CHAR(10)
			+ 'Prozedur: '  + ERROR_PROCEDURE() + CHAR(10)
			+ 'Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());
	END CATCH; 
END
GO
