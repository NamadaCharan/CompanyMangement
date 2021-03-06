USE [master]
GO
/****** Object:  Database [CompanyManagementDB]    Script Date: 11/8/2020 12:04:56 PM ******/
CREATE DATABASE [CompanyManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CompanyManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CompanyManagementDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CompanyManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CompanyManagementDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CompanyManagementDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CompanyManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CompanyManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CompanyManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CompanyManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CompanyManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CompanyManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CompanyManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CompanyManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [CompanyManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CompanyManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CompanyManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CompanyManagementDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CompanyManagementDB]
GO
/****** Object:  StoredProcedure [dbo].[prcAddCompanyDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[prcAddCompanyDetails]
  (
  @companyName nvarchar(150),
  @address nvarchar(150),
  @city nvarchar(50),
  @state nvarchar(50)
  )
  as 
  begin
  insert into tblCompanyDetails (CompanyName,Address,City,State) Values (@companyName,@address,@city,@state)
  end
GO
/****** Object:  StoredProcedure [dbo].[prcAddorUpdateProductItems]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[prcAddorUpdateProductItems] 
  (@UserId int, @ProductId int,@NoOfItems int)
   as

  begin 

 Declare @ExistingItem int
select @ExistingItem=1 from tblItems  where UserId=@UserId and ProductId=@ProductId

 if(@ExistingItem =1)
 begin
 update tblItems 
 set NoOfItems=@NoOfItems
 where UserId=@UserId and ProductId=@ProductId
 end
 else
 begin
 insert into tblItems(UserId,ProductId,NoOfItems)
 values(@UserId,@ProductId,@NoOfItems)
 end
  end
GO
/****** Object:  StoredProcedure [dbo].[prcAdduserContactDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [dbo].[prcAdduserContactDetails](


  @FullName nvarchar(100),

  @Email nvarchar(200),

  @Mobile nvarchar(20),

  @GenderId int,

  @ComapanyId int

  )

as

  begin


BEGIN TRY

  Insert into tblContactDetails values (@FullName,@Email,@Mobile,@GenderId,@ComapanyId)
  end try
  begin catch
  RAISERROR('Error In Inseting',16,1) 
 end catch

  end
GO
/****** Object:  StoredProcedure [dbo].[prcCheckDuplicateForCompanyPhone]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcCheckDuplicateForCompanyPhone] 
(@companyId int,
@phoneNumber nvarchar(150)=null)
as 
begin


select * from tblContactDetails where upper(Mobile)=upper(@phoneNumber) and CompanyId=@companyId

end
GO
/****** Object:  StoredProcedure [dbo].[prcGetContactDetailsById]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcGetContactDetailsById]
(@companyId as int)
as 
begin

select * from tblContactDetails where CompanyId=@companyId
end
GO
/****** Object:  StoredProcedure [dbo].[prcGetProductDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create proc [dbo].[prcGetProductDetails]
  as 
  begin
  SELECT *
  FROM tblProducts
  end
GO
/****** Object:  StoredProcedure [dbo].[prcGetProductDetailsForChats]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[prcGetProductDetailsForChats] 
(@CompanyId int)
as 
begin

select distinct   tp.ProductName,
sum(ti.NoOfItems) over(Partition by ti.ProductId) as NoOfItems
from tblItems ti join tblContactDetails tc on 
ti.UserId=tc.UserId join tblCompanyDetails tcd on tc.CompanyId=tcd.CompanyId
join tblProducts tp on ti.ProductId=tp.ProductId
where tcd.CompanyId=@CompanyId


end
GO
/****** Object:  StoredProcedure [dbo].[prcGetStatusCode]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[prcGetStatusCode]
as
begin
select * from tblStatusCode
end
GO
/****** Object:  StoredProcedure [dbo].[prcSelCompanyDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[prcSelCompanyDetails] 

@CompanyId as int=0

as

begin



if @CompanyId<>0

begin

select 

CompanyId,

CompanyName,

[Address],

City,

[State],

tblCompanyDetails.StatusId

from tblCompanyDetails 

where CompanyId=@CompanyId

end

else

begin

select 

CompanyId,

CompanyName,

[Address],

City,

[State],

tblCompanyDetails.StatusId

from tblCompanyDetails 



end



end
GO
/****** Object:  StoredProcedure [dbo].[prcUpdateStatusCode]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [dbo].[prcUpdateStatusCode]
  (
  @companyId as int,
  @changeStatusId as int
  )
  as
  begin
  if (@companyId <>0 and @changeStatusId<>0)
  begin

  Begin try
    begin transaction
  update tblCompanyDetails
  set StatusId=@changeStatusId
  where CompanyId=@companyId
  commit transaction
  end try
  begin catch
  RAISERROR ( 'Errror in Updating the Status',16,1)
  rollback transaction
  end catch
  end
  end
GO
/****** Object:  Table [dbo].[tblCompanyDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCompanyDetails](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](150) NULL,
	[Address] [nvarchar](150) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[StatusId] [int] NULL,
 CONSTRAINT [PK_tblCompanyDetails] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblContactDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblContactDetails](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[Email] [nvarchar](200) NULL,
	[Mobile] [nvarchar](50) NULL,
	[GenderId] [int] NULL,
	[CompanyId] [int] NULL,
 CONSTRAINT [PK_tblContactDetails] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblGenderDetails]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblGenderDetails](
	[Id] [int] NOT NULL,
	[Gender] [nvarchar](10) NULL,
 CONSTRAINT [PK_tblGenderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblItems]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblItems](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ProductId] [int] NULL,
	[NoOfItems] [int] NULL,
 CONSTRAINT [PK_tblItems] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProducts]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProducts](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductCost] [money] NULL,
 CONSTRAINT [PK_tblProducts] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblStatusCode]    Script Date: 11/8/2020 12:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatusCode](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusDescription] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblStatusCode] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblCompanyDetails] ON 

INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (1, N'Test', NULL, NULL, NULL, 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (2, N'Test1', N'Test3', N'Yo', N'Aus', 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (5, N'test2', N'', N'', N'', 8)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (6, N'test3', N'', N'', N'', 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (7, N'test4', N'', N'', N'', 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (8, N'Test5', N'', N'', N'', 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (9, N'test6', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (10, N'Test9', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (11, N'Test10', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (12, N'Test1111', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (13, N'test123', N'', N'', N'', 3)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (14, N'ABCCompany', N'123 Street', N'NewYork', N'USA', 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (15, N'1', N'', N'', N'', 3)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (16, N'123', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (17, N'345', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (18, N'1223', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (19, N'qww', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (20, N'Er', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (21, N'qw', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (22, N'23', N'', N'', N'', 7)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (23, N'aa', N'', N'', N'', 8)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (24, N'aa', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (25, N'Test', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (26, N'1', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (27, N'9', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (28, N'11', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (29, N'11', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (30, N'1', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (31, N'11', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (32, N'111', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (33, N'qqq', N'', N'', N'', 1)
INSERT [dbo].[tblCompanyDetails] ([CompanyId], [CompanyName], [Address], [City], [State], [StatusId]) VALUES (34, N'Test4', N'', N'', N'', 7)
SET IDENTITY_INSERT [dbo].[tblCompanyDetails] OFF
SET IDENTITY_INSERT [dbo].[tblContactDetails] ON 

INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (1, N'Test', N'Namadasaicharan@gmail.com', N'111111111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (2, N'Test', N'Namadasaicharan@gmail.com', N'11111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (3, N'Test', N'NamadaSaicharan@gmail.com', N'1111111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (4, N'123', N'123443', N'11111111', 1, 2)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (5, N'N Sai Charan', N'NamadaSaicharan@gmail.com', N'1111111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (6, N'test', N'namadasaicharan@gmail.com', N'1111111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (9, N'Test1234', N'', N'11111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (10, N'TestName', N'', N'11111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (11, N'Gokul', N'', N'1111111111', 1, 7)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (12, N'testyoyo', N'Namadasaicharan@gmail.com', N'111111111111', 1, 2)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (13, N'Test1234', N'', N'1111111111', 1, 2)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (14, N'test12345', N'', N'11111111', 1, 2)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (15, N'eqrqrqrq', N'', N'11111111', 1, 23)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (16, N'11', N'', N'111111111', 1, 1)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (17, N'11', N'', N'11111111', 1, 2)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (18, N'111', N'', N'111111111', 1, 6)
INSERT [dbo].[tblContactDetails] ([UserId], [FullName], [Email], [Mobile], [GenderId], [CompanyId]) VALUES (19, N'11111111', N'', N'111111111', 1, 7)
SET IDENTITY_INSERT [dbo].[tblContactDetails] OFF
INSERT [dbo].[tblGenderDetails] ([Id], [Gender]) VALUES (1, N'Male')
INSERT [dbo].[tblGenderDetails] ([Id], [Gender]) VALUES (2, N'Female')
INSERT [dbo].[tblGenderDetails] ([Id], [Gender]) VALUES (3, N'Others')
SET IDENTITY_INSERT [dbo].[tblItems] ON 

INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (1, 1, 1, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (2, 2, 1, 2)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (3, 1, 3, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (4, 2, 2, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (5, 9, 3, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (6, 10, 2, 2)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (7, 10, 4, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (8, 14, 2, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (9, 13, 3, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (10, 15, 2, 233)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (11, 1, 4, 2)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (12, 1, 2, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (13, 4, 2, 1)
INSERT [dbo].[tblItems] ([ItemId], [UserId], [ProductId], [NoOfItems]) VALUES (14, 4, 1, 1)
SET IDENTITY_INSERT [dbo].[tblItems] OFF
SET IDENTITY_INSERT [dbo].[tblProducts] ON 

INSERT [dbo].[tblProducts] ([ProductId], [ProductName], [ProductCost]) VALUES (1, N'Tin', 22.2200)
INSERT [dbo].[tblProducts] ([ProductId], [ProductName], [ProductCost]) VALUES (2, N'Copper', 20.0000)
INSERT [dbo].[tblProducts] ([ProductId], [ProductName], [ProductCost]) VALUES (3, N'Gold', 700.0000)
INSERT [dbo].[tblProducts] ([ProductId], [ProductName], [ProductCost]) VALUES (4, N'Silver', 350.0000)
SET IDENTITY_INSERT [dbo].[tblProducts] OFF
SET IDENTITY_INSERT [dbo].[tblStatusCode] ON 

INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (1, N'Sales Lead')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (2, N'Sales Opportunity')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (3, N'Dead End')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (4, N'Initial discussion')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (5, N'Proposal')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (6, N'Negotiation ')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (7, N'Deal Won')
INSERT [dbo].[tblStatusCode] ([StatusId], [StatusDescription]) VALUES (8, N'Deal Lost')
SET IDENTITY_INSERT [dbo].[tblStatusCode] OFF
ALTER TABLE [dbo].[tblCompanyDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblCompanyDetails_tblStatusCode] FOREIGN KEY([StatusId])
REFERENCES [dbo].[tblStatusCode] ([StatusId])
GO
ALTER TABLE [dbo].[tblCompanyDetails] CHECK CONSTRAINT [FK_tblCompanyDetails_tblStatusCode]
GO
ALTER TABLE [dbo].[tblContactDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblContactDetails_tblCompanyDetails] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[tblCompanyDetails] ([CompanyId])
GO
ALTER TABLE [dbo].[tblContactDetails] CHECK CONSTRAINT [FK_tblContactDetails_tblCompanyDetails]
GO
ALTER TABLE [dbo].[tblContactDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblContactDetails_tblGenderDetails] FOREIGN KEY([GenderId])
REFERENCES [dbo].[tblGenderDetails] ([Id])
GO
ALTER TABLE [dbo].[tblContactDetails] CHECK CONSTRAINT [FK_tblContactDetails_tblGenderDetails]
GO
ALTER TABLE [dbo].[tblItems]  WITH CHECK ADD  CONSTRAINT [FK_tblItems_tblContactDetails] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblContactDetails] ([UserId])
GO
ALTER TABLE [dbo].[tblItems] CHECK CONSTRAINT [FK_tblItems_tblContactDetails]
GO
ALTER TABLE [dbo].[tblItems]  WITH CHECK ADD  CONSTRAINT [FK_tblItems_tblProducts1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProducts] ([ProductId])
GO
ALTER TABLE [dbo].[tblItems] CHECK CONSTRAINT [FK_tblItems_tblProducts1]
GO
USE [master]
GO
ALTER DATABASE [CompanyManagementDB] SET  READ_WRITE 
GO
