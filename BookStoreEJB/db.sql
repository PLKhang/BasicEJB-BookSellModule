USE [master]
GO
/****** Object:  Database [BookStore]    Script Date: 3/28/2025 9:33:52 PM ******/
CREATE DATABASE [BookStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BookStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BookStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BookStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStore] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStore] SET RECOVERY FULL 
GO
ALTER DATABASE [BookStore] SET  MULTI_USER 
GO
ALTER DATABASE [BookStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookStore', N'ON'
GO
ALTER DATABASE [BookStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [BookStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BookStore]
GO
/****** Object:  Table [dbo].[bill]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[order_id] [numeric](19, 0) NOT NULL,
	[paymentMethod] [int] NOT NULL,
	[amount] [numeric](28, 0) NOT NULL,
	[status] [int] NOT NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK__bill__3213E83F3F36EB6F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[title] [varchar](150) NOT NULL,
	[author] [varchar](100) NOT NULL,
	[category] [varchar](100) NOT NULL,
	[isbn] [varchar](20) NOT NULL,
	[price] [float] NOT NULL,
	[publishDate] [datetime] NULL,
	[publisher] [varchar](150) NULL,
	[status] [int] NOT NULL,
	[stock] [int] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK__book__3213E83FAEC94AEA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[customer_id] [numeric](19, 0) NOT NULL,
	[totalPrice] [float] NULL,
	[updatedAt] [datetime] NOT NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK__cart__3213E83F275138A2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_detail]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_detail](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[cart_id] [numeric](19, 0) NOT NULL,
	[book_id] [numeric](19, 0) NOT NULL,
	[quantity] [int] NOT NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
 CONSTRAINT [PK__cart_det__3213E83F0542B375] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[address] [varchar](255) NOT NULL,
	[status] [int] NOT NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
 CONSTRAINT [PK__customer__3213E83F9504A741] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_detail]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[order_id] [numeric](19, 0) NOT NULL,
	[book_id] [numeric](19, 0) NOT NULL,
	[quantity] [int] NOT NULL,
	[amount] [float] NOT NULL,
	[createdAt] [datetime] NOT NULL,
 CONSTRAINT [PK__order_de__3213E83FA9F4C6DA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 3/28/2025 9:33:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[customer_id] [numeric](19, 0) NOT NULL,
	[totalPrice] [float] NOT NULL,
	[status] [int] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK__orders__3213E83FCF519AC0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[book] ON 

INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(1 AS Numeric(19, 0)), N'EJB1', N'Khang', N'Horror', N'11221122', 125, CAST(N'2025-03-24T00:00:00.000' AS DateTime), N'Khang', 0, 121, CAST(N'2025-03-24T00:00:00.000' AS DateTime), CAST(N'2025-04-04T16:39:02.093' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(2 AS Numeric(19, 0)), N'EJB2', N'Le', N'Comedy', N'22112211', 32, CAST(N'2025-03-24T00:00:00.000' AS DateTime), N'Khang', 0, 0, CAST(N'2025-03-24T00:00:00.000' AS DateTime), CAST(N'2025-04-04T16:12:40.363' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(3 AS Numeric(19, 0)), N'Clean Code', N'Robert C. Martin', N'Programming', N'9780132350884', 550000, CAST(N'2008-08-01T00:00:00.000' AS DateTime), N'Prentice Hall', 1, 50, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(4 AS Numeric(19, 0)), N'The Pragmatic Programmer', N'Andrew Hunt', N'Programming', N'9780201616224', 600000, CAST(N'1999-10-20T00:00:00.000' AS DateTime), N'Addison-Wesley', 1, 40, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(5 AS Numeric(19, 0)), N'Design Patterns', N'Erich Gamma', N'Software Engineering', N'9780201633610', 750000, CAST(N'1994-10-21T00:00:00.000' AS DateTime), N'Addison-Wesley', 1, 30, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(6 AS Numeric(19, 0)), N'Refactoring', N'Martin Fowler', N'Programming', N'9780201485677', 680000, CAST(N'1999-07-08T00:00:00.000' AS DateTime), N'Addison-Wesley', 1, 35, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(7 AS Numeric(19, 0)), N'The Mythical Man-Month', N'Frederick P. Brooks Jr.', N'Software Engineering', N'9780201835953', 450000, CAST(N'1995-08-02T00:00:00.000' AS DateTime), N'Addison-Wesley', 1, 25, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(8 AS Numeric(19, 0)), N'Introduction to Algorithms', N'Thomas H. Cormen', N'Computer Science', N'9780262033848', 950000, CAST(N'2009-07-31T00:00:00.000' AS DateTime), N'MIT Press', 1, 20, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(9 AS Numeric(19, 0)), N'Artificial Intelligence: A Modern Approach', N'Stuart Russell', N'AI', N'9780134610993', 900000, CAST(N'2020-04-28T00:00:00.000' AS DateTime), N'Pearson', 1, 15, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(10 AS Numeric(19, 0)), N'Deep Learning', N'Ian Goodfellow', N'Machine Learning', N'9780262035613', 980000, CAST(N'2016-11-18T00:00:00.000' AS DateTime), N'MIT Press', 1, 2, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-04-04T16:32:29.817' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(11 AS Numeric(19, 0)), N'Computer Networking', N'James F. Kurose', N'Networking', N'9780133594140', 700000, CAST(N'2016-03-05T00:00:00.000' AS DateTime), N'Pearson', 1, 22, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(12 AS Numeric(19, 0)), N'Operating System Concepts', N'Abraham Silberschatz', N'Operating Systems', N'9781118063330', 850000, CAST(N'2012-01-03T00:00:00.000' AS DateTime), N'Wiley', 1, 18, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(13 AS Numeric(19, 0)), N'Computer Organization and Design', N'David A. Patterson', N'Computer Science', N'9780128122754', 500000, CAST(N'2017-06-23T00:00:00.000' AS DateTime), N'Morgan Kaufmann', 1, 30, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(14 AS Numeric(19, 0)), N'Data Science for Business', N'Foster Provost', N'Data Science', N'9781449361327', 620000, CAST(N'2013-08-27T00:00:00.000' AS DateTime), N'O''Reilly Media', 1, 27, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(15 AS Numeric(19, 0)), N'Python Crash Course', N'Eric Matthes', N'Programming', N'9781593276034', 450000, CAST(N'2015-11-01T00:00:00.000' AS DateTime), N'No Starch Press', 1, 40, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(16 AS Numeric(19, 0)), N'You Don''t Know JS', N'Kyle Simpson', N'JavaScript', N'9781491904244', 380000, CAST(N'2014-12-28T00:00:00.000' AS DateTime), N'O''Reilly Media', 1, 50, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(17 AS Numeric(19, 0)), N'The Phoenix Project', N'Gene Kim', N'DevOps', N'9780988262591', 420000, CAST(N'2013-01-10T00:00:00.000' AS DateTime), N'IT Revolution Press', 1, 35, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(18 AS Numeric(19, 0)), N'Effective Java', N'Joshua Bloch', N'Java', N'9780134685991', 800000, CAST(N'2017-12-27T00:00:00.000' AS DateTime), N'Addison-Wesley', 1, 30, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(19 AS Numeric(19, 0)), N'JavaScript: The Good Parts', N'Douglas Crockford', N'JavaScript', N'9780596517748', 300000, CAST(N'2008-05-01T00:00:00.000' AS DateTime), N'O''Reilly Media', 1, 49, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-04-04T16:39:02.097' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(20 AS Numeric(19, 0)), N'Head First Design Patterns', N'Eric Freeman', N'Software Engineering', N'9780596007126', 720000, CAST(N'2004-10-25T00:00:00.000' AS DateTime), N'O''Reilly Media', 1, 28, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(21 AS Numeric(19, 0)), N'Web Development with Node.js', N'Ethan Brown', N'Web Development', N'9781491949306', 550000, CAST(N'2014-09-16T00:00:00.000' AS DateTime), N'O''Reilly Media', 1, 22, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
INSERT [dbo].[book] ([id], [title], [author], [category], [isbn], [price], [publishDate], [publisher], [status], [stock], [createdAt], [updatedAt]) VALUES (CAST(22 AS Numeric(19, 0)), N'Kubernetes Up & Running', N'Kelsey Hightower', N'DevOps', N'9781491936016', 780000, CAST(N'2017-09-10T00:00:00.000' AS DateTime), N'O''Reilly Media', 1, 18, CAST(N'2025-03-24T13:04:24.037' AS DateTime), CAST(N'2025-03-24T13:04:24.037' AS DateTime))
SET IDENTITY_INSERT [dbo].[book] OFF
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([id], [customer_id], [totalPrice], [updatedAt], [createdAt]) VALUES (CAST(7 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 0, CAST(N'2025-04-04T16:32:29.820' AS DateTime), CAST(N'2025-03-26T10:03:22.793' AS DateTime))
INSERT [dbo].[cart] ([id], [customer_id], [totalPrice], [updatedAt], [createdAt]) VALUES (CAST(8 AS Numeric(19, 0)), CAST(20 AS Numeric(19, 0)), 2500064, CAST(N'2025-03-28T18:59:45.250' AS DateTime), CAST(N'2025-03-28T18:06:50.673' AS DateTime))
INSERT [dbo].[cart] ([id], [customer_id], [totalPrice], [updatedAt], [createdAt]) VALUES (CAST(9 AS Numeric(19, 0)), CAST(12 AS Numeric(19, 0)), 0, CAST(N'2025-04-04T16:39:02.097' AS DateTime), CAST(N'2025-03-28T18:07:40.930' AS DateTime))
INSERT [dbo].[cart] ([id], [customer_id], [totalPrice], [updatedAt], [createdAt]) VALUES (CAST(10 AS Numeric(19, 0)), CAST(13 AS Numeric(19, 0)), 1480000, CAST(N'2025-03-28T18:34:58.840' AS DateTime), CAST(N'2025-03-28T18:32:20.050' AS DateTime))
INSERT [dbo].[cart] ([id], [customer_id], [totalPrice], [updatedAt], [createdAt]) VALUES (CAST(11 AS Numeric(19, 0)), CAST(24 AS Numeric(19, 0)), 0, CAST(N'2025-03-28T23:29:03.167' AS DateTime), CAST(N'2025-03-28T23:28:44.843' AS DateTime))
INSERT [dbo].[cart] ([id], [customer_id], [totalPrice], [updatedAt], [createdAt]) VALUES (CAST(12 AS Numeric(19, 0)), CAST(15 AS Numeric(19, 0)), 0, CAST(N'2025-03-28T23:29:31.520' AS DateTime), CAST(N'2025-03-28T23:29:18.860' AS DateTime))
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[cart_detail] ON 

INSERT [dbo].[cart_detail] ([id], [cart_id], [book_id], [quantity], [createdAt], [updatedAt]) VALUES (CAST(71 AS Numeric(19, 0)), CAST(10 AS Numeric(19, 0)), CAST(6 AS Numeric(19, 0)), 1, CAST(N'2025-03-28T18:34:57.383' AS DateTime), CAST(N'2025-03-28T18:34:57.383' AS DateTime))
INSERT [dbo].[cart_detail] ([id], [cart_id], [book_id], [quantity], [createdAt], [updatedAt]) VALUES (CAST(72 AS Numeric(19, 0)), CAST(10 AS Numeric(19, 0)), CAST(18 AS Numeric(19, 0)), 1, CAST(N'2025-03-28T18:34:58.840' AS DateTime), CAST(N'2025-03-28T18:34:58.840' AS DateTime))
INSERT [dbo].[cart_detail] ([id], [cart_id], [book_id], [quantity], [createdAt], [updatedAt]) VALUES (CAST(77 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), CAST(18 AS Numeric(19, 0)), 1, CAST(N'2025-03-28T18:59:14.423' AS DateTime), CAST(N'2025-03-28T18:59:14.423' AS DateTime))
INSERT [dbo].[cart_detail] ([id], [cart_id], [book_id], [quantity], [createdAt], [updatedAt]) VALUES (CAST(78 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), CAST(4 AS Numeric(19, 0)), 1, CAST(N'2025-03-28T18:59:15.420' AS DateTime), CAST(N'2025-03-28T18:59:15.420' AS DateTime))
INSERT [dbo].[cart_detail] ([id], [cart_id], [book_id], [quantity], [createdAt], [updatedAt]) VALUES (CAST(79 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)), 2, CAST(N'2025-03-28T18:59:16.117' AS DateTime), CAST(N'2025-03-28T18:59:28.713' AS DateTime))
INSERT [dbo].[cart_detail] ([id], [cart_id], [book_id], [quantity], [createdAt], [updatedAt]) VALUES (CAST(80 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)), 2, CAST(N'2025-03-28T18:59:32.707' AS DateTime), CAST(N'2025-03-28T18:59:45.250' AS DateTime))
SET IDENTITY_INSERT [dbo].[cart_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[customer] ON 

INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(1 AS Numeric(19, 0)), N's', N's', N's', N's@gmail.com', N's', N's', 0, NULL, NULL)
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(2 AS Numeric(19, 0)), N'john_doe', N'password123', N'John Doe', N'john.doe@example.com', N'0912345678', N'123 Main St, Hanoi', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(3 AS Numeric(19, 0)), N'jane_smith', N'password456', N'Jane Smith', N'jane.smith@example.com', N'0923456789', N'456 Maple Ave, Saigon', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(4 AS Numeric(19, 0)), N'alice_nguyen', N'passAlice789', N'Alice Nguyen', N'alice.nguyen@example.com', N'0934567890', N'789 Oak St, Da Nang', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(5 AS Numeric(19, 0)), N'bob_tran', N'bobSecure321', N'Bob Tran', N'bob.tran@example.com', N'0945678901', N'159 Bamboo St, Hue', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(6 AS Numeric(19, 0)), N'charlie_pham', N'charliePass654', N'Charlie Pham', N'charlie.pham@example.com', N'0956789012', N'753 Coconut St, Can Tho', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(7 AS Numeric(19, 0)), N'david_le', N'davidPass111', N'David Le', N'david.le@example.com', N'0967890123', N'852 Mango St, Nha Trang', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(8 AS Numeric(19, 0)), N'emma_hoang', N'emmaSecret789', N'Emma Hoang', N'emma.hoang@example.com', N'0978901234', N'951 Pineapple St, Vung Tau', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(9 AS Numeric(19, 0)), N'frank_nguyen', N'frankPass852', N'Frank Nguyen', N'frank.nguyen@example.com', N'0989012345', N'357 Peach St, Da Lat', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(10 AS Numeric(19, 0)), N'grace_tran', N'graceSafe963', N'Grace Tran', N'grace.tran@example.com', N'0990123456', N'753 Plum St, Quang Ngai', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(11 AS Numeric(19, 0)), N'harry_vo', N'harrySecure123', N'Harry Vo', N'harry.vo@example.com', N'0901234567', N'258 Apple St, Bac Ninh', 1, CAST(N'2025-03-24T13:02:46.100' AS DateTime), CAST(N'2025-03-24T13:02:46.100' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(12 AS Numeric(19, 0)), N'a', N'a', N'a', N'a@gmail.com', N'a', N'a', 1, NULL, NULL)
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(13 AS Numeric(19, 0)), N'b', N'b', N'b', N'b@gmail.com', N'b', N'b', 1, CAST(N'2025-03-24T22:52:56.047' AS DateTime), CAST(N'2025-03-24T22:52:56.047' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(14 AS Numeric(19, 0)), N'g', N'g', N'g', N'g@gmail.com', N'g', N'g', 0, CAST(N'2025-03-26T00:10:46.200' AS DateTime), CAST(N'2025-03-26T00:10:46.200' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(15 AS Numeric(19, 0)), N'vgbao1231', N'123123', N'VÃµ Gia Báº£o', N'vgbao1231@gmail.com', N'0384026903', N'NT', 0, CAST(N'2025-03-26T07:51:10.793' AS DateTime), CAST(N'2025-03-26T07:51:10.793' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(16 AS Numeric(19, 0)), N't', N't', N't', N't@gmail.com', N't', N't', 0, CAST(N'2025-03-26T09:32:27.460' AS DateTime), CAST(N'2025-03-26T09:32:27.460' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(17 AS Numeric(19, 0)), N'vgbao', N'123123', N'Gura', N'user@gmail.com', N'0911095800', N'NT', 0, CAST(N'2025-03-26T09:35:40.443' AS DateTime), CAST(N'2025-03-26T09:35:40.443' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(18 AS Numeric(19, 0)), N'y', N'y', N'y', N'y@gmail.com', N'y', N'y', 0, CAST(N'2025-03-26T09:57:30.607' AS DateTime), CAST(N'2025-03-26T09:57:30.607' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(19 AS Numeric(19, 0)), N'q', N'q', N'q', N'q@gmail.com', N'q', N'q', 0, CAST(N'2025-03-26T10:04:06.967' AS DateTime), CAST(N'2025-03-26T10:04:06.967' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(20 AS Numeric(19, 0)), N'u', N'u', N'u', N'u@gmail.com', N'u', N'u', 0, CAST(N'2025-03-28T18:06:45.163' AS DateTime), CAST(N'2025-03-28T18:06:45.163' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(21 AS Numeric(19, 0)), N'vgbao3', N'123123', N'VÃµ Báº£o', N'root@gmail.com', N'123123', N'Nha Trang', 0, CAST(N'2025-03-28T23:04:43.513' AS DateTime), CAST(N'2025-03-28T23:04:43.513' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(22 AS Numeric(19, 0)), N'quanbin27', N'123123', N'VÃµ Trung QuÃ¢n', N'quanbinskt27@gmail.com', N'1231231231', N'123123123', 0, CAST(N'2025-03-28T23:25:43.410' AS DateTime), CAST(N'2025-03-28T23:25:43.410' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(23 AS Numeric(19, 0)), N'p', N'p', N'p', N'p@gmail.com', N'p', N'p', 0, CAST(N'2025-03-28T23:27:00.740' AS DateTime), CAST(N'2025-03-28T23:27:00.740' AS DateTime))
INSERT [dbo].[customer] ([id], [username], [password], [name], [email], [phone], [address], [status], [createdAt], [updatedAt]) VALUES (CAST(24 AS Numeric(19, 0)), N'l', N'l', N'l', N'l@gmail.com', N'l', N'l', 0, CAST(N'2025-03-28T23:27:57.577' AS DateTime), CAST(N'2025-03-28T23:27:57.577' AS DateTime))
SET IDENTITY_INSERT [dbo].[customer] OFF
GO
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(76 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), CAST(7 AS Numeric(19, 0)), 1, 450000, CAST(N'2025-03-25T23:40:44.567' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(77 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), CAST(5 AS Numeric(19, 0)), 1, 750000, CAST(N'2025-03-25T23:40:44.567' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(78 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), CAST(4 AS Numeric(19, 0)), 1, 600000, CAST(N'2025-03-25T23:40:44.567' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(79 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)), 1, 550000, CAST(N'2025-03-25T23:40:44.567' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(80 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), CAST(9 AS Numeric(19, 0)), 1, 900000, CAST(N'2025-03-25T23:40:44.567' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(81 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), 1, 950000, CAST(N'2025-03-25T23:40:44.567' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(82 AS Numeric(19, 0)), CAST(20 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)), 1, 550000, CAST(N'2025-03-25T23:56:29.317' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(83 AS Numeric(19, 0)), CAST(20 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), 1, 950000, CAST(N'2025-03-25T23:56:29.317' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(84 AS Numeric(19, 0)), CAST(20 AS Numeric(19, 0)), CAST(5 AS Numeric(19, 0)), 1, 750000, CAST(N'2025-03-25T23:56:29.317' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(85 AS Numeric(19, 0)), CAST(20 AS Numeric(19, 0)), CAST(7 AS Numeric(19, 0)), 1, 450000, CAST(N'2025-03-25T23:56:29.317' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(86 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), CAST(5 AS Numeric(19, 0)), 1, 750000, CAST(N'2025-03-26T07:24:10.180' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(87 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)), 1, 550000, CAST(N'2025-03-26T07:24:10.180' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(88 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), CAST(7 AS Numeric(19, 0)), 5, 2250000, CAST(N'2025-03-26T07:24:10.180' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(89 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), 1, 950000, CAST(N'2025-03-26T07:24:10.177' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(90 AS Numeric(19, 0)), CAST(22 AS Numeric(19, 0)), CAST(7 AS Numeric(19, 0)), 5, 2250000, CAST(N'2025-03-26T07:51:48.920' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(91 AS Numeric(19, 0)), CAST(22 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)), 1, 550000, CAST(N'2025-03-26T07:51:48.920' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(92 AS Numeric(19, 0)), CAST(22 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), 4, 3800000, CAST(N'2025-03-26T07:51:48.920' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(93 AS Numeric(19, 0)), CAST(22 AS Numeric(19, 0)), CAST(5 AS Numeric(19, 0)), 1, 750000, CAST(N'2025-03-26T07:51:48.920' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(94 AS Numeric(19, 0)), CAST(23 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)), 1, 550000, CAST(N'2025-03-26T07:52:09.367' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(95 AS Numeric(19, 0)), CAST(23 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), 4, 3800000, CAST(N'2025-03-26T07:52:09.367' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(96 AS Numeric(19, 0)), CAST(23 AS Numeric(19, 0)), CAST(5 AS Numeric(19, 0)), 1, 750000, CAST(N'2025-03-26T07:52:09.367' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(97 AS Numeric(19, 0)), CAST(24 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), 2, 600000, CAST(N'2025-03-26T09:33:30.913' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(98 AS Numeric(19, 0)), CAST(25 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), 2, 600000, CAST(N'2025-03-26T09:35:11.210' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(99 AS Numeric(19, 0)), CAST(26 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1, 125, CAST(N'2025-03-26T09:43:44.077' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(100 AS Numeric(19, 0)), CAST(27 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1, 125, CAST(N'2025-03-26T09:54:00.523' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(101 AS Numeric(19, 0)), CAST(28 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)), 1, 32, CAST(N'2025-03-26T09:56:12.837' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(102 AS Numeric(19, 0)), CAST(29 AS Numeric(19, 0)), CAST(4 AS Numeric(19, 0)), 1, 600000, CAST(N'2025-03-26T09:56:51.007' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(103 AS Numeric(19, 0)), CAST(30 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2, 250, CAST(N'2025-03-26T09:57:41.393' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(104 AS Numeric(19, 0)), CAST(31 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2, 250, CAST(N'2025-03-26T09:57:45.080' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(105 AS Numeric(19, 0)), CAST(32 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2, 250, CAST(N'2025-03-26T09:57:46.517' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(106 AS Numeric(19, 0)), CAST(33 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2, 250, CAST(N'2025-03-26T09:57:48.253' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(107 AS Numeric(19, 0)), CAST(34 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1, 125, CAST(N'2025-03-26T09:58:17.847' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(108 AS Numeric(19, 0)), CAST(35 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), 2, 1100000, CAST(N'2025-03-26T09:59:52.227' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(109 AS Numeric(19, 0)), CAST(36 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), 1, 300000, CAST(N'2025-03-26T10:03:42.410' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(110 AS Numeric(19, 0)), CAST(36 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), 2, 1100000, CAST(N'2025-03-26T10:03:42.410' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(111 AS Numeric(19, 0)), CAST(37 AS Numeric(19, 0)), CAST(4 AS Numeric(19, 0)), 1, 600000, CAST(N'2025-03-28T18:07:08.800' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(112 AS Numeric(19, 0)), CAST(38 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), 4, 1200000, CAST(N'2025-03-28T18:07:29.877' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(113 AS Numeric(19, 0)), CAST(38 AS Numeric(19, 0)), CAST(17 AS Numeric(19, 0)), 1, 420000, CAST(N'2025-03-28T18:07:29.877' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(114 AS Numeric(19, 0)), CAST(39 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), 1, 300000, CAST(N'2025-03-28T18:51:20.537' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(115 AS Numeric(19, 0)), CAST(39 AS Numeric(19, 0)), CAST(4 AS Numeric(19, 0)), 3, 1800000, CAST(N'2025-03-28T18:51:20.537' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(116 AS Numeric(19, 0)), CAST(39 AS Numeric(19, 0)), CAST(21 AS Numeric(19, 0)), 1, 550000, CAST(N'2025-03-28T18:51:20.537' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(117 AS Numeric(19, 0)), CAST(40 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)), 1, 32, CAST(N'2025-03-28T23:29:01.213' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(118 AS Numeric(19, 0)), CAST(41 AS Numeric(19, 0)), CAST(7 AS Numeric(19, 0)), 1, 450000, CAST(N'2025-03-28T23:29:28.103' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(119 AS Numeric(19, 0)), CAST(41 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1, 125, CAST(N'2025-03-28T23:29:28.103' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(120 AS Numeric(19, 0)), CAST(42 AS Numeric(19, 0)), CAST(8 AS Numeric(19, 0)), 3, 2850000, CAST(N'2025-03-29T07:46:57.767' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(121 AS Numeric(19, 0)), CAST(43 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)), 2, 64, CAST(N'2025-04-04T16:12:38.427' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(122 AS Numeric(19, 0)), CAST(44 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1, 125, CAST(N'2025-04-04T16:18:34.327' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(123 AS Numeric(19, 0)), CAST(45 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2, 250, CAST(N'2025-04-04T16:19:35.687' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(124 AS Numeric(19, 0)), CAST(46 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2, 250, CAST(N'2025-04-04T16:21:56.430' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(125 AS Numeric(19, 0)), CAST(47 AS Numeric(19, 0)), CAST(10 AS Numeric(19, 0)), 8, 7840000, CAST(N'2025-04-04T16:32:28.473' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(126 AS Numeric(19, 0)), CAST(48 AS Numeric(19, 0)), CAST(19 AS Numeric(19, 0)), 1, 300000, CAST(N'2025-04-04T16:39:01.040' AS DateTime))
INSERT [dbo].[order_detail] ([id], [order_id], [book_id], [quantity], [amount], [createdAt]) VALUES (CAST(127 AS Numeric(19, 0)), CAST(48 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1, 125, CAST(N'2025-04-04T16:39:01.037' AS DateTime))
SET IDENTITY_INSERT [dbo].[order_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(19 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 4200000, 1, CAST(N'2025-03-25T23:40:44.567' AS DateTime), CAST(N'2025-03-25T23:40:47.913' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(20 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2700000, 1, CAST(N'2025-03-25T23:56:29.310' AS DateTime), CAST(N'2025-03-25T23:56:33.157' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(21 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 4500000, 1, CAST(N'2025-03-26T07:24:10.070' AS DateTime), CAST(N'2025-03-26T07:24:14.950' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(22 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 7350000, 0, CAST(N'2025-03-26T07:51:48.920' AS DateTime), CAST(N'2025-03-26T07:51:48.920' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(23 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 5100000, 0, CAST(N'2025-03-26T07:52:09.367' AS DateTime), CAST(N'2025-03-26T07:52:09.367' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(24 AS Numeric(19, 0)), CAST(16 AS Numeric(19, 0)), 600000, 1, CAST(N'2025-03-26T09:33:30.907' AS DateTime), CAST(N'2025-03-26T09:33:36.483' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(25 AS Numeric(19, 0)), CAST(16 AS Numeric(19, 0)), 600000, 0, CAST(N'2025-03-26T09:35:11.210' AS DateTime), CAST(N'2025-03-26T09:35:11.210' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(26 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 125, 1, CAST(N'2025-03-26T09:43:44.073' AS DateTime), CAST(N'2025-03-26T09:43:46.970' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(27 AS Numeric(19, 0)), CAST(17 AS Numeric(19, 0)), 125, 0, CAST(N'2025-03-26T09:54:00.513' AS DateTime), CAST(N'2025-03-26T09:54:00.513' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(28 AS Numeric(19, 0)), CAST(17 AS Numeric(19, 0)), 32, 1, CAST(N'2025-03-26T09:56:12.827' AS DateTime), CAST(N'2025-03-26T09:56:17.117' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(29 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 600000, 0, CAST(N'2025-03-26T09:56:50.993' AS DateTime), CAST(N'2025-03-26T09:56:50.993' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(30 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 250, 0, CAST(N'2025-03-26T09:57:41.393' AS DateTime), CAST(N'2025-03-26T09:57:41.393' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(31 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 250, 0, CAST(N'2025-03-26T09:57:45.080' AS DateTime), CAST(N'2025-03-26T09:57:45.080' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(32 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 250, 0, CAST(N'2025-03-26T09:57:46.517' AS DateTime), CAST(N'2025-03-26T09:57:46.517' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(33 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 250, 0, CAST(N'2025-03-26T09:57:48.247' AS DateTime), CAST(N'2025-03-26T09:57:48.247' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(34 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 125, 0, CAST(N'2025-03-26T09:58:17.847' AS DateTime), CAST(N'2025-03-26T09:58:17.847' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(35 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1100000, 0, CAST(N'2025-03-26T09:59:52.227' AS DateTime), CAST(N'2025-03-26T09:59:52.227' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(36 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1400000, 1, CAST(N'2025-03-26T10:03:42.400' AS DateTime), CAST(N'2025-03-26T10:03:45.593' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(37 AS Numeric(19, 0)), CAST(20 AS Numeric(19, 0)), 600000, 1, CAST(N'2025-03-28T18:07:08.797' AS DateTime), CAST(N'2025-03-28T18:07:10.083' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(38 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 1620000, 1, CAST(N'2025-03-28T18:07:29.877' AS DateTime), CAST(N'2025-03-28T18:07:31.333' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(39 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2650000, 1, CAST(N'2025-03-28T18:51:20.530' AS DateTime), CAST(N'2025-03-28T18:51:21.983' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(40 AS Numeric(19, 0)), CAST(24 AS Numeric(19, 0)), 32, 1, CAST(N'2025-03-28T23:29:01.210' AS DateTime), CAST(N'2025-03-28T23:29:03.160' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(41 AS Numeric(19, 0)), CAST(15 AS Numeric(19, 0)), 450125, 1, CAST(N'2025-03-28T23:29:28.103' AS DateTime), CAST(N'2025-03-28T23:29:31.520' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(42 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 2850000, 1, CAST(N'2025-03-29T07:46:57.753' AS DateTime), CAST(N'2025-03-29T07:47:00.647' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(43 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 64, 1, CAST(N'2025-04-04T16:12:38.410' AS DateTime), CAST(N'2025-04-04T16:12:40.357' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(44 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 125, 0, CAST(N'2025-04-04T16:18:34.323' AS DateTime), CAST(N'2025-04-04T16:18:34.323' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(45 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 250, 0, CAST(N'2025-04-04T16:19:35.687' AS DateTime), CAST(N'2025-04-04T16:19:35.687' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(46 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 250, 1, CAST(N'2025-04-04T16:21:56.427' AS DateTime), CAST(N'2025-04-04T16:21:57.443' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(47 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), 7840000, 1, CAST(N'2025-04-04T16:32:28.473' AS DateTime), CAST(N'2025-04-04T16:32:29.817' AS DateTime))
INSERT [dbo].[orders] ([id], [customer_id], [totalPrice], [status], [createdAt], [updatedAt]) VALUES (CAST(48 AS Numeric(19, 0)), CAST(12 AS Numeric(19, 0)), 300125, 1, CAST(N'2025-04-04T16:39:01.037' AS DateTime), CAST(N'2025-04-04T16:39:02.093' AS DateTime))
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
/****** Object:  Index [UQ__bill__4659622883EB747D]    Script Date: 3/28/2025 9:33:52 PM ******/
ALTER TABLE [dbo].[bill] ADD  CONSTRAINT [UQ__bill__4659622883EB747D] UNIQUE NONCLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__book__99F9D0A4C328A535]    Script Date: 3/28/2025 9:33:52 PM ******/
ALTER TABLE [dbo].[book] ADD  CONSTRAINT [UQ__book__99F9D0A4C328A535] UNIQUE NONCLUSTERED 
(
	[isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__cart__CD65CB84CC3937A1]    Script Date: 3/28/2025 9:33:52 PM ******/
ALTER TABLE [dbo].[cart] ADD  CONSTRAINT [UQ__cart__CD65CB84CC3937A1] UNIQUE NONCLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__customer__AB6E61642C1B26B7]    Script Date: 3/28/2025 9:33:52 PM ******/
ALTER TABLE [dbo].[customer] ADD  CONSTRAINT [UQ__customer__AB6E61642C1B26B7] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__customer__B43B145F3AC49898]    Script Date: 3/28/2025 9:33:52 PM ******/
ALTER TABLE [dbo].[customer] ADD  CONSTRAINT [UQ__customer__B43B145F3AC49898] UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_order_id] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_order_id]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_customer_id] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_customer_id]
GO
ALTER TABLE [dbo].[cart_detail]  WITH CHECK ADD  CONSTRAINT [FK_cart_detail_book_id] FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([id])
GO
ALTER TABLE [dbo].[cart_detail] CHECK CONSTRAINT [FK_cart_detail_book_id]
GO
ALTER TABLE [dbo].[cart_detail]  WITH CHECK ADD  CONSTRAINT [FK_cart_detail_cart_id] FOREIGN KEY([cart_id])
REFERENCES [dbo].[cart] ([id])
GO
ALTER TABLE [dbo].[cart_detail] CHECK CONSTRAINT [FK_cart_detail_cart_id]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [order_detail_book_id] FOREIGN KEY([book_id])
REFERENCES [dbo].[book] ([id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [order_detail_book_id]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [order_detail_order_id] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [order_detail_order_id]
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD  CONSTRAINT [FK_orders_customer_id] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([id])
GO
ALTER TABLE [dbo].[orders] CHECK CONSTRAINT [FK_orders_customer_id]
GO
USE [master]
GO
ALTER DATABASE [BookStore] SET  READ_WRITE 
GO
