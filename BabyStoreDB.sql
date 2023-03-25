if exists (select * from sysdatabases where name='BabyStore')
begin
  raiserror('Dropping existing BabyStore database ....',0,1)
  DROP database BabyStore
end
GO

CHECKPOINT
go

raiserror('Creating BabyStore database....',0,1)
go
   CREATE DATABASE BabyStore
GO

/*Creating table*/
raiserror('Creating Table Product....',0,1)
create table Product

(
	ProId nvarchar(4) primary key not null,
	ProName nvarchar(100) not null,
	ProBrand nvarchar(10) not null,
	ProType nvarchar(20) not null,
	Price float not null,
	Sale float,
	Stock float,
	AgeGroup nvarchar(10),
	Size nvarchar(10),
	Color nvarchar(10),
)
go

raiserror('Creating Table User....',0,1)
create table tblUser

(
	userID nvarchar(10) primary key,
	username nvarchar(20) not null,
	password char(60) not null,
	role nvarchar(2) not null,
	email nvarchar(100),
	phone varchar(11),
	userAddress varchar(100),
)
go


raiserror('Creating Table Order....',0,1)
create table tblOrder

(
	orderId nvarchar(10) primary key,
	amount int,
	proId nvarchar(4),
	userId nvarchar(10),
	billDate date,
	foreign key(ProId) references Product(proId),
	foreign key(userId) references tblUser(userId),
)
go
/*
raiserror('Creating Table Detail....',0,1)
create table OrderDetail

(
	OrderId int,
	ProductId nvarchar(4) not null,
	Amount float not null,
	foreign key(OrderId) references ProOrder(OrderId),
	primary key(OrderId),
)
go
*/
drop table Product
drop table tblUser
drop table tblOrder
drop table OrderDetail
/*****************************************************/
-- Populating data into the tables
/********************/