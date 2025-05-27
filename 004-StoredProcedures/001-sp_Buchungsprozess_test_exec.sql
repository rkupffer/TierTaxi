USE TierTaxi
GO

-- ===================================================================================================
-- Test1: Auftrag ablehenen, wenn am Standort kein Tier ist, dass das entsprechende Mitnahmegewicht leisten kann
-- ===================================================================================================
DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	3, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- ===================================================================================================
-- Test2: Fehler, wenn der Kunde nicht exsistiert
-- ===================================================================================================
DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	123, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- ===================================================================================================
-- Test3: Kunde exsistiert und am Standort gibt es ein geeignetes Tier
-- ===================================================================================================
DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	1, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- ===================================================================================================
-- Test4: Kunde exsistiert und am Standort gibt es ein geeignetes Tier 
	--> Tier hat aber kein gültiges TAP
-- ===================================================================================================
DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	4, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- ===================================================================================================
-- Test5: Kunde exsistiert und am Standort gibt es ein geeignetes Tier, das ein gueltiges TAP hat,
-- UND: das Tier befindet sich NICHT in einem anderen Auftrag
	--> Wir der Auftragsstatus korrekt in die Tabelle Auftraege uebernommen?
-- ===================================================================================================
DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	1, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;

-- ===================================================================================================
-- Test6: Kunde exsistiert und am Standort gibt es ein geeignetes Tier, das ein gueltiges TAP hat,
-- UND: das Tier befindet sich in einem anderen Auftrag
	--> Korrekter Fehler?
-- ===================================================================================================
DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	4, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;