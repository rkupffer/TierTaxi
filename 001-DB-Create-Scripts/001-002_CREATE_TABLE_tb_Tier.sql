USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Tier]    Script Date: 29.05.2025 10:31:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Tier](
	[Tier_ID] [int] NOT NULL,
	[Tier] [nchar](10) NOT NULL,
	[Tierart_ID] [int] NOT NULL,
	[Tap_ID] [int] NOT NULL,
	[Standort_ID] [int] NOT NULL,
	[TapDatum] [date] NULL,
 CONSTRAINT [PK_tb_Tier] PRIMARY KEY CLUSTERED 
(
	[Tier_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Tier]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tier_tb_Standort] FOREIGN KEY([Standort_ID])
REFERENCES [dbo].[tb_Standort] ([Standort_ID])
GO

ALTER TABLE [dbo].[tb_Tier] CHECK CONSTRAINT [FK_tb_Tier_tb_Standort]
GO

ALTER TABLE [dbo].[tb_Tier]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tier_tb_Tierart] FOREIGN KEY([Tierart_ID])
REFERENCES [dbo].[tb_Tierart] ([Tierart_ID])
GO

ALTER TABLE [dbo].[tb_Tier] CHECK CONSTRAINT [FK_tb_Tier_tb_Tierart]
GO

ALTER TABLE [dbo].[tb_Tier]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tier_tb_Tierarztprotokoll] FOREIGN KEY([Tap_ID])
REFERENCES [dbo].[tb_Tierarztprotokoll] ([Tap_ID])
GO

ALTER TABLE [dbo].[tb_Tier] CHECK CONSTRAINT [FK_tb_Tier_tb_Tierarztprotokoll]
GO


