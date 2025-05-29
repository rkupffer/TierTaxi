USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Kunden]    Script Date: 29.05.2025 10:30:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Kunden](
	[Kunde_ID] [int] IDENTITY(1,1) NOT NULL,
	[KundenVorname] [nchar](30) NOT NULL,
	[KundenNachname] [nchar](30) NOT NULL,
	[Kundengewicht] [tinyint] NOT NULL,
	[Telefonnummer] [nchar](30) NOT NULL,
	[Standort_ID] [int] NOT NULL,
 CONSTRAINT [PK_tb_Kunden] PRIMARY KEY CLUSTERED 
(
	[Kunde_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Kunden]  WITH CHECK ADD  CONSTRAINT [FK_tb_Kunden_tb_Standort] FOREIGN KEY([Standort_ID])
REFERENCES [dbo].[tb_Standort] ([Standort_ID])
GO

ALTER TABLE [dbo].[tb_Kunden] CHECK CONSTRAINT [FK_tb_Kunden_tb_Standort]
GO


