USE [TierTaxi]
GO

/****** Object:  Table [dbo].[Auftraege]    Script Date: 23.05.2025 15:38:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[tb_Auftraege]
CREATE TABLE [dbo].[tb_Auftraege](
	[Auftrags_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kunde_ID] [int] NOT NULL,
	[Zeiteinheit] [tinyint] NOT NULL,
	[Auftagsstatus_ID] [int] NOT NULL,
	[Futterkosten] [tinyint] NOT NULL,
	[Tier_ID] [int] NOT NULL,
 CONSTRAINT [PK_tb_Auftraege] PRIMARY KEY CLUSTERED 
(
	[Auftrags_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


