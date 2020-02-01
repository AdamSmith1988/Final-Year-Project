/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2014 (12.0.2269)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [FinalYear]    Script Date: 01/05/2018 02:56:59 ******/
CREATE DATABASE [FinalYear]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FinalYear', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.NEWSQL\MSSQL\DATA\FinalYear.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FinalYear_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.NEWSQL\MSSQL\DATA\FinalYear_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FinalYear] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FinalYear].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FinalYear] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FinalYear] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FinalYear] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FinalYear] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FinalYear] SET ARITHABORT OFF 
GO
ALTER DATABASE [FinalYear] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FinalYear] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FinalYear] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FinalYear] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FinalYear] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FinalYear] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FinalYear] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FinalYear] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FinalYear] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FinalYear] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FinalYear] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FinalYear] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FinalYear] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FinalYear] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FinalYear] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FinalYear] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FinalYear] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FinalYear] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FinalYear] SET  MULTI_USER 
GO
ALTER DATABASE [FinalYear] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FinalYear] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FinalYear] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FinalYear] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [FinalYear] SET DELAYED_DURABILITY = DISABLED 
GO
USE [FinalYear]
GO
/****** Object:  User [Business_User]    Script Date: 01/05/2018 02:56:59 ******/
CREATE USER [Business_User] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AdamSmith]    Script Date: 01/05/2018 02:56:59 ******/
CREATE USER [AdamSmith] FOR LOGIN [BUILTIN\Users]
GO
ALTER ROLE [db_datareader] ADD MEMBER [AdamSmith]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [AdamSmith]
GO
/****** Object:  Schema [Booking]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Booking]
GO
/****** Object:  Schema [Company]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Company]
GO
/****** Object:  Schema [Customer]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Customer]
GO
/****** Object:  Schema [Equipment]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Equipment]
GO
/****** Object:  Schema [Services]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Services]
GO
/****** Object:  Schema [Staff]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Staff]
GO
/****** Object:  Schema [Stock]    Script Date: 01/05/2018 02:56:59 ******/
CREATE SCHEMA [Stock]
GO
/****** Object:  Table [Booking].[Booking]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Booking].[Booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[CompanyID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[EventID] [int] NULL,
	[Notes] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Booking].[BookingAttendance]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Booking].[BookingAttendance](
	[AttendanceID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Attended] [bit] NOT NULL,
 CONSTRAINT [PK_BookingAttendance] PRIMARY KEY CLUSTERED 
(
	[AttendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Booking].[BookingTime]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Booking].[BookingTime](
	[BookingTime] [int] NOT NULL,
	[BookingID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[TimeStart] [time](7) NOT NULL,
	[Duration] [time](7) NOT NULL,
 CONSTRAINT [PK_BookingTime] PRIMARY KEY CLUSTERED 
(
	[BookingTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Booking].[Cost]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Booking].[Cost](
	[CostID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceID] [int] NOT NULL,
	[Cost] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cost] PRIMARY KEY CLUSTERED 
(
	[CostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Booking].[Invoice]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Booking].[Invoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NOT NULL,
	[CostID] [int] NOT NULL,
	[PaymentMethodID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Paid] [bit] NOT NULL,
	[Thanks] [nvarchar](50) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Booking].[PaymentMethod]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Booking].[PaymentMethod](
	[PaymentMethodID] [int] IDENTITY(1,1) NOT NULL,
	[MethodName] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_PaymentMethod] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Company].[Company]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Company].[Company](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[IndustryID] [int] NOT NULL,
	[CompanyName] [nvarchar](max) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Postcode] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
	[FaxNumber] [nvarchar](max) NOT NULL,
	[Website] [nvarchar](max) NULL,
	[Facebook] [nvarchar](max) NULL,
	[Twitter] [nvarchar](max) NULL,
	[LinkedIn] [nvarchar](max) NULL,
	[RegistrationDate] [datetime] NOT NULL,
	[Location] [geography] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Company].[CompanyOpeningHours]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Company].[CompanyOpeningHours](
	[OpeningTimeID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[DayOfWeek] [int] NOT NULL,
	[OpeningTime] [time](7) NOT NULL,
	[ClosingTime] [time](7) NOT NULL,
	[NotesIfClosed] [nvarchar](max) NULL,
 CONSTRAINT [PK_CompanyOpeningHours] PRIMARY KEY CLUSTERED 
(
	[OpeningTimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Company].[Industry]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Company].[Industry](
	[IndustryID] [int] IDENTITY(1,1) NOT NULL,
	[SectorName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Industry] PRIMARY KEY CLUSTERED 
(
	[IndustryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Customer].[CompanyReviews]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Customer].[CompanyReviews](
	[CompanyReviewsID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comments] [nvarchar](max) NULL,
 CONSTRAINT [PK_CompanyReviews] PRIMARY KEY CLUSTERED 
(
	[CompanyReviewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Customer].[Customer]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Customer].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](40) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Postcode] [nvarchar](10) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[PhoneNumber] [nvarchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[EventID] [int] NOT NULL,
	[BookingID] [int] NULL,
	[Subject] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](300) NOT NULL,
	[Start] [datetime] NOT NULL,
	[End] [datetime] NULL,
	[ThemeColor] [nvarchar](10) NOT NULL,
	[IsFullDay] [bit] NOT NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[EmailID] [varchar](254) NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[Password] [varchar](max) NOT NULL,
	[ConfirmPassword] [varchar](max) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[ActivationCode] [uniqueidentifier] NOT NULL,
	[ResetPasswordCode] [nvarchar](100) NULL,
	[CustomerId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Equipment].[Equiptment]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Equipment].[Equiptment](
	[EquiptmentID] [int] IDENTITY(1,1) NOT NULL,
	[EquiptmentTypeID] [int] NOT NULL,
	[EquiptmentName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Equiptment] PRIMARY KEY CLUSTERED 
(
	[EquiptmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Equipment].[EquiptmentType]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Equipment].[EquiptmentType](
	[EquiptmentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[EquiptmentTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EquiptmentType] PRIMARY KEY CLUSTERED 
(
	[EquiptmentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Services].[EquiptmentNeeded]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Services].[EquiptmentNeeded](
	[EquiptmentNeededID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceID] [int] NOT NULL,
	[EquiptmentID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_EquiptmentNeeded] PRIMARY KEY CLUSTERED 
(
	[EquiptmentNeededID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Services].[Service]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Services].[Service](
	[ServiceID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceTypeID] [int] NOT NULL,
	[ServiceName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Services].[Service_Products]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Services].[Service_Products](
	[ServiceProductsID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceID] [int] NOT NULL,
	[StockID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Services].[ServiceType]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Services].[ServiceType](
	[ServiceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceType] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ServiceType] PRIMARY KEY CLUSTERED 
(
	[ServiceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Staff].[Staff]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[StaffRoleID] [int] NOT NULL,
	[First_Name] [nvarchar](max) NOT NULL,
	[Last_Name] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Staff].[StaffAccess]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[StaffAccess](
	[StaffAccessID] [int] IDENTITY(1,1) NOT NULL,
	[SystemAuthorizationID] [int] NOT NULL,
	[StaffRoleID] [int] NOT NULL,
	[IsAccessible] [bit] NOT NULL,
 CONSTRAINT [PK_StaffAccess] PRIMARY KEY CLUSTERED 
(
	[StaffAccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Staff].[StaffRole]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[StaffRole](
	[StaffRoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_StaffRole] PRIMARY KEY CLUSTERED 
(
	[StaffRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Staff].[SystemAuthorization]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staff].[SystemAuthorization](
	[SystemAuthorizationID] [int] IDENTITY(1,1) NOT NULL,
	[Add_Edit_Del] [nvarchar](50) NOT NULL,
	[AuthorzationName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SystemAuthorization] PRIMARY KEY CLUSTERED 
(
	[SystemAuthorizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Stock].[ProductImage]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stock].[ProductImage](
	[ProductImageID] [int] IDENTITY(1,1) NOT NULL,
	[ProductImageURL] [nvarchar](max) NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_ProductImage] PRIMARY KEY CLUSTERED 
(
	[ProductImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stock].[ProductSuppliers]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stock].[ProductSuppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ContactName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[PostCode] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[URL] [nvarchar](max) NULL,
	[Logo] [nvarchar](max) NULL,
	[Notes] [nvarchar](max) NULL,
	[CurrentOrder] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductSuppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stock].[Stock]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stock].[Stock](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[ProductImageID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ProductStockTypeID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Stock].[StockLevel]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stock].[StockLevel](
	[ProductStockLevelID] [int] IDENTITY(1,1) NOT NULL,
	[StockID] [int] NOT NULL,
	[ProductStockLevel] [int] NOT NULL,
 CONSTRAINT [PK_StockLevel] PRIMARY KEY CLUSTERED 
(
	[ProductStockLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Stock].[StockType]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stock].[StockType](
	[StockTypeID] [int] IDENTITY(1,1) NOT NULL,
	[StockTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_StockType] PRIMARY KEY CLUSTERED 
(
	[StockTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[All_Bookings]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[All_Bookings]
AS
SELECT        Customer.Customer.FirstName, Customer.Customer.LastName, Services.Service.ServiceName, Booking.BookingTime.Date, Booking.BookingTime.TimeStart, Services.ServiceType.ServiceType
FROM            Booking.Booking INNER JOIN
                         Booking.BookingTime ON Booking.Booking.BookingID = Booking.BookingTime.BookingID INNER JOIN
                         Customer.Customer ON Booking.Booking.CustomerID = Customer.Customer.CustomerId INNER JOIN
                         Services.Service ON Booking.Booking.ServiceID = Services.Service.ServiceID INNER JOIN
                         Services.ServiceType ON Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID
GO
/****** Object:  View [dbo].[AllReviews]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllReviews]
AS
SELECT        Customer.Customer.FirstName, Customer.Customer.LastName, Customer.CompanyReviews.Rating, Customer.CompanyReviews.Comments, Company.Company.CompanyName
FROM            Company.Company INNER JOIN
                         Customer.CompanyReviews ON Company.Company.CompanyID = Customer.CompanyReviews.CompanyID INNER JOIN
                         Customer.Customer ON Customer.CompanyReviews.CustomerID = Customer.Customer.CustomerId
GO
/****** Object:  View [dbo].[Booking Next Month]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Booking Next Month]
AS
SELECT        Services.ServiceType.ServiceType, Booking.BookingTime.Date, Booking.BookingTime.TimeStart, Services.Service.ServiceName, Customer.Customer.FirstName, Customer.Customer.LastName
FROM            Booking.Booking INNER JOIN
                         Booking.BookingTime ON Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND 
                         Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND 
                         Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID INNER JOIN
                         Customer.Customer ON Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId AND 
                         Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId AND 
                         Booking.Booking.CustomerID = Customer.Customer.CustomerId INNER JOIN
                         Services.Service ON Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID AND 
                         Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID INNER JOIN
                         Services.ServiceType ON Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID
WHERE        (Booking.BookingTime.Date BETWEEN '2017/03/20' AND '2017/04/20')
GO
/****** Object:  View [dbo].[BookingAttendance]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BookingAttendance]
AS
SELECT        BookingAttendance_1.Attended, Booking.Booking.ServiceID, Booking.Booking.StaffID, Booking.BookingTime.Date
FROM            Booking.BookingAttendance AS BookingAttendance_1 INNER JOIN
                         Booking.Booking ON BookingAttendance_1.BookingID = Booking.Booking.BookingID AND BookingAttendance_1.BookingID = Booking.Booking.BookingID AND 
                         BookingAttendance_1.BookingID = Booking.Booking.BookingID INNER JOIN
                         Booking.BookingTime ON Booking.Booking.BookingID = Booking.BookingTime.BookingID
WHERE        (Booking.Booking.CompanyID = 38) AND (BookingAttendance_1.Attended = 0) OR
                         (BookingAttendance_1.Attended = 1)
GO
/****** Object:  View [dbo].[CompanyID38Bookings]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CompanyID38Bookings]
AS
SELECT        Customer.Customer.FirstName, Customer.Customer.LastName, Services.Service.ServiceName, Booking.BookingTime.Date, Booking.BookingTime.TimeStart, Services.ServiceType.ServiceType
FROM            Booking.Booking INNER JOIN
                         Booking.BookingTime ON Booking.Booking.BookingID = Booking.BookingTime.BookingID INNER JOIN
                         Customer.Customer ON Booking.Booking.CustomerID = Customer.Customer.CustomerId INNER JOIN
                         Services.Service ON Booking.Booking.ServiceID = Services.Service.ServiceID INNER JOIN
                         Services.ServiceType ON Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID
WHERE        (Booking.Booking.CompanyID = 38)
GO
/****** Object:  View [dbo].[Equipment Needed]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Equipment Needed]
AS
SELECT        Booking.BookingTime.Date, Booking.BookingTime.TimeStart, Equipment.Equiptment.EquiptmentName, Equipment.EquiptmentType.EquiptmentTypeName, Services.EquiptmentNeeded.Quantity, 
                         Services.Service.ServiceTypeID, Services.Service.ServiceName
FROM            Services.EquiptmentNeeded INNER JOIN
                         Equipment.Equiptment ON Services.EquiptmentNeeded.EquiptmentID = Equipment.Equiptment.EquiptmentID AND Services.EquiptmentNeeded.EquiptmentID = Equipment.Equiptment.EquiptmentID INNER JOIN
                         Equipment.EquiptmentType ON Equipment.Equiptment.EquiptmentTypeID = Equipment.EquiptmentType.EquiptmentTypeID AND 
                         Equipment.Equiptment.EquiptmentTypeID = Equipment.EquiptmentType.EquiptmentTypeID AND Equipment.Equiptment.EquiptmentTypeID = Equipment.EquiptmentType.EquiptmentTypeID INNER JOIN
                         Services.Service ON Services.EquiptmentNeeded.ServiceID = Services.Service.ServiceID INNER JOIN
                         Booking.Booking INNER JOIN
                         Booking.BookingTime ON Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND 
                         Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID ON Services.Service.ServiceID = Booking.Booking.ServiceID
GO
/****** Object:  View [dbo].[Future Bookings]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Future Bookings]
AS
SELECT        Services.ServiceType.ServiceType, Booking.BookingTime.Date, Booking.BookingTime.TimeStart, Services.Service.ServiceName, Customer.Customer.FirstName, Customer.Customer.LastName
FROM            Booking.Booking INNER JOIN
                         Booking.BookingTime ON Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND 
                         Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID AND 
                         Booking.Booking.BookingID = Booking.BookingTime.BookingID AND Booking.Booking.BookingID = Booking.BookingTime.BookingID INNER JOIN
                         Customer.Customer ON Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId AND 
                         Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId AND 
                         Booking.Booking.CustomerID = Customer.Customer.CustomerId INNER JOIN
                         Services.Service ON Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID AND 
                         Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID INNER JOIN
                         Services.ServiceType ON Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID
WHERE        (Booking.BookingTime.Date > GETDATE())
GO
/****** Object:  View [dbo].[Invoice]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Invoice]
AS
SELECT        Customer.Customer.FirstName, Customer.Customer.LastName, Services.Service.ServiceName, Staff.Staff.First_Name, Company.Company.CompanyName, Booking.Cost.Cost, Company.Company.Address, 
                         Company.Company.Postcode, Company.Company.PhoneNumber, Invoice_1.InvoiceID, Invoice_1.Paid, Invoice_1.Thanks, Invoice_1.Date
FROM            Booking.Booking INNER JOIN
                         Company.Company ON Booking.Booking.CompanyID = Company.Company.CompanyID AND Booking.Booking.CompanyID = Company.Company.CompanyID INNER JOIN
                         Customer.Customer ON Booking.Booking.CustomerID = Customer.Customer.CustomerId AND Booking.Booking.CustomerID = Customer.Customer.CustomerId INNER JOIN
                         Services.Service ON Booking.Booking.ServiceID = Services.Service.ServiceID AND Booking.Booking.ServiceID = Services.Service.ServiceID INNER JOIN
                         Booking.Cost ON Services.Service.ServiceID = Booking.Cost.ServiceID AND Services.Service.ServiceID = Booking.Cost.ServiceID AND Services.Service.ServiceID = Booking.Cost.ServiceID AND 
                         Services.Service.ServiceID = Booking.Cost.ServiceID INNER JOIN
                         Staff.Staff ON Company.Company.CompanyID = Staff.Staff.CompanyID INNER JOIN
                         Booking.Invoice AS Invoice_1 ON Booking.Booking.BookingID = Invoice_1.BookingID AND Booking.Cost.CostID = Invoice_1.CostID AND Booking.Cost.CostID = Invoice_1.CostID AND 
                         Booking.Cost.CostID = Invoice_1.CostID AND Booking.Cost.CostID = Invoice_1.CostID
GO
/****** Object:  View [dbo].[NegativeReviews]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NegativeReviews]
AS
SELECT        Customer.Customer.FirstName, Customer.Customer.LastName, Customer.CompanyReviews.Rating, Customer.CompanyReviews.Comments, Company.Company.CompanyName
FROM            Company.Company INNER JOIN
                         Customer.CompanyReviews ON Company.Company.CompanyID = Customer.CompanyReviews.CompanyID INNER JOIN
                         Customer.Customer ON Customer.CompanyReviews.CustomerID = Customer.Customer.CustomerId
WHERE        (Customer.CompanyReviews.Rating <= 5)
GO
/****** Object:  View [dbo].[PositiveReviews]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PositiveReviews]
AS
SELECT        Customer.Customer.FirstName, Customer.Customer.LastName, Customer.CompanyReviews.Rating, Customer.CompanyReviews.Comments, Company.Company.CompanyName
FROM            Company.Company INNER JOIN
                         Customer.CompanyReviews ON Company.Company.CompanyID = Customer.CompanyReviews.CompanyID INNER JOIN
                         Customer.Customer ON Customer.CompanyReviews.CustomerID = Customer.Customer.CustomerId
WHERE        (Customer.CompanyReviews.Rating >= 5)
GO
/****** Object:  View [dbo].[Price List]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Price List]
AS
SELECT        Booking.Cost.Cost, Services.Service.ServiceName, Services.ServiceType.ServiceType
FROM            Booking.Cost INNER JOIN
                         Services.Service ON Booking.Cost.ServiceID = Services.Service.ServiceID INNER JOIN
                         Services.ServiceType ON Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID
GO
/****** Object:  View [dbo].[Price Specific]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Price Specific]
AS
SELECT        Services.Service.ServiceName, Services.ServiceType.ServiceType, Booking.Cost.Cost
FROM            Booking.Cost INNER JOIN
                         Services.Service ON Booking.Cost.ServiceID = Services.Service.ServiceID AND Booking.Cost.ServiceID = Services.Service.ServiceID INNER JOIN
                         Services.ServiceType ON Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND 
                         Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID AND Services.Service.ServiceTypeID = Services.ServiceType.ServiceTypeID
WHERE        (Services.Service.ServiceID = 5)
GO
/****** Object:  View [dbo].[StockPhoto]    Script Date: 01/05/2018 02:56:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StockPhoto]
AS
SELECT        Stock.Stock.ProductName, Stock.ProductImage.ProductImageURL, Stock.Stock.ProductStockTypeID
FROM            Stock.ProductImage INNER JOIN
                         Stock.Stock ON Stock.ProductImage.ProductImageID = Stock.Stock.ProductImageID
GO
SET IDENTITY_INSERT [Booking].[Booking] ON 

INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (1, 1, 12, 61, 9, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (2, 2, 14, 61, 65, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (3, 3, 15, 61, 41, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (4, 4, 16, 61, 55, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (5, 5, 17, 61, 33, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (6, 6, 7, 44, 1, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (7, 7, 8, 44, 3, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (8, 8, 9, 44, 85, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (9, 9, 10, 44, 41, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (10, 10, 1, 38, 14, NULL, N'Great Customer', 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (11, 11, 2, 38, 77, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (12, 12, 3, 38, 84, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (13, 36, 17, 2, 73, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (14, 9, 57, 2, 50, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (15, 27, 32, 1, 6, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (16, 10, 46, 1, 71, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (17, 46, 56, 5, 83, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (18, 7, 57, 2, 21, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (19, 44, 21, 4, 32, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (20, 28, 26, 3, 75, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (21, 14, 39, 1, 67, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (22, 11, 17, 3, 31, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (23, 41, 31, 2, 21, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (24, 16, 2, 4, 33, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (25, 49, 18, 5, 30, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (26, 30, 36, 2, 19, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (27, 24, 6, 3, 49, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (28, 34, 30, 5, 16, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (29, 28, 25, 2, 36, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (30, 34, 12, 4, 85, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (31, 26, 26, 5, 81, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (32, 28, 25, 5, 34, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (33, 46, 9, 1, 68, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (34, 15, 14, 1, 39, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (35, 3, 29, 5, 9, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (36, 21, 24, 5, 51, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (37, 42, 55, 4, 65, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (38, 9, 47, 1, 56, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (39, 26, 1, 5, 85, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (40, 10, 55, 1, 45, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (41, 48, 4, 4, 35, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (42, 19, 21, 3, 54, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (43, 3, 12, 1, 27, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (44, 35, 4, 5, 44, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (45, 11, 35, 2, 67, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (46, 16, 15, 2, 68, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (47, 23, 18, 3, 24, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (48, 27, 29, 3, 12, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (49, 2, 24, 5, 24, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (50, 45, 10, 1, 82, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (51, 32, 21, 4, 8, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (52, 17, 3, 1, 68, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (53, 12, 3, 38, 24, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (54, 1, 15, 1, 73, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (55, 12, 1, 3, 16, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (56, 47, 7, 5, 81, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (57, 43, 2, 1, 75, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (58, 13, 58, 3, 78, NULL, NULL, 0)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (59, 49, 33, 4, 18, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (60, 28, 50, 5, 35, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (61, 40, 8, 5, 72, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (62, 15, 27, 1, 11, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (63, 1, 3, 38, 0, NULL, NULL, 1)
INSERT [Booking].[Booking] ([BookingID], [ServiceID], [StaffID], [CompanyID], [CustomerID], [EventID], [Notes], [Active]) VALUES (64, 12, 2, 38, 61, NULL, N'Great Customer', 1)
SET IDENTITY_INSERT [Booking].[Booking] OFF
SET IDENTITY_INSERT [Booking].[BookingAttendance] ON 

INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (1, 1, 44, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (2, 2, 45, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (3, 3, 56, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (4, 4, 78, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (5, 5, 42, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (6, 6, 11, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (7, 7, 70, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (8, 8, 21, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (9, 9, 49, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (10, 10, 61, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (11, 11, 81, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (12, 12, 64, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (13, 1, 59, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (14, 2, 23, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (15, 3, 69, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (16, 4, 78, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (17, 5, 94, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (18, 6, 13, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (19, 7, 36, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (20, 8, 73, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (21, 9, 75, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (22, 10, 67, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (23, 11, 34, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (24, 12, 57, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (25, 13, 19, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (26, 14, 55, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (27, 15, 42, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (28, 16, 36, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (29, 17, 76, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (30, 18, 15, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (31, 19, 59, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (32, 20, 46, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (33, 21, 60, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (34, 22, 38, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (35, 23, 90, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (36, 24, 6, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (37, 25, 34, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (38, 26, 92, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (39, 27, 76, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (40, 28, 85, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (41, 29, 32, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (42, 30, 57, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (43, 31, 29, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (44, 32, 95, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (45, 33, 33, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (46, 34, 96, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (47, 35, 7, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (48, 36, 55, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (49, 37, 32, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (50, 38, 1, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (51, 39, 64, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (52, 40, 5, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (53, 41, 36, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (54, 42, 72, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (55, 43, 90, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (56, 44, 3, 0)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (57, 45, 38, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (58, 46, 29, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (59, 47, 81, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (60, 48, 49, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (61, 49, 19, 1)
INSERT [Booking].[BookingAttendance] ([AttendanceID], [BookingID], [CustomerID], [Attended]) VALUES (62, 50, 36, 1)
SET IDENTITY_INSERT [Booking].[BookingAttendance] OFF
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (1, 1, CAST(N'2018-04-01' AS Date), CAST(N'11:00:00' AS Time), CAST(N'02:00:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (2, 2, CAST(N'2018-04-02' AS Date), CAST(N'09:00:00' AS Time), CAST(N'01:00:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (3, 3, CAST(N'2018-04-03' AS Date), CAST(N'10:00:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (4, 4, CAST(N'2018-04-04' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (5, 5, CAST(N'2018-04-02' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (6, 6, CAST(N'2018-05-03' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (7, 7, CAST(N'2018-06-09' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (8, 8, CAST(N'2018-07-07' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (9, 9, CAST(N'2018-08-08' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (10, 10, CAST(N'2018-09-03' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (11, 11, CAST(N'2018-10-03' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (12, 12, CAST(N'2018-11-03' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
INSERT [Booking].[BookingTime] ([BookingTime], [BookingID], [Date], [TimeStart], [Duration]) VALUES (13, 53, CAST(N'2018-11-03' AS Date), CAST(N'10:30:00' AS Time), CAST(N'00:30:00' AS Time))
SET IDENTITY_INSERT [Booking].[Cost] ON 

INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (1, 1, N'£15')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (2, 2, N'£20')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (3, 3, N'£35')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (4, 4, N'£20')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (5, 5, N'£70')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (6, 6, N'£500')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (7, 7, N'£300')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (8, 8, N'£300')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (9, 9, N'£150')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (10, 10, N'£150')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (11, 11, N'£300')
INSERT [Booking].[Cost] ([CostID], [ServiceID], [Cost]) VALUES (12, 12, N'£50')
SET IDENTITY_INSERT [Booking].[Cost] OFF
SET IDENTITY_INSERT [Booking].[Invoice] ON 

INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (1, 3, 5, 1, CAST(N'2017-05-13T14:28:03.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (2, 5, 8, 1, CAST(N'2017-04-30T17:59:37.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (3, 8, 1, 4, CAST(N'2017-05-29T12:00:34.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (4, 9, 9, 2, CAST(N'2017-11-06T10:24:04.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (5, 3, 7, 3, CAST(N'2017-08-23T05:17:53.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (6, 1, 10, 6, CAST(N'2017-06-04T11:14:29.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (7, 11, 2, 1, CAST(N'2017-11-20T05:33:31.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (8, 10, 11, 4, CAST(N'2017-12-23T00:37:36.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (9, 10, 5, 6, CAST(N'2017-07-26T22:30:53.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (10, 10, 4, 2, CAST(N'2018-01-22T22:03:39.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (11, 7, 4, 4, CAST(N'2017-10-30T09:43:34.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (12, 12, 8, 4, CAST(N'2017-12-22T10:27:38.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (13, 11, 2, 6, CAST(N'2017-10-28T04:41:16.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (14, 4, 10, 1, CAST(N'2017-09-29T01:05:06.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (15, 10, 12, 6, CAST(N'2018-01-02T20:01:59.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (16, 7, 1, 3, CAST(N'2017-08-25T02:17:04.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (17, 6, 4, 1, CAST(N'2017-03-18T01:14:43.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (18, 11, 3, 4, CAST(N'2017-05-21T15:00:28.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (19, 11, 4, 5, CAST(N'2017-04-04T05:43:44.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (20, 11, 3, 3, CAST(N'2017-08-04T13:21:50.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (21, 2, 9, 6, CAST(N'2017-11-28T09:17:10.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (22, 8, 4, 2, CAST(N'2017-09-02T06:55:41.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (23, 2, 3, 1, CAST(N'2017-04-28T16:33:21.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (24, 8, 9, 1, CAST(N'2017-02-21T02:39:32.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (25, 5, 6, 3, CAST(N'2017-06-25T08:54:28.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (26, 2, 9, 3, CAST(N'2017-07-29T03:19:23.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (27, 6, 12, 6, CAST(N'2017-03-12T21:22:34.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (28, 4, 12, 4, CAST(N'2017-03-16T15:24:45.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (29, 1, 11, 5, CAST(N'2017-08-31T23:18:29.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (30, 3, 1, 4, CAST(N'2017-12-03T08:58:17.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (31, 9, 5, 4, CAST(N'2017-11-29T04:58:41.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (32, 6, 3, 3, CAST(N'2017-08-19T23:26:53.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (33, 2, 1, 1, CAST(N'2017-09-03T19:36:32.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (34, 8, 8, 6, CAST(N'2017-12-28T14:05:51.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (35, 7, 8, 2, CAST(N'2018-01-29T02:27:53.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (36, 2, 4, 3, CAST(N'2017-04-28T02:39:29.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (37, 5, 4, 2, CAST(N'2017-07-06T11:51:16.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (38, 8, 7, 1, CAST(N'2018-01-21T01:45:54.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (39, 6, 11, 6, CAST(N'2017-09-14T04:33:00.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (40, 11, 7, 5, CAST(N'2017-09-27T01:09:04.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (41, 6, 7, 2, CAST(N'2017-07-16T06:28:41.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (42, 8, 4, 6, CAST(N'2017-08-18T20:53:43.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (43, 8, 2, 5, CAST(N'2017-03-13T09:41:40.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (44, 5, 10, 6, CAST(N'2018-01-26T04:38:13.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (45, 5, 7, 1, CAST(N'2017-05-14T21:04:42.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (46, 3, 9, 6, CAST(N'2018-01-28T15:18:51.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (47, 3, 7, 5, CAST(N'2018-02-01T12:11:15.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (48, 10, 7, 2, CAST(N'2017-02-22T02:43:24.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (49, 2, 12, 6, CAST(N'2017-10-28T04:13:01.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (50, 7, 4, 5, CAST(N'2017-09-23T13:34:03.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (51, 4, 9, 2, CAST(N'2017-03-23T05:32:46.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (52, 9, 6, 3, CAST(N'2017-02-16T07:31:19.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (53, 6, 10, 5, CAST(N'2017-06-14T00:15:55.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (54, 4, 7, 4, CAST(N'2017-08-28T07:58:34.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (55, 4, 1, 4, CAST(N'2017-03-20T08:24:07.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (56, 7, 11, 2, CAST(N'2017-02-28T23:30:21.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (57, 7, 5, 4, CAST(N'2017-10-05T18:18:00.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (58, 6, 1, 2, CAST(N'2017-06-22T08:48:37.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (59, 1, 8, 6, CAST(N'2017-04-09T03:04:52.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (60, 4, 4, 5, CAST(N'2017-11-02T08:04:31.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (61, 10, 12, 6, CAST(N'2017-12-11T16:17:32.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (62, 3, 11, 6, CAST(N'2018-01-03T03:43:53.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (63, 11, 12, 2, CAST(N'2017-11-03T05:46:53.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (64, 9, 4, 4, CAST(N'2017-10-07T06:32:32.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (65, 11, 2, 5, CAST(N'2017-03-07T18:43:40.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (66, 7, 9, 1, CAST(N'2017-02-24T20:09:22.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (67, 11, 6, 6, CAST(N'2017-06-07T13:32:57.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (68, 7, 7, 3, CAST(N'2017-10-29T04:42:18.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (69, 3, 2, 3, CAST(N'2017-12-31T09:31:17.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (70, 8, 4, 6, CAST(N'2017-04-11T23:44:22.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (71, 3, 3, 3, CAST(N'2017-07-03T20:47:56.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (72, 2, 3, 6, CAST(N'2017-03-04T07:54:11.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (73, 8, 3, 3, CAST(N'2017-12-31T14:02:58.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (74, 5, 5, 6, CAST(N'2017-04-11T18:29:01.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (75, 12, 6, 6, CAST(N'2017-05-03T12:25:25.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (76, 1, 9, 6, CAST(N'2017-06-21T09:22:15.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (77, 2, 4, 2, CAST(N'2017-09-09T04:05:03.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (78, 1, 4, 1, CAST(N'2017-03-06T02:11:39.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (79, 1, 3, 2, CAST(N'2017-10-30T20:11:08.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (80, 11, 6, 5, CAST(N'2017-03-31T14:32:43.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (81, 9, 4, 1, CAST(N'2017-07-12T14:12:17.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (82, 7, 6, 4, CAST(N'2017-07-23T07:35:01.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (83, 12, 8, 6, CAST(N'2017-07-20T04:47:24.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (84, 10, 10, 3, CAST(N'2017-11-15T06:10:09.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (85, 9, 8, 6, CAST(N'2017-06-26T01:06:38.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (86, 11, 11, 2, CAST(N'2017-05-12T21:49:52.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (87, 5, 7, 5, CAST(N'2017-09-07T11:54:29.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (88, 4, 4, 4, CAST(N'2017-05-20T14:07:35.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (89, 5, 3, 4, CAST(N'2017-10-05T17:26:50.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (90, 2, 2, 3, CAST(N'2017-12-16T09:15:42.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (91, 12, 1, 1, CAST(N'2017-10-08T14:29:25.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (92, 1, 12, 2, CAST(N'2017-06-07T18:37:23.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (93, 1, 2, 5, CAST(N'2017-07-09T16:40:05.000' AS DateTime), 0, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (94, 5, 8, 3, CAST(N'2017-11-12T09:24:34.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (95, 8, 11, 5, CAST(N'2017-05-09T06:29:05.000' AS DateTime), 0, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (96, 2, 5, 1, CAST(N'2017-10-13T04:52:50.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (97, 2, 10, 2, CAST(N'2017-05-04T12:23:20.000' AS DateTime), 1, N'Thank you')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (98, 8, 7, 3, CAST(N'2017-04-17T08:14:41.000' AS DateTime), 1, N'Not Paid')
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (99, 7, 12, 5, CAST(N'2017-03-12T09:30:27.000' AS DateTime), 0, N'Thank you')
GO
INSERT [Booking].[Invoice] ([InvoiceID], [BookingID], [CostID], [PaymentMethodID], [Date], [Paid], [Thanks]) VALUES (100, 2, 1, 3, CAST(N'2017-12-11T03:44:03.000' AS DateTime), 1, N'Thank you')
SET IDENTITY_INSERT [Booking].[Invoice] OFF
SET IDENTITY_INSERT [Booking].[PaymentMethod] ON 

INSERT [Booking].[PaymentMethod] ([PaymentMethodID], [MethodName]) VALUES (1, N'Cash')
INSERT [Booking].[PaymentMethod] ([PaymentMethodID], [MethodName]) VALUES (2, N'Debit Cart')
INSERT [Booking].[PaymentMethod] ([PaymentMethodID], [MethodName]) VALUES (3, N'Credit Card')
INSERT [Booking].[PaymentMethod] ([PaymentMethodID], [MethodName]) VALUES (4, N'Paypal')
INSERT [Booking].[PaymentMethod] ([PaymentMethodID], [MethodName]) VALUES (5, N'Apple Pay')
INSERT [Booking].[PaymentMethod] ([PaymentMethodID], [MethodName]) VALUES (6, N'Android Pay')
SET IDENTITY_INSERT [Booking].[PaymentMethod] OFF
SET IDENTITY_INSERT [Company].[Company] ON 

INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (1, 1, N'Mauris Associates', N'3130 Convallis St.', N'9920', N'371-2700', N'296-9770', NULL, NULL, NULL, NULL, CAST(N'2017-02-17T00:19:30.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (2, 3, N'Luctus Ltd', N'126-4886 Semper St.', N'41118', N'696-3937', N'478-7449', NULL, NULL, NULL, NULL, CAST(N'2018-09-04T01:56:24.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (3, 5, N'Quisque Company', N'Ap #292-4199 Quisque St.', N'7995', N'414-3566', N'200-5114', NULL, NULL, NULL, NULL, CAST(N'2017-12-05T18:41:57.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (4, 7, N'w', N'1794 Vulputate, St.', N'8769', N'599-8106', N'594-4655', NULL, NULL, NULL, NULL, CAST(N'2018-03-27T20:07:17.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (5, 9, N'Litora Torquent Per Foundation', N'156-1646 Ipsum Ave', N'13549', N'191-1797', N'397-0623', NULL, NULL, NULL, NULL, CAST(N'2018-08-19T17:50:54.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (6, 11, N'Nunc Quisque LLC', N'854-838 Duis Av.', N'41118', N'597-9380', N'562-5868', NULL, NULL, NULL, NULL, CAST(N'2018-05-13T04:28:31.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (7, 13, N'Adipiscing Lacus Incorporated', N'Ap #910-1980 Purus. Road', N'15457', N'960-6325', N'985-9478', NULL, NULL, NULL, NULL, CAST(N'2018-08-25T18:17:33.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (8, 15, N'Mauris Incorporated', N'4002 Enim Rd.', N'7197', N'616-5187', N'175-2830', NULL, NULL, NULL, NULL, CAST(N'2017-12-19T23:02:37.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (9, 17, N'Sed Turpis Nec Limited', N'393-7551 A Street', N'3787', N'904-6100', N'971-5092', NULL, NULL, NULL, NULL, CAST(N'2018-04-03T12:39:46.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (10, 19, N'Amet Foundation', N'5848 Tempus Rd.', N'41118', N'1-948-960-9615', N'203-6970', NULL, NULL, NULL, NULL, CAST(N'2018-02-03T01:03:49.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (11, 21, N'Vitae Semper PC', N'P.O. Box 957, 4517 Posuere, Street', N'6551', N'828-6769', N'477-1193', NULL, NULL, NULL, NULL, CAST(N'2018-11-24T13:20:43.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (12, 23, N'Ligula Incorporated', N'286-843 Lorem Av.', N'179453', N'216-8591', N'549-5546', NULL, NULL, NULL, NULL, CAST(N'2017-05-06T21:13:32.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (13, 25, N'Ipsum LLP', N'9328 Eros Avenue', N'44036', N'485-6413', N'386-8529', NULL, NULL, NULL, NULL, CAST(N'2016-12-19T07:53:37.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (14, 27, N'Neque Incorporated', N'Ap #456-4223 Integer Rd.', N'10418', N'560-4706', N'179-4337', NULL, NULL, NULL, NULL, CAST(N'2017-11-18T19:55:52.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (15, 29, N'Purus Ac Tellus Foundation', N'423-6033 Ipsum. Rd.', N'29895', N'487-1103', N'363-5339', NULL, NULL, NULL, NULL, CAST(N'2018-10-26T08:50:20.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (16, 31, N'Vulputate Mauris Sagittis Corp.', N'748-3590 Nibh. Ave', N'7133', N'286-9455', N'284-1276', NULL, NULL, NULL, NULL, CAST(N'2018-02-11T08:47:03.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (17, 33, N'Condimentum Corp.', N'489-9812 At Road', N'12694', N'622-3799', N'101-9474', NULL, NULL, NULL, NULL, CAST(N'2017-08-12T02:33:11.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (18, 35, N'Quisque Corp.', N'6771 Mauris Rd.', N'17904', N'341-7576', N'758-6187', NULL, NULL, NULL, NULL, CAST(N'2017-09-16T00:57:04.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (19, 37, N'Nec Tellus Nunc Corporation', N'961-9633 Eu Av.', N'20538', N'379-4636', N'320-0491', NULL, NULL, NULL, NULL, CAST(N'2017-02-22T20:35:11.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (20, 39, N'Arcu Consulting', N'9629 Facilisis. Rd.', N'574646', N'350-6507', N'757-4543', NULL, NULL, NULL, NULL, CAST(N'2018-07-24T06:30:04.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (21, 41, N'Enim Corporation', N'809-5612 Mauris Av.', N'669716', N'572-5675', N'284-9195', NULL, NULL, NULL, NULL, CAST(N'2017-05-04T06:11:34.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (22, 43, N'Elit Dictum Eu Ltd', N'9125 Imperdiet Av.', N'41118', N'369-0343', N'115-6760', NULL, NULL, NULL, NULL, CAST(N'2017-03-10T04:21:59.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (23, 45, N'In Consulting', N'284-3294 Eget Av.', N'61924', N'236-9540', N'408-3526', NULL, NULL, NULL, NULL, CAST(N'2017-09-27T02:34:07.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (24, 47, N'Neque LLP', N'2460 Lacus. Street', N'41118', N'280-4447', N'729-2691', NULL, NULL, NULL, NULL, CAST(N'2018-04-03T04:02:02.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (25, 49, N'Eget Corporation', N'967-7307 Diam Road', N'1012', N'462-6296', N'901-1344', NULL, NULL, NULL, NULL, CAST(N'2018-08-15T19:05:43.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (26, 51, N'Risus Ltd', N'536 Pellentesque St.', N'554347', N'307-9267', N'310-8928', NULL, NULL, NULL, NULL, CAST(N'2018-06-14T11:40:47.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (27, 53, N'A Nunc In Limited', N'638-2484 Pellentesque Rd.', N'5975', N'161-9290', N'741-3619', NULL, NULL, NULL, NULL, CAST(N'2018-04-11T06:20:27.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (28, 55, N'Ut Molestie In LLC', N'2065 Curae; Av.', N'5451', N'715-2951', N'385-5007', NULL, NULL, NULL, NULL, CAST(N'2018-01-21T03:14:15.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (29, 57, N'Vivamus Molestie Dapibus Corp.', N'P.O. Box 944, 2927 Lorem, Rd.', N'28224', N'574-5391', N'616-7000', NULL, NULL, NULL, NULL, CAST(N'2017-11-23T00:37:25.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (30, 59, N'Ante Vivamus Non Ltd', N'867-5751 Tortor Avenue', N'65402', N'208-0383', N'724-1944', NULL, NULL, NULL, NULL, CAST(N'2017-10-08T04:35:50.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (31, 61, N'Feugiat Tellus Incorporated', N'P.O. Box 134, 3156 Orci, Street', N'7793', N'651-2042', N'189-7520', NULL, NULL, NULL, NULL, CAST(N'2018-06-08T06:22:27.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (32, 63, N'Vitae Mauris Inc.', N'P.O. Box 532, 2316 Euismod Rd.', N'50316', N'639-0607', N'362-0432', NULL, NULL, NULL, NULL, CAST(N'2017-02-18T00:50:23.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (33, 65, N'Donec Felis PC', N'P.O. Box 149, 1391 Gravida Av.', N'6236', N'531-4998', N'957-0773', NULL, NULL, NULL, NULL, CAST(N'2018-11-20T23:22:43.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (34, 67, N'Tincidunt Limited', N'877-7440 Lorem, Rd.', N'56008', N'279-9929', N'272-2301', NULL, NULL, NULL, NULL, CAST(N'2018-02-09T10:19:06.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (35, 69, N'Sit Inc.', N'251 Elit. St.', N'102761', N'636-5255', N'703-0362', NULL, NULL, NULL, NULL, CAST(N'2018-10-01T05:19:28.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (36, 71, N'Tincidunt LLP', N'676 Fringilla St.', N'704688', N'740-2780', N'444-0889', NULL, NULL, NULL, NULL, CAST(N'2018-05-31T13:53:09.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (37, 73, N'Blandit At Consulting', N'254-3193 Nec Road', N'66860', N'256-8145', N'1-981-767-3852', NULL, NULL, NULL, NULL, CAST(N'2017-07-01T08:32:30.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (38, 75, N'Duis Gravida Industries', N'734-9679 Sed St.', N'41118', N'132-4802', N'387-0215', NULL, NULL, NULL, NULL, CAST(N'2018-04-28T05:40:01.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (39, 77, N'Nulla Aliquet Limited', N'Ap #437-6791 Nec Rd.', N'106130', N'645-6347', N'130-0520', NULL, NULL, NULL, NULL, CAST(N'2017-11-09T18:58:40.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (40, 79, N'Eget Nisi Corp.', N'1856 Urna Ave', N'4333', N'176-3761', N'323-7758', NULL, NULL, NULL, NULL, CAST(N'2017-12-11T14:25:54.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (41, 81, N'Pharetra Nam LLC', N'Ap #935-3109 Purus St.', N'96654', N'334-0125', N'597-0330', NULL, NULL, NULL, NULL, CAST(N'2017-10-19T00:20:48.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (42, 83, N'Donec Inc.', N'8505 Libero Rd.', N'41118', N'791-2294', N'531-9186', NULL, NULL, NULL, NULL, CAST(N'2018-06-25T15:56:30.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (43, 85, N'Mauris Non Corporation', N'P.O. Box 683, 7887 Nascetur Avenue', N'9807', N'263-9955', N'576-9202', NULL, NULL, NULL, NULL, CAST(N'2017-04-22T20:54:51.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (44, 87, N'Mi Pede Nonummy PC', N'215-4837 Mollis. St.', N'528341', N'792-4665', N'531-6362', NULL, NULL, NULL, NULL, CAST(N'2018-11-03T20:09:54.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (45, 89, N'Ac Mi Eleifend Incorporated', N'960-3404 Elit Rd.', N'41118', N'430-8102', N'922-3939', NULL, NULL, NULL, NULL, CAST(N'2018-02-18T00:44:08.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (46, 91, N'Magna Duis Dignissim Foundation', N'P.O. Box 430, 9512 At, St.', N'328580', N'998-0700', N'356-5902', NULL, NULL, NULL, NULL, CAST(N'2018-07-16T19:16:14.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (47, 93, N'Mi Lorem Associates', N'P.O. Box 835, 5572 Non, St.', N'6660', N'381-4298', N'530-2674', NULL, NULL, NULL, NULL, CAST(N'2017-08-03T08:21:44.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (48, 95, N'Ante Blandit Ltd', N'389-5755 Magnis Street', N'9263', N'308-9602', N'583-4862', NULL, NULL, NULL, NULL, CAST(N'2017-10-09T16:23:32.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (49, 97, N'Ligula Consectetuer Consulting', N'827-1414 Nunc Rd.', N'5627', N'769-5004', N'237-0792', NULL, NULL, NULL, NULL, CAST(N'2018-06-20T07:03:10.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (50, 99, N'Dui Cum Sociis Inc.', N'4198 Nullam Rd.', N'377021', N'798-8594', N'719-7010', NULL, NULL, NULL, NULL, CAST(N'2018-08-06T18:40:14.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (51, 101, N'Enim Non Corporation', N'3164 Ligula. Avenue', N'20077', N'428-1165', N'728-5764', NULL, NULL, NULL, NULL, CAST(N'2016-12-13T18:35:09.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (52, 103, N'Tellus Institute', N'886-8303 Ac St.', N'908', N'892-2654', N'567-5314', NULL, NULL, NULL, NULL, CAST(N'2018-10-15T21:59:32.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (53, 105, N'Mi Duis Risus Associates', N'609-7891 Luctus Av.', N'724961', N'575-3238', N'686-7454', NULL, NULL, NULL, NULL, CAST(N'2018-01-07T21:33:20.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (54, 107, N'Lobortis Incorporated', N'2704 Volutpat Rd.', N'41118', N'124-4857', N'703-7130', NULL, NULL, NULL, NULL, CAST(N'2017-09-13T01:41:39.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (55, 109, N'Amet Lorem Semper LLP', N'Ap #830-7733 Quisque Avenue', N'41118', N'750-1576', N'492-6048', NULL, NULL, NULL, NULL, CAST(N'2018-08-18T06:58:24.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (56, 111, N'Elementum Dui Corporation', N'2656 Ipsum St.', N'41118', N'785-5480', N'900-3028', NULL, NULL, NULL, NULL, CAST(N'2016-12-30T11:06:27.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (57, 113, N'Ridiculus Incorporated', N'973-9190 Nisl. St.', N'41118', N'581-0282', N'938-7935', NULL, NULL, NULL, NULL, CAST(N'2018-07-14T08:45:39.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (58, 115, N'Tellus PC', N'Ap #934-7717 Quis, St.', N'9296', N'285-4873', N'207-0003', NULL, NULL, NULL, NULL, CAST(N'2017-10-10T21:15:05.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (59, 117, N'Ligula Donec Corporation', N'Ap #281-4746 In Rd.', N'9296', N'863-5241', N'376-2127', NULL, NULL, NULL, NULL, CAST(N'2017-04-26T21:03:27.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (60, 119, N'Ultrices Mauris Ipsum LLC', N'Ap #511-9160 Massa. Ave', N'4037', N'822-2534', N'870-2975', NULL, NULL, NULL, NULL, CAST(N'2018-07-30T23:26:55.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (61, 121, N'Consequat Purus Company', N'P.O. Box 790, 682 Erat Street', N'63944', N'542-4339', N'435-8688', NULL, NULL, NULL, NULL, CAST(N'2017-01-01T15:54:36.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (62, 123, N'Massa Suspendisse Associates', N'P.O. Box 275, 1977 Dolor St.', N'63944', N'841-1526', N'727-8677', NULL, NULL, NULL, NULL, CAST(N'2018-08-01T18:27:53.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (63, 125, N'Tempus Mauris Consulting', N'154-3415 Integer St.', N'10955', N'946-9532', N'811-0269', NULL, NULL, NULL, NULL, CAST(N'2017-05-08T16:43:46.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (64, 127, N'Non Massa Company', N'P.O. Box 100, 5246 Vivamus Avenue', N'10955', N'416-4552', N'641-5248', NULL, NULL, NULL, NULL, CAST(N'2017-02-08T00:43:59.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (65, 129, N'Posuere Enim Nisl Foundation', N'4409 Ut, Street', N'6466', N'666-1022', N'479-9648', NULL, NULL, NULL, NULL, CAST(N'2017-07-09T21:23:44.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (66, 131, N'Vestibulum Ante Ltd', N'3697 Dolor, Ave', N'72471', N'408-0841', N'754-6750', NULL, NULL, NULL, NULL, CAST(N'2018-05-08T20:12:39.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (67, 133, N'Amet Risus PC', N'P.O. Box 757, 5673 Nisl St.', N'572546', N'950-9140', N'284-7667', NULL, NULL, NULL, NULL, CAST(N'2018-08-16T03:05:01.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (68, 135, N'Tellus LLC', N'P.O. Box 706, 4369 Sed Rd.', N'572546', N'661-0598', N'649-6920', NULL, NULL, NULL, NULL, CAST(N'2017-05-07T13:11:02.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (69, 137, N'Commodo Hendrerit Associates', N'122-3352 Mauris Ave', N'572546', N'198-1309', N'109-7978', NULL, NULL, NULL, NULL, CAST(N'2018-01-05T00:21:48.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (70, 139, N'At Egestas A Ltd', N'Ap #503-8264 At Road', N'6189', N'1-733-896-5775', N'616-9008', NULL, NULL, NULL, NULL, CAST(N'2018-04-10T09:08:39.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (71, 141, N'Mattis Ltd', N'924-8320 Sit St.', N'572546', N'456-2461', N'743-7466', NULL, NULL, NULL, NULL, CAST(N'2017-03-09T23:42:13.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (72, 143, N'Tincidunt Inc.', N'955-5576 Vivamus Road', N'572546', N'336-2042', N'757-1962', NULL, NULL, NULL, NULL, CAST(N'2017-02-18T10:55:53.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (73, 145, N'Diam Lorem Inc.', N'Ap #727-6662 Natoque St.', N'74945', N'698-2029', N'423-2180', NULL, NULL, NULL, NULL, CAST(N'2018-10-28T16:09:12.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (74, 147, N'Magna Ltd', N'942-199 Tincidunt, Avenue', N'2779', N'794-0527', N'324-7554', NULL, NULL, NULL, NULL, CAST(N'2017-10-15T06:59:07.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (75, 149, N'Dictum Eu Eleifend Consulting', N'P.O. Box 496, 9009 Sed St.', N'2779', N'711-2675', N'869-4489', NULL, NULL, NULL, NULL, CAST(N'2017-01-13T10:27:04.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (76, 151, N'Tincidunt PC', N'Ap #621-1023 Risus, Av.', N'58565', N'693-4138', N'793-3590', NULL, NULL, NULL, NULL, CAST(N'2018-08-10T22:01:51.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (77, 153, N'Quisque Ltd', N'P.O. Box 290, 6690 Suspendisse Rd.', N'58565', N'260-8482', N'212-0507', NULL, NULL, NULL, NULL, CAST(N'2017-12-23T08:24:50.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (78, 155, N'Orci Luctus Et Consulting', N'9230 Sem Rd.', N'58565', N'1-528-456-6772', N'810-1763', NULL, NULL, NULL, NULL, CAST(N'2018-08-20T15:22:29.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (79, 157, N'Eget Incorporated', N'463-9352 Non Street', N'58565', N'439-9940', N'311-5122', NULL, NULL, NULL, NULL, CAST(N'2018-10-23T03:01:19.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (80, 159, N'Mollis Phasellus Associates', N'Ap #296-3828 Iaculis, Rd.', N'51306', N'710-1802', N'144-1109', NULL, NULL, NULL, NULL, CAST(N'2016-12-16T11:10:28.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (81, 161, N'Urna Company', N'724-3198 Aliquam Road', N'394933', N'829-9621', N'234-2047', NULL, NULL, NULL, NULL, CAST(N'2018-12-04T08:57:46.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (82, 163, N'Est Ac Mattis LLC', N'Ap #556-8075 Mollis Avenue', N'3461', N'450-3334', N'471-9590', NULL, NULL, NULL, NULL, CAST(N'2017-01-16T17:21:53.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (83, 165, N'Laoreet Consulting', N'177-6200 Ultricies Ave', N'58565', N'1-261-605-1113', N'912-3341', NULL, NULL, NULL, NULL, CAST(N'2018-11-23T20:38:09.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (84, 167, N'Ligula Donec Luctus Industries', N'Ap #882-3339 Non Road', N'90820', N'287-1054', N'207-2793', NULL, NULL, NULL, NULL, CAST(N'2017-11-22T20:34:09.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (85, 169, N'Arcu Vivamus Sit Associates', N'384-8057 Elit. Rd.', N'58565', N'1-677-329-3913', N'866-1443', NULL, NULL, NULL, NULL, CAST(N'2017-03-09T14:56:10.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (86, 171, N'Sapien Gravida Foundation', N'P.O. Box 194, 7701 Ultrices Avenue', N'171', N'156-1405', N'588-3478', NULL, NULL, NULL, NULL, CAST(N'2018-03-23T06:41:53.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (87, 173, N'Proin PC', N'P.O. Box 136, 9765 Euismod Road', N'32014', N'875-7383', N'1-452-845-9148', NULL, NULL, NULL, NULL, CAST(N'2018-10-06T08:15:38.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (88, 175, N'Est Mauris LLC', N'558-5033 Lacinia Rd.', N'6444', N'201-4270', N'325-2413', NULL, NULL, NULL, NULL, CAST(N'2017-09-13T01:57:39.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (89, 177, N'At Velit Pellentesque Company', N'8109 Lectus Rd.', N'40320', N'962-5883', N'506-7862', NULL, NULL, NULL, NULL, CAST(N'2017-08-20T02:27:53.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (90, 179, N'Odio Etiam Inc.', N'P.O. Box 166, 5234 Sodales. Rd.', N'235400', N'842-5925', N'512-1450', NULL, NULL, NULL, NULL, CAST(N'2018-05-09T08:12:20.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (91, 181, N'Pharetra Quisque Foundation', N'P.O. Box 252, 5852 Semper Avenue', N'22833', N'242-6261', N'910-3885', NULL, NULL, NULL, NULL, CAST(N'2018-10-14T11:32:44.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (92, 183, N'Luctus Corporation', N'9353 Adipiscing St.', N'58565', N'377-8987', N'858-2273', NULL, NULL, NULL, NULL, CAST(N'2017-02-16T05:54:41.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (93, 185, N'Eget Company', N'7646 Sed St.', N'825684', N'456-3310', N'785-7721', NULL, NULL, NULL, NULL, CAST(N'2018-07-28T10:37:55.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (94, 187, N'Vel Arcu Curabitur PC', N'Ap #535-4307 Nibh Rd.', N'68905', N'483-0188', N'913-1156', NULL, NULL, NULL, NULL, CAST(N'2018-04-01T21:02:02.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (95, 189, N'Ante Dictum Cursus LLC', N'886-2905 Tempor Road', N'36145', N'481-5409', N'265-8142', NULL, NULL, NULL, NULL, CAST(N'2017-09-27T18:40:46.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (96, 191, N'Nunc Id Enim Industries', N'9820 Bibendum Rd.', N'1327', N'167-9357', N'646-0822', NULL, NULL, NULL, NULL, CAST(N'2018-09-01T19:15:50.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (97, 193, N'Felis Purus Ac Limited', N'P.O. Box 614, 987 Diam. St.', N'58565', N'421-1427', N'305-1343', NULL, NULL, NULL, NULL, CAST(N'2017-05-17T09:56:48.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (98, 195, N'Dui Augue Eu Corp.', N'8656 Donec St.', N'20185', N'231-1130', N'669-7049', NULL, NULL, NULL, NULL, CAST(N'2018-07-11T07:00:48.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (99, 197, N'Dignissim Maecenas Inc.', N'902-8706 Nec Av.', N'65177', N'979-5283', N'1-116-951-9827', NULL, NULL, NULL, NULL, CAST(N'2018-02-06T09:21:48.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
GO
INSERT [Company].[Company] ([CompanyID], [IndustryID], [CompanyName], [Address], [Postcode], [PhoneNumber], [FaxNumber], [Website], [Facebook], [Twitter], [LinkedIn], [RegistrationDate], [Location], [Active]) VALUES (100, 199, N'Interdum Ligula Eu LLC', N'244-2502 Feugiat Road', N'50813', N'854-1756', N'240-2229', NULL, NULL, NULL, NULL, CAST(N'2016-12-07T00:36:58.000' AS DateTime), 0xE6100000010C17D9CEF753D347407593180456965EC0, 1)
SET IDENTITY_INSERT [Company].[Company] OFF
SET IDENTITY_INSERT [Company].[CompanyOpeningHours] ON 

INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (2, 3, 4, CAST(N'15:09:00' AS Time), CAST(N'16:27:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (3, 4, 1, CAST(N'11:53:00' AS Time), CAST(N'11:00:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (4, 5, 7, CAST(N'16:02:00' AS Time), CAST(N'10:33:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (5, 6, 3, CAST(N'17:35:00' AS Time), CAST(N'11:31:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (6, 7, 2, CAST(N'14:02:00' AS Time), CAST(N'12:47:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (7, 8, 7, CAST(N'13:59:00' AS Time), CAST(N'12:41:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (8, 9, 5, CAST(N'12:45:00' AS Time), CAST(N'09:45:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (9, 10, 2, CAST(N'09:30:00' AS Time), CAST(N'14:28:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (10, 11, 6, CAST(N'16:20:00' AS Time), CAST(N'16:22:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (11, 12, 5, CAST(N'13:17:00' AS Time), CAST(N'10:33:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (12, 13, 2, CAST(N'17:05:00' AS Time), CAST(N'15:17:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (13, 14, 5, CAST(N'16:20:00' AS Time), CAST(N'13:34:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (14, 15, 5, CAST(N'10:42:00' AS Time), CAST(N'09:19:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (15, 16, 2, CAST(N'16:59:00' AS Time), CAST(N'15:12:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (16, 17, 3, CAST(N'11:15:00' AS Time), CAST(N'13:36:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (17, 18, 3, CAST(N'13:14:00' AS Time), CAST(N'15:52:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (18, 19, 1, CAST(N'16:19:00' AS Time), CAST(N'16:28:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (19, 20, 4, CAST(N'16:21:00' AS Time), CAST(N'14:58:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (20, 21, 2, CAST(N'12:55:00' AS Time), CAST(N'16:05:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (21, 22, 2, CAST(N'13:22:00' AS Time), CAST(N'15:26:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (22, 23, 1, CAST(N'09:15:00' AS Time), CAST(N'12:45:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (23, 24, 1, CAST(N'11:54:00' AS Time), CAST(N'08:46:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (24, 25, 4, CAST(N'11:56:00' AS Time), CAST(N'15:06:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (25, 26, 2, CAST(N'08:48:00' AS Time), CAST(N'14:15:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (26, 27, 7, CAST(N'08:20:00' AS Time), CAST(N'12:50:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (27, 28, 1, CAST(N'09:47:00' AS Time), CAST(N'09:42:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (28, 29, 7, CAST(N'09:55:00' AS Time), CAST(N'13:57:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (29, 30, 3, CAST(N'15:47:00' AS Time), CAST(N'14:17:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (30, 31, 7, CAST(N'10:52:00' AS Time), CAST(N'08:46:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (31, 32, 2, CAST(N'11:56:00' AS Time), CAST(N'11:59:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (32, 33, 1, CAST(N'17:20:00' AS Time), CAST(N'09:25:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (33, 34, 1, CAST(N'09:24:00' AS Time), CAST(N'11:44:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (34, 35, 2, CAST(N'14:38:00' AS Time), CAST(N'16:45:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (35, 36, 2, CAST(N'08:08:00' AS Time), CAST(N'12:41:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (36, 37, 2, CAST(N'10:32:00' AS Time), CAST(N'09:04:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (37, 38, 3, CAST(N'10:30:00' AS Time), CAST(N'16:49:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (38, 39, 7, CAST(N'08:40:00' AS Time), CAST(N'09:04:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (39, 40, 4, CAST(N'17:35:00' AS Time), CAST(N'12:58:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (40, 41, 7, CAST(N'17:26:00' AS Time), CAST(N'13:38:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (41, 42, 5, CAST(N'13:12:00' AS Time), CAST(N'14:28:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (42, 43, 2, CAST(N'11:03:00' AS Time), CAST(N'13:06:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (43, 44, 2, CAST(N'13:38:00' AS Time), CAST(N'09:59:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (44, 45, 6, CAST(N'16:17:00' AS Time), CAST(N'12:18:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (45, 46, 4, CAST(N'16:16:00' AS Time), CAST(N'14:41:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (46, 47, 6, CAST(N'16:02:00' AS Time), CAST(N'12:04:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (47, 48, 3, CAST(N'12:25:00' AS Time), CAST(N'11:34:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (48, 49, 6, CAST(N'10:20:00' AS Time), CAST(N'08:54:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (49, 50, 5, CAST(N'11:08:00' AS Time), CAST(N'12:36:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (50, 51, 2, CAST(N'13:53:00' AS Time), CAST(N'13:42:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (51, 52, 1, CAST(N'17:13:00' AS Time), CAST(N'09:34:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (52, 53, 2, CAST(N'10:34:00' AS Time), CAST(N'15:16:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (53, 54, 1, CAST(N'08:37:00' AS Time), CAST(N'12:45:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (54, 55, 4, CAST(N'16:42:00' AS Time), CAST(N'10:31:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (55, 56, 6, CAST(N'15:49:00' AS Time), CAST(N'16:19:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (56, 57, 4, CAST(N'09:56:00' AS Time), CAST(N'13:07:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (57, 58, 2, CAST(N'11:41:00' AS Time), CAST(N'12:18:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (58, 59, 6, CAST(N'11:25:00' AS Time), CAST(N'16:50:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (59, 60, 2, CAST(N'08:18:00' AS Time), CAST(N'15:59:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (60, 61, 6, CAST(N'10:31:00' AS Time), CAST(N'10:11:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (61, 62, 4, CAST(N'08:46:00' AS Time), CAST(N'14:17:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (62, 63, 5, CAST(N'11:23:00' AS Time), CAST(N'10:43:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (63, 64, 3, CAST(N'14:23:00' AS Time), CAST(N'15:32:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (64, 65, 1, CAST(N'08:48:00' AS Time), CAST(N'09:09:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (65, 66, 4, CAST(N'08:48:00' AS Time), CAST(N'13:40:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (66, 67, 6, CAST(N'12:57:00' AS Time), CAST(N'10:58:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (67, 68, 1, CAST(N'12:58:00' AS Time), CAST(N'08:55:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (68, 69, 1, CAST(N'10:11:00' AS Time), CAST(N'15:38:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (69, 70, 5, CAST(N'09:38:00' AS Time), CAST(N'16:42:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (70, 71, 1, CAST(N'14:22:00' AS Time), CAST(N'09:19:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (71, 72, 7, CAST(N'13:29:00' AS Time), CAST(N'16:29:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (72, 73, 6, CAST(N'14:45:00' AS Time), CAST(N'15:28:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (73, 74, 7, CAST(N'14:50:00' AS Time), CAST(N'11:28:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (74, 75, 1, CAST(N'10:14:00' AS Time), CAST(N'13:04:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (75, 76, 6, CAST(N'15:19:00' AS Time), CAST(N'16:33:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (76, 77, 3, CAST(N'10:27:00' AS Time), CAST(N'15:50:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (77, 78, 2, CAST(N'16:18:00' AS Time), CAST(N'10:35:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (78, 79, 5, CAST(N'17:28:00' AS Time), CAST(N'10:45:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (79, 80, 7, CAST(N'17:08:00' AS Time), CAST(N'13:50:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (80, 81, 1, CAST(N'13:11:00' AS Time), CAST(N'14:51:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (81, 82, 3, CAST(N'12:26:00' AS Time), CAST(N'16:54:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (82, 83, 1, CAST(N'12:18:00' AS Time), CAST(N'11:03:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (83, 84, 4, CAST(N'13:53:00' AS Time), CAST(N'09:17:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (84, 85, 4, CAST(N'17:18:00' AS Time), CAST(N'11:41:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (85, 86, 2, CAST(N'10:31:00' AS Time), CAST(N'09:24:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (86, 87, 3, CAST(N'15:54:00' AS Time), CAST(N'13:50:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (87, 88, 2, CAST(N'08:29:00' AS Time), CAST(N'13:04:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (88, 89, 2, CAST(N'16:21:00' AS Time), CAST(N'11:32:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (89, 90, 3, CAST(N'09:55:00' AS Time), CAST(N'14:03:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (90, 91, 4, CAST(N'09:17:00' AS Time), CAST(N'13:33:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (91, 92, 6, CAST(N'11:34:00' AS Time), CAST(N'16:35:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (92, 93, 4, CAST(N'11:25:00' AS Time), CAST(N'15:57:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (93, 94, 2, CAST(N'09:23:00' AS Time), CAST(N'09:58:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (94, 95, 6, CAST(N'17:28:00' AS Time), CAST(N'15:10:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (95, 96, 2, CAST(N'12:43:00' AS Time), CAST(N'13:26:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (96, 97, 1, CAST(N'14:18:00' AS Time), CAST(N'16:51:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (97, 98, 3, CAST(N'08:38:00' AS Time), CAST(N'16:24:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (98, 99, 5, CAST(N'11:32:00' AS Time), CAST(N'16:30:00' AS Time), N'Closed - Please come back between the opening hours listed')
INSERT [Company].[CompanyOpeningHours] ([OpeningTimeID], [CompanyID], [DayOfWeek], [OpeningTime], [ClosingTime], [NotesIfClosed]) VALUES (99, 100, 3, CAST(N'16:19:00' AS Time), CAST(N'10:15:00' AS Time), N'Closed - Please come back between the opening hours listed')
SET IDENTITY_INSERT [Company].[CompanyOpeningHours] OFF
GO
SET IDENTITY_INSERT [Company].[Industry] ON 

INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (1, N'Abortion Policy/Anti-Abortion')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (2, N'Abortion Policy/Pro-Abortion Rights')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (3, N'Accountants')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (4, N'Advertising/Public Relations')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (5, N'Aerospace, Defense Contractors')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (6, N'Agribusiness')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (7, N'Agricultural Services & Products')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (8, N'Agriculture')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (9, N'Air Transport')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (10, N'Air Transport Unions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (11, N'Airlines')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (12, N'Alcoholic Beverages')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (13, N'Alternative Energy Production & Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (14, N'Architectural Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (15, N'Attorneys/Law Firms')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (16, N'Auto Dealers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (17, N'Auto Dealers, Japanese')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (18, N'Auto Manufacturers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (19, N'Automotive')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (20, N'Banking, Mortgage')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (21, N'Banks, Commercial')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (22, N'Banks, Savings & Loans')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (23, N'Bars & Restaurants')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (24, N'Beer, Wine & Liquor')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (25, N'Books, Magazines & Newspapers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (26, N'Broadcasters, Radio/TV')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (27, N'Builders/General Contractors')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (28, N'Builders/Residential')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (29, N'Building Materials & Equipment')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (30, N'Building Trade Unions ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (31, N'Business Associations')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (32, N'Business Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (33, N'Cable & Satellite TV Production & Distribution')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (34, N'Candidate Committees ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (35, N'Candidate Committees, Democratic')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (36, N'Candidate Committees, Republican')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (37, N'Car Dealers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (38, N'Car Dealers, Imports')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (39, N'Car Manufacturers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (40, N'Casinos / Gambling')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (41, N'Cattle Ranchers/Livestock')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (42, N'Chemical & Related Manufacturing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (43, N'Chiropractors')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (44, N'Web Tech')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (45, N'Clergy & Religious Organizations ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (46, N'Clothing Manufacturing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (47, N'Coal Mining')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (48, N'Colleges, Universities & Schools')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (49, N'Commercial Banks')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (50, N'Commercial TV & Radio Stations')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (51, N'Communications/Electronics')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (52, N'Computer Software')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (53, N'Conservative/Republican')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (54, N'Construction')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (55, N'Construction Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (56, N'Construction Unions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (57, N'Credit Unions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (58, N'Crop Production & Basic Processing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (59, N'Cruise Lines')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (60, N'Cruise Ships & Lines')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (61, N'Hair Care')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (62, N'Defense')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (63, N'Defense Aerospace')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (64, N'Defense Electronics')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (65, N'Defense/Foreign Policy Advocates')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (66, N'Democratic Candidate Committees ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (67, N'Democratic Leadership PACs')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (68, N'Democratic/Liberal ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (69, N'Dentists')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (70, N'Doctors & Other Health Professionals')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (71, N'Drug Manufacturers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (72, N'Education ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (73, N'Electric Utilities')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (74, N'Electronics Manufacturing & Equipment')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (75, N'Electronics, Defense Contractors')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (76, N'Energy & Natural Resources')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (77, N'Entertainment Industry')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (78, N'Environment ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (79, N'Farm Bureaus')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (80, N'Farming')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (81, N'Finance / Credit Companies')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (82, N'Finance, Insurance & Real Estate')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (83, N'Food & Beverage')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (84, N'Food Processing & Sales')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (85, N'Food Products Manufacturing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (86, N'Food Stores')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (87, N'For-profit Education')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (88, N'For-profit Prisons')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (89, N'Foreign & Defense Policy ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (90, N'Forestry & Forest Products')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (91, N'Foundations, Philanthropists & Non-Profits')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (92, N'Funeral Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (93, N'Gambling & Casinos')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (94, N'Gambling, Indian Casinos')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (95, N'Garbage Collection/Waste Management')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (96, N'Gas & Oil')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (97, N'Gay & Lesbian Rights & Issues')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (98, N'General Contractors')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (99, N'Government Employee Unions')
GO
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (100, N'Government Employees')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (101, N'Gun Control ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (102, N'Gun Rights ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (103, N'Health')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (104, N'Hair Professionals')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (105, N'Health Services/HMOs')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (106, N'Hedge Funds')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (107, N'HMOs & Health Care Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (108, N'Home Builders')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (109, N'Hospitals & Nursing Homes')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (110, N'Hotels, Motels & Tourism')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (111, N'Human Rights ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (112, N'Ideological/Single-Issue')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (113, N'Indian Gaming')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (114, N'Industrial Unions ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (115, N'Insurance')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (116, N'Internet')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (117, N'Israel Policy')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (118, N'Labor')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (119, N'Lawyers & Lobbyists')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (120, N'Lawyers / Law Firms')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (121, N'Leadership PACs ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (122, N'Liberal/Democratic')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (123, N'Liquor, Wine & Beer')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (124, N'Livestock')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (125, N'Lobbyists')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (126, N'Lodging / Tourism')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (127, N'Logging, Timber & Paper Mills')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (128, N'Manufacturing, Misc')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (129, N'Marine Transport')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (130, N'Meat processing & products')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (131, N'Medical Supplies')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (132, N'Mining')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (133, N'Misc Business')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (134, N'Misc Finance')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (135, N'Misc Manufacturing & Distributing ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (136, N'Misc Unions ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (137, N'Miscellaneous Defense')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (138, N'Miscellaneous Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (139, N'Mortgage Bankers & Brokers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (140, N'Motion Picture Production & Distribution')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (141, N'Music Production')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (142, N'Natural Gas Pipelines')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (143, N'Newspaper, Magazine & Book Publishing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (144, N'Non-profits, Foundations & Philanthropists')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (145, N'Nurses')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (146, N'Nursing Homes/Hospitals')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (147, N'Nutritional & Dietary Supplements')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (148, N'Oil & Gas')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (149, N'Other')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (150, N'Payday Lenders')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (151, N'Pharmaceutical Manufacturing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (152, N'Pharmaceuticals / Health Products')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (153, N'Phone Companies')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (154, N'Physicians & Other Health Professionals')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (155, N'Postal Unions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (156, N'Poultry & Eggs')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (157, N'Power Utilities')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (158, N'Printing & Publishing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (159, N'Private Equity & Investment Firms')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (160, N'Pro-Israel ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (161, N'Professional Sports, Sports Arenas & Related Equipment & Services')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (162, N'Progressive/Democratic')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (163, N'Public Employees')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (164, N'Public Sector Unions ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (165, N'Publishing & Printing')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (166, N'Radio/TV Stations')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (167, N'Railroads')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (168, N'Real Estate')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (169, N'Record Companies/Singers')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (170, N'Recorded Music & Music Production')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (171, N'Recreation / Live Entertainment')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (172, N'Religious Organizations/Clergy')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (173, N'Republican Candidate Committees ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (174, N'Republican Leadership PACs')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (175, N'Republican/Conservative ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (176, N'Residential Construction')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (177, N'Restaurants & Drinking Establishments')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (178, N'Retail Sales')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (179, N'Retired ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (180, N'Savings & Loans')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (181, N'Schools/Education')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (182, N'Sea Transport')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (183, N'Securities & Investment')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (184, N'Special Trade Contractors')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (185, N'Sports, Professional')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (186, N'Steel Production ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (187, N'Stock Brokers/Investment Industry')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (188, N'Student Loan Companies')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (189, N'Sugar Cane & Sugar Beets')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (190, N'Teachers Unions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (191, N'Teachers/Education')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (192, N'Telecom Services & Equipment')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (193, N'Telephone Utilities')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (194, N'Textiles ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (195, N'Timber, Logging & Paper Mills')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (196, N'Tobacco')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (197, N'Transportation')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (198, N'Transportation Unions ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (199, N'Trash Collection/Waste Management')
GO
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (200, N'Web Solutions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (201, N'TV / Movies / Music')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (202, N'TV Production')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (203, N'Unions')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (204, N'Unions, Airline')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (205, N'Unions, Building Trades')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (206, N'Unions, Industrial')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (207, N'Unions, Misc')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (208, N'Unions, Public Sector')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (209, N'Unions, Teacher')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (210, N'Unions, Transportation')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (211, N'Universities, Colleges & Schools')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (212, N'Vegetables & Fruits')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (213, N'Venture Capital')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (214, N'Waste Management')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (215, N'Wine, Beer & Liquor')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (216, N'Women''s Issues ')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (217, N'test')
INSERT [Company].[Industry] ([IndustryID], [SectorName]) VALUES (218, N'TEST AGAIN')
SET IDENTITY_INSERT [Company].[Industry] OFF
SET IDENTITY_INSERT [Customer].[CompanyReviews] ON 

INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (1, 1, 1, 7, N'Switchable solution-oriented task-force')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (2, 2, 2, 2, N'Diverse hybrid software')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (3, 3, 3, 1, N'Proactive mobile leverage')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (4, 4, 4, 9, N'Enterprise-wide 5th generation standardization')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (5, 5, 5, 6, N'User-friendly 5th generation paradigm')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (6, 6, 6, 6, N'Multi-layered human-resource knowledge base')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (7, 7, 7, 10, N'Optimized responsive utilisation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (8, 8, 8, 4, N'Advanced client-server algorithm')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (9, 9, 9, 7, N'Robust tertiary service-desk')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (10, 10, 10, 7, N'Switchable eco-centric customer loyalty')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (11, 11, 11, 9, N'Enhanced intermediate methodology')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (12, 12, 12, 4, N'Fully-configurable multi-tasking interface')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (13, 13, 13, 5, N'Grass-roots hybrid architecture')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (14, 14, 14, 5, N'Integrated logistical leverage')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (15, 15, 15, 2, N'Customer-focused 24/7 instruction set')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (16, 16, 16, 8, N'Ergonomic local core')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (17, 17, 17, 4, N'Synergized demand-driven concept')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (18, 18, 18, 9, N'Automated optimal conglomeration')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (19, 19, 19, 2, N'Multi-layered exuding emulation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (20, 20, 20, 10, N'Networked systemic benchmark')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (21, 21, 21, 4, N'Team-oriented exuding moderator')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (22, 22, 22, 10, N'Horizontal impactful intranet')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (23, 23, 23, 10, N'Polarised 24/7 monitoring')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (24, 24, 24, 3, N'Reverse-engineered stable analyzer')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (25, 25, 25, 7, N'Proactive optimal productivity')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (26, 26, 26, 4, N'Team-oriented responsive service-desk')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (27, 27, 27, 4, N'Advanced bandwidth-monitored orchestration')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (28, 28, 28, 1, N'Secured context-sensitive instruction set')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (29, 29, 29, 10, N'Team-oriented clear-thinking model')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (30, 30, 30, 9, N'Profit-focused secondary archive')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (31, 31, 31, 1, N'Compatible web-enabled strategy')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (32, 32, 32, 2, N'Integrated bi-directional infrastructure')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (33, 33, 33, 4, N'Cross-platform empowering middleware')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (34, 34, 34, 2, N'Persistent explicit methodology')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (35, 35, 35, 6, N'Streamlined asynchronous application')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (36, 36, 36, 3, N'Function-based radical solution')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (37, 37, 37, 1, N'Face to face high-level superstructure')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (38, 38, 38, 6, N'Fully-configurable full-range definition')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (39, 39, 39, 9, N'Progressive grid-enabled matrix')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (40, 40, 40, 4, N'Horizontal solution-oriented data-warehouse')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (41, 41, 41, 9, N'Seamless even-keeled collaboration')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (42, 42, 42, 7, N'Fundamental static throughput')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (43, 43, 43, 5, N'Open-architected even-keeled intranet')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (44, 44, 44, 7, N'Versatile non-volatile neural-net')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (45, 45, 45, 9, N'Synergized reciprocal open system')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (46, 46, 46, 2, N'Triple-buffered 24/7 info-mediaries')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (47, 47, 47, 2, N'Decentralized fault-tolerant groupware')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (48, 48, 48, 8, N'Decentralized eco-centric archive')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (49, 49, 49, 8, N'Automated value-added local area network')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (50, 50, 50, 2, N'Devolved exuding algorithm')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (51, 51, 51, 2, N'Proactive executive challenge')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (52, 52, 52, 5, N'Operative eco-centric middleware')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (53, 53, 53, 10, N'Integrated fault-tolerant emulation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (54, 54, 54, 2, N'Customer-focused cohesive protocol')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (55, 55, 55, 4, N'Compatible directional portal')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (56, 56, 56, 3, N'Persistent exuding adapter')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (57, 57, 57, 5, N'Object-based homogeneous extranet')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (58, 58, 58, 7, N'Innovative 6th generation function')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (59, 59, 59, 4, N'Enterprise-wide global matrices')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (60, 60, 60, 7, N'Synchronised heuristic strategy')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (61, 61, 61, 2, N'Versatile exuding alliance')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (62, 62, 62, 1, N'Secured user-facing implementation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (63, 63, 63, 5, N'Object-based eco-centric neural-net')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (64, 64, 64, 5, N'Enhanced explicit complexity')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (65, 65, 65, 9, N'Down-sized client-driven hardware')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (66, 66, 66, 10, N'Pre-emptive motivating algorithm')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (67, 67, 67, 2, N'Horizontal context-sensitive website')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (68, 68, 68, 1, N'Triple-buffered encompassing emulation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (69, 69, 69, 10, N'Organic upward-trending challenge')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (70, 70, 70, 3, N'Reactive asynchronous definition')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (71, 71, 71, 6, N'Programmable composite projection')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (72, 72, 72, 2, N'Self-enabling even-keeled function')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (73, 73, 73, 9, N'Monitored client-server strategy')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (74, 74, 74, 10, N'Vision-oriented value-added structure')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (75, 75, 75, 8, N'Cross-platform coherent Graphic Interface')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (76, 76, 76, 6, N'Profit-focused fresh-thinking moderator')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (77, 77, 77, 4, N'Extended scalable utilisation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (78, 78, 78, 5, N'Persistent non-volatile alliance')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (79, 79, 79, 3, N'Synergistic contextually-based utilisation')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (80, 80, 80, 8, N'Down-sized encompassing matrices')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (81, 81, 81, 2, N'Diverse fault-tolerant internet solution')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (82, 82, 82, 6, N'Assimilated encompassing extranet')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (83, 83, 83, 10, N'Expanded responsive protocol')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (84, 84, 84, 10, N'Phased bottom-line forecast')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (85, 85, 85, 5, N'Cross-platform demand-driven alliance')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (86, 86, 86, 8, N'Fully-configurable motivating projection')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (87, 87, 87, 10, N'Function-based zero administration complexity')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (88, 88, 88, 2, N'Advanced interactive info-mediaries')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (89, 89, 89, 6, N'Adaptive reciprocal groupware')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (90, 90, 90, 2, N'Managed background local area network')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (91, 91, 91, 4, N'Advanced 24/7 support')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (92, 92, 92, 2, N'Public-key impactful database')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (93, 93, 93, 4, N'De-engineered heuristic workforce')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (94, 94, 94, 5, N'Expanded attitude-oriented standardization')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (95, 95, 95, 4, N'Implemented disintermediate system engine')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (96, 96, 96, 9, N'Expanded solution-oriented pricing structure')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (97, 97, 97, 5, N'Mandatory background hierarchy')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (98, 98, 98, 3, N'Reverse-engineered client-server function')
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (99, 99, 99, 3, N'Grass-roots maximized benchmark')
GO
INSERT [Customer].[CompanyReviews] ([CompanyReviewsID], [CompanyID], [CustomerID], [Rating], [Comments]) VALUES (100, 100, 100, 6, N'Persevering leading edge monitoring')
SET IDENTITY_INSERT [Customer].[CompanyReviews] OFF
SET IDENTITY_INSERT [Customer].[Customer] ON 

INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (0, N'Derrick', N'James', N'Mr', CAST(N'1988-07-29T00:00:00.000' AS DateTime), N'Something new', N'22525', N'Male', N'test@test.com', N'07824698887', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (1, N'Sean', N'Tudor', N'Honorable', CAST(N'1965-02-11T10:27:06.000' AS DateTime), N'0018 Evergreen Park', N'9920', N'Male', N'studor0@pcworld.com', N'(501) 3853967', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (2, N'Dorie', N'Cullinan', N'Dr', CAST(N'1963-07-05T22:19:18.000' AS DateTime), N'36168 Anderson Park', N'41118', N'Male', N'dcullinan1@jimdo.com', N'(103) 2978313', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (3, N'Romola', N'Atterbury', N'Honorable', CAST(N'1976-12-04T23:03:27.000' AS DateTime), N'8275 Blaine Terrace', N'7995', N'Female', N'ratterbury2@bloglovin.com', N'(256) 2352926', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (4, N'Merilyn', N'Fishleigh', N'Mrs', CAST(N'1974-04-09T21:59:32.000' AS DateTime), N'26800 Crownhardt Junction', N'8769', N'Femal', N'mfishleigh3@meetup.com', N'(716) 9197071', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (5, N'Oona', N'Roust', N'Rev', CAST(N'1996-08-26T20:24:28.000' AS DateTime), N'8408 Ramsey Center', N'13549', N'Female', N'oroust4@ustream.tv', N'(203) 3782195', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (6, N'Joelynn', N'Fackrell', N'Mr', CAST(N'1974-06-06T19:57:42.000' AS DateTime), N'40521 5th Crossing', N'13549', N'Female', N'jfackrell5@sbwire.com', N'(645) 8369645', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (7, N'Trev', N'Pantry', N'Mr', CAST(N'1960-06-12T05:42:28.000' AS DateTime), N'54903 Shelley Circle', N'15457', N'Male', N'tpantry6@opensource.org', N'(613) 6411062', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (8, N'Ahmad', N'Hanby', N'Rev', CAST(N'1968-08-22T17:34:52.000' AS DateTime), N'61 Mccormick Road', N'7197', N'Male', N'ahanby7@people.com.cn', N'(369) 5458927', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (9, N'Cornall', N'Lanbertoni', N'Mrs', CAST(N'1951-08-20T03:51:40.000' AS DateTime), N'1 Holy Cross Hill', N'3787', N'Male', N'clanbertoni8@elpais.com', N'(640) 5664324', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (10, N'Any', N'Sansom', N'Rev', CAST(N'1972-11-28T23:23:35.000' AS DateTime), N'2 Burning Wood Circle', N'13549', N'Male', N'asansom9@zdnet.com', N'(930) 4693591', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (11, N'Ewell', N'Hammand', N'Mr', CAST(N'1945-07-01T11:51:06.000' AS DateTime), N'16368 La Follette Drive', N'6551', N'Male', N'ehammanda@surveymonkey.com', N'(234) 3165331', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (12, N'Orion', N'Kleewein', N'Mr', CAST(N'1983-07-10T06:21:07.000' AS DateTime), N'64 Sachs Place', N'179453', N'Male', N'okleeweinb@virginia.edu', N'(336) 5102311', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (13, N'Larina', N'Copyn', N'Mr', CAST(N'1967-01-18T15:47:31.000' AS DateTime), N'810 Anderson Hill', N'44036', N'Female', N'lcopync@jimdo.com', N'(820) 9809803', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (14, N'Barbabas', N'Rapsony', N'Honorable', CAST(N'1986-04-13T12:12:02.000' AS DateTime), N'39 Hollow Ridge Crossing', N'10418', N'Male', N'brapsond@reuters.com', N'(950) 7088055', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (15, N'Marie-ann', N'Forsaith', N'Mr', CAST(N'1959-06-03T14:43:24.000' AS DateTime), N'366 Mesta Hill', N'29895', N'Female', N'mforsaithe@deliciousdays.com', N'(368) 8451526', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (16, N'Suzann', N'McAulay', N'Honorable', CAST(N'1943-12-06T03:16:10.000' AS DateTime), N'12 4th Circle', N'7133', N'Female', N'smcaulayf@wikimedia.org', N'(925) 9744293', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (17, N'Thorin', N'Crutchley', N'Rev', CAST(N'1991-09-17T00:13:22.000' AS DateTime), N'197 Dennis Alley', N'12694', N'Male', N'tcrutchleyg@odnoklassniki.ru', N'(696) 8847301', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (18, N'Steffane', N'Philipart', N'Mr', CAST(N'1953-01-24T20:15:39.000' AS DateTime), N'52 Crowley Terrace', N'17904', N'Female', N'sphiliparth@zdnet.com', N'(114) 6603537', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (19, N'Caressa', N'Brellin', N'Honorable', CAST(N'1979-09-28T11:53:40.000' AS DateTime), N'42 Forest Dale Pass', N'20538', N'Female', N'cbrellini@alibaba.com', N'(561) 3514137', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (20, N'Zelda', N'Itzak', N'Dr', CAST(N'1956-12-07T23:32:13.000' AS DateTime), N'50 Old Shore Lane', N'574646', N'Female', N'zitzakj@examiner.com', N'(870) 7889825', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (21, N'Tiphanie', N'Ninnis', N'Honorable', CAST(N'1986-04-14T02:31:57.000' AS DateTime), N'3733 Kim Center', N'669716', N'Female', N'tninnisk@stumbleupon.com', N'(884) 7691069', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (22, N'Ferdinande', N'Delue', N'Ms', CAST(N'1955-09-17T04:30:22.000' AS DateTime), N'989 Scofield Hill', N'13549', N'Female', N'fdeluel@yandex.ru', N'(652) 1306877', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (23, N'Randy', N'Deighan', N'Mr', CAST(N'1990-01-04T13:33:57.000' AS DateTime), N'07 Kensington Place', N'61924', N'Male', N'rdeighanm@sourceforge.net', N'(421) 4380114', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (24, N'Mylo', N'Ondrus', N'Mr', CAST(N'1987-03-06T11:49:17.000' AS DateTime), N'63 Eliot Park', N'13549', N'Male', N'mondrusn@netlog.com', N'(370) 3504817', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (25, N'Manny', N'Piggford', N'Ms', CAST(N'1975-09-23T11:51:48.000' AS DateTime), N'605 Grim Park', N'1012', N'Male', N'mpiggfordo@free.fr', N'(902) 7198996', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (26, N'Nerita', N'Fenton', N'Mrs', CAST(N'1983-12-24T01:14:00.000' AS DateTime), N'192 Mallard Drive', N'554347', N'Female', N'nfentonp@theatlantic.com', N'(949) 8629887', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (27, N'Sebastien', N'Winkett', N'Mr', CAST(N'1998-03-09T06:19:26.000' AS DateTime), N'2 Longview Junction', N'5975', N'Male', N'swinkettq@seesaa.net', N'(490) 7944377', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (28, N'Sharia', N'Winch', N'Mr', CAST(N'1942-11-24T15:03:06.000' AS DateTime), N'10 Ryan Center', N'5451', N'Female', N'swinchr@yale.edu', N'(676) 8722172', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (29, N'Herta', N'Espinola', N'Rev', CAST(N'1982-03-17T00:00:18.000' AS DateTime), N'4 Village Court', N'28224', N'Female', N'hespinolas@yahoo.com', N'(229) 7784192', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (30, N'Carmelina', N'Chalfont', N'Dr', CAST(N'1977-04-07T23:30:32.000' AS DateTime), N'4869 Straubel Place', N'65402', N'Female', N'cchalfontt@deliciousdays.com', N'(539) 7040885', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (31, N'Beckie', N'Hatrick', N'Ms', CAST(N'1992-10-29T12:33:06.000' AS DateTime), N'811 Mccormick Terrace', N'7793', N'Female', N'bhatricku@simplemachines.org', N'(133) 9676161', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (32, N'Daffie', N'Woodcock', N'Ms', CAST(N'1991-10-07T16:01:27.000' AS DateTime), N'7 Scoville Crossing', N'50316', N'Female', N'dwoodcockv@wufoo.com', N'(808) 9061684', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (33, N'Ermentrude', N'Prose', N'Dr', CAST(N'1966-03-03T00:52:28.000' AS DateTime), N'7540 Old Gate Way', N'6236', N'Female', N'eprosew@narod.ru', N'(551) 1802815', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (34, N'Izaak', N'Innman', N'Mr', CAST(N'1975-04-01T16:14:13.000' AS DateTime), N'720 Stoughton Hill', N'56008', N'Male', N'iinnmanx@hp.com', N'(890) 4137576', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (35, N'Devland', N'Jurs', N'Mr', CAST(N'1945-05-31T03:44:44.000' AS DateTime), N'16 Main Way', N'102761', N'Male', N'djursy@yahoo.com', N'(437) 4970182', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (36, N'Hynda', N'Cromly', N'Ms', CAST(N'1962-09-23T08:27:19.000' AS DateTime), N'93 Meadow Valley Center', N'704688', N'Female', N'hcromlyz@jimdo.com', N'(718) 1979652', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (37, N'Cesare', N'Castagneri', N'Mr', CAST(N'1991-05-30T21:22:42.000' AS DateTime), N'0647 Westerfield Parkway', N'66860', N'Male', N'ccastagneri10@miitbeian.gov.cn', N'(558) 8457898', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (38, N'Corny', N'Duferie', N'Honorable', CAST(N'1994-04-30T19:30:21.000' AS DateTime), N'523 Fallview Trail', N'669716', N'Male', N'cduferie11@yolasite.com', N'(396) 4200761', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (39, N'Abbie', N'Concklin', N'Rev', CAST(N'1956-09-23T05:39:34.000' AS DateTime), N'8434 Monica Plaza', N'106130', N'Female', N'aconcklin12@wsj.com', N'(674) 9312933', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (40, N'Weylin', N'Binford', N'Mr', CAST(N'1953-09-06T08:51:08.000' AS DateTime), N'35 Maple Hill', N'4333', N'Male', N'wbinford13@wiley.com', N'(496) 3706542', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (41, N'Kelley', N'Eardley', N'Honorable', CAST(N'1973-05-26T15:49:36.000' AS DateTime), N'520 Golden Leaf Crossing', N'96654', N'Female', N'keardley14@hatena.ne.jp', N'(514) 1979621', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (42, N'Nikolai', N'Wippermann', N'Honorable', CAST(N'1968-01-24T06:50:18.000' AS DateTime), N'97 Elmside Parkway', N'669716', N'Male', N'nwippermann15@cdbaby.com', N'(407) 6067172', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (43, N'Bryon', N'Pach', N'Dr', CAST(N'1942-05-10T14:30:17.000' AS DateTime), N'931 Dryden Terrace', N'9807', N'Male', N'bpach16@purevolume.com', N'(725) 7084007', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (44, N'Barry', N'Wilmott', N'Dr', CAST(N'1999-01-24T04:12:16.000' AS DateTime), N'969 Amoth Way', N'528341', N'Female', N'bwilmott17@wired.com', N'(967) 7025105', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (45, N'Dyanne', N'Brame', N'Mrs', CAST(N'1961-03-01T02:06:40.000' AS DateTime), N'2 Summer Ridge Alley', N'669716', N'Female', N'dbrame18@dailymail.co.uk', N'(802) 7999175', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (46, N'Brewster', N'O''Cooney', N'Mr', CAST(N'1961-07-27T10:33:35.000' AS DateTime), N'2 Roth Point', N'328580', N'Male', N'bocooney19@sogou.com', N'(833) 6066581', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (47, N'Demott', N'Nisius', N'Honorable', CAST(N'1964-02-13T21:59:00.000' AS DateTime), N'04 Center Street', N'6660', N'Male', N'dnisius1a@examiner.com', N'(387) 4458441', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (48, N'Damita', N'Caseley', N'Rev', CAST(N'1986-12-18T17:54:22.000' AS DateTime), N'4 Petterle Street', N'9263', N'Female', N'dcaseley1b@state.gov', N'(964) 5510890', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (49, N'Erin', N'Aynscombe', N'Rev', CAST(N'1970-06-10T16:45:52.000' AS DateTime), N'7628 Elgar Plaza', N'5627', N'Male', N'eaynscombe1c@mlb.com', N'(261) 8348842', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (50, N'Devan', N'Gouda', N'Ms', CAST(N'1947-02-18T19:00:20.000' AS DateTime), N'251 Orin Drive', N'377021', N'Female', N'dgouda1d@histats.com', N'(649) 9734267', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (51, N'Etta', N'Ascrofte', N'Rev', CAST(N'1944-01-23T10:31:39.000' AS DateTime), N'6 La Follette Parkway', N'20077', N'Female', N'eascrofte1e@surveymonkey.com', N'(579) 5166831', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (52, N'Haven', N'Woodall', N'Honorable', CAST(N'1972-11-23T19:52:11.000' AS DateTime), N'6822 Carey Trail', N'908', N'Male', N'hwoodall1f@mysql.com', N'(281) 5668456', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (53, N'Gary', N'Bletso', N'Dr', CAST(N'1955-09-17T22:44:00.000' AS DateTime), N'23223 Vernon Crossing', N'724961', N'Male', N'gbletso1g@ihg.com', N'(166) 7239686', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (54, N'Ned', N'Roft', N'Rev', CAST(N'1990-03-03T03:01:14.000' AS DateTime), N'56 Atwood Hill', N'528341', N'Male', N'nroft1h@hexun.com', N'(731) 2241736', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (55, N'Averil', N'Dict', N'Dr', CAST(N'1975-01-16T13:29:48.000' AS DateTime), N'41 Green Ridge Parkway', N'528341', N'Female', N'adict1i@privacy.gov.au', N'(820) 9206471', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (56, N'Trever', N'Leggin', N'Rev', CAST(N'1996-07-12T21:12:01.000' AS DateTime), N'7 Cody Crossing', N'528341', N'Male', N'tleggin1j@boston.com', N'(721) 6838351', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (57, N'Maible', N'Melendez', N'Honorable', CAST(N'1983-06-10T02:52:22.000' AS DateTime), N'678 Lillian Junction', N'528341', N'Female', N'mmelendez1k@vistaprint.com', N'(419) 1680915', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (58, N'Etheline', N'O''Fihily', N'Mr', CAST(N'1975-11-12T20:19:42.000' AS DateTime), N'86304 Iowa Park', N'9296', N'Female', N'eofihily1l@constantcontact.com', N'(431) 1863916', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (59, N'Dov', N'Weston', N'Ms', CAST(N'1987-07-23T17:22:11.000' AS DateTime), N'69 Thompson Point', N'528341', N'Male', N'dweston1m@angelfire.com', N'(414) 1157856', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (60, N'Braden', N'Lyles', N'Mr', CAST(N'1957-01-07T19:35:34.000' AS DateTime), N'0913 Northfield Hill', N'4037', N'Male', N'blyles1n@prnewswire.com', N'(670) 1325544', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (61, N'Zita', N'Union', N'Mrs', CAST(N'1987-09-19T06:40:17.000' AS DateTime), N'44 Thackeray Place', N'63944', N'Female', N'zunion1o@ted.com', N'(111) 4523255', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (62, N'Dina', N'Cohani', N'Mrs', CAST(N'1957-08-17T14:35:46.000' AS DateTime), N'509 Cherokee Plaza', N'63944', N'Female', N'dcohani1p@wordpress.org', N'(762) 9589335', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (63, N'Kendre', N'Danelet', N'Dr', CAST(N'1944-12-10T22:01:31.000' AS DateTime), N'68 Talmadge Center', N'10955', N'Female', N'kdanelet1q@auda.org.au', N'(906) 2976857', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (64, N'Town', N'Sagrott', N'Mrs', CAST(N'1971-11-02T21:23:03.000' AS DateTime), N'03858 Springview Center', N'528341', N'Male', N'tsagrott1r@google.pl', N'(144) 3316546', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (65, N'Danella', N'Skipp', N'Mr', CAST(N'1961-09-27T13:24:36.000' AS DateTime), N'31 Warrior Way', N'6466', N'Female', N'dskipp1s@admin.ch', N'(775) 9706336', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (66, N'Ray', N'Shekle', N'Mr', CAST(N'1974-08-27T19:51:43.000' AS DateTime), N'93861 Bayside Parkway', N'72471', N'Female', N'rshekle1t@dailymail.co.uk', N'(966) 1850347', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (67, N'Christine', N'Ough', N'Ms', CAST(N'1988-05-01T08:26:50.000' AS DateTime), N'41448 Transport Center', N'572546', N'Female', N'cough1u@networkadvertising.org', N'(557) 2924405', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (68, N'Jacinta', N'Brokenshaw', N'Honorable', CAST(N'1991-06-22T21:01:17.000' AS DateTime), N'92801 Donald Plaza', N'8604', N'Female', N'jbrokenshaw1v@sina.com.cn', N'(675) 1876666', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (69, N'Beatrisa', N'Drennan', N'Dr', CAST(N'1948-02-18T20:08:27.000' AS DateTime), N'7 Warbler Point', N'528341', N'Female', N'bdrennan1w@elpais.com', N'(654) 2454141', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (70, N'Bryna', N'Andrewartha', N'Mr', CAST(N'1963-12-21T10:38:15.000' AS DateTime), N'5220 Myrtle Lane', N'6189', N'Female', N'bandrewartha1x@hibu.com', N'(573) 7609356', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (71, N'Inigo', N'Jenkerson', N'Mr', CAST(N'1982-08-06T01:59:24.000' AS DateTime), N'4 David Pass', N'528341', N'Male', N'ijenkerson1y@fema.gov', N'(555) 6125855', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (72, N'Lurlene', N'Foale', N'Ms', CAST(N'1972-08-04T12:30:22.000' AS DateTime), N'6 Welch Street', N'528341', N'Female', N'lfoale1z@wsj.com', N'(685) 3348910', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (73, N'Ina', N'Patrick', N'Rev', CAST(N'1999-11-12T05:48:57.000' AS DateTime), N'49 Daystar Terrace', N'74945', N'Female', N'ipatrick20@behance.net', N'(437) 8575818', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (74, N'Leroi', N'Blackesland', N'Ms', CAST(N'1995-07-28T13:09:02.000' AS DateTime), N'5772 Mayer Junction', N'2779', N'Male', N'lblackesland21@addtoany.com', N'(645) 1373902', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (75, N'Brandice', N'Dysart', N'Rev', CAST(N'1990-03-28T19:21:27.000' AS DateTime), N'06010 Anzinger Terrace', N'528341', N'Female', N'bdysart22@cyberchimps.com', N'(540) 8800704', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (76, N'Taylor', N'Franey', N'Dr', CAST(N'1981-05-15T10:22:00.000' AS DateTime), N'14057 South Trail', N'58565', N'Male', N'tfraney23@sourceforge.net', N'(990) 4505547', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (77, N'Feliks', N'Pidding', N'Rev', CAST(N'1979-09-01T12:23:10.000' AS DateTime), N'9659 Maryland Plaza', N'2779', N'Male', N'fpiddington24@theatlantic.com', N'(934) 1310160', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (78, N'Perry', N'Charte', N'Rev', CAST(N'1995-11-22T04:30:36.000' AS DateTime), N'262 Scoville Lane', N'2779', N'Male', N'pcharte25@fotki.com', N'(786) 2379235', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (79, N'Sheff', N'Caswill', N'Rev', CAST(N'1944-05-26T11:56:07.000' AS DateTime), N'8 Dryden Plaza', N'2779', N'Male', N'scaswill26@ebay.co.uk', N'(141) 8690514', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (80, N'Doralin', N'Mucklow', N'Mrs', CAST(N'1987-03-23T01:34:12.000' AS DateTime), N'52070 Dunning Pass', N'51306', N'Female', N'dmucklow27@businesswire.com', N'(517) 8179059', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (81, N'Dusty', N'Wyard', N'Dr', CAST(N'1943-12-19T22:53:06.000' AS DateTime), N'1450 8th Plaza', N'394933', N'Female', N'dwyard28@com.com', N'(196) 5699293', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (82, N'Dorie', N'Clemendot', N'Mr', CAST(N'1995-08-07T21:39:02.000' AS DateTime), N'38 Manitowish Pass', N'3461', N'Male', N'dclemendot29@psu.edu', N'(134) 5833237', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (83, N'Christoph', N'Slucock', N'Rev', CAST(N'1962-01-30T23:57:55.000' AS DateTime), N'76 Delladonna Parkway', N'51306', N'Male', N'cslucock2a@comsenz.com', N'(198) 8080153', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (84, N'Carol-jean', N'Spurgin', N'Honorable', CAST(N'1943-05-09T04:29:44.000' AS DateTime), N'700 Dorton Terrace', N'90820', N'Female', N'cspurgin2b@archive.org', N'(575) 2686723', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (85, N'Ward', N'Lonie', N'Honorable', CAST(N'1948-09-28T06:21:14.000' AS DateTime), N'0449 Oneill Plaza', N'51306', N'Male', N'wlonie2c@rakuten.co.jp', N'(243) 7113555', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (86, N'Germaine', N'Lindroos', N'Ms', CAST(N'1943-11-09T02:21:06.000' AS DateTime), N'37 Colorado Center', N'171', N'Female', N'glindroos2d@yale.edu', N'(757) 8033599', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (87, N'Audrye', N'Horning', N'Mrs', CAST(N'1996-12-16T16:23:36.000' AS DateTime), N'7984 6th Terrace', N'32014', N'Female', N'ahorning2e@yellowbook.com', N'(610) 2104095', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (88, N'Bill', N'Safell', N'Mr', CAST(N'1961-06-17T09:49:36.000' AS DateTime), N'16190 Grim Crossing', N'6444', N'Male', N'bsafell2f@unesco.org', N'(115) 5619616', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (89, N'Jessy', N'Petr', N'Ms', CAST(N'1969-08-26T09:12:39.000' AS DateTime), N'954 Nevada Pass', N'40320', N'Female', N'jpetr2g@woothemes.com', N'(499) 3101814', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (90, N'Alva', N'Lippiatt', N'Honorable', CAST(N'1982-05-02T14:04:44.000' AS DateTime), N'9 Johnson Circle', N'235400', N'Male', N'alippiatt2h@ted.com', N'(883) 4830083', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (91, N'Sheba', N'Clewley', N'Dr', CAST(N'1970-10-11T03:37:56.000' AS DateTime), N'19323 Anniversary Center', N'22833', N'Female', N'sclewley2i@who.int', N'(205) 9471805', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (92, N'Alick', N'Ducker', N'Mrs', CAST(N'1941-06-30T08:38:47.000' AS DateTime), N'0927 Northport Alley', N'51306', N'Male', N'aducker2j@facebook.com', N'(402) 2604994', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (93, N'Maggi', N'Pepperill', N'Honorable', CAST(N'1995-02-15T18:33:26.000' AS DateTime), N'30110 Washington Point', N'825684', N'Female', N'mpepperill2k@posterous.com', N'(374) 5496382', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (94, N'Marilyn', N'Clerke', N'Mrs', CAST(N'1953-02-23T06:37:50.000' AS DateTime), N'88601 Hoepker Way', N'68905', N'Female', N'mclerke2l@meetup.com', N'(357) 2510804', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (95, N'Neysa', N'Paulin', N'Dr', CAST(N'1972-04-02T20:54:16.000' AS DateTime), N'998 Mockingbird Drive', N'36145', N'Female', N'npaulin2m@un.org', N'(540) 5316861', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (96, N'Elene', N'Busk', N'Mrs', CAST(N'1942-04-07T05:13:19.000' AS DateTime), N'31 Grim Center', N'1327', N'Female', N'ebusk2n@nsw.gov.au', N'(477) 5252242', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (97, N'Geri', N'O''Hingerty', N'Mrs', CAST(N'1943-06-20T13:53:11.000' AS DateTime), N'9296 Brentwood Pass', N'1327', N'Female', N'gohingerty2o@usgs.gov', N'(470) 6158621', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (98, N'Lynda', N'Bocke', N'Ms', CAST(N'1991-01-25T11:50:42.000' AS DateTime), N'51 Farmco Parkway', N'20185', N'Female', N'lbocke2p@huffingtonpost.com', N'(213) 5088615', 1)
GO
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (99, N'Petrina', N'Wemm', N'Mr', CAST(N'1962-08-19T07:18:08.000' AS DateTime), N'47936 Spaight Place', N'65177', N'Female', N'pwemm2q@europa.eu', N'(543) 2406179', 0)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (100, N'Thaddus', N'Vannozzii', N'Rev', CAST(N'1940-12-21T22:06:49.000' AS DateTime), N'01 Commercial Junction', N'50813', N'Male', N'tvannozzii2r@prlog.org', N'(472) 4419886', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (101, N'Adam', N'Smith', N'Dr', CAST(N'1988-07-29T00:00:00.000' AS DateTime), N'17 Roebay Close', N'DH6 2LH', N'Male', N'Smith@test.com', N'07824698886', 1)
INSERT [Customer].[Customer] ([CustomerId], [FirstName], [LastName], [Title], [DateOfBirth], [Address], [Postcode], [Gender], [Email], [PhoneNumber], [Active]) VALUES (102, N'TESTAGAIN', N'TESTAGAIN', N'Mr', CAST(N'1963-07-05T22:19:18.000' AS DateTime), N'16 Test Test', N'dh6 2pd ', N'Male', N'test@test.com', N'07824695644', 1)
SET IDENTITY_INSERT [Customer].[Customer] OFF
INSERT [dbo].[Events] ([EventID], [BookingID], [Subject], [Description], [Start], [End], [ThemeColor], [IsFullDay]) VALUES (1, 10, N'24 Hour Car Hire', N'24h rental for customer Mr S. Smith', CAST(N'2018-03-28T07:00:00.000' AS DateTime), CAST(N'2017-06-26T10:00:00.000' AS DateTime), N'Red', 0)
INSERT [dbo].[Events] ([EventID], [BookingID], [Subject], [Description], [Start], [End], [ThemeColor], [IsFullDay]) VALUES (2, 11, N'1 week Rental', N'1w rental for good customer mr B Kent', CAST(N'2018-03-26T07:30:26.123' AS DateTime), CAST(N'2018-03-26T10:00:00.000' AS DateTime), N'Orange', 0)
INSERT [dbo].[Events] ([EventID], [BookingID], [Subject], [Description], [Start], [End], [ThemeColor], [IsFullDay]) VALUES (3, 12, N'Jaguar Rental', N'JagRent - Must have everything ready!!!', CAST(N'2018-03-28T07:00:00.000' AS DateTime), CAST(N'2018-03-28T10:00:00.000' AS DateTime), N'Green', 0)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [EmailID], [DateOfBirth], [Password], [ConfirmPassword], [IsEmailVerified], [ActivationCode], [ResetPasswordCode], [CustomerId]) VALUES (3, N'Adam', N'Smith', N'Smith06@hotmail.co.uk', CAST(N'1988-07-29T00:00:00.000' AS DateTime), N'5mhgVG8YzbvNhrNeGLUlv/xn93LGUM7f4/96ACb6He4=', N'5mhgVG8YzbvNhrNeGLUlv/xn93LGUM7f4/96ACb6He4=', 1, N'e25bea76-5a9a-445d-98f0-1ef1f19c555e', N'', NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [EmailID], [DateOfBirth], [Password], [ConfirmPassword], [IsEmailVerified], [ActivationCode], [ResetPasswordCode], [CustomerId]) VALUES (5, N'Adam ', N'Smith', N'Smith.as@gmail.com', CAST(N'1988-07-29T00:00:00.000' AS DateTime), N'5mhgVG8YzbvNhrNeGLUlv/xn93LGUM7f4/96ACb6He4=', N'5mhgVG8YzbvNhrNeGLUlv/xn93LGUM7f4/96ACb6He4=', 0, N'629e6d71-feb7-4da8-887a-d9d00cc040b2', NULL, NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [EmailID], [DateOfBirth], [Password], [ConfirmPassword], [IsEmailVerified], [ActivationCode], [ResetPasswordCode], [CustomerId]) VALUES (8, N'ADam', N'Smith', N'Smith06.as@gmail.com', CAST(N'1988-07-29T00:00:00.000' AS DateTime), N'qzjq2ut0ZZnywe6Q+CZ/MfRnNHRidkok1xrBhD7nf+M=', N'qzjq2ut0ZZnywe6Q+CZ/MfRnNHRidkok1xrBhD7nf+M=', 1, N'cac7eb6b-943d-49a7-bf6f-8a68e2853138', N'', NULL)
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [EmailID], [DateOfBirth], [Password], [ConfirmPassword], [IsEmailVerified], [ActivationCode], [ResetPasswordCode], [CustomerId]) VALUES (7, N'TestName', N'TestName', N'Test@test.com', CAST(N'1988-07-29T00:00:00.000' AS DateTime), N'qzjq2ut0ZZnywe6Q+CZ/MfRnNHRidkok1xrBhD7nf+M=', N'qzjq2ut0ZZnywe6Q+CZ/MfRnNHRidkok1xrBhD7nf+M=', 0, N'dbfb8ff2-e7e0-465a-8f70-724e893e71ad', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [Equipment].[Equiptment] ON 

INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (1, 38, N'vitae')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (2, 5, N'consequat')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (3, 41, N'nulla')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (4, 23, N'eleifend')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (5, 1, N'risus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (6, 4, N'nunc')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (7, 42, N'phasellus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (8, 39, N'ante')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (9, 8, N'metus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (10, 22, N'nulla')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (11, 27, N'nascetur')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (12, 25, N'diam')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (13, 37, N'cras')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (14, 26, N'metus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (15, 20, N'montes')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (16, 1, N'odio')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (17, 45, N'enim')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (18, 21, N'nisl')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (19, 29, N'accumsan')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (20, 13, N'rutrum')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (21, 14, N'donec')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (22, 15, N'maecenas')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (23, 36, N'neque')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (24, 5, N'luctus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (25, 21, N'aenean')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (26, 11, N'neque')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (27, 27, N'at')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (28, 20, N'vulputate')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (29, 18, N'eget')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (30, 12, N'nunc')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (31, 12, N'lectus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (32, 20, N'cubilia')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (33, 44, N'nunc')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (34, 43, N'a')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (35, 34, N'est')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (36, 36, N'ac')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (37, 18, N'morbi')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (38, 19, N'ut')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (39, 27, N'sollicitudin')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (40, 7, N'nisi')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (41, 8, N'non')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (42, 44, N'posuere')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (43, 8, N'quis')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (44, 42, N'praesent')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (45, 49, N'phasellus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (46, 5, N'id')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (47, 11, N'lacus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (48, 25, N'sapien')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (49, 28, N'etiam')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (50, 12, N'convallis')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (51, 25, N'vitae')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (52, 30, N'ante')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (53, 15, N'consectetuer')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (54, 20, N'eleifend')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (55, 47, N'ante')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (56, 4, N'sit')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (57, 6, N'cursus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (58, 27, N'est')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (59, 9, N'justo')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (60, 19, N'eu')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (61, 32, N'a')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (62, 14, N'ut')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (63, 36, N'habitasse')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (64, 46, N'sapien')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (65, 2, N'felis')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (66, 11, N'magna')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (67, 11, N'nam')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (68, 11, N'dictumst')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (69, 13, N'mi')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (70, 43, N'magnis')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (71, 48, N'erat')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (72, 26, N'donec')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (73, 38, N'ridiculus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (74, 39, N'lacinia')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (75, 49, N'amet')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (76, 16, N'orci')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (77, 43, N'donec')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (78, 46, N'non')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (79, 6, N'augue')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (80, 39, N'pede')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (81, 47, N'tempor')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (82, 45, N'nullam')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (83, 39, N'dapibus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (84, 42, N'magna')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (85, 38, N'pellentesque')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (86, 23, N'dolor')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (87, 7, N'vulputate')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (88, 19, N'nullam')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (89, 2, N'sapien')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (90, 25, N'mauris')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (91, 31, N'venenatis')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (92, 26, N'in')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (93, 11, N'semper')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (94, 33, N'est')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (95, 12, N'ipsum')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (96, 6, N'phasellus')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (97, 9, N'in')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (98, 11, N'elementum')
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (99, 37, N'vestibulum')
GO
INSERT [Equipment].[Equiptment] ([EquiptmentID], [EquiptmentTypeID], [EquiptmentName]) VALUES (100, 44, N'dapibus')
SET IDENTITY_INSERT [Equipment].[Equiptment] OFF
SET IDENTITY_INSERT [Equipment].[EquiptmentType] ON 

INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (1, N'bibendum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (2, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (3, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (4, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (5, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (6, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (7, N'porttitor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (8, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (9, N'dictumst')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (10, N'malesuada')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (11, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (12, N'pretium')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (13, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (14, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (15, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (16, N'magna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (17, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (18, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (19, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (20, N'tristique')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (21, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (22, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (23, N'platea')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (24, N'sociis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (25, N'sodales')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (26, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (27, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (28, N'penatibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (29, N'rhoncus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (30, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (31, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (32, N'lacus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (33, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (34, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (35, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (36, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (37, N'cubilia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (38, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (39, N'magna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (40, N'cum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (41, N'mi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (42, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (43, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (44, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (45, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (46, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (47, N'tristique')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (48, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (49, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (50, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (51, N'suspendisse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (52, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (53, N'suspendisse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (54, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (55, N'purus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (56, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (57, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (58, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (59, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (60, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (61, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (62, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (63, N'tellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (64, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (65, N'primis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (66, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (67, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (68, N'lobortis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (69, N'potenti')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (70, N'arcu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (71, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (72, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (73, N'magna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (74, N'tortor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (75, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (76, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (77, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (78, N'leo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (79, N'pharetra')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (80, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (81, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (82, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (83, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (84, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (85, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (86, N'cubilia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (87, N'venenatis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (88, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (89, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (90, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (91, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (92, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (93, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (94, N'tortor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (95, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (96, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (97, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (98, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (99, N'ut')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (100, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (101, N'ridiculus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (102, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (103, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (104, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (105, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (106, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (107, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (108, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (109, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (110, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (111, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (112, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (113, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (114, N'fusce')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (115, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (116, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (117, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (118, N'rhoncus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (119, N'sociis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (120, N'porta')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (121, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (122, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (123, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (124, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (125, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (126, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (127, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (128, N'mattis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (129, N'velit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (130, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (131, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (132, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (133, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (134, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (135, N'habitasse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (136, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (137, N'interdum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (138, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (139, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (140, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (141, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (142, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (143, N'pretium')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (144, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (145, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (146, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (147, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (148, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (149, N'nisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (150, N'mi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (151, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (152, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (153, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (154, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (155, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (156, N'libero')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (157, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (158, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (159, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (160, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (161, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (162, N'iaculis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (163, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (164, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (165, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (166, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (167, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (168, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (169, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (170, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (171, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (172, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (173, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (174, N'dictumst')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (175, N'risus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (176, N'sodales')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (177, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (178, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (179, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (180, N'molestie')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (181, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (182, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (183, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (184, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (185, N'nisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (186, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (187, N'aenean')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (188, N'lorem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (189, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (190, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (191, N'tellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (192, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (193, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (194, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (195, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (196, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (197, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (198, N'maecenas')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (199, N'mi')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (200, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (201, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (202, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (203, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (204, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (205, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (206, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (207, N'habitasse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (208, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (209, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (210, N'phasellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (211, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (212, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (213, N'interdum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (214, N'faucibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (215, N'porttitor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (216, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (217, N'urna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (218, N'sollicitudin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (219, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (220, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (221, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (222, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (223, N'curae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (224, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (225, N'accumsan')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (226, N'tincidunt')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (227, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (228, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (229, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (230, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (231, N'cursus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (232, N'praesent')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (233, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (234, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (235, N'faucibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (236, N'eleifend')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (237, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (238, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (239, N'congue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (240, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (241, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (242, N'platea')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (243, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (244, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (245, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (246, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (247, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (248, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (249, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (250, N'libero')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (251, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (252, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (253, N'urna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (254, N'aenean')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (255, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (256, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (257, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (258, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (259, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (260, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (261, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (262, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (263, N'ornare')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (264, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (265, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (266, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (267, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (268, N'magna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (269, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (270, N'faucibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (271, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (272, N'leo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (273, N'sollicitudin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (274, N'porttitor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (275, N'potenti')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (276, N'interdum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (277, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (278, N'rhoncus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (279, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (280, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (281, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (282, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (283, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (284, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (285, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (286, N'accumsan')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (287, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (288, N'cubilia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (289, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (290, N'nonummy')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (291, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (292, N'praesent')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (293, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (294, N'fusce')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (295, N'mi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (296, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (297, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (298, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (299, N'morbi')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (300, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (301, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (302, N'sollicitudin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (303, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (304, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (305, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (306, N'cubilia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (307, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (308, N'varius')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (309, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (310, N'etiam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (311, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (312, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (313, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (314, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (315, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (316, N'fermentum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (317, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (318, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (319, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (320, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (321, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (322, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (323, N'nascetur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (324, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (325, N'dolor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (326, N'lorem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (327, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (328, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (329, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (330, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (331, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (332, N'penatibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (333, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (334, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (335, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (336, N'enim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (337, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (338, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (339, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (340, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (341, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (342, N'aliquet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (343, N'curae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (344, N'enim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (345, N'integer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (346, N'libero')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (347, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (348, N'viverra')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (349, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (350, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (351, N'libero')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (352, N'mollis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (353, N'mi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (354, N'penatibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (355, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (356, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (357, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (358, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (359, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (360, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (361, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (362, N'maecenas')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (363, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (364, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (365, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (366, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (367, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (368, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (369, N'etiam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (370, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (371, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (372, N'lobortis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (373, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (374, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (375, N'sollicitudin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (376, N'suspendisse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (377, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (378, N'suscipit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (379, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (380, N'sociis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (381, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (382, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (383, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (384, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (385, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (386, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (387, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (388, N'auctor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (389, N'magnis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (390, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (391, N'neque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (392, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (393, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (394, N'ridiculus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (395, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (396, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (397, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (398, N'hendrerit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (399, N'commodo')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (400, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (401, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (402, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (403, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (404, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (405, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (406, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (407, N'accumsan')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (408, N'velit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (409, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (410, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (411, N'molestie')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (412, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (413, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (414, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (415, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (416, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (417, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (418, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (419, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (420, N'neque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (421, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (422, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (423, N'purus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (424, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (425, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (426, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (427, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (428, N'aenean')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (429, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (430, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (431, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (432, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (433, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (434, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (435, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (436, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (437, N'pretium')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (438, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (439, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (440, N'leo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (441, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (442, N'nam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (443, N'dictumst')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (444, N'phasellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (445, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (446, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (447, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (448, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (449, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (450, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (451, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (452, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (453, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (454, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (455, N'phasellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (456, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (457, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (458, N'dignissim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (459, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (460, N'libero')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (461, N'nibh')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (462, N'tortor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (463, N'magna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (464, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (465, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (466, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (467, N'neque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (468, N'faucibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (469, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (470, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (471, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (472, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (473, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (474, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (475, N'tortor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (476, N'etiam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (477, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (478, N'pharetra')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (479, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (480, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (481, N'tristique')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (482, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (483, N'scelerisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (484, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (485, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (486, N'nibh')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (487, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (488, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (489, N'tincidunt')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (490, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (491, N'purus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (492, N'dictumst')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (493, N'eleifend')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (494, N'libero')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (495, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (496, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (497, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (498, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (499, N'velit')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (500, N'lorem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (501, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (502, N'sodales')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (503, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (504, N'enim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (505, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (506, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (507, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (508, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (509, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (510, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (511, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (512, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (513, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (514, N'venenatis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (515, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (516, N'faucibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (517, N'fusce')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (518, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (519, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (520, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (521, N'aliquet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (522, N'lacus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (523, N'dolor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (524, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (525, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (526, N'lorem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (527, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (528, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (529, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (530, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (531, N'blandit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (532, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (533, N'posuere')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (534, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (535, N'nam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (536, N'condimentum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (537, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (538, N'augue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (539, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (540, N'etiam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (541, N'platea')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (542, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (543, N'pharetra')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (544, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (545, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (546, N'praesent')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (547, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (548, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (549, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (550, N'accumsan')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (551, N'phasellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (552, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (553, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (554, N'gravida')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (555, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (556, N'eleifend')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (557, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (558, N'augue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (559, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (560, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (561, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (562, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (563, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (564, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (565, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (566, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (567, N'tincidunt')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (568, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (569, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (570, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (571, N'augue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (572, N'consectetuer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (573, N'dis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (574, N'hac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (575, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (576, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (577, N'nam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (578, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (579, N'platea')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (580, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (581, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (582, N'integer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (583, N'nibh')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (584, N'urna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (585, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (586, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (587, N'mi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (588, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (589, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (590, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (591, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (592, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (593, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (594, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (595, N'venenatis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (596, N'venenatis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (597, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (598, N'tempor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (599, N'ultrices')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (600, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (601, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (602, N'neque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (603, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (604, N'facilisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (605, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (606, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (607, N'risus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (608, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (609, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (610, N'risus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (611, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (612, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (613, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (614, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (615, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (616, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (617, N'lorem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (618, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (619, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (620, N'tellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (621, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (622, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (623, N'tincidunt')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (624, N'duis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (625, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (626, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (627, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (628, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (629, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (630, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (631, N'velit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (632, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (633, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (634, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (635, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (636, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (637, N'mattis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (638, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (639, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (640, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (641, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (642, N'congue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (643, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (644, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (645, N'hac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (646, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (647, N'porttitor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (648, N'ullamcorper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (649, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (650, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (651, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (652, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (653, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (654, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (655, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (656, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (657, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (658, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (659, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (660, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (661, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (662, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (663, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (664, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (665, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (666, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (667, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (668, N'nisl')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (669, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (670, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (671, N'nullam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (672, N'scelerisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (673, N'velit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (674, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (675, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (676, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (677, N'mi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (678, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (679, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (680, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (681, N'phasellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (682, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (683, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (684, N'interdum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (685, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (686, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (687, N'praesent')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (688, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (689, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (690, N'imperdiet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (691, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (692, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (693, N'tristique')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (694, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (695, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (696, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (697, N'enim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (698, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (699, N'vulputate')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (700, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (701, N'nascetur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (702, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (703, N'lacus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (704, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (705, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (706, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (707, N'ultricies')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (708, N'interdum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (709, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (710, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (711, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (712, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (713, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (714, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (715, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (716, N'primis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (717, N'leo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (718, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (719, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (720, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (721, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (722, N'vivamus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (723, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (724, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (725, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (726, N'sed')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (727, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (728, N'varius')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (729, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (730, N'porta')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (731, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (732, N'integer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (733, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (734, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (735, N'risus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (736, N'nibh')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (737, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (738, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (739, N'cum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (740, N'accumsan')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (741, N'ligula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (742, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (743, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (744, N'magnis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (745, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (746, N'pretium')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (747, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (748, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (749, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (750, N'augue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (751, N'dolor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (752, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (753, N'morbi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (754, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (755, N'tempor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (756, N'integer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (757, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (758, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (759, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (760, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (761, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (762, N'fusce')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (763, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (764, N'velit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (765, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (766, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (767, N'quis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (768, N'dui')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (769, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (770, N'nibh')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (771, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (772, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (773, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (774, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (775, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (776, N'quisque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (777, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (778, N'eleifend')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (779, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (780, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (781, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (782, N'eleifend')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (783, N'magna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (784, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (785, N'imperdiet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (786, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (787, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (788, N'nam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (789, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (790, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (791, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (792, N'feugiat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (793, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (794, N'tempus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (795, N'sollicitudin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (796, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (797, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (798, N'suscipit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (799, N'porttitor')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (800, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (801, N'est')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (802, N'sem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (803, N'nascetur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (804, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (805, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (806, N'platea')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (807, N'lacus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (808, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (809, N'laoreet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (810, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (811, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (812, N'leo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (813, N'eros')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (814, N'habitasse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (815, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (816, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (817, N'bibendum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (818, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (819, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (820, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (821, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (822, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (823, N'urna')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (824, N'venenatis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (825, N'vel')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (826, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (827, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (828, N'fermentum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (829, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (830, N'dis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (831, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (832, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (833, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (834, N'maecenas')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (835, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (836, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (837, N'tincidunt')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (838, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (839, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (840, N'vehicula')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (841, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (842, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (843, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (844, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (845, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (846, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (847, N'vitae')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (848, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (849, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (850, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (851, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (852, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (853, N'augue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (854, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (855, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (856, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (857, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (858, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (859, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (860, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (861, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (862, N'enim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (863, N'accumsan')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (864, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (865, N'mattis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (866, N'non')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (867, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (868, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (869, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (870, N'nisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (871, N'nec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (872, N'ac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (873, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (874, N'augue')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (875, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (876, N'lacinia')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (877, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (878, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (879, N'convallis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (880, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (881, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (882, N'integer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (883, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (884, N'ultricies')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (885, N'consequat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (886, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (887, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (888, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (889, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (890, N'ultrices')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (891, N'adipiscing')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (892, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (893, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (894, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (895, N'ornare')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (896, N'nam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (897, N'neque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (898, N'nulla')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (899, N'sagittis')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (900, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (901, N'sapien')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (902, N'donec')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (903, N'purus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (904, N'montes')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (905, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (906, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (907, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (908, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (909, N'fusce')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (910, N'porta')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (911, N'semper')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (912, N'integer')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (913, N'lectus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (914, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (915, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (916, N'risus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (917, N'elit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (918, N'suspendisse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (919, N'penatibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (920, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (921, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (922, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (923, N'sociis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (924, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (925, N'mauris')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (926, N'odio')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (927, N'lacus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (928, N'orci')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (929, N'curabitur')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (930, N'amet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (931, N'faucibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (932, N'id')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (933, N'arcu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (934, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (935, N'aliquam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (936, N'dolor')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (937, N'vestibulum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (938, N'tincidunt')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (939, N'maecenas')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (940, N'in')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (941, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (942, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (943, N'quam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (944, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (945, N'hac')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (946, N'sagittis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (947, N'elementum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (948, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (949, N'facilisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (950, N'sit')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (951, N'cras')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (952, N'felis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (953, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (954, N'tellus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (955, N'habitasse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (956, N'nisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (957, N'justo')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (958, N'lorem')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (959, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (960, N'eget')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (961, N'massa')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (962, N'turpis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (963, N'metus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (964, N'eu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (965, N'dapibus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (966, N'potenti')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (967, N'nibh')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (968, N'nunc')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (969, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (970, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (971, N'enim')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (972, N'bibendum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (973, N'pellentesque')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (974, N'mollis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (975, N'vulputate')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (976, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (977, N'pede')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (978, N'a')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (979, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (980, N'ante')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (981, N'arcu')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (982, N'sociis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (983, N'aliquet')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (984, N'habitasse')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (985, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (986, N'ipsum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (987, N'nisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (988, N'nisi')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (989, N'praesent')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (990, N'at')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (991, N'erat')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (992, N'diam')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (993, N'luctus')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (994, N'lobortis')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (995, N'et')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (996, N'ut')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (997, N'proin')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (998, N'rutrum')
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (999, N'consectetuer')
GO
INSERT [Equipment].[EquiptmentType] ([EquiptmentTypeID], [EquiptmentTypeName]) VALUES (1000, N'vestibulum')
SET IDENTITY_INSERT [Equipment].[EquiptmentType] OFF
SET IDENTITY_INSERT [Services].[EquiptmentNeeded] ON 

INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (1, 4, 45, 747)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (2, 12, 38, 333)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (3, 6, 53, 863)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (4, 10, 18, 199)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (5, 6, 59, 503)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (6, 9, 63, 891)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (7, 3, 50, 617)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (8, 6, 31, 872)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (9, 7, 40, 752)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (10, 5, 12, 493)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (11, 8, 61, 35)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (13, 2, 85, 368)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (14, 1, 71, 503)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (15, 12, 70, 903)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (16, 7, 16, 292)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (17, 2, 31, 998)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (18, 8, 19, 180)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (19, 6, 65, 562)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (20, 7, 51, 125)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (21, 7, 62, 18)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (22, 9, 83, 492)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (23, 12, 15, 594)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (24, 7, 73, 992)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (25, 3, 21, 192)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (26, 3, 60, 958)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (27, 12, 88, 912)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (28, 10, 88, 641)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (29, 3, 89, 608)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (30, 8, 68, 653)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (31, 11, 89, 592)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (32, 2, 24, 992)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (33, 12, 15, 386)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (34, 9, 39, 12)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (35, 5, 4, 604)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (36, 5, 75, 899)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (37, 11, 3, 745)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (38, 8, 21, 210)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (39, 8, 25, 331)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (40, 6, 83, 799)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (41, 3, 85, 196)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (43, 9, 23, 174)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (44, 9, 71, 655)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (45, 7, 8, 848)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (46, 10, 31, 367)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (47, 7, 47, 415)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (48, 12, 80, 959)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (50, 7, 30, 809)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (51, 2, 3, 378)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (52, 6, 84, 576)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (53, 2, 61, 630)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (55, 11, 45, 483)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (56, 1, 21, 29)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (57, 4, 21, 802)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (58, 10, 13, 145)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (60, 11, 57, 30)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (61, 8, 82, 15)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (62, 8, 25, 545)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (63, 9, 62, 762)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (64, 8, 3, 239)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (65, 10, 56, 749)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (66, 2, 71, 311)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (67, 10, 3, 499)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (68, 11, 54, 599)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (69, 6, 11, 824)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (70, 5, 73, 137)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (71, 12, 48, 108)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (72, 9, 28, 10)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (73, 5, 43, 826)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (74, 5, 80, 581)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (75, 6, 70, 374)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (76, 10, 20, 53)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (77, 6, 74, 637)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (79, 9, 83, 57)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (80, 4, 66, 19)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (81, 9, 57, 389)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (82, 7, 86, 350)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (83, 7, 6, 245)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (84, 4, 59, 634)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (85, 12, 16, 603)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (86, 10, 88, 910)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (87, 1, 40, 988)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (88, 10, 20, 106)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (89, 6, 81, 486)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (90, 5, 10, 220)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (91, 1, 65, 506)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (92, 2, 13, 206)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (93, 8, 70, 582)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (94, 5, 16, 769)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (95, 9, 6, 724)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (96, 2, 26, 354)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (97, 11, 10, 254)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (98, 10, 45, 128)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (99, 9, 43, 519)
INSERT [Services].[EquiptmentNeeded] ([EquiptmentNeededID], [ServiceID], [EquiptmentID], [Quantity]) VALUES (100, 2, 53, 551)
SET IDENTITY_INSERT [Services].[EquiptmentNeeded] OFF
SET IDENTITY_INSERT [Services].[Service] ON 

INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (1, 68, N'Eyebrow Re-Shape', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (2, 68, N'Short back and sides', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (3, 68, N'Top Knot', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (4, 68, N'Fringe Trim', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (5, 68, N'Colour change', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (6, 73, N'Full custom website', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (7, 73, N'Wordpress site', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (8, 73, N'Custom Javascript', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (9, 73, N'Content Editing', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (10, 15, N'3 Days Car', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (11, 15, N'5 Days Car', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (12, 15, N'24 hours Car', NULL, CAST(N'2018-02-04T00:00:00.000' AS DateTime), CAST(N'2018-02-04T00:00:00.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (13, 33, N'odio justo', N'Enterprise-wide non-volatile infrastructure', CAST(N'2017-08-16T03:49:19.000' AS DateTime), CAST(N'2017-04-25T16:28:04.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (14, 55, N'curae duis', N'Up-sized secondary moderator', CAST(N'2017-07-26T15:15:58.000' AS DateTime), CAST(N'2017-11-06T08:31:12.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (15, 33, N'eu tincidunt in', N'Visionary leading edge capability', CAST(N'2017-12-30T20:22:51.000' AS DateTime), CAST(N'2018-04-10T10:11:58.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (16, 64, N'commodo', N'Multi-lateral homogeneous contingency', CAST(N'2017-10-09T18:07:21.000' AS DateTime), CAST(N'2017-10-22T05:27:38.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (17, 36, N'lacus purus aliquet', N'Open-source asymmetric access', CAST(N'2017-09-27T06:53:27.000' AS DateTime), CAST(N'2017-06-03T12:32:29.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (18, 53, N'ac est lacinia', N'Universal intangible array', CAST(N'2017-08-25T05:16:46.000' AS DateTime), CAST(N'2018-01-24T08:30:35.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (19, 55, N'non', N'Multi-lateral local customer loyalty', CAST(N'2017-11-30T07:07:48.000' AS DateTime), CAST(N'2017-07-11T03:17:24.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (20, 63, N'in hac', N'Multi-tiered optimal circuit', CAST(N'2018-01-27T15:28:06.000' AS DateTime), CAST(N'2017-12-11T01:18:32.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (21, 56, N'augue vestibulum', N'Operative well-modulated analyzer', CAST(N'2018-03-03T10:15:13.000' AS DateTime), CAST(N'2018-02-17T06:10:31.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (22, 49, N'massa id', N'Quality-focused well-modulated instruction set', CAST(N'2018-02-17T23:40:13.000' AS DateTime), CAST(N'2018-03-04T22:38:15.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (23, 23, N'cursus vestibulum proin', N'Inverse modular moratorium', CAST(N'2017-04-26T06:13:27.000' AS DateTime), CAST(N'2017-07-20T11:26:04.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (24, 18, N'maecenas', N'Multi-tiered tangible emulation', CAST(N'2017-07-05T19:51:57.000' AS DateTime), CAST(N'2017-11-03T15:27:13.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (25, 15, N'lobortis', N'Organic systematic open architecture', CAST(N'2017-10-30T11:39:04.000' AS DateTime), CAST(N'2017-04-23T07:09:20.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (26, 69, N'gravida sem', N'De-engineered next generation instruction set', CAST(N'2017-08-24T22:37:40.000' AS DateTime), CAST(N'2017-07-26T06:38:33.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (27, 24, N'diam in magna', N'Programmable reciprocal service-desk', CAST(N'2018-01-08T10:40:34.000' AS DateTime), CAST(N'2017-05-03T04:22:11.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (28, 39, N'vestibulum sit', N'Enhanced uniform solution', CAST(N'2018-02-04T23:20:40.000' AS DateTime), CAST(N'2017-09-17T08:09:46.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (29, 49, N'odio', N'Polarised analyzing adapter', CAST(N'2017-05-19T18:16:53.000' AS DateTime), CAST(N'2017-05-16T04:02:37.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (30, 72, N'eros', N'Configurable uniform forecast', CAST(N'2017-12-13T11:14:40.000' AS DateTime), CAST(N'2017-06-06T16:02:47.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (31, 43, N'amet', N'Adaptive national support', CAST(N'2017-08-27T21:04:21.000' AS DateTime), CAST(N'2017-12-31T13:18:38.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (32, 51, N'convallis', N'Enhanced static algorithm', CAST(N'2017-04-28T01:58:34.000' AS DateTime), CAST(N'2017-11-03T22:45:58.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (33, 12, N'fusce consequat', N'Team-oriented fault-tolerant product', CAST(N'2018-02-17T14:11:00.000' AS DateTime), CAST(N'2018-01-27T11:27:18.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (34, 66, N'nam dui', N'Grass-roots disintermediate structure', CAST(N'2018-02-27T18:35:02.000' AS DateTime), CAST(N'2017-05-17T05:41:59.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (35, 43, N'turpis donec', N'Reverse-engineered mobile internet solution', CAST(N'2017-10-24T14:47:47.000' AS DateTime), CAST(N'2017-12-10T03:22:54.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (36, 46, N'urna', N'Realigned grid-enabled neural-net', CAST(N'2017-12-04T01:40:08.000' AS DateTime), CAST(N'2017-11-03T05:54:54.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (37, 2, N'etiam', N'Cross-group multi-state complexity', CAST(N'2017-04-30T03:49:12.000' AS DateTime), CAST(N'2017-11-24T04:51:05.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (38, 61, N'tristique', N'User-centric secondary policy', CAST(N'2017-09-12T11:15:23.000' AS DateTime), CAST(N'2017-12-11T20:22:47.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (39, 29, N'in libero ut', N'Profit-focused logistical standardization', CAST(N'2017-12-02T11:01:52.000' AS DateTime), CAST(N'2017-10-27T10:54:49.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (40, 3, N'sed accumsan felis', N'Proactive 24/7 product', CAST(N'2017-08-27T23:57:04.000' AS DateTime), CAST(N'2017-10-15T04:36:34.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (41, 30, N'luctus', N'Enhanced high-level portal', CAST(N'2017-07-06T01:38:39.000' AS DateTime), CAST(N'2017-10-21T05:41:59.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (42, 26, N'imperdiet nullam orci', N'Horizontal optimal portal', CAST(N'2018-02-28T14:38:25.000' AS DateTime), CAST(N'2018-01-08T05:55:30.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (43, 67, N'amet nunc', N'Triple-buffered bifurcated utilisation', CAST(N'2017-12-13T17:04:56.000' AS DateTime), CAST(N'2017-04-30T16:58:30.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (44, 9, N'vel', N'Phased solution-oriented workforce', CAST(N'2017-08-13T06:03:34.000' AS DateTime), CAST(N'2017-06-07T10:41:58.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (45, 12, N'augue quam', N'Public-key content-based capability', CAST(N'2017-09-14T23:35:19.000' AS DateTime), CAST(N'2017-09-20T02:16:10.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (46, 63, N'pellentesque volutpat dui', N'Object-based 4th generation neural-net', CAST(N'2017-11-19T18:50:31.000' AS DateTime), CAST(N'2017-06-21T19:46:57.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (47, 46, N'donec', N'Phased hybrid system engine', CAST(N'2017-08-18T21:29:49.000' AS DateTime), CAST(N'2017-09-19T12:58:25.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (48, 10, N'luctus cum', N'Stand-alone global instruction set', CAST(N'2017-05-07T12:59:22.000' AS DateTime), CAST(N'2017-08-10T13:29:26.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (49, 46, N'ante vivamus tortor', N'Ameliorated user-facing projection', CAST(N'2018-02-07T16:32:09.000' AS DateTime), CAST(N'2017-09-24T21:07:30.000' AS DateTime))
INSERT [Services].[Service] ([ServiceID], [ServiceTypeID], [ServiceName], [Description], [Created], [Modified]) VALUES (50, 41, N'odio odio elementum', N'Compatible mission-critical info-mediaries', CAST(N'2017-05-13T18:58:55.000' AS DateTime), CAST(N'2017-06-01T17:49:14.000' AS DateTime))
SET IDENTITY_INSERT [Services].[Service] OFF
SET IDENTITY_INSERT [Services].[Service_Products] ON 

INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (1, 3, 3)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (2, 6, 45)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (3, 8, 13)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (4, 4, 28)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (5, 2, 34)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (6, 12, 33)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (7, 6, 27)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (8, 8, 45)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (9, 1, 12)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (10, 5, 21)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (11, 5, 47)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (12, 11, 46)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (13, 4, 15)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (14, 8, 6)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (15, 2, 18)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (16, 11, 20)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (1, 3, 3)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (2, 6, 45)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (3, 8, 13)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (4, 4, 28)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (5, 2, 34)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (6, 12, 33)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (7, 6, 27)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (8, 8, 45)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (9, 1, 12)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (10, 5, 21)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (11, 5, 47)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (12, 11, 46)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (13, 4, 15)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (14, 8, 6)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (15, 2, 18)
INSERT [Services].[Service_Products] ([ServiceProductsID], [ServiceID], [StockID]) VALUES (16, 11, 20)
SET IDENTITY_INSERT [Services].[Service_Products] OFF
SET IDENTITY_INSERT [Services].[ServiceType] ON 

INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (2, N'Message Therapist')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (3, N'Advertising Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (4, N'Moving Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (5, N'Auto Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (6, N'Painting Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (7, N'Building Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (8, N'Personal-Care Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (9, N'Boat Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (10, N'Personal Chef')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (11, N'Bridal Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (12, N'Pest Control Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (13, N'Business Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (14, N'Pet-Care Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (15, N'Car Rental Agencies')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (16, N'Photography Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (17, N'Catering Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (18, N'Plant Maintenance Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (19, N'Children’s Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (20, N'Plumbing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (21, N'Check-Cashing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (22, N'Pool Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (23, N'Cleaning Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (24, N'Postal & Business Centers')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (25, N'Check-Cashing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (26, N'Printing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (27, N'Consulting Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (28, N'Private Investigation')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (29, N'Contractor Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (30, N'roperty Inspection')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (31, N'Copywriting & Proof Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (32, N'Property Management Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (33, N'Cover Letter/Resume Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (34, N'Publishing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (35, N'Dating Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (36, N'Real Estate Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (37, N'Decorating Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (38, N'Recreational Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (39, N'Designing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (40, N'Referral Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (41, N'DJ Businesses')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (42, N'Remodeling/Renovation Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (43, N'Dry Cleaning & Laundry ')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (44, N'Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (45, N'Repair Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (46, N'Dry Cleaning Delivery')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (47, N'Security Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (48, N'Editorial Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (49, N'Senior Care Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (50, N'Educational Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (51, N'Shipping Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (52, N'Electrical Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (53, N'Shoe Repair')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (54, N'Employment Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (55, N'Sign Stores')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (56, N'Environmental Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (57, N'Staffing Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (58, N'Errand Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (59, N'Tanning Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (60, N'Event Planning')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (61, N'Tax Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (62, N'Eye-Care Centers')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (63, N'Tech Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (64, N'Financial Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (65, N'Travel Agencies')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (66, N'Fitness Centers')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (67, N'Training Businesses')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (68, N'Hair Salons')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (69, N'Tutoring Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (70, N'Handyman Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (71, N'Videotaping Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (72, N'Health-Care Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (73, N'Web-Site Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (74, N'Home-Improvement Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (75, N'Wedding Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (76, N'Lawn Care & Landscaping')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (77, N'Weight-Control Centers')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (78, N'Limousine Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (79, N'Miscellaneous Services')
INSERT [Services].[ServiceType] ([ServiceTypeID], [ServiceType]) VALUES (80, N'Test Type')
SET IDENTITY_INSERT [Services].[ServiceType] OFF
SET IDENTITY_INSERT [Staff].[Staff] ON 

INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (1, 38, 1, N'Melvin', N'De Gowe', N'mdegowe0', N'Y0xQ3n6NRusW', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (2, 38, 2, N'Rourke', N'Cannavan', N'rcannavan1', N'OCRwiva', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (3, 38, 3, N'Debra', N'Nacey', N'dnacey2', N'7UNV6m', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (4, 38, 4, N'Kerstin', N'Keme', N'kkeme3', N'KYLiXuSDu', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (5, 38, 5, N'Babb', N'MacDirmid', N'bmacdirmid4', N'2V90hpquQK', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (6, 38, 4, N'Cassie', N'Kingsmill', N'ckingsmill5', N'4c5VIi', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (7, 44, 1, N'Joly', N'Laverack', N'jlaverack6', N'3eqYI94qU0', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (8, 44, 2, N'Whitaker', N'Rawsthorn', N'wrawsthorn7', N'csnuG1', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (9, 44, 3, N'Delano', N'Thieme', N'dthieme8', N'Timqow5oP7', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (10, 44, 4, N'Vikki', N'Kettlesing', N'vkettlesing9', N'JTHrWp8', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (11, 44, 5, N'Danice', N'Karpe', N'dkarpea', N'cLO8vOmMR', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (12, 61, 1, N'Loy', N'Rossbrook', N'lrossbrookb', N'Sw0Pk6xN07', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (14, 61, 2, N'Nat', N'Rainer', N'nrainerd', N'J29jWnT', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (15, 61, 3, N'Hurley', N'Blackadder', N'hblackaddere', N'TQHIVtD6', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (16, 61, 4, N'Filberto', N'Dumphries', N'fdumphriesf', N'JdOdcxw', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (17, 61, 5, N'Sonia', N'Rigmond', N'srigmondg', N'udDjXSMQ', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (18, 33, 1, N'Brander', N'Moxon', N'bmoxonh', N'GvSqonPkbg', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (19, 31, 3, N'Shellie', N'Dener', N'sdeneri', N'GVfdNTbkTYb', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (20, 10, 4, N'Deloris', N'Lorens', N'dlorensj', N'v8pQag3', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (21, 74, 3, N'Nobie', N'Radin', N'nradink', N'EuZ7nf', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (22, 38, 1, N'Connor', N'Gergely', N'cgergelyl', N'7Z5RMNVGSfFE', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (23, 88, 5, N'Yasmin', N'Gingold', N'ygingoldm', N'OJAD5Gqdzj', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (24, 78, 5, N'Gilligan', N'Alvarado', N'galvaradon', N'HwBpDOl8', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (25, 16, 2, N'Britteny', N'Challenger', N'bchallengero', N'hvxOna', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (26, 64, 2, N'Charmian', N'Biggam', N'cbiggamp', N'OkXaympAzE', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (27, 98, 3, N'Cordi', N'Petty', N'cpettyq', N'HNVWVCTKTZHL', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (28, 89, 5, N'Dino', N'Scudder', N'dscudderr', N'vA689N', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (29, 3, 3, N'Hyacinth', N'Crellim', N'hcrellims', N'nGkpHG', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (30, 89, 5, N'Carroll', N'Dabourne', N'cdabournet', N'gxufpr6vg4', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (31, 82, 4, N'Britte', N'Giovanetti', N'bgiovanettiu', N'XvBVbp', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (32, 78, 5, N'Rayner', N'Schuster', N'rschusterv', N'NMc0zy9Y', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (33, 76, 1, N'Juliet', N'Gilleon', N'jgilleonw', N'COufixw', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (34, 14, 1, N'Janna', N'Trapp', N'jtrappx', N'7F5I4aFL', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (35, 32, 5, N'Carlina', N'Soares', N'csoaresy', N'aIdUR62tAvz', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (36, 40, 5, N'Carrie', N'Rochelle', N'crochellez', N'XYooqpE1f', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (37, 92, 4, N'Hester', N'Petrescu', N'hpetrescu10', N'B5PK2j', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (39, 92, 4, N'Lynne', N'Hammand', N'lhammand12', N'4GmniGq8MDX', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (40, 13, 5, N'Nicholle', N'Gravet', N'ngravet13', N'G9jhCm2G80uN', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (41, 6, 3, N'Wenona', N'Basillon', N'wbasillon14', N'30HjD1', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (42, 67, 5, N'Catharina', N'Bohlin', N'cbohlin15', N'mcjbURP', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (43, 39, 3, N'Des', N'Eplett', N'deplett16', N'0MvkkuWp4uS', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (44, 99, 1, N'Ruperto', N'Krimmer', N'rkrimmer17', N'AHo1OJ7czRt', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (45, 91, 3, N'Lacie', N'Brawson', N'lbrawson18', N'9W4UeWC2', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (46, 33, 4, N'Aleta', N'Harriot', N'aharriot19', N'SHN5Fnljeg', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (47, 71, 5, N'Valerye', N'Burgne', N'vburgne1a', N'xJygzAC1', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (48, 63, 1, N'Johnette', N'Fyfield', N'jfyfield1b', N'aGPwehTaD', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (49, 78, 4, N'Trevar', N'Chapelle', N'tchapelle1c', N'iqOJEcvneZ2y', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (50, 57, 2, N'Symon', N'Rising', N'srising1d', N'NT3s831h', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (51, 7, 5, N'Adolf', N'Shurmore', N'ashurmore1e', N'3Cvyjo3qW', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (52, 26, 2, N'Aldric', N'Drover', N'adrover1f', N'MLhxuDOwPX', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (53, 95, 1, N'Tallulah', N'Geffcock', N'tgeffcock1g', N'iCOyQrsbGi', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (54, 13, 5, N'Gussy', N'Fooks', N'gfooks1h', N'xqsXVVMxh', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (55, 16, 1, N'Trace', N'Blunsden', N'tblunsden1i', N'xGTD4r', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (56, 8, 5, N'Anica', N'Lghan', N'alghan1j', N'K01dERM2GaMb', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (57, 57, 1, N'Joscelin', N'Dillicate', N'jdillicate1k', N'q1JhoEqVIg', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (58, 95, 2, N'Leeann', N'Rentelll', N'lrentelll1l', N'z9LyJCkkbF', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (59, 29, 2, N'Dacie', N'Swadden', N'dswadden1m', N'GEuoMaMPbXCR', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (60, 10, 1, N'Ollie', N'Blackaller', N'oblackaller1n', N'1zuR4Jqln15X', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (61, 85, 2, N'Stephan', N'Munslow', N'smunslow1o', N'onY9l2mz', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (62, 72, 3, N'Cleon', N'Chappelle', N'cchappelle1p', N'BBrNqpNPIV', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (63, 8, 5, N'Derick', N'Anthony', N'danthony1q', N'EWCExUWh7', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (64, 48, 1, N'Merrile', N'Broadnicke', N'mbroadnicke1r', N'KNShRn', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (65, 80, 1, N'Charity', N'Ziemecki', N'cziemecki1s', N'p3WMT4aoTV', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (66, 12, 3, N'Bernardo', N'Beedle', N'bbeedle1t', N'ckGoOHpwFVFy', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (67, 11, 3, N'Lloyd', N'Smedmoor', N'lsmedmoor1u', N'3ETc0JI7tX', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (68, 96, 3, N'Karlene', N'Issacson', N'kissacson1v', N'k4qJANO', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (69, 76, 2, N'Noell', N'Nast', N'nnast1w', N'3KWKiijS', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (70, 17, 5, N'Corinna', N'Senyard', N'csenyard1x', N'nc2r47tPe', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (71, 78, 2, N'Willamina', N'Barosch', N'wbarosch1y', N'eoYVqwC4WLe', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (72, 52, 2, N'Car', N'Wheatley', N'cwheatley1z', N'kjbSNY2i', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (73, 46, 4, N'Aubine', N'Poulsom', N'apoulsom20', N'iakzQutgAy1', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (74, 62, 1, N'Noble', N'Bakhrushkin', N'nbakhrushkin21', N'EvMnhaCL', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (75, 53, 1, N'Sibyl', N'Skyram', N'sskyram22', N'zPX4nqcFH3k', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (76, 74, 5, N'Mendy', N'Ashbe', N'mashbe23', N'a239XU', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (77, 66, 2, N'Cart', N'Powderham', N'cpowderham24', N'DRrjuhA1', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (78, 32, 1, N'Verne', N'Inwood', N'vinwood25', N'2qRsmiGpHQ', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (79, 1, 2, N'Amelita', N'Schule', N'aschule26', N'py4iErpUV', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (80, 18, 1, N'Taite', N'Casewell', N'tcasewell27', N'uAO4ngAMaa', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (81, 18, 3, N'Augusta', N'Kittley', N'akittley28', N'agGnni6ZE4xl', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (82, 52, 2, N'Shandy', N'Febre', N'sfebre29', N'Pdq9ANICxVIr', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (83, 41, 4, N'Hermine', N'Mateos', N'hmateos2a', N'Ikd9vNdaY', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (84, 71, 1, N'Dominik', N'Piggford', N'dpiggford2b', N'U3TVjT2', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (85, 73, 3, N'Hanna', N'Thing', N'hthing2c', N'KOoeOmgLf', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (86, 54, 5, N'Orelee', N'Redmell', N'oredmell2d', N'0GTY99KgE', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (87, 85, 2, N'Bron', N'Franck', N'bfranck2e', N'YhuYRIx0Q', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (88, 4, 4, N'Anatole', N'Purbrick', N'apurbrick2f', N'lAxpo6bjQV', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (89, 48, 5, N'Parke', N'Tooher', N'ptooher2g', N'UL1qZscj', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (90, 36, 4, N'Cayla', N'Gormally', N'cgormally2h', N'FSw9rX', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (91, 13, 5, N'Ronnica', N'Bundey', N'rbundey2i', N'fL1BFzOg', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (92, 11, 3, N'Reinold', N'Darnbrough', N'rdarnbrough2j', N'KmEjEi', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (93, 80, 3, N'Stella', N'MacSkeaghan', N'smacskeaghan2k', N'f9G00rrU', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (94, 25, 5, N'Edith', N'Fuster', N'efuster2l', N'tAbf8j5', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (95, 3, 2, N'Nathan', N'Ferrettini', N'nferrettini2m', N'zQBFEyhepNo', 0)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (96, 23, 3, N'Tobey', N'Viall', N'tviall2n', N'7fN1FVND', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (97, 19, 2, N'Forbes', N'Tsar', N'ftsar2o', N'9UbeutDZ46', 1)
INSERT [Staff].[Staff] ([StaffID], [CompanyID], [StaffRoleID], [First_Name], [Last_Name], [Username], [Password], [Active]) VALUES (98, 38, 1, N'Adam', N'Smith', N'adam', N'Passw0rd', 1)
SET IDENTITY_INSERT [Staff].[Staff] OFF
SET IDENTITY_INSERT [Staff].[StaffAccess] ON 

INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (1, 1, 1, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (2, 2, 1, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (3, 3, 1, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (4, 4, 1, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (5, 5, 1, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (6, 1, 2, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (7, 2, 2, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (8, 3, 2, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (9, 4, 2, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (10, 5, 2, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (11, 1, 3, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (12, 2, 3, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (13, 3, 3, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (14, 4, 3, 0)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (15, 5, 3, 0)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (16, 1, 5, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (17, 2, 4, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (18, 3, 4, 1)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (19, 4, 4, 0)
INSERT [Staff].[StaffAccess] ([StaffAccessID], [SystemAuthorizationID], [StaffRoleID], [IsAccessible]) VALUES (20, 5, 4, 0)
SET IDENTITY_INSERT [Staff].[StaffAccess] OFF
SET IDENTITY_INSERT [Staff].[StaffRole] ON 

INSERT [Staff].[StaffRole] ([StaffRoleID], [RoleName]) VALUES (1, N'Owner')
INSERT [Staff].[StaffRole] ([StaffRoleID], [RoleName]) VALUES (2, N'Manager')
INSERT [Staff].[StaffRole] ([StaffRoleID], [RoleName]) VALUES (3, N'Senior')
INSERT [Staff].[StaffRole] ([StaffRoleID], [RoleName]) VALUES (4, N'Mid Level')
INSERT [Staff].[StaffRole] ([StaffRoleID], [RoleName]) VALUES (5, N'Junior')
SET IDENTITY_INSERT [Staff].[StaffRole] OFF
SET IDENTITY_INSERT [Staff].[SystemAuthorization] ON 

INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (1, N'CreateCustomer', N'C_Customer')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (2, N'UpdateCustomer', N'U_Customer')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (3, N'DeleteCustomer', N'D_Customer')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (4, N'CreateSupplier', N'C_Supplier')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (5, N'UpdateSupplier', N'U_Supplier')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (6, N'DeleteSupplier', N'D_Supplier')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (7, N'CreateBooking', N'C_Booking')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (8, N'UpdateBooking', N'U_Booking')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (9, N'DeleteBooking', N'D_Booking')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (10, N'CreateStaff', N'C_Staff')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (11, N'UpdateStaff', N'U_Staff')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (12, N'DeleteDtaff', N'D_Staff')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (13, N'CreateStock', N'C_Stock')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (14, N'UpdateStock', N'U_Stock')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (15, N'DeleteStock', N'D_Stock')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (16, N'CreateServices', N'C_Services')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (17, N'UpdateServices', N'U_Services')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (18, N'DeleteServices', N'D_Services')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (19, N'CreateInvoice', N'C_Invoice')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (20, N'UpdateInvoice', N'U_Invoice')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (21, N'DeleteInvoice', N'D_Invoice')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (22, N'CreateCost', N'C_Cost')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (23, N'UpdateCode', N'U_Cost')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (24, N'DeleteCost', N'D_Cost')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (25, N'DeleteReviews', N'DeleteReviews')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (26, N'CreateReviews', N'C_Review')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (27, N'CreateEquipment', N'C_Equipment')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (28, N'UpdateEquipment', N'U_Equipment')
INSERT [Staff].[SystemAuthorization] ([SystemAuthorizationID], [Add_Edit_Del], [AuthorzationName]) VALUES (29, N'DeleteEqupment', N'D_Equipment')
SET IDENTITY_INSERT [Staff].[SystemAuthorization] OFF
SET IDENTITY_INSERT [Stock].[ProductImage] ON 

INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (2, N'http://dummyimage.com/161x216.jpg/cc0000/ffffff', N'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (3, N'http://dummyimage.com/149x113.jpg/ff4444/ffffff', N'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (4, N'http://dummyimage.com/181x203.jpg/dddddd/000000', N'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (5, N'http://dummyimage.com/145x250.jpg/5fa2dd/ffffff', N'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (6, N'http://dummyimage.com/148x163.jpg/dddddd/000000', N'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (7, N'http://dummyimage.com/211x203.jpg/5fa2dd/ffffff', N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (8, N'http://dummyimage.com/155x180.jpg/dddddd/000000', N'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (9, N'http://dummyimage.com/142x162.jpg/ff4444/ffffff', N'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (10, N'http://dummyimage.com/224x218.jpg/dddddd/000000', N'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (11, N'http://dummyimage.com/152x138.jpg/5fa2dd/ffffff', N'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (12, N'http://dummyimage.com/143x109.jpg/ff4444/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (13, N'http://dummyimage.com/174x246.jpg/dddddd/000000', N'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (14, N'http://dummyimage.com/111x214.jpg/dddddd/000000', N'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (15, N'http://dummyimage.com/139x219.jpg/ff4444/ffffff', N'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (16, N'http://dummyimage.com/232x110.jpg/5fa2dd/ffffff', N'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (17, N'http://dummyimage.com/236x167.jpg/dddddd/000000', N'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (18, N'http://dummyimage.com/172x207.jpg/cc0000/ffffff', N'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (19, N'http://dummyimage.com/148x168.jpg/cc0000/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (20, N'http://dummyimage.com/225x125.jpg/ff4444/ffffff', N'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (21, N'http://dummyimage.com/173x111.jpg/dddddd/000000', N'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (22, N'http://dummyimage.com/225x145.jpg/ff4444/ffffff', N'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (23, N'http://dummyimage.com/181x118.jpg/dddddd/000000', N'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (24, N'http://dummyimage.com/111x109.jpg/cc0000/ffffff', N'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (25, N'http://dummyimage.com/121x237.jpg/dddddd/000000', N'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (26, N'http://dummyimage.com/223x193.jpg/cc0000/ffffff', N'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (27, N'http://dummyimage.com/203x114.jpg/cc0000/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (28, N'http://dummyimage.com/175x109.jpg/cc0000/ffffff', N'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (29, N'http://dummyimage.com/241x174.jpg/cc0000/ffffff', N'Phasellus in felis. Donec semper sapien a libero. Nam dui.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (30, N'http://dummyimage.com/149x139.jpg/dddddd/000000', N'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (31, N'http://dummyimage.com/199x181.jpg/cc0000/ffffff', N'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (32, N'http://dummyimage.com/183x138.jpg/ff4444/ffffff', N'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (33, N'http://dummyimage.com/117x138.jpg/cc0000/ffffff', N'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (34, N'http://dummyimage.com/153x153.jpg/5fa2dd/ffffff', N'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (35, N'http://dummyimage.com/133x247.jpg/cc0000/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (36, N'http://dummyimage.com/161x169.jpg/dddddd/000000', N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (37, N'http://dummyimage.com/155x222.jpg/ff4444/ffffff', N'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (38, N'http://dummyimage.com/170x156.jpg/dddddd/000000', N'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (39, N'http://dummyimage.com/175x138.jpg/cc0000/ffffff', N'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (40, N'http://dummyimage.com/161x209.jpg/ff4444/ffffff', N'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (41, N'http://dummyimage.com/171x102.jpg/dddddd/000000', N'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (42, N'http://dummyimage.com/125x250.jpg/dddddd/000000', N'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (43, N'http://dummyimage.com/232x117.jpg/dddddd/000000', N'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (44, N'http://dummyimage.com/203x235.jpg/ff4444/ffffff', N'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (45, N'http://dummyimage.com/123x217.jpg/dddddd/000000', N'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (46, N'http://dummyimage.com/234x231.jpg/cc0000/ffffff', N'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (47, N'http://dummyimage.com/187x206.jpg/cc0000/ffffff', N'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (48, N'http://dummyimage.com/216x191.jpg/ff4444/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (49, N'http://dummyimage.com/246x181.jpg/cc0000/ffffff', N'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (50, N'http://dummyimage.com/116x236.jpg/cc0000/ffffff', N'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (51, N'http://dummyimage.com/119x128.jpg/5fa2dd/ffffff', N'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (52, N'http://dummyimage.com/119x177.jpg/ff4444/ffffff', N'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (53, N'http://dummyimage.com/205x180.jpg/dddddd/000000', N'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (54, N'http://dummyimage.com/111x242.jpg/dddddd/000000', N'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (55, N'http://dummyimage.com/165x174.jpg/5fa2dd/ffffff', N'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (56, N'http://dummyimage.com/212x218.jpg/ff4444/ffffff', N'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (57, N'http://dummyimage.com/192x120.jpg/dddddd/000000', N'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (58, N'http://dummyimage.com/168x179.jpg/dddddd/000000', N'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (59, N'http://dummyimage.com/202x207.jpg/cc0000/ffffff', N'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (60, N'http://dummyimage.com/198x100.jpg/dddddd/000000', N'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (61, N'http://dummyimage.com/105x218.jpg/5fa2dd/ffffff', N'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (62, N'http://dummyimage.com/113x237.jpg/cc0000/ffffff', N'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (63, N'http://dummyimage.com/216x247.jpg/cc0000/ffffff', N'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (64, N'http://dummyimage.com/131x238.jpg/ff4444/ffffff', N'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (65, N'http://dummyimage.com/132x193.jpg/ff4444/ffffff', N'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (66, N'http://dummyimage.com/236x158.jpg/5fa2dd/ffffff', N'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (67, N'http://dummyimage.com/151x119.jpg/ff4444/ffffff', N'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (68, N'http://dummyimage.com/149x105.jpg/cc0000/ffffff', N'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (69, N'http://dummyimage.com/111x175.jpg/cc0000/ffffff', N'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (70, N'http://dummyimage.com/218x137.jpg/cc0000/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (71, N'http://dummyimage.com/242x167.jpg/5fa2dd/ffffff', N'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (72, N'http://dummyimage.com/203x134.jpg/dddddd/000000', N'Fusce consequat. Nulla nisl. Nunc nisl.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (73, N'http://dummyimage.com/209x193.jpg/cc0000/ffffff', N'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (74, N'http://dummyimage.com/168x166.jpg/ff4444/ffffff', N'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (75, N'http://dummyimage.com/125x123.jpg/5fa2dd/ffffff', N'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (76, N'http://dummyimage.com/106x204.jpg/dddddd/000000', N'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (77, N'http://dummyimage.com/225x214.jpg/ff4444/ffffff', N'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (78, N'http://dummyimage.com/239x245.jpg/5fa2dd/ffffff', N'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (79, N'http://dummyimage.com/135x241.jpg/ff4444/ffffff', N'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (80, N'http://dummyimage.com/110x208.jpg/ff4444/ffffff', N'Sed ante. Vivamus tortor. Duis mattis egestas metus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (81, N'http://dummyimage.com/168x222.jpg/dddddd/000000', N'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (82, N'http://dummyimage.com/158x206.jpg/dddddd/000000', N'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (83, N'http://dummyimage.com/174x150.jpg/ff4444/ffffff', N'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (84, N'http://dummyimage.com/238x164.jpg/ff4444/ffffff', N'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (85, N'http://dummyimage.com/110x158.jpg/ff4444/ffffff', N'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (86, N'http://dummyimage.com/202x168.jpg/cc0000/ffffff', N'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (87, N'http://dummyimage.com/232x113.jpg/ff4444/ffffff', N'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (88, N'http://dummyimage.com/225x233.jpg/cc0000/ffffff', N'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (89, N'http://dummyimage.com/184x131.jpg/cc0000/ffffff', N'Phasellus in felis. Donec semper sapien a libero. Nam dui.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (90, N'http://dummyimage.com/229x183.jpg/dddddd/000000', N'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (91, N'http://dummyimage.com/107x108.jpg/dddddd/000000', N'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (92, N'http://dummyimage.com/119x186.jpg/ff4444/ffffff', N'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (93, N'http://dummyimage.com/147x168.jpg/dddddd/000000', N'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (94, N'http://dummyimage.com/230x203.jpg/ff4444/ffffff', N'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (95, N'http://dummyimage.com/175x103.jpg/5fa2dd/ffffff', N'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (96, N'http://dummyimage.com/123x194.jpg/ff4444/ffffff', N'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (97, N'http://dummyimage.com/150x190.jpg/cc0000/ffffff', N'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (98, N'http://dummyimage.com/161x242.jpg/dddddd/000000', N'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (99, N'http://dummyimage.com/198x128.jpg/5fa2dd/ffffff', N'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.')
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (100, N'http://dummyimage.com/151x242.jpg/dddddd/000000', N'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.')
GO
INSERT [Stock].[ProductImage] ([ProductImageID], [ProductImageURL], [Notes]) VALUES (101, N'http://dummyimage.com/105x227.jpg/dddddd/000000', N'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.')
SET IDENTITY_INSERT [Stock].[ProductImage] OFF
SET IDENTITY_INSERT [Stock].[ProductSuppliers] ON 

INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (1, N'Torphy-Roberts', N'Farrand MacAiline', N'9', N'21-080', N'Ukraine', N'884-877-7987', N'fmacailine0@addtoany.com', N'http://webeden.co.uk/parturient/montes/nascetur/ridiculus/mus.jpg?nascetur=amet&ridiculus=justo&mus=morbi&vivamus=ut&vestibulum=odio&sagittis=cras&sapien=mi&cum=pede&sociis=malesuada&natoque=in&penatibus=imperdiet&et=et&magnis=commodo&dis=vulputate&parturient=justo&montes=in&nascetur=blandit&ridiculus=ultrices&mus=enim&etiam=lorem&vel=ipsum&augue=dolor&vestibulum=sit&rutrum=amet&rutrum=consectetuer&neque=adipiscing&aenean=elit&auctor=proin&gravida=interdum&sem=mauris&praesent=non&id=ligula&massa=pellentesque&id=ultrices&nisl=phasellus&venenatis=id&lacinia=sapien&aenean=in&sit=sapien&amet=iaculis&justo=congue&morbi=vivamus&ut=metus&odio=arcu&cras=adipiscing&mi=molestie&pede=hendrerit&malesuada=at&in=vulputate&imperdiet=vitae&et=nisl&commodo=aenean&vulputate=lectus&justo=pellentesque&in=eget&blandit=nunc&ultrices=donec&enim=quis&lorem=orci&ipsum=eget&dolor=orci&sit=vehicula&amet=condimentum', N'http://dummyimage.com/245x198.jpg/cc0000/ffffff', N'mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus', N'suspendisse')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (2, N'Lynch, Feil and Frami', N'Pippa Brisse', N'10', N'1152', N'Philippines', N'284-526-4756', N'pbrisse1@webeden.co.uk', N'http://google.com.hk/justo/pellentesque/viverra/pede/ac/diam.xml?justo=amet&sit=diam&amet=in&sapien=magna&dignissim=bibendum&vestibulum=imperdiet&vestibulum=nullam&ante=orci&ipsum=pede&primis=venenatis&in=non&faucibus=sodales&orci=sed&luctus=tincidunt&et=eu&ultrices=felis&posuere=fusce&cubilia=posuere&curae=felis&nulla=sed&dapibus=lacus&dolor=morbi&vel=sem&est=mauris&donec=laoreet&odio=ut', N'http://dummyimage.com/173x242.png/dddddd/000000', NULL, N'sodales')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (3, N'Koepp LLC', N'Tasha Pearch', N'10', N'E4K', N'Canada', N'966-136-7975', N'tpearch2@sbwire.com', N'http://flavors.me/nullam/orci.png?quis=aliquam&turpis=sit&eget=amet&elit=diam&sodales=in&scelerisque=magna&mauris=bibendum&sit=imperdiet&amet=nullam&eros=orci&suspendisse=pede&accumsan=venenatis&tortor=non&quis=sodales&turpis=sed&sed=tincidunt&ante=eu&vivamus=felis&tortor=fusce', N'http://dummyimage.com/192x190.bmp/5fa2dd/ffffff', N'turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (4, N'Windler and Sons', N'Rey Dibsdale', N'4', N'21-080', N'Indonesia', N'475-628-5931', N'rdibsdale3@angelfire.com', N'https://washington.edu/pretium/quis/lectus/suspendisse/potenti/in.json?fermentum=viverra&justo=eget&nec=congue&condimentum=eget&neque=semper&sapien=rutrum&placerat=nulla&ante=nunc&nulla=purus&justo=phasellus&aliquam=in&quis=felis&turpis=donec&eget=semper&elit=sapien&sodales=a&scelerisque=libero&mauris=nam&sit=dui&amet=proin&eros=leo&suspendisse=odio&accumsan=porttitor&tortor=id&quis=consequat&turpis=in', N'http://dummyimage.com/106x138.bmp/5fa2dd/ffffff', N'posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (5, N'Swaniawski, O''Keefe and Tremblay', N'Starr Carillo', N'5', N'21-080', N'Nigeria', N'815-453-5164', N'scarillo4@yandex.ru', N'https://edublogs.org/vivamus/tortor/duis.aspx?sit=vel&amet=lectus&consectetuer=in&adipiscing=quam&elit=fringilla&proin=rhoncus&interdum=mauris&mauris=enim&non=leo&ligula=rhoncus&pellentesque=sed&ultrices=vestibulum&phasellus=sit&id=amet&sapien=cursus&in=id&sapien=turpis&iaculis=integer&congue=aliquet&vivamus=massa&metus=id&arcu=lobortis&adipiscing=convallis&molestie=tortor&hendrerit=risus&at=dapibus&vulputate=augue&vitae=vel&nisl=accumsan&aenean=tellus&lectus=nisi&pellentesque=eu&eget=orci&nunc=mauris&donec=lacinia&quis=sapien', N'http://dummyimage.com/123x169.jpg/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (6, N'Macejkovic-Okuneva', N'Kira Hast', N'8', N'21-080', N'Central African Republic', N'856-925-5505', N'khast5@chron.com', N'https://creativecommons.org/sollicitudin/mi.js?sapien=et&placerat=tempus&ante=semper&nulla=est&justo=quam&aliquam=pharetra&quis=magna&turpis=ac&eget=consequat&elit=metus&sodales=sapien&scelerisque=ut&mauris=nunc&sit=vestibulum&amet=ante&eros=ipsum&suspendisse=primis&accumsan=in&tortor=faucibus&quis=orci&turpis=luctus&sed=et&ante=ultrices&vivamus=posuere&tortor=cubilia&duis=curae&mattis=mauris&egestas=viverra&metus=diam&aenean=vitae&fermentum=quam&donec=suspendisse&ut=potenti&mauris=nullam&eget=porttitor&massa=lacus&tempor=at&convallis=turpis', N'http://dummyimage.com/249x146.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (7, N'Conroy-Schuster', N'Cele Vaz', N'1', N'6707', N'Philippines', N'849-111-2556', N'cvaz6@elegantthemes.com', N'http://shop-pro.jp/cubilia/curae/duis.jpg?vulputate=quam&luctus=sollicitudin&cum=vitae&sociis=consectetuer&natoque=eget&penatibus=rutrum&et=at&magnis=lorem&dis=integer&parturient=tincidunt&montes=ante&nascetur=vel&ridiculus=ipsum', N'http://dummyimage.com/114x116.png/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (8, N'Johnston Group', N'Blythe Komorowski', N'5', N'21-080', N'Poland', N'333-883-7816', N'bkomorowski7@phpbb.com', N'https://techcrunch.com/pede/venenatis/non/sodales/sed/tincidunt/eu.png?aliquet=consequat&maecenas=in&leo=consequat&odio=ut&condimentum=nulla&id=sed&luctus=accumsan&nec=felis&molestie=ut&sed=at&justo=dolor&pellentesque=quis&viverra=odio&pede=consequat&ac=varius&diam=integer&cras=ac&pellentesque=leo&volutpat=pellentesque&dui=ultrices&maecenas=mattis&tristique=odio&est=donec&et=vitae&tempus=nisi&semper=nam&est=ultrices&quam=libero&pharetra=non&magna=mattis&ac=pulvinar&consequat=nulla&metus=pede&sapien=ullamcorper&ut=augue&nunc=a&vestibulum=suscipit&ante=nulla&ipsum=elit&primis=ac&in=nulla&faucibus=sed&orci=vel&luctus=enim&et=sit&ultrices=amet&posuere=nunc&cubilia=viverra&curae=dapibus&mauris=nulla&viverra=suscipit&diam=ligula&vitae=in&quam=lacus&suspendisse=curabitur&potenti=at&nullam=ipsum&porttitor=ac', N'http://dummyimage.com/164x154.png/5fa2dd/ffffff', N'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (9, N'Boyer Group', N'Simmonds Ollive', N'10', N'6707', N'Indonesia', N'109-332-7847', N'sollive8@squidoo.com', N'https://springer.com/elementum/ligula/vehicula/consequat/morbi/a/ipsum.png?in=sapien&hac=iaculis&habitasse=congue&platea=vivamus&dictumst=metus&maecenas=arcu&ut=adipiscing&massa=molestie&quis=hendrerit&augue=at&luctus=vulputate&tincidunt=vitae&nulla=nisl&mollis=aenean&molestie=lectus&lorem=pellentesque&quisque=eget&ut=nunc&erat=donec&curabitur=quis&gravida=orci&nisi=eget&at=orci&nibh=vehicula&in=condimentum&hac=curabitur', N'http://dummyimage.com/197x111.jpg/dddddd/000000', NULL, N'lobortis')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (10, N'Parisian Inc', N'Chadwick Sparshatt', N'2', N'6707', N'China', N'258-481-8731', N'csparshatt9@cafepress.com', N'https://netscape.com/justo/etiam/pretium/iaculis/justo/in.js?fermentum=odio&justo=odio&nec=elementum&condimentum=eu&neque=interdum&sapien=eu&placerat=tincidunt&ante=in&nulla=leo&justo=maecenas&aliquam=pulvinar&quis=lobortis&turpis=est&eget=phasellus&elit=sit&sodales=amet&scelerisque=erat&mauris=nulla&sit=tempus&amet=vivamus&eros=in&suspendisse=felis&accumsan=eu&tortor=sapien&quis=cursus&turpis=vestibulum&sed=proin&ante=eu&vivamus=mi&tortor=nulla&duis=ac&mattis=enim&egestas=in&metus=tempor&aenean=turpis&fermentum=nec&donec=euismod&ut=scelerisque&mauris=quam&eget=turpis&massa=adipiscing&tempor=lorem&convallis=vitae&nulla=mattis&neque=nibh&libero=ligula&convallis=nec&eget=sem&eleifend=duis&luctus=aliquam&ultricies=convallis&eu=nunc&nibh=proin&quisque=at&id=turpis&justo=a&sit=pede&amet=posuere&sapien=nonummy&dignissim=integer&vestibulum=non&vestibulum=velit&ante=donec&ipsum=diam', N'http://dummyimage.com/236x130.jpg/ff4444/ffffff', NULL, N'maecenas ut')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (11, N'Schmitt LLC', N'Sebastien Evitts', N'6', N'6707', N'China', N'618-632-2619', N'sevittsa@elpais.com', N'http://w3.org/duis.jsp?dui=aenean&proin=sit&leo=amet&odio=justo&porttitor=morbi&id=ut&consequat=odio&in=cras&consequat=mi&ut=pede&nulla=malesuada&sed=in&accumsan=imperdiet&felis=et&ut=commodo&at=vulputate&dolor=justo&quis=in&odio=blandit&consequat=ultrices&varius=enim&integer=lorem&ac=ipsum&leo=dolor&pellentesque=sit&ultrices=amet&mattis=consectetuer&odio=adipiscing&donec=elit&vitae=proin&nisi=interdum&nam=mauris&ultrices=non&libero=ligula&non=pellentesque&mattis=ultrices&pulvinar=phasellus&nulla=id&pede=sapien&ullamcorper=in&augue=sapien&a=iaculis&suscipit=congue&nulla=vivamus&elit=metus&ac=arcu&nulla=adipiscing&sed=molestie&vel=hendrerit&enim=at&sit=vulputate&amet=vitae&nunc=nisl&viverra=aenean&dapibus=lectus&nulla=pellentesque&suscipit=eget&ligula=nunc&in=donec&lacus=quis&curabitur=orci&at=eget&ipsum=orci&ac=vehicula&tellus=condimentum&semper=curabitur&interdum=in', N'http://dummyimage.com/125x216.png/5fa2dd/ffffff', N'posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit', N'vestibulum sit')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (12, N'Keeling, Carroll and Hegmann', N'Gibb Thorneley', N'1', N'28299', N'United States', N'704-102-3725', N'gthorneleyb@icq.com', N'http://rediff.com/ut/nulla/sed/accumsan/felis.jpg?leo=massa&odio=id&porttitor=nisl&id=venenatis&consequat=lacinia&in=aenean&consequat=sit&ut=amet&nulla=justo&sed=morbi&accumsan=ut&felis=odio&ut=cras&at=mi&dolor=pede&quis=malesuada&odio=in&consequat=imperdiet&varius=et&integer=commodo&ac=vulputate&leo=justo&pellentesque=in&ultrices=blandit&mattis=ultrices&odio=enim&donec=lorem&vitae=ipsum&nisi=dolor&nam=sit&ultrices=amet&libero=consectetuer&non=adipiscing&mattis=elit&pulvinar=proin&nulla=interdum&pede=mauris&ullamcorper=non&augue=ligula&a=pellentesque&suscipit=ultrices&nulla=phasellus&elit=id&ac=sapien&nulla=in&sed=sapien&vel=iaculis&enim=congue&sit=vivamus&amet=metus&nunc=arcu&viverra=adipiscing&dapibus=molestie&nulla=hendrerit&suscipit=at&ligula=vulputate&in=vitae&lacus=nisl&curabitur=aenean&at=lectus&ipsum=pellentesque&ac=eget&tellus=nunc&semper=donec&interdum=quis&mauris=orci&ullamcorper=eget&purus=orci', N'http://dummyimage.com/245x244.jpg/ff4444/ffffff', NULL, N'in hac')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (13, N'O''Keefe and Sons', N'Honor Kinchlea', N'10', N'65204 CEDEX', N'France', N'848-550-1119', N'hkinchleac@spotify.com', N'https://cbc.ca/molestie/lorem.jsp?tortor=lacus&risus=morbi&dapibus=quis&augue=tortor&vel=id&accumsan=nulla&tellus=ultrices&nisi=aliquet&eu=maecenas&orci=leo&mauris=odio&lacinia=condimentum&sapien=id&quis=luctus&libero=nec&nullam=molestie&sit=sed&amet=justo&turpis=pellentesque&elementum=viverra&ligula=pede&vehicula=ac&consequat=diam&morbi=cras&a=pellentesque&ipsum=volutpat&integer=dui&a=maecenas&nibh=tristique&in=est&quis=et&justo=tempus&maecenas=semper&rhoncus=est&aliquam=quam&lacus=pharetra&morbi=magna&quis=ac&tortor=consequat&id=metus&nulla=sapien&ultrices=ut&aliquet=nunc&maecenas=vestibulum&leo=ante&odio=ipsum&condimentum=primis&id=in&luctus=faucibus', N'http://dummyimage.com/219x246.bmp/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (14, N'Mills Inc', N'Lauraine Mahomet', N'7', N'65204 CEDEX', N'Nigeria', N'933-714-1071', N'lmahometd@sakura.ne.jp', N'https://wsj.com/mi/in.html?nisi=dui&venenatis=nec&tristique=nisi&fusce=volutpat&congue=eleifend&diam=donec&id=ut&ornare=dolor&imperdiet=morbi&sapien=vel&urna=lectus&pretium=in&nisl=quam&ut=fringilla&volutpat=rhoncus&sapien=mauris&arcu=enim&sed=leo&augue=rhoncus&aliquam=sed&erat=vestibulum&volutpat=sit&in=amet&congue=cursus&etiam=id&justo=turpis&etiam=integer&pretium=aliquet&iaculis=massa&justo=id&in=lobortis&hac=convallis&habitasse=tortor&platea=risus&dictumst=dapibus&etiam=augue&faucibus=vel&cursus=accumsan&urna=tellus&ut=nisi&tellus=eu&nulla=orci&ut=mauris&erat=lacinia&id=sapien&mauris=quis&vulputate=libero&elementum=nullam&nullam=sit&varius=amet&nulla=turpis&facilisi=elementum&cras=ligula&non=vehicula&velit=consequat&nec=morbi&nisi=a&vulputate=ipsum&nonummy=integer&maecenas=a&tincidunt=nibh&lacus=in&at=quis&velit=justo&vivamus=maecenas&vel=rhoncus&nulla=aliquam&eget=lacus&eros=morbi', N'http://dummyimage.com/171x212.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (15, N'Bartoletti, Harber and Aufderhar', N'Vergil Craise', N'3', N'65204 CEDEX', N'Peru', N'109-734-9199', N'vcraisee@php.net', N'http://shop-pro.jp/id/ornare.xml?quam=in&fringilla=quis&rhoncus=justo&mauris=maecenas&enim=rhoncus&leo=aliquam&rhoncus=lacus&sed=morbi&vestibulum=quis&sit=tortor&amet=id&cursus=nulla&id=ultrices&turpis=aliquet&integer=maecenas&aliquet=leo&massa=odio&id=condimentum&lobortis=id&convallis=luctus&tortor=nec&risus=molestie&dapibus=sed&augue=justo&vel=pellentesque&accumsan=viverra&tellus=pede&nisi=ac&eu=diam&orci=cras&mauris=pellentesque&lacinia=volutpat&sapien=dui&quis=maecenas&libero=tristique&nullam=est&sit=et&amet=tempus&turpis=semper&elementum=est&ligula=quam&vehicula=pharetra&consequat=magna&morbi=ac&a=consequat&ipsum=metus&integer=sapien&a=ut&nibh=nunc&in=vestibulum&quis=ante&justo=ipsum&maecenas=primis&rhoncus=in&aliquam=faucibus&lacus=orci&morbi=luctus&quis=et&tortor=ultrices&id=posuere&nulla=cubilia&ultrices=curae&aliquet=mauris&maecenas=viverra&leo=diam&odio=vitae&condimentum=quam&id=suspendisse&luctus=potenti&nec=nullam&molestie=porttitor&sed=lacus&justo=at&pellentesque=turpis&viverra=donec&pede=posuere&ac=metus&diam=vitae&cras=ipsum&pellentesque=aliquam&volutpat=non&dui=mauris&maecenas=morbi&tristique=non&est=lectus&et=aliquam&tempus=sit&semper=amet&est=diam&quam=in&pharetra=magna&magna=bibendum&ac=imperdiet&consequat=nullam', N'http://dummyimage.com/152x198.jpg/cc0000/ffffff', NULL, N'mauris morbi')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (16, N'Prosacco LLC', N'Konstantin Dofty', N'1', N'373 72', N'Czech Republic', N'360-525-4261', N'kdoftyf@cnet.com', N'https://friendfeed.com/dapibus.jpg?ligula=libero&nec=ut&sem=massa&duis=volutpat&aliquam=convallis&convallis=morbi&nunc=odio&proin=odio&at=elementum&turpis=eu&a=interdum&pede=eu&posuere=tincidunt&nonummy=in&integer=leo&non=maecenas&velit=pulvinar&donec=lobortis&diam=est&neque=phasellus&vestibulum=sit&eget=amet&vulputate=erat&ut=nulla&ultrices=tempus&vel=vivamus&augue=in&vestibulum=felis&ante=eu&ipsum=sapien&primis=cursus&in=vestibulum&faucibus=proin&orci=eu&luctus=mi&et=nulla&ultrices=ac&posuere=enim&cubilia=in&curae=tempor&donec=turpis&pharetra=nec&magna=euismod&vestibulum=scelerisque&aliquet=quam&ultrices=turpis&erat=adipiscing&tortor=lorem&sollicitudin=vitae&mi=mattis&sit=nibh&amet=ligula&lobortis=nec&sapien=sem&sapien=duis&non=aliquam&mi=convallis&integer=nunc&ac=proin&neque=at&duis=turpis&bibendum=a&morbi=pede&non=posuere&quam=nonummy&nec=integer&dui=non&luctus=velit&rutrum=donec&nulla=diam&tellus=neque&in=vestibulum', N'http://dummyimage.com/112x246.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (17, N'Jones, Schinner and Crooks', N'Gerladina Clew', N'1', N'65204 CEDEX', N'China', N'451-801-4038', N'gclewg@archive.org', N'https://acquirethisname.com/vestibulum/ante/ipsum/primis/in.xml?diam=ipsum&vitae=praesent&quam=blandit&suspendisse=lacinia&potenti=erat&nullam=vestibulum&porttitor=sed&lacus=magna&at=at&turpis=nunc&donec=commodo&posuere=placerat&metus=praesent&vitae=blandit&ipsum=nam&aliquam=nulla&non=integer&mauris=pede&morbi=justo&non=lacinia&lectus=eget&aliquam=tincidunt&sit=eget&amet=tempus&diam=vel&in=pede&magna=morbi&bibendum=porttitor&imperdiet=lorem&nullam=id&orci=ligula&pede=suspendisse&venenatis=ornare&non=consequat&sodales=lectus&sed=in&tincidunt=est&eu=risus&felis=auctor&fusce=sed&posuere=tristique&felis=in&sed=tempus&lacus=sit&morbi=amet&sem=sem&mauris=fusce&laoreet=consequat&ut=nulla&rhoncus=nisl&aliquet=nunc&pulvinar=nisl&sed=duis&nisl=bibendum', N'http://dummyimage.com/230x149.jpg/5fa2dd/ffffff', N'pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (18, N'Effertz, Thiel and Volkman', N'Gipsy Gee', N'10', N'65204 CEDEX', N'China', N'940-842-0758', N'ggeeh@springer.com', N'https://soundcloud.com/nunc/viverra.xml?phasellus=non&id=lectus&sapien=aliquam&in=sit&sapien=amet&iaculis=diam&congue=in&vivamus=magna&metus=bibendum&arcu=imperdiet&adipiscing=nullam&molestie=orci&hendrerit=pede&at=venenatis&vulputate=non&vitae=sodales&nisl=sed&aenean=tincidunt&lectus=eu&pellentesque=felis&eget=fusce&nunc=posuere&donec=felis&quis=sed&orci=lacus&eget=morbi&orci=sem&vehicula=mauris&condimentum=laoreet&curabitur=ut&in=rhoncus&libero=aliquet&ut=pulvinar&massa=sed&volutpat=nisl&convallis=nunc&morbi=rhoncus&odio=dui&odio=vel&elementum=sem&eu=sed&interdum=sagittis&eu=nam&tincidunt=congue&in=risus&leo=semper&maecenas=porta&pulvinar=volutpat&lobortis=quam&est=pede&phasellus=lobortis&sit=ligula&amet=sit&erat=amet&nulla=eleifend&tempus=pede&vivamus=libero&in=quis&felis=orci&eu=nullam&sapien=molestie&cursus=nibh&vestibulum=in&proin=lectus&eu=pellentesque&mi=at&nulla=nulla&ac=suspendisse&enim=potenti&in=cras&tempor=in&turpis=purus&nec=eu&euismod=magna&scelerisque=vulputate', N'http://dummyimage.com/152x186.bmp/5fa2dd/ffffff', N'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (19, N'Vandervort-Lynch', N'Robinet Dunthorne', N'4', N'70120', N'Thailand', N'936-704-3280', N'rdunthornei@deliciousdays.com', N'https://a8.net/ut/suscipit/a.json?mauris=nisi&eget=volutpat&massa=eleifend&tempor=donec&convallis=ut&nulla=dolor&neque=morbi&libero=vel&convallis=lectus&eget=in&eleifend=quam&luctus=fringilla&ultricies=rhoncus&eu=mauris&nibh=enim&quisque=leo&id=rhoncus&justo=sed&sit=vestibulum&amet=sit&sapien=amet&dignissim=cursus&vestibulum=id&vestibulum=turpis&ante=integer&ipsum=aliquet&primis=massa&in=id&faucibus=lobortis&orci=convallis&luctus=tortor&et=risus&ultrices=dapibus&posuere=augue&cubilia=vel&curae=accumsan&nulla=tellus&dapibus=nisi&dolor=eu&vel=orci&est=mauris&donec=lacinia&odio=sapien&justo=quis&sollicitudin=libero&ut=nullam&suscipit=sit&a=amet&feugiat=turpis&et=elementum&eros=ligula&vestibulum=vehicula&ac=consequat', N'http://dummyimage.com/250x133.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (20, N'Hartmann, Klocko and Gutmann', N'Adriana Inchboard', N'9', N'75929 CEDEX 19', N'Philippines', N'367-344-1500', N'ainchboardj@dailymail.co.uk', N'http://wufoo.com/odio.jpg?dictumst=convallis&maecenas=tortor&ut=risus&massa=dapibus&quis=augue&augue=vel&luctus=accumsan&tincidunt=tellus&nulla=nisi&mollis=eu&molestie=orci&lorem=mauris&quisque=lacinia&ut=sapien&erat=quis&curabitur=libero&gravida=nullam&nisi=sit&at=amet&nibh=turpis&in=elementum&hac=ligula&habitasse=vehicula&platea=consequat&dictumst=morbi&aliquam=a&augue=ipsum&quam=integer&sollicitudin=a&vitae=nibh&consectetuer=in&eget=quis&rutrum=justo&at=maecenas&lorem=rhoncus&integer=aliquam&tincidunt=lacus&ante=morbi&vel=quis&ipsum=tortor&praesent=id', N'http://dummyimage.com/212x115.bmp/ff4444/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (21, N'Jacobi, Gerhold and Conroy', N'Di Wild', N'10', N'65204 CEDEX', N'Indonesia', N'588-952-6370', N'dwildk@youku.com', N'http://oakley.com/fusce/posuere/felis/sed/lacus/morbi/sem.html?nulla=ligula&nisl=sit&nunc=amet&nisl=eleifend&duis=pede&bibendum=libero&felis=quis&sed=orci&interdum=nullam&venenatis=molestie&turpis=nibh&enim=in&blandit=lectus', N'http://dummyimage.com/241x116.jpg/5fa2dd/ffffff', N'orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (22, N'Rodriguez-Bednar', N'Ilse Habbin', N'1', N'70120', N'China', N'635-251-0986', N'ihabbinl@merriam-webster.com', N'https://fc2.com/leo/odio/porttitor/id/consequat/in/consequat.html?turpis=nullam&enim=sit&blandit=amet&mi=turpis&in=elementum&porttitor=ligula&pede=vehicula&justo=consequat&eu=morbi&massa=a&donec=ipsum&dapibus=integer&duis=a&at=nibh&velit=in&eu=quis&est=justo&congue=maecenas&elementum=rhoncus&in=aliquam&hac=lacus&habitasse=morbi&platea=quis&dictumst=tortor&morbi=id&vestibulum=nulla&velit=ultrices&id=aliquet&pretium=maecenas&iaculis=leo&diam=odio&erat=condimentum&fermentum=id&justo=luctus&nec=nec&condimentum=molestie&neque=sed&sapien=justo&placerat=pellentesque&ante=viverra&nulla=pede&justo=ac&aliquam=diam&quis=cras&turpis=pellentesque&eget=volutpat&elit=dui&sodales=maecenas&scelerisque=tristique&mauris=est&sit=et&amet=tempus&eros=semper&suspendisse=est&accumsan=quam', N'http://dummyimage.com/162x161.jpg/dddddd/000000', N'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (23, N'Ruecker, Homenick and Schmitt', N'Haley Skippon', N'3', N'77281', N'China', N'316-319-2653', N'hskipponm@dell.com', N'https://unicef.org/et/tempus/semper/est/quam.html?massa=ultrices&id=posuere&lobortis=cubilia&convallis=curae&tortor=nulla&risus=dapibus&dapibus=dolor&augue=vel&vel=est&accumsan=donec&tellus=odio&nisi=justo&eu=sollicitudin&orci=ut&mauris=suscipit&lacinia=a&sapien=feugiat&quis=et&libero=eros&nullam=vestibulum&sit=ac&amet=est&turpis=lacinia&elementum=nisi&ligula=venenatis', N'http://dummyimage.com/153x141.png/dddddd/000000', N'dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (24, N'Mante-Thiel', N'Daren Gwioneth', N'8', N'77281', N'United States', N'713-102-0557', N'dgwionethn@instagram.com', N'https://house.gov/aliquet/massa/id/lobortis/convallis/tortor/risus.jpg?primis=vitae&in=nisl&faucibus=aenean&orci=lectus&luctus=pellentesque&et=eget&ultrices=nunc&posuere=donec&cubilia=quis&curae=orci&duis=eget&faucibus=orci&accumsan=vehicula&odio=condimentum&curabitur=curabitur&convallis=in&duis=libero&consequat=ut&dui=massa&nec=volutpat&nisi=convallis&volutpat=morbi&eleifend=odio&donec=odio&ut=elementum&dolor=eu&morbi=interdum&vel=eu&lectus=tincidunt&in=in&quam=leo&fringilla=maecenas&rhoncus=pulvinar&mauris=lobortis&enim=est&leo=phasellus&rhoncus=sit&sed=amet&vestibulum=erat', N'http://dummyimage.com/164x171.png/5fa2dd/ffffff', NULL, N'auctor sed')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (25, N'Carroll Inc', N'Charmine Pedycan', N'7', N'77281', N'China', N'299-502-1034', N'cpedycano@mysql.com', N'http://liveinternet.ru/odio/cras/mi/pede/malesuada/in.png?vestibulum=imperdiet&rutrum=sapien&rutrum=urna&neque=pretium', N'http://dummyimage.com/213x208.bmp/dddddd/000000', NULL, N'sit')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (26, N'Dibbert-Eichmann', N'Randie Churching', N'4', N'75929 CEDEX 19', N'France', N'575-921-8944', N'rchurchingp@state.gov', N'https://slideshare.net/mus/vivamus/vestibulum/sagittis/sapien/cum/sociis.js?id=nunc&lobortis=proin&convallis=at&tortor=turpis&risus=a&dapibus=pede&augue=posuere&vel=nonummy&accumsan=integer&tellus=non&nisi=velit&eu=donec&orci=diam&mauris=neque&lacinia=vestibulum&sapien=eget&quis=vulputate&libero=ut&nullam=ultrices&sit=vel&amet=augue&turpis=vestibulum&elementum=ante&ligula=ipsum&vehicula=primis&consequat=in&morbi=faucibus&a=orci&ipsum=luctus&integer=et&a=ultrices&nibh=posuere&in=cubilia&quis=curae&justo=donec&maecenas=pharetra&rhoncus=magna&aliquam=vestibulum&lacus=aliquet&morbi=ultrices&quis=erat&tortor=tortor&id=sollicitudin&nulla=mi&ultrices=sit&aliquet=amet&maecenas=lobortis&leo=sapien&odio=sapien&condimentum=non&id=mi', N'http://dummyimage.com/214x146.png/ff4444/ffffff', N'consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (27, N'Walker, Pfannerstill and MacGyver', N'Brier Caillou', N'9', N'633008', N'Colombia', N'130-355-6352', N'bcaillouq@nifty.com', N'http://eepurl.com/vel/augue.js?curae=sem&donec=duis&pharetra=aliquam&magna=convallis&vestibulum=nunc&aliquet=proin&ultrices=at&erat=turpis&tortor=a&sollicitudin=pede&mi=posuere&sit=nonummy&amet=integer&lobortis=non', N'http://dummyimage.com/207x117.bmp/ff4444/ffffff', N'nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum', N'nunc')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (28, N'Hyatt-McGlynn', N'Wake McGrail', N'3', N'288 02', N'China', N'375-396-7694', N'wmcgrailr@apple.com', N'https://tmall.com/sapien/varius.js?sollicitudin=sapien&ut=a&suscipit=libero&a=nam&feugiat=dui&et=proin&eros=leo&vestibulum=odio&ac=porttitor&est=id&lacinia=consequat&nisi=in&venenatis=consequat&tristique=ut&fusce=nulla&congue=sed&diam=accumsan&id=felis&ornare=ut&imperdiet=at&sapien=dolor&urna=quis&pretium=odio&nisl=consequat&ut=varius&volutpat=integer&sapien=ac&arcu=leo&sed=pellentesque&augue=ultrices&aliquam=mattis&erat=odio&volutpat=donec&in=vitae&congue=nisi&etiam=nam&justo=ultrices&etiam=libero&pretium=non&iaculis=mattis&justo=pulvinar&in=nulla&hac=pede&habitasse=ullamcorper&platea=augue&dictumst=a&etiam=suscipit&faucibus=nulla&cursus=elit&urna=ac&ut=nulla&tellus=sed&nulla=vel&ut=enim&erat=sit&id=amet', N'http://dummyimage.com/179x156.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (29, N'Von, Marks and Stanton', N'Tamma Ganny', N'1', N'288 02', N'China', N'100-405-4186', N'tgannys@google.de', N'https://phoca.cz/pulvinar.jpg?lacus=nam&morbi=dui&sem=proin&mauris=leo&laoreet=odio&ut=porttitor&rhoncus=id&aliquet=consequat&pulvinar=in&sed=consequat&nisl=ut&nunc=nulla&rhoncus=sed&dui=accumsan&vel=felis&sem=ut&sed=at&sagittis=dolor&nam=quis', N'http://dummyimage.com/136x243.jpg/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (30, N'Kutch-Bradtke', N'Christopher Jeune', N'4', N'288 02', N'Czech Republic', N'121-692-1171', N'cjeunet@ehow.com', N'http://ebay.com/velit/donec/diam/neque/vestibulum/eget/vulputate.xml?ac=porta&neque=volutpat&duis=erat&bibendum=quisque&morbi=erat&non=eros&quam=viverra&nec=eget&dui=congue&luctus=eget&rutrum=semper&nulla=rutrum&tellus=nulla', N'http://dummyimage.com/113x151.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (31, N'Mertz, Wolff and Hagenes', N'Keith Edes', N'10', N'7003', N'Vietnam', N'548-907-8900', N'kedesu@tinypic.com', N'http://gravatar.com/tellus/semper/interdum/mauris/ullamcorper/purus/sit.json?nibh=donec&in=diam&hac=neque&habitasse=vestibulum&platea=eget&dictumst=vulputate&aliquam=ut&augue=ultrices&quam=vel&sollicitudin=augue', N'http://dummyimage.com/221x222.bmp/5fa2dd/ffffff', N'ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur', N'dolor vel')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (32, N'Wisoky-Murazik', N'Freedman Gauvain', N'9', N'7003', N'Philippines', N'628-362-7139', N'fgauvainv@jugem.jp', N'http://sfgate.com/ligula.html?nibh=vivamus&fusce=vestibulum&lacus=sagittis&purus=sapien&aliquet=cum&at=sociis&feugiat=natoque&non=penatibus&pretium=et&quis=magnis&lectus=dis&suspendisse=parturient&potenti=montes&in=nascetur&eleifend=ridiculus&quam=mus&a=etiam&odio=vel&in=augue&hac=vestibulum&habitasse=rutrum&platea=rutrum&dictumst=neque&maecenas=aenean&ut=auctor&massa=gravida&quis=sem&augue=praesent&luctus=id&tincidunt=massa&nulla=id&mollis=nisl&molestie=venenatis&lorem=lacinia&quisque=aenean&ut=sit&erat=amet&curabitur=justo&gravida=morbi&nisi=ut&at=odio&nibh=cras&in=mi&hac=pede&habitasse=malesuada&platea=in&dictumst=imperdiet&aliquam=et&augue=commodo&quam=vulputate&sollicitudin=justo&vitae=in&consectetuer=blandit&eget=ultrices&rutrum=enim&at=lorem&lorem=ipsum&integer=dolor&tincidunt=sit&ante=amet&vel=consectetuer&ipsum=adipiscing&praesent=elit&blandit=proin&lacinia=interdum&erat=mauris&vestibulum=non&sed=ligula&magna=pellentesque&at=ultrices&nunc=phasellus&commodo=id&placerat=sapien&praesent=in&blandit=sapien&nam=iaculis&nulla=congue&integer=vivamus&pede=metus&justo=arcu&lacinia=adipiscing&eget=molestie&tincidunt=hendrerit&eget=at', N'http://dummyimage.com/170x127.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (33, N'Bechtelar Inc', N'Gertrude Delwater', N'2', N'7003', N'China', N'500-548-0288', N'gdelwaterw@elpais.com', N'https://linkedin.com/lorem/ipsum/dolor/sit.aspx?faucibus=posuere&orci=cubilia&luctus=curae&et=duis&ultrices=faucibus&posuere=accumsan&cubilia=odio&curae=curabitur&donec=convallis&pharetra=duis&magna=consequat&vestibulum=dui&aliquet=nec&ultrices=nisi&erat=volutpat&tortor=eleifend&sollicitudin=donec&mi=ut&sit=dolor&amet=morbi&lobortis=vel&sapien=lectus&sapien=in&non=quam&mi=fringilla&integer=rhoncus', N'http://dummyimage.com/250x194.jpg/5fa2dd/ffffff', NULL, N'ultricies eu')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (34, N'Torp, Stroman and Hermann', N'Dion Milhench', N'4', N'7003', N'China', N'926-431-6752', N'dmilhenchx@geocities.jp', N'http://chicagotribune.com/at/velit.js?in=nulla&congue=mollis&etiam=molestie&justo=lorem&etiam=quisque&pretium=ut&iaculis=erat&justo=curabitur&in=gravida&hac=nisi&habitasse=at&platea=nibh&dictumst=in&etiam=hac&faucibus=habitasse&cursus=platea&urna=dictumst&ut=aliquam&tellus=augue&nulla=quam&ut=sollicitudin&erat=vitae&id=consectetuer&mauris=eget&vulputate=rutrum&elementum=at&nullam=lorem&varius=integer&nulla=tincidunt&facilisi=ante&cras=vel&non=ipsum&velit=praesent&nec=blandit&nisi=lacinia&vulputate=erat&nonummy=vestibulum&maecenas=sed&tincidunt=magna&lacus=at&at=nunc&velit=commodo&vivamus=placerat&vel=praesent&nulla=blandit&eget=nam&eros=nulla&elementum=integer&pellentesque=pede&quisque=justo&porta=lacinia&volutpat=eget&erat=tincidunt&quisque=eget&erat=tempus&eros=vel&viverra=pede&eget=morbi&congue=porttitor&eget=lorem&semper=id&rutrum=ligula&nulla=suspendisse&nunc=ornare', N'http://dummyimage.com/204x204.png/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (35, N'Dicki Inc', N'Allan Wicks', N'6', N'8301', N'Philippines', N'472-969-6872', N'awicksy@usnews.com', N'https://answers.com/mi/integer/ac/neque/duis/bibendum/morbi.png?sapien=vulputate&urna=ut&pretium=ultrices&nisl=vel&ut=augue&volutpat=vestibulum&sapien=ante&arcu=ipsum&sed=primis&augue=in&aliquam=faucibus&erat=orci&volutpat=luctus&in=et&congue=ultrices&etiam=posuere&justo=cubilia&etiam=curae&pretium=donec&iaculis=pharetra&justo=magna&in=vestibulum&hac=aliquet&habitasse=ultrices&platea=erat&dictumst=tortor&etiam=sollicitudin&faucibus=mi&cursus=sit&urna=amet&ut=lobortis&tellus=sapien&nulla=sapien&ut=non&erat=mi&id=integer&mauris=ac&vulputate=neque&elementum=duis&nullam=bibendum&varius=morbi&nulla=non&facilisi=quam&cras=nec&non=dui&velit=luctus&nec=rutrum&nisi=nulla&vulputate=tellus&nonummy=in&maecenas=sagittis&tincidunt=dui&lacus=vel&at=nisl', N'http://dummyimage.com/106x154.bmp/5fa2dd/ffffff', N'nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus', N'bibendum')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (36, N'Wilderman, Barton and Hauck', N'Robby Fisk', N'5', N'8301', N'Indonesia', N'930-558-9154', N'rfiskz@unesco.org', N'http://harvard.edu/ante/ipsum/primis/in/faucibus.html?ut=felis&odio=ut&cras=at&mi=dolor&pede=quis&malesuada=odio&in=consequat&imperdiet=varius&et=integer&commodo=ac&vulputate=leo&justo=pellentesque&in=ultrices&blandit=mattis&ultrices=odio&enim=donec&lorem=vitae&ipsum=nisi&dolor=nam&sit=ultrices&amet=libero&consectetuer=non&adipiscing=mattis&elit=pulvinar&proin=nulla&interdum=pede&mauris=ullamcorper&non=augue&ligula=a&pellentesque=suscipit&ultrices=nulla&phasellus=elit', N'http://dummyimage.com/132x177.jpg/ff4444/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (37, N'Turcotte, Oberbrunner and Reichert', N'Zaneta Gurling', N'3', N'425 33', N'Indonesia', N'430-413-1358', N'zgurling10@sohu.com', N'http://ca.gov/feugiat/non/pretium/quis/lectus.jsp?ultrices=eu&posuere=nibh&cubilia=quisque&curae=id&duis=justo&faucibus=sit&accumsan=amet&odio=sapien&curabitur=dignissim&convallis=vestibulum&duis=vestibulum&consequat=ante&dui=ipsum&nec=primis&nisi=in&volutpat=faucibus&eleifend=orci&donec=luctus&ut=et&dolor=ultrices&morbi=posuere&vel=cubilia&lectus=curae&in=nulla&quam=dapibus&fringilla=dolor&rhoncus=vel&mauris=est&enim=donec&leo=odio&rhoncus=justo&sed=sollicitudin&vestibulum=ut&sit=suscipit&amet=a&cursus=feugiat&id=et&turpis=eros&integer=vestibulum&aliquet=ac&massa=est&id=lacinia&lobortis=nisi&convallis=venenatis&tortor=tristique&risus=fusce&dapibus=congue&augue=diam&vel=id&accumsan=ornare&tellus=imperdiet&nisi=sapien&eu=urna&orci=pretium&mauris=nisl&lacinia=ut&sapien=volutpat&quis=sapien&libero=arcu&nullam=sed&sit=augue&amet=aliquam&turpis=erat&elementum=volutpat&ligula=in&vehicula=congue&consequat=etiam&morbi=justo&a=etiam&ipsum=pretium&integer=iaculis&a=justo&nibh=in&in=hac&quis=habitasse&justo=platea&maecenas=dictumst&rhoncus=etiam&aliquam=faucibus&lacus=cursus&morbi=urna&quis=ut&tortor=tellus&id=nulla&nulla=ut&ultrices=erat&aliquet=id&maecenas=mauris&leo=vulputate&odio=elementum&condimentum=nullam&id=varius&luctus=nulla', N'http://dummyimage.com/219x159.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (38, N'Bednar-Gerhold', N'Wynnie Liddel', N'10', N'8115', N'South Africa', N'148-475-4935', N'wliddel11@goo.ne.jp', N'https://umn.edu/posuere/cubilia/curae.json?ante=et&ipsum=ultrices&primis=posuere&in=cubilia&faucibus=curae&orci=donec&luctus=pharetra&et=magna&ultrices=vestibulum&posuere=aliquet&cubilia=ultrices&curae=erat&donec=tortor&pharetra=sollicitudin&magna=mi&vestibulum=sit&aliquet=amet&ultrices=lobortis&erat=sapien&tortor=sapien&sollicitudin=non&mi=mi&sit=integer&amet=ac&lobortis=neque&sapien=duis&sapien=bibendum&non=morbi&mi=non&integer=quam&ac=nec&neque=dui&duis=luctus&bibendum=rutrum&morbi=nulla&non=tellus&quam=in&nec=sagittis&dui=dui&luctus=vel&rutrum=nisl&nulla=duis&tellus=ac&in=nibh&sagittis=fusce&dui=lacus&vel=purus&nisl=aliquet&duis=at&ac=feugiat&nibh=non&fusce=pretium&lacus=quis', N'http://dummyimage.com/195x115.png/ff4444/ffffff', N'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (39, N'Boehm Group', N'Rochelle MacGragh', N'3', N'425 33', N'Sweden', N'911-312-5534', N'rmacgragh12@narod.ru', N'http://webnode.com/amet/eros/suspendisse/accumsan/tortor/quis/turpis.json?praesent=aliquam&blandit=lacus&nam=morbi&nulla=quis&integer=tortor&pede=id&justo=nulla&lacinia=ultrices&eget=aliquet&tincidunt=maecenas&eget=leo&tempus=odio&vel=condimentum', N'http://dummyimage.com/203x238.bmp/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (40, N'Weber-Daniel', N'Kristoffer Benton', N'9', N'P0M', N'Ukraine', N'891-637-5289', N'kbenton13@house.gov', N'http://usda.gov/ultrices/aliquet/maecenas/leo/odio/condimentum/id.xml?quis=sit&justo=amet&maecenas=erat&rhoncus=nulla&aliquam=tempus&lacus=vivamus&morbi=in&quis=felis&tortor=eu&id=sapien&nulla=cursus&ultrices=vestibulum&aliquet=proin&maecenas=eu&leo=mi&odio=nulla&condimentum=ac&id=enim&luctus=in&nec=tempor&molestie=turpis&sed=nec&justo=euismod&pellentesque=scelerisque&viverra=quam&pede=turpis&ac=adipiscing&diam=lorem&cras=vitae&pellentesque=mattis', N'http://dummyimage.com/101x222.bmp/dddddd/000000', NULL, N'vel')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (41, N'Aufderhar Inc', N'Rudolfo Lowrance', N'4', N'355 92', N'Sweden', N'444-724-0426', N'rlowrance14@51.la', N'http://amazonaws.com/scelerisque.html?diam=duis&erat=aliquam&fermentum=convallis&justo=nunc&nec=proin&condimentum=at&neque=turpis&sapien=a&placerat=pede&ante=posuere&nulla=nonummy&justo=integer&aliquam=non&quis=velit&turpis=donec&eget=diam&elit=neque&sodales=vestibulum&scelerisque=eget&mauris=vulputate&sit=ut&amet=ultrices&eros=vel&suspendisse=augue&accumsan=vestibulum&tortor=ante&quis=ipsum&turpis=primis&sed=in&ante=faucibus&vivamus=orci&tortor=luctus&duis=et&mattis=ultrices&egestas=posuere&metus=cubilia&aenean=curae&fermentum=donec&donec=pharetra&ut=magna&mauris=vestibulum&eget=aliquet&massa=ultrices&tempor=erat&convallis=tortor', N'http://dummyimage.com/157x119.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (42, N'Krajcik-Koepp', N'Emilia Caulier', N'8', N'P0M', N'Indonesia', N'591-855-2198', N'ecaulier15@oakley.com', N'https://webeden.co.uk/varius.html?felis=odio&eu=curabitur&sapien=convallis&cursus=duis&vestibulum=consequat&proin=dui&eu=nec&mi=nisi&nulla=volutpat&ac=eleifend&enim=donec&in=ut&tempor=dolor&turpis=morbi&nec=vel&euismod=lectus&scelerisque=in&quam=quam&turpis=fringilla&adipiscing=rhoncus&lorem=mauris&vitae=enim&mattis=leo&nibh=rhoncus&ligula=sed', N'http://dummyimage.com/108x197.jpg/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (43, N'Jacobi, Tremblay and Stiedemann', N'Chancey Feather', N'6', N'P0M', N'Canada', N'854-968-9695', N'cfeather16@usnews.com', N'http://gov.uk/aliquam/sit.aspx?nonummy=adipiscing&integer=lorem&non=vitae&velit=mattis&donec=nibh&diam=ligula&neque=nec&vestibulum=sem&eget=duis&vulputate=aliquam&ut=convallis&ultrices=nunc&vel=proin&augue=at&vestibulum=turpis&ante=a&ipsum=pede&primis=posuere&in=nonummy&faucibus=integer&orci=non&luctus=velit&et=donec&ultrices=diam&posuere=neque&cubilia=vestibulum&curae=eget&donec=vulputate&pharetra=ut&magna=ultrices&vestibulum=vel&aliquet=augue&ultrices=vestibulum&erat=ante&tortor=ipsum&sollicitudin=primis&mi=in&sit=faucibus&amet=orci&lobortis=luctus&sapien=et&sapien=ultrices&non=posuere&mi=cubilia&integer=curae&ac=donec&neque=pharetra&duis=magna&bibendum=vestibulum&morbi=aliquet&non=ultrices&quam=erat&nec=tortor&dui=sollicitudin&luctus=mi&rutrum=sit&nulla=amet&tellus=lobortis', N'http://dummyimage.com/153x240.png/ff4444/ffffff', NULL, N'justo')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (44, N'Volkman, Balistreri and Jast', N'Beckie Mollnar', N'4', N'63-830', N'Indonesia', N'683-561-4246', N'bmollnar17@ca.gov', N'https://feedburner.com/eget.js?justo=ligula&nec=nec&condimentum=sem&neque=duis&sapien=aliquam&placerat=convallis&ante=nunc&nulla=proin&justo=at&aliquam=turpis&quis=a&turpis=pede&eget=posuere&elit=nonummy&sodales=integer&scelerisque=non&mauris=velit&sit=donec&amet=diam&eros=neque&suspendisse=vestibulum&accumsan=eget&tortor=vulputate&quis=ut&turpis=ultrices&sed=vel&ante=augue&vivamus=vestibulum&tortor=ante&duis=ipsum&mattis=primis&egestas=in&metus=faucibus&aenean=orci&fermentum=luctus&donec=et&ut=ultrices&mauris=posuere&eget=cubilia&massa=curae&tempor=donec&convallis=pharetra&nulla=magna&neque=vestibulum&libero=aliquet&convallis=ultrices&eget=erat&eleifend=tortor&luctus=sollicitudin&ultricies=mi&eu=sit&nibh=amet&quisque=lobortis&id=sapien&justo=sapien&sit=non&amet=mi&sapien=integer&dignissim=ac&vestibulum=neque', N'http://dummyimage.com/197x158.png/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (45, N'Koss, Ernser and Bergnaum', N'Stavros Sauven', N'1', N'474-0074', N'Malawi', N'467-289-9449', N'ssauven18@huffingtonpost.com', N'http://hp.com/felis/fusce/posuere/felis/sed/lacus/morbi.xml?cras=pharetra&mi=magna&pede=vestibulum&malesuada=aliquet&in=ultrices&imperdiet=erat&et=tortor&commodo=sollicitudin&vulputate=mi&justo=sit&in=amet&blandit=lobortis&ultrices=sapien&enim=sapien&lorem=non&ipsum=mi&dolor=integer&sit=ac&amet=neque&consectetuer=duis', N'http://dummyimage.com/155x190.jpg/ff4444/ffffff', N'consequat morbi a ipsum integer a nibh in quis justo', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (46, N'Smith, Schimmel and Mann', N'Siffre Stile', N'10', N'474-0074', N'China', N'989-141-5931', N'sstile19@gizmodo.com', N'https://ftc.gov/nulla.jpg?pede=aenean&posuere=sit&nonummy=amet&integer=justo&non=morbi&velit=ut&donec=odio&diam=cras&neque=mi&vestibulum=pede&eget=malesuada&vulputate=in&ut=imperdiet&ultrices=et&vel=commodo&augue=vulputate&vestibulum=justo&ante=in&ipsum=blandit&primis=ultrices&in=enim&faucibus=lorem&orci=ipsum&luctus=dolor&et=sit&ultrices=amet&posuere=consectetuer&cubilia=adipiscing&curae=elit&donec=proin&pharetra=interdum&magna=mauris&vestibulum=non&aliquet=ligula&ultrices=pellentesque&erat=ultrices&tortor=phasellus&sollicitudin=id&mi=sapien&sit=in&amet=sapien&lobortis=iaculis&sapien=congue&sapien=vivamus&non=metus&mi=arcu&integer=adipiscing&ac=molestie&neque=hendrerit&duis=at&bibendum=vulputate&morbi=vitae&non=nisl&quam=aenean&nec=lectus&dui=pellentesque&luctus=eget&rutrum=nunc&nulla=donec&tellus=quis&in=orci&sagittis=eget&dui=orci&vel=vehicula&nisl=condimentum&duis=curabitur&ac=in&nibh=libero&fusce=ut&lacus=massa&purus=volutpat', N'http://dummyimage.com/246x107.png/ff4444/ffffff', N'suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id', N'in')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (47, N'Balistreri Inc', N'Farand Ebbs', N'3', N'93214 CEDEX', N'Indonesia', N'664-997-1385', N'febbs1a@dropbox.com', N'http://hud.gov/lorem.jsp?ut=neque&erat=aenean&id=auctor&mauris=gravida&vulputate=sem&elementum=praesent&nullam=id&varius=massa&nulla=id&facilisi=nisl&cras=venenatis&non=lacinia&velit=aenean&nec=sit&nisi=amet&vulputate=justo&nonummy=morbi&maecenas=ut&tincidunt=odio&lacus=cras&at=mi&velit=pede&vivamus=malesuada&vel=in&nulla=imperdiet&eget=et&eros=commodo&elementum=vulputate&pellentesque=justo&quisque=in&porta=blandit&volutpat=ultrices&erat=enim&quisque=lorem&erat=ipsum&eros=dolor&viverra=sit&eget=amet&congue=consectetuer&eget=adipiscing&semper=elit&rutrum=proin&nulla=interdum&nunc=mauris&purus=non&phasellus=ligula&in=pellentesque&felis=ultrices&donec=phasellus&semper=id&sapien=sapien&a=in&libero=sapien&nam=iaculis&dui=congue&proin=vivamus&leo=metus&odio=arcu&porttitor=adipiscing&id=molestie&consequat=hendrerit&in=at&consequat=vulputate&ut=vitae&nulla=nisl&sed=aenean&accumsan=lectus&felis=pellentesque&ut=eget&at=nunc&dolor=donec&quis=quis&odio=orci&consequat=eget&varius=orci&integer=vehicula&ac=condimentum&leo=curabitur&pellentesque=in&ultrices=libero&mattis=ut&odio=massa&donec=volutpat&vitae=convallis&nisi=morbi&nam=odio', N'http://dummyimage.com/118x137.png/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (48, N'Littel, Collier and Hayes', N'Gianina Merrydew', N'9', N'93214 CEDEX', N'Greece', N'423-523-2765', N'gmerrydew1b@icq.com', N'https://clickbank.net/quisque/id/justo.jsp?integer=eleifend&ac=luctus&leo=ultricies&pellentesque=eu&ultrices=nibh&mattis=quisque&odio=id&donec=justo&vitae=sit&nisi=amet&nam=sapien&ultrices=dignissim&libero=vestibulum&non=vestibulum&mattis=ante&pulvinar=ipsum&nulla=primis&pede=in&ullamcorper=faucibus&augue=orci&a=luctus&suscipit=et&nulla=ultrices&elit=posuere&ac=cubilia&nulla=curae&sed=nulla&vel=dapibus&enim=dolor&sit=vel&amet=est&nunc=donec&viverra=odio&dapibus=justo&nulla=sollicitudin&suscipit=ut&ligula=suscipit&in=a&lacus=feugiat&curabitur=et&at=eros&ipsum=vestibulum&ac=ac&tellus=est&semper=lacinia&interdum=nisi&mauris=venenatis&ullamcorper=tristique&purus=fusce&sit=congue&amet=diam&nulla=id&quisque=ornare&arcu=imperdiet&libero=sapien&rutrum=urna&ac=pretium&lobortis=nisl&vel=ut&dapibus=volutpat&at=sapien&diam=arcu&nam=sed', N'http://dummyimage.com/234x220.png/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (49, N'Steuber Group', N'Shellie Eadmeades', N'7', N'P0T', N'Canada', N'401-997-9309', N'seadmeades1c@g.co', N'http://tinypic.com/ac.jpg?diam=tincidunt&erat=eu&fermentum=felis&justo=fusce&nec=posuere&condimentum=felis&neque=sed&sapien=lacus&placerat=morbi&ante=sem&nulla=mauris&justo=laoreet&aliquam=ut&quis=rhoncus&turpis=aliquet&eget=pulvinar&elit=sed&sodales=nisl&scelerisque=nunc&mauris=rhoncus&sit=dui&amet=vel&eros=sem&suspendisse=sed&accumsan=sagittis&tortor=nam&quis=congue&turpis=risus&sed=semper&ante=porta&vivamus=volutpat', N'http://dummyimage.com/245x124.bmp/cc0000/ffffff', N'purus sit amet nulla quisque arcu libero rutrum ac lobortis vel', N'blandit')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (50, N'Hoeger, Hauck and Hoppe', N'Pet Gibberd', N'4', N'88901', N'Finland', N'665-718-6313', N'pgibberd1d@cam.ac.uk', N'https://squidoo.com/in/porttitor.jsp?nulla=sed&dapibus=ante&dolor=vivamus&vel=tortor&est=duis&donec=mattis&odio=egestas', N'http://dummyimage.com/157x222.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (51, N'Simonis, Von and Oberbrunner', N'Marlee Latham', N'3', N'86-318', N'Poland', N'685-892-1847', N'mlatham1e@ted.com', N'https://theguardian.com/vulputate/vitae/nisl.jsp?ipsum=donec&dolor=dapibus&sit=duis&amet=at&consectetuer=velit&adipiscing=eu&elit=est&proin=congue&interdum=elementum&mauris=in&non=hac&ligula=habitasse&pellentesque=platea&ultrices=dictumst&phasellus=morbi&id=vestibulum&sapien=velit&in=id&sapien=pretium&iaculis=iaculis&congue=diam&vivamus=erat&metus=fermentum&arcu=justo&adipiscing=nec&molestie=condimentum&hendrerit=neque&at=sapien&vulputate=placerat&vitae=ante&nisl=nulla&aenean=justo&lectus=aliquam&pellentesque=quis&eget=turpis&nunc=eget&donec=elit&quis=sodales&orci=scelerisque&eget=mauris&orci=sit&vehicula=amet&condimentum=eros&curabitur=suspendisse&in=accumsan&libero=tortor&ut=quis&massa=turpis&volutpat=sed&convallis=ante&morbi=vivamus&odio=tortor&odio=duis&elementum=mattis&eu=egestas&interdum=metus&eu=aenean&tincidunt=fermentum&in=donec&leo=ut&maecenas=mauris&pulvinar=eget&lobortis=massa&est=tempor&phasellus=convallis&sit=nulla', N'http://dummyimage.com/175x130.jpg/cc0000/ffffff', N'nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (52, N'Morar and Sons', N'Meara Paradine', N'3', N'474-0074', N'Japan', N'224-389-5538', N'mparadine1f@wikispaces.com', N'http://dion.ne.jp/vestibulum/aliquet/ultrices/erat.json?molestie=eleifend&nibh=quam&in=a&lectus=odio&pellentesque=in&at=hac&nulla=habitasse&suspendisse=platea&potenti=dictumst&cras=maecenas&in=ut&purus=massa&eu=quis&magna=augue&vulputate=luctus&luctus=tincidunt&cum=nulla&sociis=mollis&natoque=molestie&penatibus=lorem&et=quisque&magnis=ut&dis=erat&parturient=curabitur&montes=gravida&nascetur=nisi&ridiculus=at&mus=nibh&vivamus=in&vestibulum=hac&sagittis=habitasse&sapien=platea&cum=dictumst&sociis=aliquam&natoque=augue&penatibus=quam&et=sollicitudin&magnis=vitae&dis=consectetuer&parturient=eget&montes=rutrum&nascetur=at&ridiculus=lorem&mus=integer&etiam=tincidunt&vel=ante&augue=vel&vestibulum=ipsum&rutrum=praesent&rutrum=blandit&neque=lacinia&aenean=erat&auctor=vestibulum&gravida=sed&sem=magna&praesent=at&id=nunc&massa=commodo&id=placerat&nisl=praesent&venenatis=blandit&lacinia=nam&aenean=nulla&sit=integer&amet=pede&justo=justo&morbi=lacinia&ut=eget&odio=tincidunt&cras=eget&mi=tempus&pede=vel&malesuada=pede&in=morbi&imperdiet=porttitor&et=lorem&commodo=id&vulputate=ligula&justo=suspendisse&in=ornare&blandit=consequat&ultrices=lectus', N'http://dummyimage.com/101x228.jpg/5fa2dd/ffffff', N'orci pede venenatis non sodales sed tincidunt eu felis fusce posuere', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (53, N'Wolff, Pagac and Zboncak', N'Muffin Abbotson', N'7', N'93214 CEDEX', N'China', N'945-409-9018', N'mabbotson1g@unblog.fr', N'https://imageshack.us/porta/volutpat/erat.js?at=libero&lorem=non&integer=mattis&tincidunt=pulvinar&ante=nulla&vel=pede&ipsum=ullamcorper&praesent=augue&blandit=a&lacinia=suscipit&erat=nulla&vestibulum=elit&sed=ac&magna=nulla&at=sed&nunc=vel&commodo=enim&placerat=sit&praesent=amet&blandit=nunc', N'http://dummyimage.com/124x204.png/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (54, N'Goldner, Nicolas and Wyman', N'Reinald Wren', N'7', N'63-830', N'China', N'790-155-9698', N'rwren1h@soup.io', N'https://apache.org/sed/nisl/nunc.xml?enim=ridiculus&lorem=mus&ipsum=etiam&dolor=vel&sit=augue&amet=vestibulum&consectetuer=rutrum&adipiscing=rutrum&elit=neque&proin=aenean&interdum=auctor&mauris=gravida&non=sem&ligula=praesent&pellentesque=id&ultrices=massa&phasellus=id&id=nisl&sapien=venenatis&in=lacinia&sapien=aenean&iaculis=sit&congue=amet&vivamus=justo&metus=morbi&arcu=ut&adipiscing=odio&molestie=cras&hendrerit=mi&at=pede&vulputate=malesuada&vitae=in&nisl=imperdiet&aenean=et&lectus=commodo&pellentesque=vulputate&eget=justo&nunc=in&donec=blandit&quis=ultrices&orci=enim&eget=lorem&orci=ipsum&vehicula=dolor&condimentum=sit&curabitur=amet&in=consectetuer&libero=adipiscing&ut=elit&massa=proin&volutpat=interdum&convallis=mauris&morbi=non&odio=ligula&odio=pellentesque&elementum=ultrices&eu=phasellus&interdum=id&eu=sapien&tincidunt=in&in=sapien&leo=iaculis&maecenas=congue&pulvinar=vivamus&lobortis=metus&est=arcu&phasellus=adipiscing&sit=molestie&amet=hendrerit&erat=at&nulla=vulputate&tempus=vitae&vivamus=nisl&in=aenean&felis=lectus&eu=pellentesque&sapien=eget&cursus=nunc&vestibulum=donec&proin=quis&eu=orci&mi=eget&nulla=orci', N'http://dummyimage.com/205x136.jpg/cc0000/ffffff', N'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (55, N'Durgan-Zemlak', N'Stinky Shelmardine', N'2', N'63-830', N'Poland', N'661-232-1142', N'sshelmardine1i@oakley.com', N'http://ycombinator.com/nunc/purus/phasellus/in/felis/donec/semper.js?convallis=ac&morbi=diam&odio=cras&odio=pellentesque&elementum=volutpat&eu=dui&interdum=maecenas&eu=tristique&tincidunt=est&in=et&leo=tempus&maecenas=semper&pulvinar=est&lobortis=quam&est=pharetra&phasellus=magna&sit=ac&amet=consequat&erat=metus&nulla=sapien&tempus=ut&vivamus=nunc&in=vestibulum&felis=ante&eu=ipsum&sapien=primis&cursus=in&vestibulum=faucibus&proin=orci&eu=luctus&mi=et', N'http://dummyimage.com/222x215.png/dddddd/000000', N'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (56, N'Goldner, Yundt and Roberts', N'Sidonnie Skakunas', N'4', N'35450-000', N'Zimbabwe', N'167-822-7003', N'sskakunas1j@vk.com', N'http://theguardian.com/urna/ut/tellus/nulla/ut.js?elementum=in&nullam=leo&varius=maecenas&nulla=pulvinar&facilisi=lobortis&cras=est&non=phasellus&velit=sit&nec=amet&nisi=erat&vulputate=nulla&nonummy=tempus&maecenas=vivamus&tincidunt=in&lacus=felis&at=eu&velit=sapien&vivamus=cursus&vel=vestibulum&nulla=proin&eget=eu&eros=mi&elementum=nulla&pellentesque=ac&quisque=enim&porta=in&volutpat=tempor&erat=turpis&quisque=nec&erat=euismod&eros=scelerisque&viverra=quam&eget=turpis&congue=adipiscing&eget=lorem&semper=vitae&rutrum=mattis&nulla=nibh&nunc=ligula&purus=nec&phasellus=sem&in=duis&felis=aliquam&donec=convallis&semper=nunc&sapien=proin&a=at&libero=turpis&nam=a&dui=pede&proin=posuere', N'http://dummyimage.com/226x116.png/5fa2dd/ffffff', N'sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (57, N'Daniel LLC', N'Dolly Devlin', N'3', N'WC2H', N'United Kingdom', N'993-965-8617', N'ddevlin1k@bloglines.com', N'http://sitemeter.com/nullam/porttitor.js?odio=aliquam&in=augue&hac=quam&habitasse=sollicitudin&platea=vitae&dictumst=consectetuer&maecenas=eget&ut=rutrum&massa=at&quis=lorem&augue=integer&luctus=tincidunt&tincidunt=ante&nulla=vel&mollis=ipsum&molestie=praesent&lorem=blandit&quisque=lacinia&ut=erat&erat=vestibulum&curabitur=sed&gravida=magna&nisi=at&at=nunc&nibh=commodo&in=placerat&hac=praesent&habitasse=blandit&platea=nam&dictumst=nulla&aliquam=integer&augue=pede&quam=justo&sollicitudin=lacinia&vitae=eget&consectetuer=tincidunt&eget=eget&rutrum=tempus&at=vel&lorem=pede&integer=morbi&tincidunt=porttitor&ante=lorem&vel=id&ipsum=ligula&praesent=suspendisse&blandit=ornare&lacinia=consequat&erat=lectus&vestibulum=in&sed=est&magna=risus&at=auctor&nunc=sed&commodo=tristique&placerat=in&praesent=tempus&blandit=sit&nam=amet&nulla=sem&integer=fusce&pede=consequat&justo=nulla&lacinia=nisl&eget=nunc&tincidunt=nisl&eget=duis&tempus=bibendum&vel=felis&pede=sed&morbi=interdum&porttitor=venenatis&lorem=turpis&id=enim&ligula=blandit&suspendisse=mi&ornare=in&consequat=porttitor&lectus=pede&in=justo&est=eu&risus=massa&auctor=donec&sed=dapibus&tristique=duis&in=at&tempus=velit&sit=eu&amet=est&sem=congue&fusce=elementum&consequat=in&nulla=hac&nisl=habitasse&nunc=platea&nisl=dictumst', N'http://dummyimage.com/189x168.jpg/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (58, N'Jones Inc', N'Carin McIlroy', N'1', N'93214 CEDEX', N'France', N'767-797-0940', N'cmcilroy1l@constantcontact.com', N'http://nifty.com/platea.js?imperdiet=risus&sapien=semper&urna=porta&pretium=volutpat&nisl=quam&ut=pede&volutpat=lobortis&sapien=ligula&arcu=sit&sed=amet&augue=eleifend&aliquam=pede&erat=libero&volutpat=quis&in=orci&congue=nullam&etiam=molestie&justo=nibh&etiam=in&pretium=lectus&iaculis=pellentesque&justo=at&in=nulla&hac=suspendisse&habitasse=potenti&platea=cras&dictumst=in&etiam=purus&faucibus=eu&cursus=magna&urna=vulputate&ut=luctus&tellus=cum&nulla=sociis&ut=natoque&erat=penatibus&id=et&mauris=magnis&vulputate=dis&elementum=parturient&nullam=montes&varius=nascetur&nulla=ridiculus&facilisi=mus&cras=vivamus&non=vestibulum&velit=sagittis&nec=sapien&nisi=cum&vulputate=sociis&nonummy=natoque&maecenas=penatibus&tincidunt=et&lacus=magnis&at=dis&velit=parturient&vivamus=montes&vel=nascetur&nulla=ridiculus&eget=mus&eros=etiam&elementum=vel&pellentesque=augue&quisque=vestibulum&porta=rutrum&volutpat=rutrum&erat=neque&quisque=aenean&erat=auctor&eros=gravida&viverra=sem&eget=praesent&congue=id&eget=massa&semper=id&rutrum=nisl&nulla=venenatis&nunc=lacinia&purus=aenean&phasellus=sit&in=amet&felis=justo&donec=morbi', N'http://dummyimage.com/185x150.bmp/dddddd/000000', N'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (59, N'Brakus and Sons', N'Melvin Theuss', N'6', N'739 04', N'Czech Republic', N'524-761-1413', N'mtheuss1m@huffingtonpost.com', N'https://washington.edu/in/faucibus/orci/luctus/et/ultrices/posuere.jsp?amet=volutpat&turpis=dui&elementum=maecenas&ligula=tristique&vehicula=est&consequat=et&morbi=tempus&a=semper&ipsum=est&integer=quam&a=pharetra&nibh=magna&in=ac&quis=consequat&justo=metus&maecenas=sapien&rhoncus=ut&aliquam=nunc&lacus=vestibulum&morbi=ante&quis=ipsum&tortor=primis&id=in&nulla=faucibus&ultrices=orci&aliquet=luctus&maecenas=et&leo=ultrices&odio=posuere&condimentum=cubilia&id=curae', N'http://dummyimage.com/106x166.jpg/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (60, N'Kautzer-Kozey', N'Bonita Longden', N'2', N'35450-000', N'Brazil', N'556-542-1028', N'blongden1n@sbwire.com', N'https://comsenz.com/lobortis/vel/dapibus/at/diam/nam.aspx?potenti=nec&cras=condimentum&in=neque&purus=sapien&eu=placerat&magna=ante&vulputate=nulla&luctus=justo', N'http://dummyimage.com/211x145.png/cc0000/ffffff', N'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (61, N'Grady-Miller', N'Marcelo Weiser', N'5', N'314-0048', N'Vietnam', N'471-249-1136', N'mweiser1o@vinaora.com', N'https://dedecms.com/sit/amet/consectetuer.json?sed=amet&magna=turpis&at=elementum&nunc=ligula&commodo=vehicula&placerat=consequat&praesent=morbi&blandit=a&nam=ipsum&nulla=integer&integer=a&pede=nibh&justo=in&lacinia=quis&eget=justo&tincidunt=maecenas&eget=rhoncus&tempus=aliquam&vel=lacus&pede=morbi&morbi=quis&porttitor=tortor&lorem=id&id=nulla&ligula=ultrices&suspendisse=aliquet&ornare=maecenas&consequat=leo&lectus=odio&in=condimentum&est=id&risus=luctus&auctor=nec&sed=molestie&tristique=sed&in=justo&tempus=pellentesque&sit=viverra&amet=pede&sem=ac&fusce=diam&consequat=cras&nulla=pellentesque&nisl=volutpat&nunc=dui&nisl=maecenas&duis=tristique&bibendum=est&felis=et&sed=tempus&interdum=semper&venenatis=est&turpis=quam&enim=pharetra&blandit=magna&mi=ac&in=consequat&porttitor=metus&pede=sapien&justo=ut&eu=nunc&massa=vestibulum&donec=ante&dapibus=ipsum&duis=primis&at=in&velit=faucibus&eu=orci&est=luctus&congue=et&elementum=ultrices&in=posuere&hac=cubilia&habitasse=curae&platea=mauris&dictumst=viverra&morbi=diam&vestibulum=vitae&velit=quam&id=suspendisse&pretium=potenti&iaculis=nullam&diam=porttitor&erat=lacus&fermentum=at&justo=turpis&nec=donec&condimentum=posuere&neque=metus&sapien=vitae', N'http://dummyimage.com/241x111.jpg/ff4444/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (62, N'Rempel, Pollich and Ryan', N'Linet Zanutti', N'4', N'35450-000', N'Indonesia', N'288-267-1457', N'lzanutti1p@wired.com', N'https://oakley.com/vulputate/nonummy/maecenas/tincidunt/lacus/at.png?id=justo&nulla=aliquam&ultrices=quis&aliquet=turpis&maecenas=eget&leo=elit&odio=sodales&condimentum=scelerisque&id=mauris&luctus=sit&nec=amet&molestie=eros&sed=suspendisse&justo=accumsan&pellentesque=tortor&viverra=quis&pede=turpis&ac=sed&diam=ante&cras=vivamus&pellentesque=tortor&volutpat=duis&dui=mattis&maecenas=egestas&tristique=metus&est=aenean&et=fermentum&tempus=donec&semper=ut&est=mauris&quam=eget&pharetra=massa&magna=tempor&ac=convallis&consequat=nulla&metus=neque&sapien=libero&ut=convallis&nunc=eget&vestibulum=eleifend&ante=luctus&ipsum=ultricies&primis=eu&in=nibh&faucibus=quisque&orci=id&luctus=justo&et=sit&ultrices=amet&posuere=sapien&cubilia=dignissim&curae=vestibulum&mauris=vestibulum&viverra=ante&diam=ipsum&vitae=primis&quam=in&suspendisse=faucibus&potenti=orci&nullam=luctus&porttitor=et&lacus=ultrices&at=posuere&turpis=cubilia&donec=curae&posuere=nulla&metus=dapibus&vitae=dolor&ipsum=vel&aliquam=est&non=donec&mauris=odio&morbi=justo&non=sollicitudin&lectus=ut&aliquam=suscipit&sit=a&amet=feugiat&diam=et&in=eros&magna=vestibulum&bibendum=ac&imperdiet=est&nullam=lacinia&orci=nisi', N'http://dummyimage.com/245x190.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (63, N'Wyman Inc', N'Richardo Trevallion', N'5', N'2955-229', N'China', N'202-392-3248', N'rtrevallion1q@1688.com', N'http://time.com/congue/elementum/in/hac.aspx?vivamus=in&tortor=sapien&duis=iaculis&mattis=congue&egestas=vivamus&metus=metus&aenean=arcu&fermentum=adipiscing&donec=molestie&ut=hendrerit&mauris=at&eget=vulputate&massa=vitae&tempor=nisl&convallis=aenean&nulla=lectus&neque=pellentesque&libero=eget&convallis=nunc&eget=donec&eleifend=quis&luctus=orci&ultricies=eget&eu=orci&nibh=vehicula&quisque=condimentum&id=curabitur&justo=in&sit=libero&amet=ut&sapien=massa&dignissim=volutpat&vestibulum=convallis&vestibulum=morbi&ante=odio&ipsum=odio&primis=elementum&in=eu&faucibus=interdum&orci=eu&luctus=tincidunt&et=in&ultrices=leo&posuere=maecenas&cubilia=pulvinar&curae=lobortis&nulla=est&dapibus=phasellus&dolor=sit&vel=amet&est=erat&donec=nulla&odio=tempus&justo=vivamus&sollicitudin=in&ut=felis&suscipit=eu&a=sapien&feugiat=cursus&et=vestibulum&eros=proin&vestibulum=eu&ac=mi&est=nulla&lacinia=ac&nisi=enim&venenatis=in&tristique=tempor&fusce=turpis&congue=nec&diam=euismod&id=scelerisque&ornare=quam&imperdiet=turpis&sapien=adipiscing&urna=lorem&pretium=vitae&nisl=mattis&ut=nibh&volutpat=ligula&sapien=nec&arcu=sem&sed=duis&augue=aliquam&aliquam=convallis', N'http://dummyimage.com/174x242.jpg/cc0000/ffffff', N'amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in', N'justo')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (64, N'Kutch, Ruecker and Dooley', N'Rowney Iacovolo', N'10', N'2955-229', N'Indonesia', N'370-493-1759', N'riacovolo1r@nps.gov', N'https://boston.com/morbi/porttitor/lorem/id.jpg?nibh=orci&in=mauris&hac=lacinia&habitasse=sapien&platea=quis&dictumst=libero&aliquam=nullam&augue=sit&quam=amet&sollicitudin=turpis&vitae=elementum&consectetuer=ligula&eget=vehicula&rutrum=consequat&at=morbi&lorem=a&integer=ipsum&tincidunt=integer&ante=a&vel=nibh&ipsum=in&praesent=quis&blandit=justo&lacinia=maecenas&erat=rhoncus&vestibulum=aliquam&sed=lacus&magna=morbi&at=quis&nunc=tortor&commodo=id&placerat=nulla&praesent=ultrices&blandit=aliquet&nam=maecenas&nulla=leo&integer=odio&pede=condimentum&justo=id&lacinia=luctus&eget=nec&tincidunt=molestie&eget=sed&tempus=justo&vel=pellentesque&pede=viverra&morbi=pede&porttitor=ac&lorem=diam&id=cras&ligula=pellentesque&suspendisse=volutpat&ornare=dui&consequat=maecenas&lectus=tristique&in=est&est=et&risus=tempus&auctor=semper&sed=est&tristique=quam&in=pharetra&tempus=magna&sit=ac&amet=consequat&sem=metus&fusce=sapien&consequat=ut&nulla=nunc&nisl=vestibulum&nunc=ante&nisl=ipsum&duis=primis&bibendum=in&felis=faucibus&sed=orci&interdum=luctus&venenatis=et&turpis=ultrices&enim=posuere&blandit=cubilia&mi=curae&in=mauris&porttitor=viverra&pede=diam&justo=vitae&eu=quam&massa=suspendisse&donec=potenti&dapibus=nullam&duis=porttitor&at=lacus&velit=at&eu=turpis&est=donec&congue=posuere', N'http://dummyimage.com/214x147.jpg/dddddd/000000', NULL, N'aenean lectus')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (65, N'Block and Sons', N'Tate Reston', N'9', N'35450-000', N'Uganda', N'696-162-2082', N'treston1s@google.pl', N'https://lycos.com/mus/vivamus/vestibulum/sagittis/sapien/cum.xml?in=dui&porttitor=proin&pede=leo&justo=odio&eu=porttitor&massa=id&donec=consequat&dapibus=in&duis=consequat&at=ut&velit=nulla&eu=sed&est=accumsan&congue=felis&elementum=ut&in=at&hac=dolor&habitasse=quis&platea=odio&dictumst=consequat&morbi=varius&vestibulum=integer&velit=ac&id=leo&pretium=pellentesque&iaculis=ultrices', N'http://dummyimage.com/108x135.jpg/ff4444/ffffff', N'rutrum ac lobortis vel dapibus at diam nam tristique tortor', N'eu')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (66, N'Buckridge LLC', N'Colin Boggis', N'9', N'35450-000', N'Indonesia', N'704-158-2459', N'cboggis1t@goodreads.com', N'https://macromedia.com/in/tempor.aspx?molestie=in&sed=faucibus&justo=orci&pellentesque=luctus&viverra=et&pede=ultrices&ac=posuere&diam=cubilia&cras=curae&pellentesque=nulla&volutpat=dapibus&dui=dolor&maecenas=vel&tristique=est&est=donec&et=odio&tempus=justo&semper=sollicitudin&est=ut&quam=suscipit&pharetra=a&magna=feugiat&ac=et&consequat=eros&metus=vestibulum&sapien=ac&ut=est&nunc=lacinia&vestibulum=nisi&ante=venenatis&ipsum=tristique&primis=fusce&in=congue&faucibus=diam&orci=id&luctus=ornare&et=imperdiet&ultrices=sapien&posuere=urna&cubilia=pretium&curae=nisl&mauris=ut&viverra=volutpat&diam=sapien&vitae=arcu&quam=sed&suspendisse=augue&potenti=aliquam&nullam=erat&porttitor=volutpat&lacus=in&at=congue&turpis=etiam&donec=justo&posuere=etiam&metus=pretium&vitae=iaculis&ipsum=justo', N'http://dummyimage.com/208x223.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (67, N'Quigley LLC', N'Beryl Le Fleming', N'2', N'2955-229', N'Portugal', N'290-481-4450', N'ble1u@hp.com', N'https://gizmodo.com/rutrum/rutrum/neque/aenean.html?in=nibh&magna=quisque&bibendum=id&imperdiet=justo&nullam=sit&orci=amet&pede=sapien&venenatis=dignissim&non=vestibulum&sodales=vestibulum&sed=ante&tincidunt=ipsum&eu=primis&felis=in&fusce=faucibus&posuere=orci&felis=luctus&sed=et&lacus=ultrices&morbi=posuere&sem=cubilia', N'http://dummyimage.com/158x247.png/5fa2dd/ffffff', NULL, N'ac')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (68, N'Jacobson-Aufderhar', N'Erroll Inett', N'5', N'593 62', N'Ecuador', N'365-668-9165', N'einett1v@webnode.com', N'http://posterous.com/in/leo/maecenas/pulvinar.png?sit=nec&amet=nisi&diam=volutpat', N'http://dummyimage.com/233x151.png/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (69, N'Walter, Hoeger and Reichel', N'Adams Pennino', N'10', N'439 03', N'China', N'245-521-5742', N'apennino1w@skyrock.com', N'https://wired.com/lobortis/est/phasellus.js?orci=sed&eget=tristique&orci=in&vehicula=tempus&condimentum=sit&curabitur=amet&in=sem&libero=fusce&ut=consequat&massa=nulla&volutpat=nisl&convallis=nunc&morbi=nisl&odio=duis&odio=bibendum&elementum=felis&eu=sed&interdum=interdum&eu=venenatis&tincidunt=turpis&in=enim&leo=blandit&maecenas=mi&pulvinar=in&lobortis=porttitor&est=pede&phasellus=justo&sit=eu&amet=massa&erat=donec&nulla=dapibus&tempus=duis&vivamus=at&in=velit&felis=eu&eu=est&sapien=congue&cursus=elementum&vestibulum=in&proin=hac&eu=habitasse&mi=platea&nulla=dictumst&ac=morbi&enim=vestibulum', N'http://dummyimage.com/171x105.png/5fa2dd/ffffff', N'mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (70, N'Zboncak Inc', N'Rodie Lorroway', N'6', N'641 22', N'Ukraine', N'698-793-8596', N'rlorroway1x@omniture.com', N'https://reference.com/eget/eros/elementum/pellentesque/quisque/porta.js?rutrum=nulla&nulla=facilisi&nunc=cras&purus=non&phasellus=velit&in=nec&felis=nisi&donec=vulputate&semper=nonummy&sapien=maecenas&a=tincidunt&libero=lacus&nam=at&dui=velit&proin=vivamus&leo=vel&odio=nulla&porttitor=eget&id=eros&consequat=elementum&in=pellentesque&consequat=quisque&ut=porta&nulla=volutpat&sed=erat&accumsan=quisque&felis=erat&ut=eros&at=viverra&dolor=eget&quis=congue&odio=eget&consequat=semper&varius=rutrum&integer=nulla&ac=nunc&leo=purus&pellentesque=phasellus&ultrices=in&mattis=felis&odio=donec&donec=semper&vitae=sapien&nisi=a&nam=libero&ultrices=nam&libero=dui&non=proin&mattis=leo&pulvinar=odio&nulla=porttitor&pede=id&ullamcorper=consequat&augue=in&a=consequat&suscipit=ut&nulla=nulla&elit=sed&ac=accumsan&nulla=felis&sed=ut&vel=at&enim=dolor&sit=quis&amet=odio&nunc=consequat&viverra=varius&dapibus=integer&nulla=ac&suscipit=leo&ligula=pellentesque&in=ultrices&lacus=mattis&curabitur=odio&at=donec&ipsum=vitae&ac=nisi&tellus=nam&semper=ultrices&interdum=libero&mauris=non&ullamcorper=mattis&purus=pulvinar&sit=nulla&amet=pede&nulla=ullamcorper&quisque=augue&arcu=a&libero=suscipit&rutrum=nulla&ac=elit&lobortis=ac&vel=nulla', N'http://dummyimage.com/215x200.png/5fa2dd/ffffff', N'nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (71, N'Emard, Reichel and Schamberger', N'Moll Seid', N'9', N'439 03', N'Czech Republic', N'640-566-6248', N'mseid1y@hibu.com', N'https://hhs.gov/ligula/nec/sem/duis.xml?magna=proin&vulputate=at&luctus=turpis&cum=a&sociis=pede&natoque=posuere&penatibus=nonummy&et=integer&magnis=non&dis=velit&parturient=donec&montes=diam&nascetur=neque&ridiculus=vestibulum&mus=eget&vivamus=vulputate&vestibulum=ut&sagittis=ultrices&sapien=vel&cum=augue&sociis=vestibulum&natoque=ante&penatibus=ipsum&et=primis&magnis=in&dis=faucibus&parturient=orci&montes=luctus&nascetur=et&ridiculus=ultrices&mus=posuere&etiam=cubilia&vel=curae&augue=donec&vestibulum=pharetra&rutrum=magna&rutrum=vestibulum&neque=aliquet&aenean=ultrices&auctor=erat&gravida=tortor&sem=sollicitudin&praesent=mi&id=sit&massa=amet&id=lobortis&nisl=sapien&venenatis=sapien&lacinia=non&aenean=mi&sit=integer', N'http://dummyimage.com/198x112.jpg/cc0000/ffffff', N'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (72, N'Rempel-Rowe', N'Starlin Gaven', N'8', N'32350', N'Indonesia', N'117-110-9666', N'sgaven1z@nasa.gov', N'https://usnews.com/curabitur/in.png?adipiscing=cubilia&elit=curae&proin=nulla&risus=dapibus&praesent=dolor&lectus=vel&vestibulum=est&quam=donec&sapien=odio&varius=justo&ut=sollicitudin&blandit=ut&non=suscipit&interdum=a&in=feugiat&ante=et&vestibulum=eros&ante=vestibulum&ipsum=ac&primis=est&in=lacinia&faucibus=nisi&orci=venenatis&luctus=tristique&et=fusce&ultrices=congue&posuere=diam&cubilia=id&curae=ornare&duis=imperdiet&faucibus=sapien&accumsan=urna&odio=pretium&curabitur=nisl&convallis=ut&duis=volutpat&consequat=sapien&dui=arcu&nec=sed&nisi=augue&volutpat=aliquam&eleifend=erat&donec=volutpat&ut=in&dolor=congue&morbi=etiam&vel=justo&lectus=etiam&in=pretium&quam=iaculis&fringilla=justo&rhoncus=in&mauris=hac&enim=habitasse&leo=platea&rhoncus=dictumst&sed=etiam&vestibulum=faucibus&sit=cursus&amet=urna&cursus=ut&id=tellus&turpis=nulla&integer=ut&aliquet=erat&massa=id&id=mauris&lobortis=vulputate&convallis=elementum&tortor=nullam&risus=varius&dapibus=nulla&augue=facilisi&vel=cras&accumsan=non&tellus=velit&nisi=nec&eu=nisi&orci=vulputate&mauris=nonummy&lacinia=maecenas', N'http://dummyimage.com/113x213.png/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (73, N'Ryan-Murray', N'Loria Burrass', N'4', N'32350', N'Mexico', N'612-182-7378', N'lburrass20@ucoz.com', N'http://msu.edu/in/lacus/curabitur/at.png?dictumst=ac&aliquam=consequat&augue=metus&quam=sapien&sollicitudin=ut&vitae=nunc&consectetuer=vestibulum&eget=ante&rutrum=ipsum&at=primis&lorem=in&integer=faucibus&tincidunt=orci&ante=luctus&vel=et&ipsum=ultrices&praesent=posuere&blandit=cubilia&lacinia=curae&erat=mauris&vestibulum=viverra&sed=diam&magna=vitae&at=quam&nunc=suspendisse&commodo=potenti&placerat=nullam&praesent=porttitor&blandit=lacus&nam=at&nulla=turpis&integer=donec&pede=posuere&justo=metus&lacinia=vitae&eget=ipsum&tincidunt=aliquam&eget=non&tempus=mauris&vel=morbi&pede=non&morbi=lectus&porttitor=aliquam&lorem=sit&id=amet&ligula=diam&suspendisse=in&ornare=magna&consequat=bibendum&lectus=imperdiet&in=nullam&est=orci&risus=pede&auctor=venenatis&sed=non&tristique=sodales&in=sed&tempus=tincidunt&sit=eu&amet=felis&sem=fusce&fusce=posuere&consequat=felis&nulla=sed&nisl=lacus&nunc=morbi&nisl=sem&duis=mauris&bibendum=laoreet&felis=ut&sed=rhoncus&interdum=aliquet&venenatis=pulvinar&turpis=sed&enim=nisl&blandit=nunc&mi=rhoncus&in=dui&porttitor=vel&pede=sem&justo=sed&eu=sagittis&massa=nam&donec=congue&dapibus=risus&duis=semper&at=porta&velit=volutpat&eu=quam&est=pede', N'http://dummyimage.com/132x234.bmp/cc0000/ffffff', N'egestas metus aenean fermentum donec ut mauris eget massa tempor', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (74, N'Smith Group', N'Dolorita Dibdin', N'8', N'593 62', N'Sweden', N'500-387-6743', N'ddibdin21@baidu.com', N'http://naver.com/sem/praesent/id.html?sociis=amet&natoque=consectetuer&penatibus=adipiscing&et=elit&magnis=proin&dis=risus&parturient=praesent&montes=lectus&nascetur=vestibulum&ridiculus=quam&mus=sapien&vivamus=varius&vestibulum=ut&sagittis=blandit&sapien=non&cum=interdum&sociis=in&natoque=ante&penatibus=vestibulum&et=ante&magnis=ipsum&dis=primis&parturient=in&montes=faucibus&nascetur=orci&ridiculus=luctus&mus=et&etiam=ultrices&vel=posuere&augue=cubilia&vestibulum=curae&rutrum=duis&rutrum=faucibus&neque=accumsan&aenean=odio&auctor=curabitur&gravida=convallis&sem=duis&praesent=consequat&id=dui&massa=nec&id=nisi&nisl=volutpat&venenatis=eleifend&lacinia=donec&aenean=ut&sit=dolor&amet=morbi', N'http://dummyimage.com/169x152.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (75, N'Mohr, Becker and Torp', N'Alleyn Brodie', N'1', N'641 22', N'Sweden', N'306-317-5057', N'abrodie22@reference.com', N'http://liveinternet.ru/lectus/aliquam/sit/amet/diam/in/magna.aspx?tortor=vivamus&id=tortor&nulla=duis&ultrices=mattis&aliquet=egestas&maecenas=metus&leo=aenean&odio=fermentum&condimentum=donec&id=ut&luctus=mauris&nec=eget&molestie=massa&sed=tempor&justo=convallis&pellentesque=nulla&viverra=neque&pede=libero&ac=convallis&diam=eget&cras=eleifend&pellentesque=luctus&volutpat=ultricies&dui=eu&maecenas=nibh&tristique=quisque&est=id&et=justo&tempus=sit&semper=amet&est=sapien&quam=dignissim&pharetra=vestibulum&magna=vestibulum&ac=ante&consequat=ipsum&metus=primis&sapien=in&ut=faucibus&nunc=orci&vestibulum=luctus&ante=et&ipsum=ultrices&primis=posuere&in=cubilia&faucibus=curae&orci=nulla&luctus=dapibus&et=dolor&ultrices=vel&posuere=est&cubilia=donec&curae=odio&mauris=justo&viverra=sollicitudin&diam=ut&vitae=suscipit&quam=a&suspendisse=feugiat&potenti=et&nullam=eros&porttitor=vestibulum&lacus=ac&at=est&turpis=lacinia&donec=nisi&posuere=venenatis&metus=tristique&vitae=fusce&ipsum=congue&aliquam=diam&non=id&mauris=ornare&morbi=imperdiet&non=sapien&lectus=urna&aliquam=pretium&sit=nisl&amet=ut&diam=volutpat&in=sapien&magna=arcu&bibendum=sed&imperdiet=augue&nullam=aliquam&orci=erat&pede=volutpat&venenatis=in&non=congue&sodales=etiam&sed=justo&tincidunt=etiam&eu=pretium&felis=iaculis&fusce=justo&posuere=in&felis=hac&sed=habitasse&lacus=platea&morbi=dictumst', N'http://dummyimage.com/222x153.bmp/cc0000/ffffff', N'vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (76, N'Harris-Conroy', N'Kelila Gregersen', N'5', N'314-0048', N'Japan', N'134-517-1049', N'kgregersen23@artisteer.com', N'https://latimes.com/id/mauris.json?ut=hac&massa=habitasse&quis=platea&augue=dictumst&luctus=etiam&tincidunt=faucibus&nulla=cursus&mollis=urna&molestie=ut&lorem=tellus&quisque=nulla&ut=ut&erat=erat&curabitur=id&gravida=mauris&nisi=vulputate&at=elementum&nibh=nullam&in=varius&hac=nulla&habitasse=facilisi&platea=cras&dictumst=non&aliquam=velit&augue=nec&quam=nisi&sollicitudin=vulputate&vitae=nonummy&consectetuer=maecenas&eget=tincidunt&rutrum=lacus&at=at&lorem=velit&integer=vivamus', N'http://dummyimage.com/233x235.png/5fa2dd/ffffff', N'montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor', N'amet eros')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (77, N'Prosacco-Quitzon', N'Manny Driuzzi', N'7', N'679-1212', N'Peru', N'407-464-3097', N'mdriuzzi24@ask.com', N'http://istockphoto.com/varius/integer.jsp?ante=nulla&vel=dapibus', N'http://dummyimage.com/114x163.jpg/cc0000/ffffff', N'in tempus sit amet sem fusce consequat nulla nisl nunc nisl', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (78, N'Moore Group', N'Antonin Brookesbie', N'7', N'314-0048', N'Honduras', N'267-273-4647', N'abrookesbie25@ted.com', N'http://simplemachines.org/at/turpis/a/pede.js?morbi=sit&non=amet&quam=sapien&nec=dignissim&dui=vestibulum&luctus=vestibulum&rutrum=ante&nulla=ipsum&tellus=primis&in=in&sagittis=faucibus&dui=orci&vel=luctus&nisl=et&duis=ultrices&ac=posuere&nibh=cubilia&fusce=curae&lacus=nulla&purus=dapibus&aliquet=dolor&at=vel&feugiat=est&non=donec&pretium=odio&quis=justo&lectus=sollicitudin&suspendisse=ut&potenti=suscipit&in=a&eleifend=feugiat&quam=et&a=eros&odio=vestibulum&in=ac&hac=est&habitasse=lacinia', N'http://dummyimage.com/134x243.jpg/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (79, N'Toy-Schoen', N'Jamal Fiddian', N'2', N'641 22', N'Palestinian Territory', N'978-913-8839', N'jfiddian26@diigo.com', N'https://weibo.com/donec/ut/dolor/morbi/vel/lectus/in.json?eget=sit&semper=amet&rutrum=consectetuer&nulla=adipiscing&nunc=elit&purus=proin&phasellus=interdum&in=mauris&felis=non&donec=ligula&semper=pellentesque&sapien=ultrices&a=phasellus&libero=id&nam=sapien&dui=in&proin=sapien&leo=iaculis&odio=congue&porttitor=vivamus&id=metus&consequat=arcu&in=adipiscing&consequat=molestie&ut=hendrerit&nulla=at&sed=vulputate&accumsan=vitae&felis=nisl&ut=aenean&at=lectus&dolor=pellentesque&quis=eget&odio=nunc', N'http://dummyimage.com/160x154.bmp/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (80, N'Flatley-Hahn', N'Willie Ceeley', N'10', N'593 62', N'Palestinian Territory', N'379-649-4447', N'wceeley27@trellian.com', N'https://moonfruit.com/libero/convallis/eget/eleifend/luctus/ultricies.json?nullam=vulputate&porttitor=justo&lacus=in&at=blandit&turpis=ultrices&donec=enim&posuere=lorem&metus=ipsum&vitae=dolor&ipsum=sit&aliquam=amet&non=consectetuer&mauris=adipiscing&morbi=elit&non=proin&lectus=interdum&aliquam=mauris&sit=non&amet=ligula&diam=pellentesque&in=ultrices&magna=phasellus&bibendum=id&imperdiet=sapien&nullam=in&orci=sapien&pede=iaculis&venenatis=congue&non=vivamus&sodales=metus&sed=arcu&tincidunt=adipiscing&eu=molestie&felis=hendrerit&fusce=at&posuere=vulputate&felis=vitae&sed=nisl&lacus=aenean&morbi=lectus&sem=pellentesque&mauris=eget&laoreet=nunc&ut=donec&rhoncus=quis&aliquet=orci&pulvinar=eget&sed=orci&nisl=vehicula&nunc=condimentum&rhoncus=curabitur&dui=in&vel=libero&sem=ut&sed=massa&sagittis=volutpat&nam=convallis&congue=morbi&risus=odio&semper=odio&porta=elementum&volutpat=eu&quam=interdum&pede=eu&lobortis=tincidunt&ligula=in&sit=leo&amet=maecenas&eleifend=pulvinar&pede=lobortis&libero=est&quis=phasellus&orci=sit&nullam=amet&molestie=erat&nibh=nulla&in=tempus&lectus=vivamus&pellentesque=in&at=felis&nulla=eu&suspendisse=sapien&potenti=cursus&cras=vestibulum&in=proin&purus=eu&eu=mi&magna=nulla&vulputate=ac&luctus=enim&cum=in&sociis=tempor&natoque=turpis', N'http://dummyimage.com/170x122.jpg/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (81, N'Hodkiewicz-Huels', N'Ira Shorto', N'5', N'43150', N'Paraguay', N'759-796-8053', N'ishorto28@feedburner.com', N'http://qq.com/hac/habitasse.jpg?nec=pulvinar&nisi=sed&vulputate=nisl&nonummy=nunc&maecenas=rhoncus&tincidunt=dui&lacus=vel&at=sem&velit=sed&vivamus=sagittis&vel=nam&nulla=congue&eget=risus&eros=semper&elementum=porta&pellentesque=volutpat&quisque=quam&porta=pede&volutpat=lobortis&erat=ligula&quisque=sit&erat=amet&eros=eleifend&viverra=pede&eget=libero&congue=quis&eget=orci&semper=nullam&rutrum=molestie&nulla=nibh&nunc=in&purus=lectus&phasellus=pellentesque&in=at&felis=nulla&donec=suspendisse&semper=potenti&sapien=cras&a=in&libero=purus&nam=eu&dui=magna&proin=vulputate&leo=luctus&odio=cum&porttitor=sociis&id=natoque&consequat=penatibus&in=et&consequat=magnis&ut=dis&nulla=parturient&sed=montes&accumsan=nascetur&felis=ridiculus&ut=mus&at=vivamus&dolor=vestibulum&quis=sagittis&odio=sapien&consequat=cum&varius=sociis&integer=natoque&ac=penatibus&leo=et&pellentesque=magnis&ultrices=dis&mattis=parturient&odio=montes&donec=nascetur&vitae=ridiculus&nisi=mus&nam=etiam&ultrices=vel&libero=augue&non=vestibulum&mattis=rutrum&pulvinar=rutrum&nulla=neque&pede=aenean&ullamcorper=auctor&augue=gravida&a=sem&suscipit=praesent&nulla=id&elit=massa&ac=id&nulla=nisl&sed=venenatis&vel=lacinia&enim=aenean&sit=sit', N'http://dummyimage.com/108x123.png/dddddd/000000', N'risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (82, N'Lubowitz, Hauck and Kuhic', N'Garvin Kulic', N'1', N'43150', N'China', N'749-755-4255', N'gkulic29@time.com', N'http://barnesandnoble.com/interdum.jsp?quam=in&fringilla=faucibus&rhoncus=orci&mauris=luctus&enim=et&leo=ultrices&rhoncus=posuere&sed=cubilia&vestibulum=curae&sit=donec&amet=pharetra&cursus=magna&id=vestibulum&turpis=aliquet&integer=ultrices&aliquet=erat', N'http://dummyimage.com/101x107.bmp/5fa2dd/ffffff', N'est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (83, N'Casper-Hilpert', N'Kaela Wakeley', N'10', N'43150', N'Thailand', N'710-189-1726', N'kwakeley2a@cnn.com', N'https://marriott.com/id/luctus/nec/molestie/sed/justo.jpg?mattis=ut&pulvinar=dolor', N'http://dummyimage.com/112x188.jpg/ff4444/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (84, N'Senger, Terry and Blanda', N'Eveline Poundsford', N'1', N'79150-000', N'China', N'123-390-6229', N'epoundsford2b@wunderground.com', N'https://irs.gov/commodo/placerat.html?libero=curae&nullam=mauris&sit=viverra&amet=diam&turpis=vitae&elementum=quam&ligula=suspendisse&vehicula=potenti&consequat=nullam&morbi=porttitor&a=lacus&ipsum=at&integer=turpis&a=donec&nibh=posuere&in=metus&quis=vitae&justo=ipsum&maecenas=aliquam&rhoncus=non&aliquam=mauris&lacus=morbi&morbi=non&quis=lectus&tortor=aliquam&id=sit&nulla=amet&ultrices=diam&aliquet=in&maecenas=magna&leo=bibendum&odio=imperdiet&condimentum=nullam&id=orci&luctus=pede&nec=venenatis&molestie=non&sed=sodales&justo=sed&pellentesque=tincidunt&viverra=eu&pede=felis&ac=fusce&diam=posuere&cras=felis&pellentesque=sed&volutpat=lacus&dui=morbi&maecenas=sem&tristique=mauris&est=laoreet&et=ut&tempus=rhoncus&semper=aliquet&est=pulvinar&quam=sed&pharetra=nisl&magna=nunc&ac=rhoncus&consequat=dui&metus=vel&sapien=sem&ut=sed&nunc=sagittis&vestibulum=nam&ante=congue&ipsum=risus&primis=semper&in=porta&faucibus=volutpat&orci=quam&luctus=pede&et=lobortis&ultrices=ligula&posuere=sit&cubilia=amet&curae=eleifend&mauris=pede&viverra=libero&diam=quis&vitae=orci&quam=nullam&suspendisse=molestie&potenti=nibh&nullam=in&porttitor=lectus&lacus=pellentesque&at=at&turpis=nulla&donec=suspendisse&posuere=potenti&metus=cras&vitae=in&ipsum=purus&aliquam=eu&non=magna&mauris=vulputate', N'http://dummyimage.com/134x122.bmp/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (85, N'Gibson-Adams', N'Rhetta Lorroway', N'3', N'679-1212', N'Indonesia', N'790-932-8304', N'rlorroway2c@ehow.com', N'https://fotki.com/tristique/in/tempus/sit/amet/sem.jpg?odio=rhoncus&justo=dui&sollicitudin=vel&ut=sem&suscipit=sed&a=sagittis&feugiat=nam&et=congue&eros=risus&vestibulum=semper&ac=porta&est=volutpat&lacinia=quam&nisi=pede&venenatis=lobortis&tristique=ligula&fusce=sit&congue=amet&diam=eleifend&id=pede&ornare=libero&imperdiet=quis&sapien=orci&urna=nullam&pretium=molestie&nisl=nibh&ut=in&volutpat=lectus&sapien=pellentesque&arcu=at&sed=nulla&augue=suspendisse&aliquam=potenti&erat=cras&volutpat=in&in=purus&congue=eu&etiam=magna&justo=vulputate&etiam=luctus&pretium=cum&iaculis=sociis&justo=natoque&in=penatibus&hac=et&habitasse=magnis&platea=dis&dictumst=parturient&etiam=montes&faucibus=nascetur&cursus=ridiculus&urna=mus&ut=vivamus&tellus=vestibulum&nulla=sagittis&ut=sapien&erat=cum&id=sociis&mauris=natoque&vulputate=penatibus&elementum=et&nullam=magnis&varius=dis&nulla=parturient&facilisi=montes&cras=nascetur&non=ridiculus&velit=mus&nec=etiam&nisi=vel&vulputate=augue&nonummy=vestibulum&maecenas=rutrum&tincidunt=rutrum&lacus=neque&at=aenean', N'http://dummyimage.com/246x160.jpg/5fa2dd/ffffff', N'erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (86, N'Hyatt-Hauck', N'Babara Cabane', N'9', N'616 32', N'China', N'146-541-0398', N'bcabane2d@privacy.gov.au', N'http://virginia.edu/ultrices.json?rutrum=faucibus&nulla=orci&nunc=luctus&purus=et&phasellus=ultrices&in=posuere&felis=cubilia&donec=curae&semper=duis&sapien=faucibus&a=accumsan&libero=odio&nam=curabitur&dui=convallis&proin=duis&leo=consequat&odio=dui&porttitor=nec&id=nisi&consequat=volutpat&in=eleifend&consequat=donec&ut=ut&nulla=dolor&sed=morbi&accumsan=vel&felis=lectus&ut=in&at=quam&dolor=fringilla&quis=rhoncus&odio=mauris&consequat=enim&varius=leo&integer=rhoncus&ac=sed&leo=vestibulum&pellentesque=sit&ultrices=amet&mattis=cursus&odio=id&donec=turpis&vitae=integer&nisi=aliquet&nam=massa&ultrices=id&libero=lobortis&non=convallis&mattis=tortor&pulvinar=risus&nulla=dapibus&pede=augue&ullamcorper=vel&augue=accumsan&a=tellus&suscipit=nisi&nulla=eu&elit=orci&ac=mauris&nulla=lacinia&sed=sapien&vel=quis&enim=libero&sit=nullam&amet=sit&nunc=amet&viverra=turpis&dapibus=elementum&nulla=ligula&suscipit=vehicula&ligula=consequat&in=morbi&lacus=a&curabitur=ipsum', N'http://dummyimage.com/160x125.png/cc0000/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (87, N'Cole-Ullrich', N'Neal Sent', N'8', N'18351', N'Nepal', N'400-256-8267', N'nsent2e@loc.gov', N'http://digg.com/platea/dictumst/maecenas/ut/massa/quis/augue.png?eget=id&vulputate=justo&ut=sit&ultrices=amet&vel=sapien&augue=dignissim&vestibulum=vestibulum&ante=vestibulum&ipsum=ante&primis=ipsum&in=primis&faucibus=in&orci=faucibus&luctus=orci&et=luctus&ultrices=et&posuere=ultrices&cubilia=posuere&curae=cubilia&donec=curae&pharetra=nulla&magna=dapibus&vestibulum=dolor&aliquet=vel&ultrices=est&erat=donec&tortor=odio&sollicitudin=justo&mi=sollicitudin&sit=ut&amet=suscipit&lobortis=a&sapien=feugiat&sapien=et&non=eros&mi=vestibulum&integer=ac&ac=est&neque=lacinia&duis=nisi&bibendum=venenatis&morbi=tristique&non=fusce&quam=congue&nec=diam&dui=id&luctus=ornare&rutrum=imperdiet&nulla=sapien&tellus=urna&in=pretium&sagittis=nisl&dui=ut&vel=volutpat&nisl=sapien&duis=arcu&ac=sed&nibh=augue&fusce=aliquam&lacus=erat&purus=volutpat&aliquet=in&at=congue&feugiat=etiam&non=justo&pretium=etiam&quis=pretium&lectus=iaculis&suspendisse=justo&potenti=in&in=hac&eleifend=habitasse&quam=platea&a=dictumst&odio=etiam&in=faucibus&hac=cursus&habitasse=urna&platea=ut&dictumst=tellus', N'http://dummyimage.com/210x123.png/dddddd/000000', N'justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (88, N'Zemlak-Moore', N'Vern Littleton', N'4', N'18351', N'Pakistan', N'271-533-2527', N'vlittleton2f@gnu.org', N'https://dion.ne.jp/at/nunc/commodo/placerat/praesent/blandit.jpg?velit=cubilia&nec=curae&nisi=donec&vulputate=pharetra&nonummy=magna&maecenas=vestibulum&tincidunt=aliquet&lacus=ultrices&at=erat&velit=tortor&vivamus=sollicitudin&vel=mi&nulla=sit&eget=amet&eros=lobortis&elementum=sapien&pellentesque=sapien&quisque=non&porta=mi&volutpat=integer&erat=ac', N'http://dummyimage.com/173x226.png/5fa2dd/ffffff', NULL, N'lobortis sapien')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (89, N'Wilkinson, Schultz and Raynor', N'Kelwin Cockrell', N'9', N'616 32', N'Sweden', N'825-454-2437', N'kcockrell2g@eventbrite.com', N'http://ow.ly/justo/morbi/ut/odio.aspx?aliquet=aliquet&maecenas=at&leo=feugiat&odio=non&condimentum=pretium&id=quis&luctus=lectus&nec=suspendisse&molestie=potenti&sed=in&justo=eleifend&pellentesque=quam&viverra=a', N'http://dummyimage.com/148x139.jpg/dddddd/000000', N'mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (90, N'Mann-Kshlerin', N'Athene Iwaszkiewicz', N'9', N'679-1212', N'Japan', N'372-174-8504', N'aiwaszkiewicz2h@uol.com.br', N'https://diigo.com/non/mattis/pulvinar/nulla.png?vestibulum=sed&proin=tincidunt&eu=eu&mi=felis&nulla=fusce&ac=posuere&enim=felis&in=sed&tempor=lacus&turpis=morbi&nec=sem&euismod=mauris&scelerisque=laoreet&quam=ut&turpis=rhoncus&adipiscing=aliquet&lorem=pulvinar&vitae=sed&mattis=nisl&nibh=nunc&ligula=rhoncus&nec=dui&sem=vel&duis=sem&aliquam=sed&convallis=sagittis&nunc=nam&proin=congue&at=risus&turpis=semper&a=porta&pede=volutpat&posuere=quam&nonummy=pede&integer=lobortis&non=ligula&velit=sit&donec=amet&diam=eleifend&neque=pede&vestibulum=libero&eget=quis&vulputate=orci&ut=nullam&ultrices=molestie&vel=nibh&augue=in&vestibulum=lectus&ante=pellentesque&ipsum=at&primis=nulla&in=suspendisse&faucibus=potenti&orci=cras&luctus=in&et=purus&ultrices=eu&posuere=magna&cubilia=vulputate&curae=luctus&donec=cum&pharetra=sociis&magna=natoque&vestibulum=penatibus&aliquet=et&ultrices=magnis&erat=dis&tortor=parturient&sollicitudin=montes&mi=nascetur&sit=ridiculus&amet=mus&lobortis=vivamus&sapien=vestibulum&sapien=sagittis&non=sapien&mi=cum&integer=sociis&ac=natoque&neque=penatibus&duis=et&bibendum=magnis', N'http://dummyimage.com/137x205.bmp/ff4444/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (91, N'Cassin, Volkman and Olson', N'Gregg Ledington', N'10', N'79150-000', N'Brazil', N'930-792-2234', N'gledington2i@seesaa.net', N'https://yellowpages.com/sem/duis/aliquam.js?vitae=cursus&mattis=id&nibh=turpis&ligula=integer&nec=aliquet&sem=massa&duis=id&aliquam=lobortis&convallis=convallis&nunc=tortor&proin=risus&at=dapibus&turpis=augue&a=vel&pede=accumsan&posuere=tellus&nonummy=nisi&integer=eu&non=orci&velit=mauris&donec=lacinia&diam=sapien&neque=quis&vestibulum=libero&eget=nullam&vulputate=sit&ut=amet&ultrices=turpis&vel=elementum&augue=ligula&vestibulum=vehicula&ante=consequat&ipsum=morbi&primis=a&in=ipsum&faucibus=integer&orci=a&luctus=nibh&et=in&ultrices=quis&posuere=justo&cubilia=maecenas&curae=rhoncus&donec=aliquam&pharetra=lacus&magna=morbi&vestibulum=quis&aliquet=tortor&ultrices=id&erat=nulla&tortor=ultrices&sollicitudin=aliquet&mi=maecenas&sit=leo&amet=odio&lobortis=condimentum&sapien=id&sapien=luctus&non=nec&mi=molestie&integer=sed&ac=justo&neque=pellentesque&duis=viverra&bibendum=pede&morbi=ac&non=diam&quam=cras&nec=pellentesque&dui=volutpat&luctus=dui', N'http://dummyimage.com/243x115.bmp/5fa2dd/ffffff', NULL, N'non')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (92, N'Donnelly Group', N'Julian Kloser', N'4', N'74080', N'Germany', N'979-936-6605', N'jkloser2j@yellowbook.com', N'http://kickstarter.com/pretium/iaculis/diam/erat.js?mauris=et&viverra=eros&diam=vestibulum&vitae=ac&quam=est&suspendisse=lacinia&potenti=nisi&nullam=venenatis&porttitor=tristique', N'http://dummyimage.com/133x164.png/5fa2dd/ffffff', N'sed nisl nunc rhoncus dui vel sem sed sagittis nam congue', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (93, N'Bayer, Littel and Osinski', N'Vinny Pummery', N'4', N'J2L', N'Canada', N'933-999-4264', N'vpummery2k@about.com', N'https://cnet.com/lorem/id/ligula.js?pretium=posuere&quis=cubilia&lectus=curae&suspendisse=nulla&potenti=dapibus&in=dolor&eleifend=vel&quam=est&a=donec&odio=odio&in=justo&hac=sollicitudin&habitasse=ut&platea=suscipit&dictumst=a&maecenas=feugiat&ut=et&massa=eros&quis=vestibulum&augue=ac&luctus=est&tincidunt=lacinia&nulla=nisi&mollis=venenatis&molestie=tristique&lorem=fusce&quisque=congue&ut=diam&erat=id&curabitur=ornare&gravida=imperdiet&nisi=sapien&at=urna&nibh=pretium&in=nisl&hac=ut&habitasse=volutpat', N'http://dummyimage.com/124x168.jpg/ff4444/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (94, N'Hahn Group', N'Aubrey Tabourier', N'10', N'50943', N'Malaysia', N'433-981-1278', N'atabourier2l@youtu.be', N'https://soup.io/sapien/sapien.jpg?ut=nulla&suscipit=facilisi&a=cras&feugiat=non&et=velit&eros=nec&vestibulum=nisi&ac=vulputate&est=nonummy&lacinia=maecenas&nisi=tincidunt&venenatis=lacus&tristique=at&fusce=velit&congue=vivamus&diam=vel&id=nulla&ornare=eget&imperdiet=eros&sapien=elementum&urna=pellentesque&pretium=quisque&nisl=porta&ut=volutpat&volutpat=erat&sapien=quisque&arcu=erat&sed=eros&augue=viverra&aliquam=eget&erat=congue&volutpat=eget&in=semper&congue=rutrum&etiam=nulla&justo=nunc&etiam=purus', N'http://dummyimage.com/117x176.jpg/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (95, N'Becker-Cummerata', N'Carri Micklem', N'5', N'679130', N'Russia', N'288-122-5937', N'cmicklem2m@desdev.cn', N'http://netscape.com/vitae/mattis.jpg?nulla=augue&tempus=quam&vivamus=sollicitudin&in=vitae&felis=consectetuer&eu=eget&sapien=rutrum&cursus=at&vestibulum=lorem&proin=integer&eu=tincidunt&mi=ante&nulla=vel&ac=ipsum&enim=praesent&in=blandit&tempor=lacinia&turpis=erat&nec=vestibulum&euismod=sed&scelerisque=magna&quam=at&turpis=nunc&adipiscing=commodo&lorem=placerat&vitae=praesent&mattis=blandit&nibh=nam&ligula=nulla&nec=integer&sem=pede&duis=justo&aliquam=lacinia&convallis=eget&nunc=tincidunt&proin=eget&at=tempus&turpis=vel&a=pede&pede=morbi&posuere=porttitor&nonummy=lorem&integer=id&non=ligula&velit=suspendisse&donec=ornare&diam=consequat&neque=lectus&vestibulum=in&eget=est', N'http://dummyimage.com/120x226.png/5fa2dd/ffffff', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (96, N'Watsica, Bradtke and Hessel', N'Devland Mantrup', N'1', N'679130', N'China', N'974-385-7716', N'dmantrup2n@ebay.co.uk', N'http://nydailynews.com/nulla/facilisi/cras/non/velit/nec.json?libero=amet&non=consectetuer&mattis=adipiscing&pulvinar=elit&nulla=proin&pede=risus&ullamcorper=praesent&augue=lectus&a=vestibulum&suscipit=quam&nulla=sapien&elit=varius&ac=ut&nulla=blandit&sed=non&vel=interdum&enim=in&sit=ante&amet=vestibulum&nunc=ante&viverra=ipsum&dapibus=primis&nulla=in&suscipit=faucibus&ligula=orci&in=luctus&lacus=et&curabitur=ultrices&at=posuere&ipsum=cubilia&ac=curae&tellus=duis&semper=faucibus&interdum=accumsan&mauris=odio&ullamcorper=curabitur&purus=convallis&sit=duis&amet=consequat&nulla=dui&quisque=nec&arcu=nisi&libero=volutpat&rutrum=eleifend&ac=donec&lobortis=ut&vel=dolor&dapibus=morbi&at=vel&diam=lectus', N'http://dummyimage.com/173x223.bmp/dddddd/000000', NULL, NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (97, N'Bergnaum LLC', N'Gaelan Spearing', N'3', N'679130', N'Israel', N'387-556-6595', N'gspearing2o@reuters.com', N'https://ovh.net/a/libero/nam/dui/proin.aspx?dui=sit&proin=amet&leo=sapien&odio=dignissim&porttitor=vestibulum&id=vestibulum&consequat=ante&in=ipsum&consequat=primis&ut=in&nulla=faucibus&sed=orci&accumsan=luctus&felis=et&ut=ultrices&at=posuere&dolor=cubilia&quis=curae&odio=nulla&consequat=dapibus&varius=dolor&integer=vel&ac=est&leo=donec&pellentesque=odio&ultrices=justo', N'http://dummyimage.com/150x176.bmp/ff4444/ffffff', NULL, N'malesuada in')
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (98, N'Blick-Schoen', N'Fransisco Friskey', N'9', N'1659', N'Philippines', N'378-767-8483', N'ffriskey2p@cdbaby.com', N'https://sitemeter.com/ut/odio/cras/mi/pede/malesuada/in.jpg?at=luctus&nunc=et&commodo=ultrices&placerat=posuere&praesent=cubilia&blandit=curae&nam=donec&nulla=pharetra&integer=magna&pede=vestibulum&justo=aliquet&lacinia=ultrices&eget=erat&tincidunt=tortor&eget=sollicitudin&tempus=mi&vel=sit&pede=amet&morbi=lobortis&porttitor=sapien&lorem=sapien&id=non&ligula=mi&suspendisse=integer&ornare=ac&consequat=neque&lectus=duis&in=bibendum&est=morbi&risus=non&auctor=quam&sed=nec&tristique=dui&in=luctus&tempus=rutrum&sit=nulla&amet=tellus&sem=in&fusce=sagittis&consequat=dui&nulla=vel&nisl=nisl&nunc=duis&nisl=ac&duis=nibh&bibendum=fusce&felis=lacus&sed=purus&interdum=aliquet&venenatis=at&turpis=feugiat&enim=non&blandit=pretium&mi=quis&in=lectus&porttitor=suspendisse&pede=potenti&justo=in&eu=eleifend&massa=quam&donec=a&dapibus=odio&duis=in&at=hac&velit=habitasse&eu=platea&est=dictumst&congue=maecenas&elementum=ut&in=massa&hac=quis&habitasse=augue&platea=luctus&dictumst=tincidunt&morbi=nulla&vestibulum=mollis&velit=molestie&id=lorem', N'http://dummyimage.com/197x108.png/ff4444/ffffff', N'luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum', NULL)
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (99, N'Heaney, Osinski and Braun', N'Jodi Carmont', N'9', N'679130', N'China', N'500-188-0493', N'jcarmont2q@bbb.org', N'http://bloglovin.com/integer/a/nibh/in/quis.js?vestibulum=vel&rutrum=augue&rutrum=vestibulum&neque=rutrum&aenean=rutrum&auctor=neque&gravida=aenean&sem=auctor&praesent=gravida&id=sem&massa=praesent&id=id&nisl=massa&venenatis=id&lacinia=nisl&aenean=venenatis&sit=lacinia&amet=aenean&justo=sit&morbi=amet&ut=justo&odio=morbi&cras=ut&mi=odio&pede=cras&malesuada=mi&in=pede', N'http://dummyimage.com/138x152.png/5fa2dd/ffffff', N'odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis', N'et commodo')
GO
INSERT [Stock].[ProductSuppliers] ([SupplierID], [Name], [ContactName], [Address], [PostCode], [Country], [PhoneNo], [Email], [URL], [Logo], [Notes], [CurrentOrder]) VALUES (100, N'Berge, Spencer and Johns', N'Chanda Caston', N'1', N'679130', N'China', N'299-833-7292', N'ccaston2r@de.vu', N'http://hud.gov/in/hac/habitasse/platea/dictumst/aliquam/augue.jsp?ut=aliquam&mauris=erat&eget=volutpat&massa=in&tempor=congue&convallis=etiam&nulla=justo&neque=etiam&libero=pretium&convallis=iaculis&eget=justo&eleifend=in&luctus=hac&ultricies=habitasse&eu=platea&nibh=dictumst&quisque=etiam&id=faucibus&justo=cursus&sit=urna&amet=ut&sapien=tellus&dignissim=nulla&vestibulum=ut&vestibulum=erat&ante=id&ipsum=mauris&primis=vulputate&in=elementum&faucibus=nullam&orci=varius&luctus=nulla&et=facilisi&ultrices=cras&posuere=non&cubilia=velit&curae=nec&nulla=nisi&dapibus=vulputate&dolor=nonummy&vel=maecenas&est=tincidunt&donec=lacus&odio=at&justo=velit&sollicitudin=vivamus&ut=vel&suscipit=nulla&a=eget&feugiat=eros&et=elementum&eros=pellentesque&vestibulum=quisque&ac=porta&est=volutpat&lacinia=erat&nisi=quisque&venenatis=erat&tristique=eros&fusce=viverra&congue=eget&diam=congue&id=eget&ornare=semper&imperdiet=rutrum&sapien=nulla&urna=nunc&pretium=purus&nisl=phasellus&ut=in&volutpat=felis&sapien=donec&arcu=semper&sed=sapien&augue=a', N'http://dummyimage.com/174x148.jpg/5fa2dd/ffffff', N'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', N'magna')
SET IDENTITY_INSERT [Stock].[ProductSuppliers] OFF
SET IDENTITY_INSERT [Stock].[Stock] ON 

INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (1, 26, 90, 65, N'eget')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (2, 17, 83, 85, N'in')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (3, 45, 20, 2, N'sollicitudin')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (4, 23, 74, 40, N'at')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (5, 38, 22, 66, N'nisl')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (6, 17, 78, 35, N'varius')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (7, 37, 88, 58, N'tortor')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (8, 29, 55, 8, N'ac')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (9, 30, 45, 47, N'in')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (10, 30, 65, 46, N'donec')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (11, 18, 21, 35, N'a')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (12, 10, 4, 38, N'porta')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (13, 41, 61, 31, N'lorem')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (14, 50, 45, 27, N'pretium')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (15, 43, 16, 71, N'pede')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (17, 33, 83, 55, N'non')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (18, 37, 12, 74, N'etiam')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (19, 39, 65, 3, N'sollicitudin')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (20, 48, 11, 81, N'risus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (21, 22, 59, 26, N'molestie')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (22, 22, 21, 13, N'dapibus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (23, 6, 40, 46, N'fusce')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (24, 9, 28, 53, N'nibh')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (25, 45, 33, 76, N'tempus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (26, 48, 49, 73, N'sapien')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (27, 43, 38, 63, N'ridiculus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (28, 34, 55, 17, N'in')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (29, 28, 18, 52, N'tellus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (30, 22, 50, 46, N'pellentesque')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (31, 11, 24, 51, N'cubilia')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (32, 16, 48, 3, N'in')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (33, 37, 71, 9, N'vestibulum')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (34, 4, 8, 2, N'maecenas')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (35, 16, 54, 2, N'sit')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (36, 16, 4, 3, N'ridiculus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (37, 35, 32, 9, N'aliquam')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (38, 39, 17, 46, N'sagittis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (39, 38, 75, 9, N'nec')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (40, 24, 22, 32, N'orci')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (41, 15, 63, 10, N'orci')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (42, 22, 34, 22, N'consequat')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (43, 17, 82, 18, N'mattis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (44, 7, 62, 54, N'congue')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (45, 2, 93, 12, N'id')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (46, 26, 68, 14, N'mi')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (47, 40, 78, 69, N'primis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (48, 37, 58, 20, N'at')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (49, 2, 46, 81, N'vulputate')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (50, 38, 96, 29, N'justo')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (51, 36, 60, 24, N'tortor')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (52, 50, 57, 60, N'sit')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (53, 31, 44, 60, N'commodo')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (54, 27, 87, 47, N'consequat')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (55, 9, 96, 64, N'diam')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (56, 2, 16, 12, N'volutpat')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (57, 4, 64, 60, N'augue')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (58, 39, 58, 4, N'maecenas')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (59, 21, 8, 27, N'hac')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (60, 43, 45, 15, N'lacus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (61, 49, 1, 59, N'molestie')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (62, 19, 72, 7, N'sapien')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (63, 46, 25, 46, N'mauris')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (64, 31, 76, 4, N'viverra')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (65, 46, 86, 48, N'eget')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (66, 5, 18, 73, N'porttitor')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (67, 40, 48, 63, N'eros')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (68, 6, 12, 71, N'tempus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (69, 45, 22, 77, N'ipsum')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (70, 28, 45, 14, N'tincidunt')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (71, 32, 84, 74, N'vestibulum')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (72, 34, 33, 6, N'eros')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (73, 34, 80, 8, N'amet')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (74, 43, 47, 17, N'nunc')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (75, 37, 98, 19, N'diam')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (76, 42, 20, 12, N'justo')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (77, 41, 53, 71, N'luctus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (78, 50, 22, 4, N'eu')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (79, 31, 76, 82, N'libero')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (80, 20, 95, 78, N'in')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (81, 8, 88, 84, N'bibendum')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (82, 13, 63, 7, N'nisl')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (83, 43, 75, 21, N'felis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (84, 23, 29, 27, N'quam')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (85, 44, 84, 42, N'sapien')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (86, 16, 76, 5, N'ac')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (87, 10, 9, 63, N'quis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (88, 43, 82, 68, N'mattis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (89, 7, 49, 27, N'malesuada')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (90, 39, 69, 52, N'libero')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (91, 10, 77, 9, N'nulla')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (92, 28, 82, 22, N'rutrum')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (93, 4, 91, 1, N'pretium')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (94, 34, 9, 27, N'duis')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (95, 23, 96, 7, N'integer')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (96, 38, 85, 56, N'vel')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (97, 26, 55, 47, N'vel')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (98, 6, 22, 6, N'vivamus')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (99, 10, 23, 70, N'morbi')
INSERT [Stock].[Stock] ([StockID], [ProductImageID], [SupplierID], [ProductStockTypeID], [ProductName]) VALUES (100, 35, 70, 17, N'habitasse')
GO
SET IDENTITY_INSERT [Stock].[Stock] OFF
SET IDENTITY_INSERT [Stock].[StockLevel] ON 

INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (1, 36, 17)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (2, 7, 50)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (3, 10, 6)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (4, 3, 45)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (5, 63, 59)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (6, 8, 46)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (7, 22, 41)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (8, 5, 56)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (9, 5, 51)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (10, 28, 26)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (11, 2, 43)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (12, 59, 38)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (13, 21, 11)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (14, 8, 37)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (15, 33, 56)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (16, 20, 32)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (17, 9, 39)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (18, 28, 13)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (19, 6, 55)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (20, 13, 15)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (21, 45, 17)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (22, 2, 41)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (23, 47, 63)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (24, 45, 47)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (25, 2, 46)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (26, 41, 27)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (27, 3, 47)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (28, 29, 42)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (29, 46, 13)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (30, 66, 63)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (31, 51, 28)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (32, 9, 28)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (33, 61, 13)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (34, 65, 47)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (35, 61, 1)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (36, 59, 26)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (37, 54, 42)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (38, 5, 66)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (39, 28, 46)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (40, 2, 1)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (41, 43, 26)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (42, 57, 54)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (43, 25, 5)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (44, 33, 12)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (45, 9, 33)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (46, 40, 28)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (48, 56, 58)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (49, 41, 63)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (50, 27, 6)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (51, 36, 28)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (52, 64, 18)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (53, 4, 49)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (54, 55, 49)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (55, 61, 7)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (56, 46, 48)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (57, 40, 36)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (58, 50, 60)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (59, 64, 28)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (60, 40, 12)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (61, 52, 49)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (62, 54, 48)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (63, 13, 64)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (64, 31, 30)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (65, 14, 60)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (66, 5, 41)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (67, 1, 13)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (68, 11, 65)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (69, 59, 56)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (70, 4, 65)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (71, 32, 26)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (72, 59, 60)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (73, 9, 46)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (74, 45, 24)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (75, 65, 51)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (76, 63, 59)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (77, 53, 47)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (78, 45, 60)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (79, 36, 15)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (80, 45, 5)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (81, 66, 50)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (82, 39, 9)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (84, 27, 41)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (85, 28, 22)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (86, 46, 9)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (87, 33, 50)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (88, 45, 50)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (89, 31, 64)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (90, 53, 32)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (91, 15, 36)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (92, 9, 46)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (93, 62, 23)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (94, 48, 51)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (95, 30, 54)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (96, 49, 55)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (97, 42, 30)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (98, 4, 34)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (99, 1, 50)
INSERT [Stock].[StockLevel] ([ProductStockLevelID], [StockID], [ProductStockLevel]) VALUES (100, 56, 53)
SET IDENTITY_INSERT [Stock].[StockLevel] OFF
GO
SET IDENTITY_INSERT [Stock].[StockType] ON 

INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (1, N'lorem')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (2, N'nulla')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (3, N'at')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (4, N'porta')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (5, N'in')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (6, N'integer')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (7, N'nulla')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (8, N'donec')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (9, N'ullamcorper')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (10, N'habitasse')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (11, N'montes')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (12, N'interdum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (13, N'justo')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (14, N'diam')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (15, N'in')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (16, N'non')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (17, N'ut')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (18, N'pellentesque')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (19, N'nulla')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (20, N'commodo')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (21, N'turpis')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (22, N'dictumst')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (23, N'nisi')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (24, N'dui')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (25, N'montes')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (26, N'semper')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (27, N'tempor')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (28, N'vel')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (29, N'odio')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (30, N'in')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (31, N'sem')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (32, N'integer')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (33, N'id')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (34, N'sed')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (35, N'natoque')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (36, N'adipiscing')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (37, N'metus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (38, N'praesent')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (39, N'vitae')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (40, N'donec')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (41, N'interdum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (42, N'tortor')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (43, N'feugiat')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (44, N'dui')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (45, N'imperdiet')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (46, N'elit')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (47, N'sagittis')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (48, N'duis')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (49, N'risus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (50, N'dapibus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (51, N'nulla')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (52, N'mattis')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (53, N'bibendum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (54, N'amet')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (55, N'libero')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (56, N'semper')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (57, N'in')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (58, N'elementum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (59, N'volutpat')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (60, N'elementum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (61, N'natoque')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (62, N'faucibus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (63, N'orci')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (64, N'urna')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (65, N'ac')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (66, N'massa')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (67, N'felis')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (68, N'est')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (69, N'duis')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (70, N'proin')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (71, N'morbi')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (72, N'ligula')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (73, N'nullam')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (74, N'faucibus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (75, N'phasellus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (76, N'ipsum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (77, N'mauris')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (78, N'justo')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (79, N'sem')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (80, N'nunc')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (81, N'ultrices')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (82, N'donec')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (83, N'urna')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (84, N'eget')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (85, N'lacinia')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (86, N'leo')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (87, N'libero')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (88, N'suspendisse')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (89, N'est')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (90, N'nisi')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (91, N'luctus')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (92, N'tortor')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (93, N'sed')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (94, N'vel')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (95, N'mauris')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (96, N'sapien')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (97, N'cum')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (98, N'facilisi')
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (99, N'in')
GO
INSERT [Stock].[StockType] ([StockTypeID], [StockTypeName]) VALUES (100, N'sed')
SET IDENTITY_INSERT [Stock].[StockType] OFF
ALTER TABLE [Booking].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Company] FOREIGN KEY([CompanyID])
REFERENCES [Company].[Company] ([CompanyID])
GO
ALTER TABLE [Booking].[Booking] CHECK CONSTRAINT [FK_Booking_Company]
GO
ALTER TABLE [Booking].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Customer] FOREIGN KEY([CustomerID])
REFERENCES [Customer].[Customer] ([CustomerId])
GO
ALTER TABLE [Booking].[Booking] CHECK CONSTRAINT [FK_Booking_Customer]
GO
ALTER TABLE [Booking].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Service] FOREIGN KEY([ServiceID])
REFERENCES [Services].[Service] ([ServiceID])
GO
ALTER TABLE [Booking].[Booking] CHECK CONSTRAINT [FK_Booking_Service]
GO
ALTER TABLE [Booking].[BookingAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BookingAttendance_Booking] FOREIGN KEY([BookingID])
REFERENCES [Booking].[Booking] ([BookingID])
GO
ALTER TABLE [Booking].[BookingAttendance] CHECK CONSTRAINT [FK_BookingAttendance_Booking]
GO
ALTER TABLE [Booking].[BookingAttendance]  WITH CHECK ADD  CONSTRAINT [FK_BookingAttendance_Customer] FOREIGN KEY([CustomerID])
REFERENCES [Customer].[Customer] ([CustomerId])
GO
ALTER TABLE [Booking].[BookingAttendance] CHECK CONSTRAINT [FK_BookingAttendance_Customer]
GO
ALTER TABLE [Booking].[Cost]  WITH CHECK ADD  CONSTRAINT [FK_Cost_Service] FOREIGN KEY([ServiceID])
REFERENCES [Services].[Service] ([ServiceID])
GO
ALTER TABLE [Booking].[Cost] CHECK CONSTRAINT [FK_Cost_Service]
GO
ALTER TABLE [Booking].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Booking] FOREIGN KEY([BookingID])
REFERENCES [Booking].[Booking] ([BookingID])
GO
ALTER TABLE [Booking].[Invoice] CHECK CONSTRAINT [FK_Invoice_Booking]
GO
ALTER TABLE [Booking].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Cost] FOREIGN KEY([CostID])
REFERENCES [Booking].[Cost] ([CostID])
GO
ALTER TABLE [Booking].[Invoice] CHECK CONSTRAINT [FK_Invoice_Cost]
GO
ALTER TABLE [Booking].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_PaymentMethod] FOREIGN KEY([PaymentMethodID])
REFERENCES [Booking].[PaymentMethod] ([PaymentMethodID])
GO
ALTER TABLE [Booking].[Invoice] CHECK CONSTRAINT [FK_Invoice_PaymentMethod]
GO
ALTER TABLE [Company].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Industry] FOREIGN KEY([IndustryID])
REFERENCES [Company].[Industry] ([IndustryID])
GO
ALTER TABLE [Company].[Company] CHECK CONSTRAINT [FK_Company_Industry]
GO
ALTER TABLE [Company].[CompanyOpeningHours]  WITH CHECK ADD  CONSTRAINT [FK_CompanyOpeningHours_Company] FOREIGN KEY([CompanyID])
REFERENCES [Company].[Company] ([CompanyID])
GO
ALTER TABLE [Company].[CompanyOpeningHours] CHECK CONSTRAINT [FK_CompanyOpeningHours_Company]
GO
ALTER TABLE [Customer].[CompanyReviews]  WITH CHECK ADD  CONSTRAINT [FK_CompanyReviews_Company] FOREIGN KEY([CompanyID])
REFERENCES [Company].[Company] ([CompanyID])
GO
ALTER TABLE [Customer].[CompanyReviews] CHECK CONSTRAINT [FK_CompanyReviews_Company]
GO
ALTER TABLE [Customer].[CompanyReviews]  WITH CHECK ADD  CONSTRAINT [FK_CompanyReviews_Customer] FOREIGN KEY([CustomerID])
REFERENCES [Customer].[Customer] ([CustomerId])
GO
ALTER TABLE [Customer].[CompanyReviews] CHECK CONSTRAINT [FK_CompanyReviews_Customer]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Booking1] FOREIGN KEY([BookingID])
REFERENCES [Booking].[Booking] ([BookingID])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Booking1]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Customer] FOREIGN KEY([CustomerId])
REFERENCES [Customer].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Customer]
GO
ALTER TABLE [Equipment].[Equiptment]  WITH CHECK ADD  CONSTRAINT [FK_Equiptment_EquiptmentType] FOREIGN KEY([EquiptmentTypeID])
REFERENCES [Equipment].[EquiptmentType] ([EquiptmentTypeID])
GO
ALTER TABLE [Equipment].[Equiptment] CHECK CONSTRAINT [FK_Equiptment_EquiptmentType]
GO
ALTER TABLE [Services].[EquiptmentNeeded]  WITH CHECK ADD  CONSTRAINT [FK_EquiptmentNeeded_Equiptment1] FOREIGN KEY([EquiptmentID])
REFERENCES [Equipment].[Equiptment] ([EquiptmentID])
GO
ALTER TABLE [Services].[EquiptmentNeeded] CHECK CONSTRAINT [FK_EquiptmentNeeded_Equiptment1]
GO
ALTER TABLE [Services].[EquiptmentNeeded]  WITH CHECK ADD  CONSTRAINT [FK_EquiptmentNeeded_Service] FOREIGN KEY([ServiceID])
REFERENCES [Services].[Service] ([ServiceID])
GO
ALTER TABLE [Services].[EquiptmentNeeded] CHECK CONSTRAINT [FK_EquiptmentNeeded_Service]
GO
ALTER TABLE [Services].[Service]  WITH CHECK ADD  CONSTRAINT [FK_Service_ServiceType] FOREIGN KEY([ServiceTypeID])
REFERENCES [Services].[ServiceType] ([ServiceTypeID])
GO
ALTER TABLE [Services].[Service] CHECK CONSTRAINT [FK_Service_ServiceType]
GO
ALTER TABLE [Services].[Service_Products]  WITH CHECK ADD  CONSTRAINT [FK_Service_Products_Service] FOREIGN KEY([ServiceID])
REFERENCES [Services].[Service] ([ServiceID])
GO
ALTER TABLE [Services].[Service_Products] CHECK CONSTRAINT [FK_Service_Products_Service]
GO
ALTER TABLE [Services].[Service_Products]  WITH CHECK ADD  CONSTRAINT [FK_Service_Products_Stock] FOREIGN KEY([StockID])
REFERENCES [Stock].[Stock] ([StockID])
GO
ALTER TABLE [Services].[Service_Products] CHECK CONSTRAINT [FK_Service_Products_Stock]
GO
ALTER TABLE [Staff].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Company] FOREIGN KEY([CompanyID])
REFERENCES [Company].[Company] ([CompanyID])
GO
ALTER TABLE [Staff].[Staff] CHECK CONSTRAINT [FK_Staff_Company]
GO
ALTER TABLE [Staff].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_StaffRole] FOREIGN KEY([StaffRoleID])
REFERENCES [Staff].[StaffRole] ([StaffRoleID])
GO
ALTER TABLE [Staff].[Staff] CHECK CONSTRAINT [FK_Staff_StaffRole]
GO
ALTER TABLE [Staff].[StaffAccess]  WITH CHECK ADD  CONSTRAINT [FK_StaffAccess_StaffRole] FOREIGN KEY([StaffRoleID])
REFERENCES [Staff].[StaffRole] ([StaffRoleID])
GO
ALTER TABLE [Staff].[StaffAccess] CHECK CONSTRAINT [FK_StaffAccess_StaffRole]
GO
ALTER TABLE [Staff].[StaffAccess]  WITH CHECK ADD  CONSTRAINT [FK_StaffAccess_SystemAuthorization] FOREIGN KEY([SystemAuthorizationID])
REFERENCES [Staff].[SystemAuthorization] ([SystemAuthorizationID])
GO
ALTER TABLE [Staff].[StaffAccess] CHECK CONSTRAINT [FK_StaffAccess_SystemAuthorization]
GO
ALTER TABLE [Stock].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock_ProductImage] FOREIGN KEY([ProductImageID])
REFERENCES [Stock].[ProductImage] ([ProductImageID])
GO
ALTER TABLE [Stock].[Stock] CHECK CONSTRAINT [FK_Stock_ProductImage]
GO
ALTER TABLE [Stock].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock_ProductSuppliers] FOREIGN KEY([SupplierID])
REFERENCES [Stock].[ProductSuppliers] ([SupplierID])
GO
ALTER TABLE [Stock].[Stock] CHECK CONSTRAINT [FK_Stock_ProductSuppliers]
GO
ALTER TABLE [Stock].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock_StockType] FOREIGN KEY([ProductStockTypeID])
REFERENCES [Stock].[StockType] ([StockTypeID])
GO
ALTER TABLE [Stock].[Stock] CHECK CONSTRAINT [FK_Stock_StockType]
GO
ALTER TABLE [Stock].[StockLevel]  WITH CHECK ADD  CONSTRAINT [FK_StockLevel_Stock] FOREIGN KEY([StockID])
REFERENCES [Stock].[Stock] ([StockID])
GO
ALTER TABLE [Stock].[StockLevel] CHECK CONSTRAINT [FK_StockLevel_Stock]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[68] 4[4] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 36
               Left = 3
               Bottom = 166
               Right = 173
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BookingTime (Booking)"
            Begin Extent = 
               Top = 205
               Left = 189
               Bottom = 359
               Right = 360
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 93
               Left = 370
               Bottom = 344
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 17
               Left = 554
               Bottom = 187
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServiceType (Services)"
            Begin Extent = 
               Top = 34
               Left = 757
               Bottom = 152
               Right = 927
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'All_Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'All_Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'All_Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Company (Company)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "CompanyReviews (Customer)"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 136
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 136
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllReviews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllReviews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[4] 2[46] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 10
               Left = 497
               Bottom = 204
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BookingTime (Booking)"
            Begin Extent = 
               Top = 191
               Left = 240
               Bottom = 347
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 34
               Left = 732
               Bottom = 290
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 17
               Left = 237
               Bottom = 179
               Right = 407
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServiceType (Services)"
            Begin Extent = 
               Top = 15
               Left = 16
               Bottom = 111
               Right = 186
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Booking Next Month'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Booking Next Month'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Booking Next Month'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[3] 2[34] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "BookingAttendance_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 225
               Right = 297
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 40
               Left = 380
               Bottom = 170
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "BookingTime (Booking)"
            Begin Extent = 
               Top = 33
               Left = 618
               Bottom = 163
               Right = 788
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BookingAttendance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BookingAttendance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BookingTime (Booking)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 136
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServiceType (Services)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 234
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompanyID38Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompanyID38Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CompanyID38Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[61] 4[4] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EquiptmentNeeded (Services)"
            Begin Extent = 
               Top = 6
               Left = 681
               Bottom = 136
               Right = 884
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Equiptment (Equipment)"
            Begin Extent = 
               Top = 26
               Left = 444
               Bottom = 139
               Right = 632
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EquiptmentType (Equipment)"
            Begin Extent = 
               Top = 168
               Left = 690
               Bottom = 264
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 193
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BookingTime (Booking)"
            Begin Extent = 
               Top = 236
               Left = 86
               Bottom = 409
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin C' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipment Needed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'riteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipment Needed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipment Needed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[24] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BookingTime (Booking)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 417
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 6
               Left = 455
               Bottom = 136
               Right = 625
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 6
               Left = 663
               Bottom = 136
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ServiceType (Services)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 234
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Future Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Future Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Future Bookings'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[5] 2[46] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Booking (Booking)"
            Begin Extent = 
               Top = 204
               Left = 183
               Bottom = 381
               Right = 353
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Company (Company)"
            Begin Extent = 
               Top = 192
               Left = 740
               Bottom = 508
               Right = 916
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 8
               Left = 0
               Bottom = 250
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 17
               Left = 213
               Bottom = 186
               Right = 383
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cost (Booking)"
            Begin Extent = 
               Top = 5
               Left = 781
               Bottom = 118
               Right = 951
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Staff (Staff)"
            Begin Extent = 
               Top = 108
               Left = 453
               Bottom = 312
               Right = 623
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Invoice_1"
            Begin Extent = 
               Top = 174
               Left = 390
               Bottom = 304
               Righ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Invoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N't = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Invoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Invoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Company (Company)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CompanyReviews (Customer)"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 136
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 136
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NegativeReviews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NegativeReviews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Company (Company)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CompanyReviews (Customer)"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 136
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (Customer)"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 136
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PositiveReviews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PositiveReviews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cost (Booking)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServiceType (Services)"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 102
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Price List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Price List'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cost (Booking)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Service (Services)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServiceType (Services)"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 102
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1950
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Price Specific'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Price Specific'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProductImage (Stock)"
            Begin Extent = 
               Top = 9
               Left = 286
               Bottom = 197
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Stock (Stock)"
            Begin Extent = 
               Top = 1
               Left = 15
               Bottom = 201
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StockPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StockPhoto'
GO
USE [master]
GO
ALTER DATABASE [FinalYear] SET  READ_WRITE 
GO
