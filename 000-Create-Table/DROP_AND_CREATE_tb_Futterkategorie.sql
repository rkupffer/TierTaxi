USE [TierTaxi]
GO

/****** Object:  Table [dbo].[Futterkategorie]    Script Date: 23.05.2025 15:40:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[tb_Futterkategorie]
CREATE TABLE [dbo].[tb_Futterkategorie](
	[FutterK_ID] [int] IDENTITY(1,1) NOT NULL,
	[Futterkategorie] [nchar](10) NULL,
 CONSTRAINT [PK_tb_Futterkategorie] PRIMARY KEY CLUSTERED 
(
	[FutterK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


