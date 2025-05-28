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
	-----
	@Erfolg bit OUTPUT, -- geklappt oder nicht
	@Feedback NVARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	-- Hilfsvariable definieren
	DECLARE @CheckResult bit;

	BEGIN TRY 
		-- ========================================================================
		-- Ist der Kunde vorhanden?
		-- Falls nicht, wirf einen Fehler
		-- ========================================================================
		
		SET @CheckResult =
		(
		SELECT	Kunden_ID
		FROM	tb_Kunden
		WHERE	Kunden_ID = @KundenID
		)

		IF @CheckResult IS NULL

			THROW 50001,'FEHLER: Diese KundenID ist uns nicht bekannt!',1;

		ELSE PRINT('Hallo Kunde, Sie sind bereits in unserer Datenbank und können Tiere mieten.')

		-- ========================================================================
		-- Ist ein geeignetes Tier fuer den Kunden vorhanden?
		--		- Tier muss am Kundenstandort sein
		--		- Tier muss Gewicht von Kunden leisten koennen
		--		- Tier muss ueber ein gueltiges TAP verfuegen
		--			--> tf_Verfuegbarkeit_Tier
		-- ========================================================================
		DECLARE @counter int;
		DECLARE @tier_id int;
		DECLARE @i int =1;
		DECLARE @status int;

		-- ========================================================================
		-- Auf Tabellenwertfunktion zugreifen und ueberpruefen, wie viele Tiere am 
		-- Standort verfuegbar sind, die die oben genannten Kriterien erfuellen.
		-- ========================================================================
		SET @counter =
		(
		SELECT COUNT(Tier_ID)
		FROM tf_Verfuegbarkeit_Tier(@KundenID)
		)

		-- ========================================================================
		-- Wenn kein Tier verfuegbar soll eine Fehlermeldung ausgeworfen werden
		-- ========================================================================
		IF @counter = 0
		BEGIN
			INSERT INTO dbo.tb_Auftraege
			([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
			VALUES (@KundenID, 7, NULL, NULL, NULL);

			THROW 50002,'FEHLER: Momentan ist kein geeignetes Tier fuer Sie verfuegbar. Bitte fragen Sie zu einem anderen Zeitpunkt erneut nach.', 1;
		END

		-- ========================================================================
		-- Wenn mehrere Tiere am Kundenstandort verfuegbar sind:
		-- ========================================================================
		IF @counter > 1
		BEGIN
			-- ========================================
			-- Ein Tier auswaehlen
			-- ========================================
			WHILE (@i < @counter )
				BEGIN
					-- aktuelle Tier_id auswaehlen
					SELECT	@tier_id = Tier_ID
					FROM	(
						SELECT	Tier_ID, ROW_NUMBER() OVER (ORDER BY Tier_ID) AS RowNum
						FROM	tf_Verfuegbarkeit_Tier(8)
					) as NumberedRows
					WHERE RowNum = @i

					-- Auftragsstatus des Tiers pruefen
					SET @status =
						(
						SELECT [dbo].[sf_Tier_in_Durchfuehrung](@tier_id)
						)

					-- wenn freies Tier gefunden --> While-Schleife verlassen
					IF @status=0
						BREAK

				SET @i = @i + 1

				END -- while schleife

			-- ========================================
			-- Wenn die WHILE Schleife endet und der Status
			-- noch auf 1 steht, sind alle Tiere gerade im
			-- Status "in Durchfuehrung".
			-- --> Kein Tier zum ausleihen verfuegbar.
			-- ========================================
			IF @status = 1
				BEGIN
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
					VALUES (@KundenID, 7, NULL, NULL, NULL);

					THROW 50003,'FEHLER: Momentan befinden sich alle Tiere in Betrieb. Bitte fragen Sie zu einem anderen Zeitpunkt erneut nach.', 1;
				END

			-- ========================================
			-- Neuen Auftrag anlegen
			-- ========================================
			ELSE
				BEGIN
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
					VALUES (@KundenID, 2, @tier_id, NULL, NULL);

					PRINT('Die Buchung war erfolgreich. Gute Fahrt!')
				END

			-- ========================================
			-- Aktuelle Auftrags_ID in Variable fuer 
			-- spaeter speichern
			-- ========================================
			DECLARE @auftrags_id int;
			SET @auftrags_id =
			(
			SELECT	[Auftrags_ID]
			FROM	[dbo].[tb_Auftraege]
			WHERE	Kunde_ID = @KundenID
			AND		Auftagsstatus_ID = 2
			)

		END -- if-Abfrage counter>0

		-- ========================================================================
		-- Wenn genau ein geeignetes Tier am Kundenstandort verfuegbar ist.
		-- ========================================================================
		IF @counter=1
			BEGIN
				SET @tier_id =
				(
				SELECT Tier_ID
				FROM tf_Verfuegbarkeit_Tier(@KundenID)
				)
				-- Auftragsstatus des Tiers pruefen
				SET @status =
				(
				SELECT [dbo].[sf_Tier_in_Durchfuehrung](@tier_id)
				)

			-- ========================================
			-- Status=1: "in Durchfuehrung".
			-- --> Kein Tier zum ausleihen verfuegbar.
			-- ========================================
			IF @status = 1
				BEGIN
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
					VALUES (@KundenID, 7, NULL, NULL, NULL);

					THROW 50003,'FEHLER: Momentan befinden sich alle Tiere in Betrieb. Bitte fragen Sie zu einem anderen Zeitpunkt erneut nach.', 1;
				END

			-- ========================================
			-- Neuen Auftrag anlegen
			-- ========================================
			ELSE
				BEGIN
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftagsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
					VALUES (@KundenID, 2, @tier_id, NULL, NULL);

					PRINT('Die Buchung war erfolgreich. Gute Fahrt!')
				END

		END -- if-Abfrage counter=1
		
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
