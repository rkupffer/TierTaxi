USE [TierTaxi]
GO

/****** Object:  Trigger [dbo].[trg_Buchungszeit_Insert]    Script Date: 30.05.2025 09:24:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Trigger erstellen
CREATE OR ALTER TRIGGER [dbo].[trg_Buchungszeit_Insert]
ON [dbo].[tb_Auftraege]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Neue Zeilen in Tabelle Rechnung einfügen wenn bei denen Buchungszeit_Ende von NULL auf einen Wert geändert wurde
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

GO

ALTER TABLE [dbo].[tb_Auftraege] ENABLE TRIGGER [trg_Buchungszeit_Insert]
GO


