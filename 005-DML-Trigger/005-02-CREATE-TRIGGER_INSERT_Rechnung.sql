-- ==================================================================================
-- Abschlussprojekt TierTaxi von Simone M�ller, Theresa D�rbeck und Rebekka Kupffer
-- Informationen zu diesem Script: Trigger f�r wenn das Enddatum und Uhrzeit eingetragen wird, 
-- der Auftragsstatus auf 4 springt
-- Authorin(-nen): 
-- ==================================================================================
USE TierTaxi;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER [tr_AuftragsstatusUpdate] 
   ON [TierTaxi].[dbo].[tb_Auftraege]
   FOR UPDATE 
AS 
	BEGIN

			INSERT INTO [dbo].[AuftragsLog]
			(mode, ,[Auftragsstatus_ID])
			VALUES ('U',5);
	END

GO


CREATE OR ALTER TRIGGER Neue_Rechnung_Nach_status_change
 ON [dbo].[tb_Auftraege]
	AFTER UPDATE 
	AS
	BEGIN
		DECLARE  @zeit int;
		
		SET @zeit = (select [Auftrags_ID] from inserted)
		IF @zeit <> NULL 
        -- Neue Zeile in Tabelle2 einf�gen
        INSERT INTO  dbo.tb_Rechnung ([Auftragsstatus_ID])
			VALUES (5);
	END
GO

CREATE OR ALTER TRIGGER Neue_Rechnung_Nach_status_change
 ON [dbo].[tb_Auftraege]
	AFTER UPDATE 
	AS
	BEGIN
		--DECLARE  @zeit_old int;
		DECLARE  @zeit_new int;

		--SET @zeit_old = (select [Gesamtdauer] from [dbo].[tb_Auftraege])
		SET @zeit_new = (select [Auftrags_ID] from inserted)

		-- �berpr�fen, ob der Status ge�ndert wurde
		IF @zeit_new <> NULL 
	
        -- Neue Zeile in Tabelle2 einf�gen
        INSERT INTO  dbo.tb_Rechnung ([Auftragsstatus_ID])
			VALUES (5);

		--ELSE SET @zeit_new = NULL
	END
 
GO
	 

