-- ==============================================================
-- An dieser Stelle im Buchungsprozess setzt der Trigger an:
-- Ein Kunde hat bereits ein Tier ausgeliehen und beendet die Buchung. 
-- Wenn die Endzeit der Buchung in die Tabelle Auftraege eingetragen
-- berechnet sich automatisch die Gesamtdauer (berechnete Spalte)
-- und es wird (ausgelöst durch diesen Trigger) eine Zeile in der 
-- Tabelle Rechnung mit den entsprechenden Daten angelegt.
-- ==============================================================

CREATE OR ALTER TRIGGER trg_Buchungszeit_Insert
ON [dbo].[tb_Auftraege]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Neue Zeilen in Rechnung einfügen für alle Datensätze,
    -- bei denen Buchungszeit von NULL auf einen Wert geändert wurde
    INSERT INTO [dbo].[tb_Rechnung] (
        Auftrags_ID,			
        Gesamtdauer,			
		FutterkostenProStunde,
		Kunden_ID
       
    )
    SELECT 
        i.Auftrags_ID,           
        i.Gesamtdauer,         
		i.FutterkostenProStunde,
		i.Kunde_ID

    FROM inserted i
    INNER JOIN deleted d ON i.Auftrags_ID = d.Auftrags_ID  -- Vergleich alte vs. neue Werte
    WHERE 
        d.Gesamtdauer IS NULL           -- Vorher war NULL
        AND i.Gesamtdauer IS NOT NULL;  -- Jetzt ist ein Wert gesetzt
        
 
END;

