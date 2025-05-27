USE TierTaxi
GO

DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

-- testen, ob man mit der systemprozedur daten in eine tabelle hinzufuegen kann

-- Test1: Auftrag ablehenen, wenn am Standort kein Tier ist, dass das entsprechende Mitnahmegewicht leisten kann
EXEC [dbo].[sp_Buchungsprozess]
	3, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- Test2: Fehler, wenn der Kunde nicht exsistiert
EXEC [dbo].[sp_Buchungsprozess]
	123, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- Test3: Kunde exsistiert und am Standort gibt es ein geeignetes Tier
EXEC [dbo].[sp_Buchungsprozess]
	1, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;
