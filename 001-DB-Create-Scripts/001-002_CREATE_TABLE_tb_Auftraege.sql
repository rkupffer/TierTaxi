USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Auftraege]    Script Date: 29.05.2025 10:25:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Auftraege](
	[Auftrags_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kunde_ID] [int] NOT NULL,
	[Auftragsstatus_ID] [int] NOT NULL,
	[Tier_ID] [int] NULL,
	[DatumUhrzeitStart] [datetime] NULL,
	[DatumUhrzeitEnde] [datetime] NULL,
	[Gesamtdauer]  AS (datediff(minute,[DatumUhrzeitStart],[DatumUhrzeitEnde])) PERSISTED,
	[FutterKostenProStunde] [money] NULL,
 CONSTRAINT [PK_tb_Auftraege] PRIMARY KEY CLUSTERED 
(
	[Auftrags_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Auftragsstatus] FOREIGN KEY([Auftragsstatus_ID])
REFERENCES [dbo].[tb_Auftragsstatus] ([Auftragsstatus_ID])
GO

ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Auftragsstatus]
GO

ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Kunden] FOREIGN KEY([Kunde_ID])
REFERENCES [dbo].[tb_Kunden] ([Kunde_ID])
GO

ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Kunden]
GO

ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Tier] FOREIGN KEY([Tier_ID])
REFERENCES [dbo].[tb_Tier] ([Tier_ID])
GO

ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Tier]
GO


