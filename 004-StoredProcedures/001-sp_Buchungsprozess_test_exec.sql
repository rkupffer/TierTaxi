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
