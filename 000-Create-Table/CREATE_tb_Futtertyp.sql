USE [Tiertransport]
GO

/****** Object:  Table [dbo].[tb_Futtertyp]    Script Date: 23.05.2025 15:41:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Futtertyp](
	[Futtertyp_ID] [int] IDENTITY(1,1) NOT NULL,
	[Futtertyp] [nchar](10) NOT NULL,
	[Futterkategorie_ID] [int] NULL
) ON [PRIMARY]
GO


