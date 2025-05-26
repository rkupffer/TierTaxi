USE [TierTaxi]
GO

/****** Object:  View [dbo].[View_Futter]    Script Date: 26.05.2025 17:10:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Futter]
AS
SELECT        dbo.tb_Tierart.Tierart, dbo.tb_Futterkosten.KostenProStunde, dbo.tb_Futtermenge.Futtermenge, dbo.tb_Futtertyp.Futtertyp
FROM            dbo.tb_Futterkosten INNER JOIN
                         dbo.tb_Futtermenge ON dbo.tb_Futterkosten.Futtermenge_ID = dbo.tb_Futtermenge.Futtermenge_ID INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Futterkosten.Futterkosten_ID = dbo.tb_Tierart.Futterkosten_ID INNER JOIN
                         dbo.tb_Futtertyp ON dbo.tb_Futterkosten.Futtertyp_ID = dbo.tb_Futtertyp.Futtertyp_ID
GO
