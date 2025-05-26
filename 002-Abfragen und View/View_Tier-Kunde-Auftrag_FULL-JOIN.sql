-- Sicht ueber mehrere Tabellen mit FULL OUTER JOIN
-- auch Tiere anzeigen, die keine Auftraege hatten

SELECT  dbo.tb_Kunden.KundenVorname, dbo.tb_Kunden.KundenNachname, dbo.tb_Tier.Tier AS 'TierName', dbo.tb_Auftraege.DatumUhrzeitStart, dbo.tb_Auftraege.DatumUhrzeitEnde
FROM    dbo.tb_Kunden INNER JOIN
                 dbo.tb_Auftraege ON dbo.tb_Kunden.Kunden_ID = dbo.tb_Auftraege.Kunde_ID FULL OUTER JOIN
		         dbo.tb_Tier ON dbo.tb_Auftraege.Tier_ID = dbo.tb_Tier.Tier_ID