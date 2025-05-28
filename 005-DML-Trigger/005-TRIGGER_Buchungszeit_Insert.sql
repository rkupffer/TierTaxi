-- Trigger erstellen
CREATE TRIGGER trg_Buchungszeit_Insert
ON [dbo].[tb_Auftraege]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Neue Zeilen in Tabelle2 einfügen für alle Datensätze,
    -- bei denen Buchungszeit von NULL auf einen Wert geändert wurde
    INSERT INTO [dbo].[tb_Rechnung] (
        Auftrags_ID,        -- ID aus Tabelle1 =Auftraege
        Gesamtdauer       -- Die neue Buchungszeit
       -- Erstellt_Am,        -- Zeitstempel der Trigger-Ausführung
       -- Status              -- Beispiel-Spalte
    )
    SELECT 
        i.Auftrags_ID,           -- ID aus der eingefügten/geänderten Zeile
        i.Gesamtdauer          -- Die neue Buchungszeit
        --GETDATE(),               -- Aktueller Zeitstempel
        --'Neu gebucht'            -- Beispiel-Status
    FROM inserted i
    INNER JOIN deleted d ON i.Auftrags_ID = d.Auftrags_ID  -- Vergleich alte vs. neue Werte
    WHERE 
        d.Gesamtdauer IS NULL           -- Vorher war NULL
        AND i.Gesamtdauer IS NOT NULL;  -- Jetzt ist ein Wert gesetzt
        
    -- Optional: Logging oder weitere Aktionen
  --  IF @@ROWCOUNT > 0
   -- BEGIN
   --     PRINT CAST(@@ROWCOUNT AS VARCHAR(10)) + ' neue Einträge in Tabelle2 erstellt.';
   -- END
END;

-- Beispiel: Trigger testen
/*
-- Testdaten in Tabelle1 einfügen (mit NULL Buchungszeit)
INSERT INTO Tabelle1 (Name, Buchungszeit) VALUES ('Test Entry', NULL);

-- Buchungszeit setzen - sollte den Trigger auslösen
UPDATE Tabelle1 
SET Buchungszeit = GETDATE() 
WHERE Name = 'Test Entry' AND Buchungszeit IS NULL;

-- Prüfen ob Eintrag in Tabelle2 erstellt wurde
SELECT * FROM Tabelle2 WHERE Status = 'Neu gebucht';
*/

-- Trigger löschen (falls nötig):
-- DROP TRIGGER trg_Buchungszeit_Insert;