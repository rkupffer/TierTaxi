USE [master]
GO
/****** Object:  Database [TierTaxi]    Script Date: 26.05.2025 10:11:22 ******/
CREATE DATABASE [TierTaxi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TierTaxi', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2022\MSSQL\DATA\TierTaxi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TierTaxi_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2022\MSSQL\DATA\TierTaxi.mdf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TierTaxi] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TierTaxi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TierTaxi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TierTaxi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TierTaxi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TierTaxi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TierTaxi] SET ARITHABORT OFF 
GO
ALTER DATABASE [TierTaxi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TierTaxi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TierTaxi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TierTaxi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TierTaxi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TierTaxi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TierTaxi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TierTaxi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TierTaxi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TierTaxi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TierTaxi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TierTaxi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TierTaxi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TierTaxi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TierTaxi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TierTaxi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TierTaxi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TierTaxi] SET RECOVERY FULL 
GO
ALTER DATABASE [TierTaxi] SET  MULTI_USER 
GO
ALTER DATABASE [TierTaxi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TierTaxi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TierTaxi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TierTaxi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TierTaxi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TierTaxi] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TierTaxi', N'ON'
GO
ALTER DATABASE [TierTaxi] SET QUERY_STORE = ON
GO
ALTER DATABASE [TierTaxi] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TierTaxi]
GO
/****** Object:  Table [dbo].[tb_Auftraege]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Auftraege](
	[Auftrags_ID] [int] IDENTITY(1,1) NOT NULL,
	[Kunde_ID] [int] NOT NULL,
	[Zeiteinheit] [tinyint] NOT NULL,
	[Auftagsstatus_ID] [int] NOT NULL,
	[Futterkosten_ID] [int] NOT NULL,
	[Tier_ID] [int] NOT NULL,
 CONSTRAINT [PK_tb_Auftraege] PRIMARY KEY CLUSTERED 
(
	[Auftrags_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Auftragsstatus]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  Table [dbo].[tb_Futterkategorie]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Futterkategorie](
	[Futterkategorie_ID] [int] IDENTITY(1,1) NOT NULL,
	[Futterkategorie] [nchar](10) NULL,
 CONSTRAINT [PK_tb_Futterkategorie] PRIMARY KEY CLUSTERED 
(
	[Futterkategorie_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Futterkosten]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Futterkosten](
	[Futterkosten_ID] [int] IDENTITY(1,1) NOT NULL,
	[KostenProStunde] [tinyint] NOT NULL,
	[Futtertyp_ID] [int] NULL,
	[Futterkategorie_ID] [int] NULL,
 CONSTRAINT [PK_tb_Futterkosten] PRIMARY KEY CLUSTERED 
(
	[Futterkosten_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Futtertyp]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Futtertyp](
	[Futtertyp_ID] [int] IDENTITY(1,1) NOT NULL,
	[Futtertyp] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tb_Futtertyp] PRIMARY KEY CLUSTERED 
(
	[Futtertyp_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Kunden]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Kunden](
	[Kunden_ID] [int] IDENTITY(1,1) NOT NULL,
	[KundenVorname] [nchar](30) NULL,
	[KundenNachname] [nchar](30) NULL,
	[Kundengewicht] [tinyint] NULL,
	[Telefonnummer] [nchar](30) NULL,
 CONSTRAINT [PK_tb_Kunden] PRIMARY KEY CLUSTERED 
(
	[Kunden_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Standort]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Standort](
	[Standort_ID] [int] IDENTITY(1,1) NOT NULL,
	[Standort] [nchar](30) NULL,
 CONSTRAINT [PK_tb_standort] PRIMARY KEY CLUSTERED 
(
	[Standort_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Tier]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Tier](
	[Tier_ID] [int] NOT NULL,
	[Tier] [nchar](10) NOT NULL,
	[Tierart_ID] [int] NULL,
	[Tap_ID] [int] NULL,
	[Standort_ID] [int] NULL,
 CONSTRAINT [PK_tb_Tier] PRIMARY KEY CLUSTERED 
(
	[Tier_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Tierart]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Tierart](
	[Tierart_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tierart] [nchar](20) NOT NULL,
	[Geschwindigkeit] [tinyint] NOT NULL,
	[Mitnahmegewicht] [tinyint] NOT NULL,
	[Arbeitszeit_Max] [tinyint] NOT NULL,
	[Transportweg_ID] [int] NOT NULL,
	[Futterkategorie_ID] [int] NOT NULL,
	[TapFrequenz] [tinyint] NOT NULL,
 CONSTRAINT [PK_tb_Tierart] PRIMARY KEY CLUSTERED 
(
	[Tierart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Tierarztprotokoll]    Script Date: 26.05.2025 10:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Tierarztprotokoll](
	[Tap_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tap] [bit] NULL,
 CONSTRAINT [PK_tb_Tierarztprotokoll] PRIMARY KEY CLUSTERED 
(
	[Tap_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Transportwege]    Script Date: 26.05.2025 10:11:22 ******/
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
ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Auftragsstatus] FOREIGN KEY([Auftagsstatus_ID])
REFERENCES [dbo].[tb_Auftragsstatus] ([Auftragsstatus_ID])
GO
ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Auftragsstatus]
GO
ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Futterkosten] FOREIGN KEY([Futterkosten_ID])
REFERENCES [dbo].[tb_Futterkosten] ([Futterkosten_ID])
GO
ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Futterkosten]
GO
ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Kunden] FOREIGN KEY([Kunde_ID])
REFERENCES [dbo].[tb_Kunden] ([Kunden_ID])
GO
ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Kunden]
GO
ALTER TABLE [dbo].[tb_Auftraege]  WITH CHECK ADD  CONSTRAINT [FK_tb_Auftraege_tb_Tier] FOREIGN KEY([Tier_ID])
REFERENCES [dbo].[tb_Tier] ([Tier_ID])
GO
ALTER TABLE [dbo].[tb_Auftraege] CHECK CONSTRAINT [FK_tb_Auftraege_tb_Tier]
GO
ALTER TABLE [dbo].[tb_Futterkosten]  WITH CHECK ADD  CONSTRAINT [FK_tb_Futterkosten_tb_Futterkategorie] FOREIGN KEY([Futterkategorie_ID])
REFERENCES [dbo].[tb_Futterkategorie] ([Futterkategorie_ID])
GO
ALTER TABLE [dbo].[tb_Futterkosten] CHECK CONSTRAINT [FK_tb_Futterkosten_tb_Futterkategorie]
GO
ALTER TABLE [dbo].[tb_Futterkosten]  WITH CHECK ADD  CONSTRAINT [FK_tb_Futterkosten_tb_Futtertyp] FOREIGN KEY([Futtertyp_ID])
REFERENCES [dbo].[tb_Futtertyp] ([Futtertyp_ID])
GO
ALTER TABLE [dbo].[tb_Futterkosten] CHECK CONSTRAINT [FK_tb_Futterkosten_tb_Futtertyp]
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
ALTER TABLE [dbo].[tb_Tierart]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tierart_tb_Futterkategorie] FOREIGN KEY([Futterkategorie_ID])
REFERENCES [dbo].[tb_Futterkategorie] ([Futterkategorie_ID])
GO
ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [FK_tb_Tierart_tb_Futterkategorie]
GO
ALTER TABLE [dbo].[tb_Tierart]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tierart_tb_Transportwege] FOREIGN KEY([Transportweg_ID])
REFERENCES [dbo].[tb_Transportwege] ([Transportwege_ID])
GO
ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [FK_tb_Tierart_tb_Transportwege]
GO
USE [master]
GO
ALTER DATABASE [TierTaxi] SET  READ_WRITE 
GO
