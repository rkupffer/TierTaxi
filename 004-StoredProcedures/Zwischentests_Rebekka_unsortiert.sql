DECLARE @counter int;

SET @counter =
(
SELECT COUNT(Tier)
FROM tf_Verfuegbarkeit_Tier(2)
);

Print(@counter);


---
DECLARE @tier NCHAR(10);

SET @tier =
(
SELECT TOP (1) Tier_ID
FROM tf_Verfuegbarkeit_Tier(5)
);

Print(@tier);

--
DECLARE @CheckResult bit;

SET @CheckResult =
(
SELECT Kunden_ID
FROM tb_Kunden
WHERE Kunden_ID = 112
)

PRINT(@CheckResult);

IF @CheckResult IS NULL

THROW 50001,'FEHLER',1;