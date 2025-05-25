USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Auftragsstatus]    Script Date: 23.05.2025 21:33:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE IF EXISTS [dbo].[tb_Auftragsstatus];
CREATE TABLE [dbo].[tb_Auftragsstatus](
	[Auftragsstatus_ID] [int] IDENTITY(1,1) NOT NULL,
	[Auftagsstatus] [nchar](20) NULL,
	[Auftrags_ID] [int] NULL,
 CONSTRAINT [PK_tb_Auftragsstatus] PRIMARY KEY CLUSTERED 
(
	[Auftragsstatus_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


