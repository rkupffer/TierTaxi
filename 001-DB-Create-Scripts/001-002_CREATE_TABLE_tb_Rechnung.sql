USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Rechnung]    Script Date: 29.05.2025 10:30:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Rechnung](
	[Rechnung_ID] [int] IDENTITY(1,1) NOT NULL,
	[FutterkostenProStunde] [money] NULL,
	[Kunden_ID] [int] NULL,
	[Gesamtdauer] [int] NULL,
	[Auftrags_ID] [int] NULL,
	[Gesamtkosten] [int] NULL,
 CONSTRAINT [PK_tb_Rechnung] PRIMARY KEY CLUSTERED 
(
	[Rechnung_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Rechnung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Rechnung_tb_Auftraege] FOREIGN KEY([Auftrags_ID])
REFERENCES [dbo].[tb_Auftraege] ([Auftrags_ID])
GO

ALTER TABLE [dbo].[tb_Rechnung] CHECK CONSTRAINT [FK_tb_Rechnung_tb_Auftraege]
GO

ALTER TABLE [dbo].[tb_Rechnung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Rechnung_tb_Futterkosten] FOREIGN KEY([FutterkostenProStunde])
REFERENCES [dbo].[tb_Futterkosten] ([Futterkosten_ID])
GO

ALTER TABLE [dbo].[tb_Rechnung] CHECK CONSTRAINT [FK_tb_Rechnung_tb_Futterkosten]
GO

ALTER TABLE [dbo].[tb_Rechnung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Rechnung_tb_Kunden] FOREIGN KEY([Kunden_ID])
REFERENCES [dbo].[tb_Kunden] ([Kunde_ID])
GO

ALTER TABLE [dbo].[tb_Rechnung] CHECK CONSTRAINT [FK_tb_Rechnung_tb_Kunden]
GO


