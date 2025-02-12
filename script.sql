USE [master]
GO
/****** Object:  Database [Sistemas]    Script Date: 25/11/2020 14:54:59 ******/
CREATE DATABASE [Sistemas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sistemas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\Sistemas.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Sistemas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\Sistemas_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Sistemas] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sistemas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sistemas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sistemas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sistemas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sistemas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sistemas] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sistemas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sistemas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sistemas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sistemas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sistemas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sistemas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sistemas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sistemas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sistemas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sistemas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sistemas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sistemas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sistemas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sistemas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sistemas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sistemas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sistemas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sistemas] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sistemas] SET  MULTI_USER 
GO
ALTER DATABASE [Sistemas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sistemas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sistemas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sistemas] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Sistemas] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Sistemas]
GO
/****** Object:  Table [dbo].[Administradores]    Script Date: 25/11/2020 14:54:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Administradores](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](20) NULL DEFAULT (''),
	[Apellido] [varchar](20) NULL DEFAULT (''),
	[tDoc] [char](3) NULL DEFAULT ('DNI'),
	[Doc] [varchar](8) NULL DEFAULT (''),
	[Usuario] [varchar](10) NULL DEFAULT (''),
	[Pass] [varchar](10) NULL DEFAULT (''),
	[Activo] [bit] NULL DEFAULT ((1)),
	[Email] [varchar](70) NULL DEFAULT (''),
	[idProv] [tinyint] NULL DEFAULT ((1)),
	[Localidad] [varchar](25) NULL DEFAULT (''),
	[Direccion] [varchar](100) NULL DEFAULT (''),
	[Telefonos] [varchar](25) NULL DEFAULT (''),
	[FAlta] [datetime] NULL DEFAULT (getdate()),
	[fNacimiento] [date] NULL DEFAULT (getdate()),
 CONSTRAINT [PK_Administradores] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 25/11/2020 14:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](20) NULL DEFAULT (''),
	[Apellido] [varchar](20) NULL DEFAULT (''),
	[tDoc] [char](3) NULL DEFAULT ('DNI'),
	[Doc] [varchar](8) NULL DEFAULT (''),
	[Usuario] [varchar](10) NULL DEFAULT (''),
	[Pass] [varchar](10) NULL DEFAULT (''),
	[Activo] [bit] NULL DEFAULT ((1)),
	[Email] [varchar](70) NULL DEFAULT (''),
	[idProv] [tinyint] NULL DEFAULT ((1)),
	[Localidad] [varchar](25) NULL DEFAULT (''),
	[Direccion] [varchar](100) NULL DEFAULT (''),
	[Telefonos] [varchar](25) NULL DEFAULT (''),
	[FAlta] [datetime] NULL DEFAULT (getdate()),
	[fNacimiento] [date] NULL DEFAULT (getdate()),
	[Estado] [varchar](20) NOT NULL DEFAULT ('Activo'),
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WEB_Pedidos]    Script Date: 25/11/2020 14:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WEB_Pedidos](
	[NPedido] [int] IDENTITY(1,1) NOT NULL,
	[NUM_CLI] [int] NULL CONSTRAINT [DF_WEB_Pedidos_NUM_CLI]  DEFAULT ((0)),
	[Fecha] [datetime] NULL CONSTRAINT [DF_Table_1_fecha]  DEFAULT (getdate()),
	[Estado] [nchar](20) NULL CONSTRAINT [DF_WEB_Pedidos_Estado]  DEFAULT ('Solicitado'),
 CONSTRAINT [PK_WEB_Pedidos] PRIMARY KEY CLUSTERED 
(
	[NPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WEB_Pedidos_Detalle]    Script Date: 25/11/2020 14:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WEB_Pedidos_Detalle](
	[NItem] [int] IDENTITY(1,1) NOT NULL,
	[NPedido] [int] NULL CONSTRAINT [DF_WEB_Pedidos_Detalle_NPedido]  DEFAULT ((0)),
	[Item] [varchar](100) NULL CONSTRAINT [DF_WEB_Pedidos_Detalle_Item]  DEFAULT (''),
	[Cantidad] [int] NULL CONSTRAINT [DF_WEB_Pedidos_Detalle_Cantidad]  DEFAULT ((0)),
 CONSTRAINT [PK_WEB_Pedidos_Detalle] PRIMARY KEY CLUSTERED 
(
	[NItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Web_Pedidos_Temporal]    Script Date: 25/11/2020 14:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Web_Pedidos_Temporal](
	[NItem] [int] IDENTITY(1,1) NOT NULL,
	[Num_Cli] [int] NULL,
	[Item] [varchar](100) NULL,
	[Cantidad] [int] NULL,
 CONSTRAINT [PK_Web_Pedidos_Temporal] PRIMARY KEY CLUSTERED 
(
	[NItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Web_Productos]    Script Date: 25/11/2020 14:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Web_Productos](
	[Cod] [int] IDENTITY(1,1) NOT NULL,
	[Producto] [varchar](100) NULL CONSTRAINT [DF_Web_Productos_Producto]  DEFAULT (''),
	[Stock] [int] NULL,
	[PrecioSinIva] [money] NULL,
 CONSTRAINT [PK_Web_Productos] PRIMARY KEY CLUSTERED 
(
	[Cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Web_Pedidos_Temporal] ADD  CONSTRAINT [DF_Web_Pedidos_Temporal_Num_Cli]  DEFAULT ((0)) FOR [Num_Cli]
GO
ALTER TABLE [dbo].[Web_Pedidos_Temporal] ADD  CONSTRAINT [DF_Web_Pedidos_Temporal_Item]  DEFAULT ('') FOR [Item]
GO
ALTER TABLE [dbo].[Web_Pedidos_Temporal] ADD  CONSTRAINT [DF_Web_Pedidos_Temporal_Cantidad]  DEFAULT ((0)) FOR [Cantidad]
GO
USE [master]
GO
ALTER DATABASE [Sistemas] SET  READ_WRITE 
GO
