-- ==============================================================
-- Test des Triggers trg_Buchungszeit_Insert
-- ==============================================================

USE TierTaxi;
GO

UPDATE [dbo].[tb_Auftraege]
SET [DatumUhrzeitEnde] = '2025-07-07 12:00:00'
WHERE [Auftrags_ID] = 23;