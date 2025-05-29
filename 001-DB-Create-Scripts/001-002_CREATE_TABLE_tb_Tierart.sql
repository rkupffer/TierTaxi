USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Tierart]    Script Date: 29.05.2025 10:31:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Tierart](
	[Tierart_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tierart] [nchar](20) NOT NULL,
	[Geschwindigkeit] [tinyint] NOT NULL,
	[Mitnahmegewicht] [tinyint] NOT NULL,
	[Transportweg_ID] [int] NOT NULL,
	[Futterkosten_ID] [money] NOT NULL,
	[TapFrequenz] [tinyint] NOT NULL,
 CONSTRAINT [PK_tb_Tierart] PRIMARY KEY CLUSTERED 
(
	[Tierart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Tierart]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tierart_tb_Futterkosten] FOREIGN KEY([Futterkosten_ID])
REFERENCES [dbo].[tb_Futterkosten] ([Futterkosten_ID])
GO

ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [FK_tb_Tierart_tb_Futterkosten]
GO

ALTER TABLE [dbo].[tb_Tierart]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tierart_tb_Transportwege] FOREIGN KEY([Transportweg_ID])
REFERENCES [dbo].[tb_Transportwege] ([Transportwege_ID])
GO

ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [FK_tb_Tierart_tb_Transportwege]
GO


