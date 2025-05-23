USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Tier]    Script Date: 23.05.2025 21:42:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_Tier]') AND type in (N'U'))
DROP TABLE [dbo].[tb_Tier]
GO

/****** Object:  Table [dbo].[tb_Tier]    Script Date: 23.05.2025 21:42:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Tier](
	[TierID] [int] NOT NULL,
	[Tier] [nchar](10) NOT NULL,
	[Tierart] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tb_Tier] PRIMARY KEY CLUSTERED 
(
	[TierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


