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
/****** Object:  Database [FinalYear]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  User [Business_User]    Script Date: 01/05/2018 02:56:06 ******/
CREATE USER [Business_User] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AdamSmith]    Script Date: 01/05/2018 02:56:06 ******/
CREATE USER [AdamSmith] FOR LOGIN [BUILTIN\Users]
GO
ALTER ROLE [db_datareader] ADD MEMBER [AdamSmith]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [AdamSmith]
GO
/****** Object:  Schema [Booking]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Booking]
GO
/****** Object:  Schema [Company]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Company]
GO
/****** Object:  Schema [Customer]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Customer]
GO
/****** Object:  Schema [Equipment]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Equipment]
GO
/****** Object:  Schema [Services]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Services]
GO
/****** Object:  Schema [Staff]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Staff]
GO
/****** Object:  Schema [Stock]    Script Date: 01/05/2018 02:56:06 ******/
CREATE SCHEMA [Stock]
GO
/****** Object:  Table [Booking].[Booking]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Booking].[BookingAttendance]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Booking].[BookingTime]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Booking].[Cost]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Booking].[Invoice]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Booking].[PaymentMethod]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Company].[Company]    Script Date: 01/05/2018 02:56:06 ******/
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
/****** Object:  Table [Company].[CompanyOpeningHours]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Company].[Industry]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Customer].[CompanyReviews]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Customer].[Customer]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [dbo].[Events]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Equipment].[Equiptment]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Equipment].[EquiptmentType]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Services].[EquiptmentNeeded]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Services].[Service]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Services].[Service_Products]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Services].[ServiceType]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Staff].[Staff]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Staff].[StaffAccess]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Staff].[StaffRole]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Staff].[SystemAuthorization]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Stock].[ProductImage]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Stock].[ProductSuppliers]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Stock].[Stock]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Stock].[StockLevel]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  Table [Stock].[StockType]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[All_Bookings]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[AllReviews]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[Booking Next Month]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[BookingAttendance]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[CompanyID38Bookings]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[Equipment Needed]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[Future Bookings]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[Invoice]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[NegativeReviews]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[PositiveReviews]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[Price List]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[Price Specific]    Script Date: 01/05/2018 02:56:07 ******/
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
/****** Object:  View [dbo].[StockPhoto]    Script Date: 01/05/2018 02:56:07 ******/
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
