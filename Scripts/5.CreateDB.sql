USE [master]
GO

CREATE DATABASE [DB_PMITG_FGOS]

ALTER DATABASE [DB_PMITG_FGOS] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_PMITG_FGOS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DB_PMITG_FGOS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET ARITHABORT OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET  ENABLE_BROKER 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET RECOVERY FULL 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET  MULTI_USER 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DB_PMITG_FGOS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DB_PMITG_FGOS] SET QUERY_STORE = OFF
GO

ALTER DATABASE [DB_PMITG_FGOS] SET  READ_WRITE 
GO

