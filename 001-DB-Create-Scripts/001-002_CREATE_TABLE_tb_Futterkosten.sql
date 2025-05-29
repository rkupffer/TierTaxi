USE [TierTaxi]
GO

/****** Object:  Table [dbo].[tb_Futterkosten]    Script Date: 29.05.2025 10:29:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Futterkosten](
	[Futterkosten_ID] [money] NOT NULL,
	[KostenProStunde] [money] NULL,
	[Futtertyp_ID] [int] NOT NULL,
	[Futtermenge_ID] [int] NOT NULL,
 CONSTRAINT [PK_tb_Futterkosten] PRIMARY KEY CLUSTERED 
(
	[Futterkosten_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_Futterkosten]  WITH CHECK ADD  CONSTRAINT [FK_tb_Futterkosten_tb_Futterkategorie] FOREIGN KEY([Futtermenge_ID])
REFERENCES [dbo].[tb_Futtermenge] ([Futtermenge_ID])
GO

ALTER TABLE [dbo].[tb_Futterkosten] CHECK CONSTRAINT [FK_tb_Futterkosten_tb_Futterkategorie]
GO

ALTER TABLE [dbo].[tb_Futterkosten]  WITH CHECK ADD  CONSTRAINT [FK_tb_Futterkosten_tb_Futtertyp] FOREIGN KEY([Futtertyp_ID])
REFERENCES [dbo].[tb_Futtertyp] ([Futtertyp_ID])
GO

ALTER TABLE [dbo].[tb_Futterkosten] CHECK CONSTRAINT [FK_tb_Futterkosten_tb_Futtertyp]
GO


