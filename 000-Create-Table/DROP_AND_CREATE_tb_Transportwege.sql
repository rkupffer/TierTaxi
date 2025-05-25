USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Transportwege]    Script Date: 23.05.2025 21:58:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tb_Transportwege]') AND type in (N'U'))
DROP TABLE [dbo].[tb_Transportwege]
GO

/****** Object:  Table [dbo].[tb_Transportwege]    Script Date: 23.05.2025 21:58:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Transportwege](
	[Transportwege_ID] [int] IDENTITY(1,1) NOT NULL,
	[Transportweg] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tb_Transportwege] PRIMARY KEY CLUSTERED 
(
	[Transportwege_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


