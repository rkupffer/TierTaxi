USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Futtermenge]    Script Date: 29.05.2025 10:29:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Futtermenge](
	[Futtermenge_ID] [int] IDENTITY(1,1) NOT NULL,
	[Futtermenge] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tb_Futterkategorie] PRIMARY KEY CLUSTERED 
(
	[Futtermenge_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


