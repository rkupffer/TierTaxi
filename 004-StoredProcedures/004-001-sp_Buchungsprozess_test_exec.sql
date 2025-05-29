USE TierTaxi
GO

SELECT  dbo.tb_Tierart.Tierart, 
		dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tier, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort', 
		dbo.tb_Standort.Standort, 
        dbo.tb_Kunden.Kunde_ID, 
		dbo.tb_Kunden.KundenNachname, 
		dbo.tb_Kunden.Kundengewicht,
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort'
FROM    dbo.tb_Tierart 
		INNER JOIN
			dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID 
		INNER JOIN
			dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID 
		INNER JOIN
			dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID


-- ===================================================================================================
-- Test1: Fehler, wenn der Kunde nicht exsistiert
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
-- Test2: Am Kundenstandort gibt es kein Tier mit gueltigem TAP.
-- ===================================================================================================
SELECT  dbo.tb_Tierart.Tierart, 
		dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tier, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort', 
		dbo.tb_Standort.Standort, 
        dbo.tb_Kunden.Kunde_ID, 
		dbo.tb_Kunden.KundenNachname, 
		dbo.tb_Kunden.Kundengewicht,
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort'
FROM    dbo.tb_Tierart 
		INNER JOIN
			dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID 
		INNER JOIN
			dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID 
		INNER JOIN
			dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID
WHERE	Kunde_ID = 4

-- =======================================

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
-- Test3: Auftrag ablehenen, wenn am Standort kein Tier ist, dass das entsprechende Mitnahmegewicht 
-- leisten kann
-- ===================================================================================================
SELECT  dbo.tb_Tierart.Tierart, 
		dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tier, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort', 
		dbo.tb_Standort.Standort, 
        dbo.tb_Kunden.Kunde_ID, 
		dbo.tb_Kunden.KundenNachname, 
		dbo.tb_Kunden.Kundengewicht,
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort'
FROM    dbo.tb_Tierart 
		INNER JOIN
			dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID 
		INNER JOIN
			dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID 
		INNER JOIN
			dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID
WHERE Kunde_ID = 3

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
-- Test4: Kunde exsistiert und am Standort gibt es ein geeignetes Tier
-- ===================================================================================================
SELECT  dbo.tb_Tierart.Tierart, 
		dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tier, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort', 
		dbo.tb_Standort.Standort, 
        dbo.tb_Kunden.Kunde_ID, 
		dbo.tb_Kunden.KundenNachname, 
		dbo.tb_Kunden.Kundengewicht,
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort'
FROM    dbo.tb_Tierart 
		INNER JOIN
			dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID 
		INNER JOIN
			dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID 
		INNER JOIN
			dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID
WHERE Kunde_ID = 1

-- =======================================

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
-- Test5: Es gibt mehrere Tiere am Kundenstandort, die geeignet und sind.
-- ===================================================================================================
SELECT  dbo.tb_Tierart.Tierart, 
		dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tier, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort', 
		dbo.tb_Standort.Standort, 
        dbo.tb_Kunden.Kunde_ID, 
		dbo.tb_Kunden.KundenNachname, 
		dbo.tb_Kunden.Kundengewicht,
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort'
FROM    dbo.tb_Tierart 
		INNER JOIN
			dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID 
		INNER JOIN
			dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID 
		INNER JOIN
			dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID
WHERE Kunde_ID = 8

-- ===================================================================================================
-- Tier 4 ist aber momentan in einer anderen Buchung --> es soll Tier 12 gewaehlt werden.
-- ===================================================================================================
SELECT	Auftrags_ID,
		Auftragsstatus_ID,
		Tier_ID
FROM	tb_Auftraege
WHERE	Auftragsstatus_ID = 3;

-- =======================================

DECLARE	@Erfolg bit; -- geklappt oder nicht
DECLARE	@Feedback NVARCHAR(MAX); -- Fehlermeldungen etc.

EXEC [dbo].[sp_Buchungsprozess]
	8, -- KundenID
	----------------------- 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;

PRINT @Erfolg;
PRINT @Feedback;
