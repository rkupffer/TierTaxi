-- ==================================================================================
-- Abschlussprojekt TierTaxi von Simone Moeller, Theresa Duerbeck und Rebekka Kupffer
-- Informationen zu diesem Script: Tier Tabelle erstellen
-- Authorin(-nen): Rebekka, Theresa
-- ==================================================================================

USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Tier]    Script Date: 23.05.2025 12:35:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF 
 ( NOT EXISTS 
   (SELECT object_id FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_Tier]'))
 )
BEGIN

CREATE TABLE [dbo].[tb_Tier](
	[TierID] [int] NOT NULL,
	[Tier] [nchar](10) NOT NULL,
	[Tierart] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tb_Tier] PRIMARY KEY CLUSTERED 
(
	[TierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END;
GO
