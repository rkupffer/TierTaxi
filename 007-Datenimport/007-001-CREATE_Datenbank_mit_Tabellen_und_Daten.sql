USE [master]
GO
/****** Object:  Database [TierTaxi]    Script Date: 29.05.2025 10:53:19 ******/
CREATE DATABASE [TierTaxi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TierTaxi', FILENAME = N'C:\SQL-Kurs\SQL-Projektbezeichnung-Name-Vorname-UMBENENNEN!\GitHub Scripts\TierTaxi\001-DB-Create-Scripts.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TierTaxi_log', FILENAME = N'C:\SQL-Kurs\SQL-Projektbezeichnung-Name-Vorname-UMBENENNEN!\GitHub Scripts\TierTaxi\001-DB-Create-Scripts_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  UserDefinedFunction [dbo].[sf_Tap_bestanden]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Hat Tier X den letzten TAP bestanden?
-- =============================================
CREATE   FUNCTION [dbo].[sf_Tap_bestanden]
(
	@Tier_ID int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable
	DECLARE @bestanden bit;

	-- T-SQL statements to compute the return value
	SET @bestanden =
	(
	SELECT   dbo.tb_Tierarztprotokoll.Tap
	FROM     dbo.tb_Tierarztprotokoll INNER JOIN
                     dbo.tb_Tier ON dbo.tb_Tierarztprotokoll.Tap_ID = dbo.tb_Tier.Tap_ID
	WHERE Tier_ID = @Tier_ID
	);

	-- Return the result of the function
	RETURN @bestanden

END
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Tier_in_Durchfuehrung]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Funktion soll nur Tiere ausgeben, die sich
-- momentan nicht in Durchfuehrung befinden.
-- =============================================
CREATE   FUNCTION [dbo].[sf_Tier_in_Durchfuehrung]
(
	@Tier_ID int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @in_Durchfuehrung bit;
	DECLARE @hilfsvariable int;

	SET @hilfsvariable =
	(
	SELECT   dbo.tb_Auftraege.Auftragsstatus_ID 
	FROM     dbo.tb_Auftraege
	WHERE	 Tier_ID = @Tier_ID
	)

	-- T-SQL statements to compute the return value
	IF (@hilfsvariable = 3)
		SET @in_Durchfuehrung = 1
	ELSE
		SET @in_Durchfuehrung = 0

	-- Return the result of the function
	RETURN @in_Durchfuehrung

END
GO
/****** Object:  Table [dbo].[tb_Futterkosten]    Script Date: 29.05.2025 10:53:19 ******/
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
/****** Object:  Table [dbo].[tb_Tierart]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Tierart](
	[Tierart_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tierart] [nchar](20) NOT NULL,
	[Geschwindigkeit] [tinyint] NOT NULL,
	[Mitnahmegewicht] [tinyint] NOT NULL,
	[Futterkosten_ID] [money] NOT NULL,
	[TapFrequenz] [tinyint] NOT NULL,
 CONSTRAINT [PK_tb_Tierart] PRIMARY KEY CLUSTERED 
(
	[Tierart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Futtertyp]    Script Date: 29.05.2025 10:53:19 ******/
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
/****** Object:  Table [dbo].[tb_Tier]    Script Date: 29.05.2025 10:53:19 ******/
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
/****** Object:  UserDefinedFunction [dbo].[tf_Futterpraeferenz]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- TierID eingeben und Futterpraeferenz ausgeben
-- =============================================
CREATE   FUNCTION [dbo].[tf_Futterpraeferenz]
(	
	@Tierart nchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT		dbo.tb_Tier.Tier_ID, 
				dbo.tb_Tier.Tier, 
				dbo.tb_Tierart.Tierart, 
				dbo.tb_Futtertyp.Futtertyp
	FROM         dbo.tb_Tierart INNER JOIN
                         dbo.tb_Tier ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID INNER JOIN
                         dbo.tb_Futterkosten ON dbo.tb_Tierart.Futterkosten_ID = dbo.tb_Futterkosten.Futterkosten_ID INNER JOIN
                         dbo.tb_Futtertyp ON dbo.tb_Futterkosten.Futtertyp_ID = dbo.tb_Futtertyp.Futtertyp_ID
	WHERE dbo.tb_Tierart.Tierart = @Tierart
)
GO
/****** Object:  Table [dbo].[tb_Futtermenge]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Futtermenge](
	[Futtermenge_ID] [int] IDENTITY(1,1) NOT NULL,
	[Futtermenge] [nchar](10) NOT NULL,
 CONSTRAINT [PK_tb_Futterkategorie] PRIMARY KEY CLUSTERED 
(
	[Futtermenge_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Futter]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Futter]
AS
SELECT        dbo.tb_Tierart.Tierart, dbo.tb_Futterkosten.KostenProStunde, dbo.tb_Futtermenge.Futtermenge, dbo.tb_Futtertyp.Futtertyp
FROM            dbo.tb_Futterkosten INNER JOIN
                         dbo.tb_Futtermenge ON dbo.tb_Futterkosten.Futtermenge_ID = dbo.tb_Futtermenge.Futtermenge_ID INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Futterkosten.Futterkosten_ID = dbo.tb_Tierart.Futterkosten_ID INNER JOIN
                         dbo.tb_Futtertyp ON dbo.tb_Futterkosten.Futtertyp_ID = dbo.tb_Futtertyp.Futtertyp_ID
GO
/****** Object:  Table [dbo].[tb_Standort]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Standort](
	[Standort_ID] [int] IDENTITY(1,1) NOT NULL,
	[Standort] [nchar](30) NOT NULL,
 CONSTRAINT [PK_tb_standort] PRIMARY KEY CLUSTERED 
(
	[Standort_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Count_Tier_per_Standort]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Count_Tier_per_Standort]
AS
SELECT   COUNT(dbo.tb_Tier.Tier_ID) AS 'Anzahl', dbo.tb_Standort.Standort
FROM     dbo.tb_Tier INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID
					INNER JOIN
                         dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID
GROUP BY dbo.tb_Standort.Standort;
GO
/****** Object:  Table [dbo].[tb_Auftraege]    Script Date: 29.05.2025 10:53:19 ******/
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
/****** Object:  Table [dbo].[tb_Kunden]    Script Date: 29.05.2025 10:53:19 ******/
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
/****** Object:  View [dbo].[View_Tier-Auftraege]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Tier-Auftraege]
AS
SELECT  dbo.tb_Kunden.KundenVorname, dbo.tb_Kunden.KundenNachname, dbo.tb_Tier.Tier AS 'TierName', dbo.tb_Auftraege.DatumUhrzeitStart, dbo.tb_Auftraege.DatumUhrzeitEnde
FROM    dbo.tb_Kunden INNER JOIN
                 dbo.tb_Auftraege ON dbo.tb_Kunden.Kunden_ID = dbo.tb_Auftraege.Kunde_ID FULL OUTER JOIN
		         dbo.tb_Tier ON dbo.tb_Auftraege.Tier_ID = dbo.tb_Tier.Tier_ID
GO
/****** Object:  View [dbo].[View_Tiere_Standort_Gewicht]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Tiere_Standort_Gewicht]
AS
SELECT        dbo.tb_Standort.Standort, dbo.tb_Tier.Tier, dbo.tb_Tierart.Mitnahmegewicht, dbo.tb_Kunden.KundenVorname, dbo.tb_Kunden.Kundengewicht
FROM            dbo.tb_Standort INNER JOIN
                         dbo.tb_Tier ON dbo.tb_Standort.Standort_ID = dbo.tb_Tier.Standort_ID INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID INNER JOIN
                         dbo.tb_Kunden ON dbo.tb_Standort.Standort_ID = dbo.tb_Kunden.Standort_ID
GO
/****** Object:  View [dbo].[View_Tier-Eigenschaften]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Tier-Eigenschaften]
AS
SELECT        dbo.tb_Tier.Tier, dbo.tb_Tierart.Tierart, dbo.tb_Tierart.Geschwindigkeit, dbo.tb_Tierart.Mitnahmegewicht, dbo.tb_Tierart.Arbeitszeit_Max, dbo.tb_Transportwege.Transportweg, dbo.tb_Standort.Standort
FROM            dbo.tb_Tier INNER JOIN
                         dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID INNER JOIN
                         dbo.tb_Transportwege ON dbo.tb_Tierart.Transportweg_ID = dbo.tb_Transportwege.Transportwege_ID INNER JOIN
                         dbo.tb_Standort ON dbo.tb_Tier.Standort_ID = dbo.tb_Standort.Standort_ID

GO
/****** Object:  UserDefinedFunction [dbo].[tf_Verfuegbarkeit_Tier]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Wenn ein Kunde ein Tier buchen will muss 
-- geprüft wernden, ob an dem Standort noch ein
-- Tier frei ist, das das Gewicht des Kunden 
-- transportieren kann.
-- =============================================
CREATE   FUNCTION [dbo].[tf_Verfuegbarkeit_Tier]
(	
	@Kunden_ID int
)
RETURNS TABLE 
AS
RETURN 
(
SELECT  dbo.tb_Tierart.Mitnahmegewicht, 
		dbo.tb_Tier.Tier_ID, 
		dbo.tb_Tier.Tap_ID, 
		dbo.tb_Tier.Standort_ID AS 'TierStandort',   
		dbo.tb_Kunden.Standort_ID AS 'KundenStandort', 
		dbo.tb_Kunden.Kundengewicht, 
		dbo.tb_Kunden.Kunde_ID
FROM    dbo.tb_Tier 
			INNER JOIN
				dbo.tb_Tierart ON dbo.tb_Tier.Tierart_ID = dbo.tb_Tierart.Tierart_ID 
			CROSS JOIN
				dbo.tb_Kunden
WHERE	dbo.tb_Kunden.Kundengewicht < dbo.tb_Tierart.Mitnahmegewicht
AND		Kunde_ID = @Kunden_ID
AND		dbo.tb_Tier.Standort_ID =
		(
		SELECT 	dbo.tb_Kunden.Standort_ID
		FROM	[dbo].[tb_Kunden]
		WHERE	Kunde_ID = @Kunden_ID
		)
AND		dbo.tb_Tier.Tap_ID = 1
)
GO
/****** Object:  Table [dbo].[tb_Auftragsstatus]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Auftragsstatus](
	[Auftragsstatus_ID] [int] IDENTITY(1,1) NOT NULL,
	[Auftagsstatus] [nchar](20) NOT NULL,
 CONSTRAINT [PK_tb_Auftragsstatus] PRIMARY KEY CLUSTERED 
(
	[Auftragsstatus_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Rechnung]    Script Date: 29.05.2025 10:53:19 ******/
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
/****** Object:  Table [dbo].[tb_Tierarztprotokoll]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Tierarztprotokoll](
	[Tap_ID] [int] IDENTITY(1,1) NOT NULL,
	[Tap] [bit] NOT NULL,
 CONSTRAINT [PK_tb_Tierarztprotokoll] PRIMARY KEY CLUSTERED 
(
	[Tap_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_Tierart]    Script Date: 29.05.2025 10:53:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [ix_Tierart] ON [dbo].[tb_Tierart]
(
	[Tierart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[tb_Kunden]  WITH CHECK ADD  CONSTRAINT [FK_tb_Kunden_tb_Standort] FOREIGN KEY([Standort_ID])
REFERENCES [dbo].[tb_Standort] ([Standort_ID])
GO
ALTER TABLE [dbo].[tb_Kunden] CHECK CONSTRAINT [FK_tb_Kunden_tb_Standort]
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
ALTER TABLE [dbo].[tb_Tierart]  WITH CHECK ADD  CONSTRAINT [FK_tb_Tierart_tb_Futterkosten] FOREIGN KEY([Futterkosten_ID])
REFERENCES [dbo].[tb_Futterkosten] ([Futterkosten_ID])
GO
ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [FK_tb_Tierart_tb_Futterkosten]
GO
/****** Object:  StoredProcedure [dbo].[sp_Buchungsprozess]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================

CREATE   PROCEDURE [dbo].[sp_Buchungsprozess]
	@KundenID int,
	-----
	@Erfolg bit OUTPUT, -- geklappt oder nicht
	@Feedback NVARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;	
	
	-- Hilfsvariable definieren
	DECLARE @CheckResult bit;

	BEGIN TRY 
		-- ========================================================================
		-- Ist der Kunde vorhanden?
		-- Falls nicht, wirf einen Fehler
		-- ========================================================================
		
		SET @CheckResult =
		(
		SELECT	Kunde_ID
		FROM	tb_Kunden
		WHERE	Kunde_ID = @KundenID
		)

		IF @CheckResult IS NULL

			THROW 50001,'FEHLER: Diese KundenID ist uns nicht bekannt!',1;

		ELSE PRINT('Hallo Kunde, Sie sind bereits in unserer Datenbank und können Tiere mieten.')

		-- ========================================================================
		-- Ist ein geeignetes Tier fuer den Kunden vorhanden?
		--		- Tier muss am Kundenstandort sein
		--		- Tier muss Gewicht von Kunden leisten koennen
		--		- Tier muss ueber ein gueltiges TAP verfuegen
		--			--> tf_Verfuegbarkeit_Tier
		-- ========================================================================
		DECLARE @counter int;
		DECLARE @tier_id int;
		DECLARE @i int =1;
		DECLARE @status int;
		DECLARE @Futterkosten money

		-- ========================================================================
		-- Auf Tabellenwertfunktion zugreifen und ueberpruefen, wie viele Tiere am 
		-- Standort verfuegbar sind, die die oben genannten Kriterien erfuellen.
		-- ========================================================================
		SET @counter =
		(
		SELECT COUNT(Tier_ID)
		FROM tf_Verfuegbarkeit_Tier(@KundenID)
		)

		-- ========================================================================
		-- Wenn kein Tier verfuegbar soll eine Fehlermeldung ausgeworfen werden
		-- ========================================================================
		IF @counter = 0
		BEGIN
			INSERT INTO dbo.tb_Auftraege
			([Kunde_ID], [Auftragsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
			VALUES (@KundenID, 7, NULL, NULL, NULL);

			THROW 50002,'FEHLER: Momentan ist kein geeignetes Tier fuer Sie verfuegbar. Bitte fragen Sie zu einem anderen Zeitpunkt erneut nach.', 1;
		END

		-- ========================================================================
		-- Wenn mehrere Tiere am Kundenstandort verfuegbar sind:
		-- ========================================================================
		IF @counter > 1
		BEGIN
			-- ========================================
			-- Ein Tier auswaehlen
			-- ========================================
			WHILE (@i < @counter )
				BEGIN
					-- aktuelle Tier_id auswaehlen
					SELECT	@tier_id = Tier_ID
					FROM	(
						SELECT	Tier_ID, ROW_NUMBER() OVER (ORDER BY Tier_ID) AS RowNum
						FROM	tf_Verfuegbarkeit_Tier(8)
					) as NumberedRows
					WHERE RowNum = @i

					-- Auftragsstatus des Tiers pruefen
					SET @status =
						(
						SELECT [dbo].[sf_Tier_in_Durchfuehrung](@tier_id)
						)

					-- wenn freies Tier gefunden --> While-Schleife verlassen
					IF @status=0
						BREAK

				SET @i = @i + 1

				END -- while schleife

			-- ========================================
			-- Wenn die WHILE Schleife endet und der Status
			-- noch auf 1 steht, sind alle Tiere gerade im
			-- Status "in Durchfuehrung".
			-- --> Kein Tier zum ausleihen verfuegbar.
			-- ========================================
			IF @status = 1
				BEGIN
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftragsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
					VALUES (@KundenID, 7, NULL, NULL, NULL);

					THROW 50003,'FEHLER: Momentan befinden sich alle Tiere in Betrieb. Bitte fragen Sie zu einem anderen Zeitpunkt erneut nach.', 1;
				END

			-- ========================================
			-- Neuen Auftrag anlegen
			-- ========================================
			ELSE
				BEGIN
				 
				SET @Futterkosten = 
				(
				SELECT dbo.tb_Futterkosten.KostenProStunde
				FROM dbo.tb_Futterkosten INNER JOIN
					dbo.tb_Tierart 
				ON dbo.tb_Futterkosten.Futterkosten_ID = dbo.tb_Tierart.Futterkosten_ID INNER JOIN
					dbo.tb_Tier 
				ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID
				WHERE (dbo.tb_Tier.Tier_ID = @tier_id)
				)
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftragsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde],[FutterKostenProStunde])
					VALUES (@KundenID, 3, @tier_id, NULL, NULL,@Futterkosten);

					PRINT('Die Buchung war erfolgreich. Gute Fahrt!')
				END

		END -- if-Abfrage counter>0

		-- ========================================================================
		-- Wenn genau ein geeignetes Tier am Kundenstandort verfuegbar ist.
		-- ========================================================================
		IF @counter=1
			BEGIN
				SET @tier_id =
				(
				SELECT Tier_ID
				FROM tf_Verfuegbarkeit_Tier(@KundenID)
				)
				-- Auftragsstatus des Tiers pruefen
				SET @status =
				(
				SELECT [dbo].[sf_Tier_in_Durchfuehrung](@tier_id)
				)

			-- ========================================
			-- Status=1: "in Durchfuehrung".
			-- --> Kein Tier zum ausleihen verfuegbar.
			-- ========================================
			IF @status = 1
				BEGIN
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftragsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde])
					VALUES (@KundenID, 7, NULL, NULL, NULL);

					THROW 50003,'FEHLER: Momentan befinden sich alle Tiere in Betrieb. Bitte fragen Sie zu einem anderen Zeitpunkt erneut nach.', 1;
				END

			-- ========================================
			-- Neuen Auftrag anlegen
			-- ========================================
			ELSE
				BEGIN
				 
				SET @Futterkosten = 
				(
				SELECT dbo.tb_Futterkosten.KostenProStunde
				FROM dbo.tb_Futterkosten INNER JOIN
					dbo.tb_Tierart 
				ON dbo.tb_Futterkosten.Futterkosten_ID = dbo.tb_Tierart.Futterkosten_ID INNER JOIN
					dbo.tb_Tier 
				ON dbo.tb_Tierart.Tierart_ID = dbo.tb_Tier.Tierart_ID
				WHERE (dbo.tb_Tier.Tier_ID = @tier_id)
				)
					INSERT INTO dbo.tb_Auftraege
					([Kunde_ID], [Auftragsstatus_ID], [Tier_ID], [DatumUhrzeitStart], [DatumUhrzeitEnde],[FutterKostenProStunde])
					VALUES (@KundenID, 3, @tier_id, NULL, NULL,@Futterkosten);

					PRINT('Die Buchung war erfolgreich. Gute Fahrt!')
				END

		END -- if-Abfrage counter=1
		
	END TRY 

	BEGIN CATCH
		SET @Erfolg = 0; -- nicht geklappt--
		-- 	@Feedback text OUTPUT --Fehlermeldungen etc.
		SET @Feedback = 
			ERROR_MESSAGE() + CHAR(10)-- Zeilenumbruch
			+ 'Fehler Nr. ' + CONVERT(varchar, ERROR_NUMBER()) + CHAR(10)
			+ 'Prozedur: '  + ERROR_PROCEDURE() + CHAR(10)
			+ 'Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());
	END CATCH; 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TAP_aktualisieren]    Script Date: 29.05.2025 10:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Die Prozedur soll prüfen, ob das TAP abgelaufen ist
-- Falls abgelaufen --> aendern
-- =============================================
CREATE   PROCEDURE [dbo].[sp_TAP_aktualisieren]
		@Tier_ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @TAPaktuell bit;
	DECLARE @Tabellendatum DATETIME;

	SET @Tabellendatum = 
	(
	SELECT		dbo.tb_Tier.TapDatum
	FROM        dbo.tb_Tier 
	WHERE		dbo.tb_Tier.Tier_ID = @Tier_ID
	)
		
	IF DATEDIFF(month, @Tabellendatum, GETDATE()) > 12
		UPDATE [dbo].[tb_Tier]
		SET [Tap_ID]= 2
		WHERE Tier_ID = @Tier_ID;

END
GO
USE [master]
GO
ALTER DATABASE [TierTaxi] SET  READ_WRITE 
GO
