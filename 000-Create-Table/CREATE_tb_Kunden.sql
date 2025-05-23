USE [Tiertransport]
GO

/****** Object:  Table [dbo].[Kunden]    Script Date: 23.05.2025 15:49:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kunden](
	[Kunden_ID] [int] IDENTITY(1,1) NOT NULL,
	[KundenVorname] [nchar](30) NULL,
	[KundenNachname] [nchar](30) NULL,
	[Kundengewicht] [tinyint] NULL,
	[Telefonnummer] [tinyint] NULL,
 CONSTRAINT [PK_Kunden] PRIMARY KEY CLUSTERED 
(
	[Kunden_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


