USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Tierart]    Script Date: 23.05.2025 21:51:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_Tierart]') AND type in (N'U'))
DROP TABLE [dbo].[tb_Tierart]
GO

/****** Object:  Table [dbo].[tb_Tierart]    Script Date: 23.05.2025 21:51:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Tierart](
	[Tierart_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tierart] [nchar](20) NOT NULL,
	[Geschwindigkeit] [tinyint] NOT NULL,
	[Mitnahmegewicht] [tinyint] NOT NULL,
	[Arbeitszeit_Max] [tinyint] NOT NULL,
	[Transportweg_ID] [int] NULL,
	[Futterkategorie_ID] [int] NULL,
 CONSTRAINT [PK_tb_Tierart] PRIMARY KEY CLUSTERED 
(
	[Tierart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


