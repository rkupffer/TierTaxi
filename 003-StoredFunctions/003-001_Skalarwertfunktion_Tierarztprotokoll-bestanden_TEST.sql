-- Test 1: Hat ein bestimmtes Tier bestanden?
-- 0 - ja, 1 - nein
SELECT [dbo].[sf_Tap_bestanden](3) AS 'bestanden?';


-- Test 2: Welche Tiere (ID) haben bestanden und welche nicht?
SELECT   dbo.tb_Tier.Tier_ID, --dbo.tb_Tierarztprotokoll.Tap,
CASE 
WHEN [dbo].[sf_Tap_bestanden](dbo.tb_Tier.Tier_ID) = 1 THEN 'bestanden'
ELSE 'nicht bestanden'
END
AS 'TAP bestanden?'
FROM     dbo.tb_Tierarztprotokoll INNER JOIN
                     dbo.tb_Tier ON dbo.tb_Tierarztprotokoll.Tap_ID = dbo.tb_Tier.Tap_ID
WHERE Tier_ID = dbo.tb_Tier.Tier_ID;