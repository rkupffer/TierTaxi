USE [master]
GO

/****** Object:  Database [TierTaxi]    Script Date: 29.05.2025 10:47:46 ******/
CREATE DATABASE [TierTaxi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TierTaxi', FILENAME = N'C:\SQL-Kurs\SQL-Projektbezeichnung-Name-Vorname-UMBENENNEN!\GitHub Scripts\TierTaxi\001-DB-Create-Scripts.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TierTaxi_log', FILENAME = N'C:\SQL-Kurs\SQL-Projektbezeichnung-Name-Vorname-UMBENENNEN!\GitHub Scripts\TierTaxi\001-DB-Create-Scripts_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
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

ALTER DATABASE [TierTaxi] SET QUERY_STORE = ON
GO

ALTER DATABASE [TierTaxi] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [TierTaxi] SET  READ_WRITE 
GO


