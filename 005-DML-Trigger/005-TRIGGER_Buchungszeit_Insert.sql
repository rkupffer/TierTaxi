-- Trigger erstellen
CREATE OR ALTER TRIGGER trg_Buchungszeit_Insert
ON [dbo].[tb_Auftraege]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Neue Zeilen in Tabelle2 einfügen für alle Datensätze,
    -- bei denen Buchungszeit von NULL auf einen Wert geändert wurde
    INSERT INTO [dbo].[tb_Rechnung] (
        Auftrags_ID,			-- ID aus Tabelle1 =Auftraege
        Gesamtdauer,			-- Die neue Buchungszeit
		FutterkostenProStunde,
		Kunden_ID
       
    )
    SELECT 
        i.Auftrags_ID,           -- ID aus der eingefügten/geänderten Zeile
        i.Gesamtdauer,          -- Die neue Buchungszeit
		i.FutterkostenProStunde,
		i.Kunde_ID

    FROM inserted i
    INNER JOIN deleted d ON i.Auftrags_ID = d.Auftrags_ID  -- Vergleich alte vs. neue Werte
    WHERE 
        d.Gesamtdauer IS NULL           -- Vorher war NULL
        AND i.Gesamtdauer IS NOT NULL;  -- Jetzt ist ein Wert gesetzt
        
 
END;

