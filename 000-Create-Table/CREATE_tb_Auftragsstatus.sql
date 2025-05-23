USE [Tiertransport]
GO

/****** Object:  Table [dbo].[tb_Auftragsstatus]    Script Date: 23.05.2025 15:51:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Auftragsstatus](
	[Auftragsstatus_ID] [int] IDENTITY(1,1) NOT NULL,
	[Auftagsstatus] [nchar](20) NULL,
	[Auftrags_ID] [int] NULL
) ON [PRIMARY]
GO


