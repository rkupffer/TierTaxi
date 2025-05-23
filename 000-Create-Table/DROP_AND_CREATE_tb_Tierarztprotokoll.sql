USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Tierarztprotokoll]    Script Date: 23.05.2025 21:56:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_Tierarztprotokoll]') AND type in (N'U'))
DROP TABLE [dbo].[tb_Tierarztprotokoll]
GO

/****** Object:  Table [dbo].[tb_Tierarztprotokoll]    Script Date: 23.05.2025 21:56:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Tierarztprotokoll](
	[Tap_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tier_ID] [int] NULL,
 CONSTRAINT [PK_tb_Tierarztprotokoll] PRIMARY KEY CLUSTERED 
(
	[Tap_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


