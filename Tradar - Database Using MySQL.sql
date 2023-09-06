-- TRADAR DATABASE --

-- drop database if already exist
DROP database tradar;

-- create database 
CREATE database tradar;

-- use database
USE tradar;

-- Create Tables 
CREATE table Employees(
	EmployeeID int not null primary key,
    LastName varchar(255) default null,
    FirstName varchar(255) default null,
    BirthDate date default null,
    Photo varchar(255) default null,
    Notes Text
);

CREATE table Customers (
	CustomerID int not null primary key,
    CustomerName varchar(255) default null,
    ContactName varchar(255) default null,
    Address varchar(255) default null,
    City varchar(255) default null,
    PostalCode varchar(255) default null,
    Country varchar(255) default null
);

CREATE table Shippers(
	ShipperID int not null primary key,
    ShipperName varchar(255) default null,
    Phoen varchar(255) default null
);

CREATE table Orders (
	OrderID int not null primary key,
    CustomerID int default null,
    EmployeeID int default null,
    OrderDate date default null,
    ShipperID int default null
);

CREATE table Categories (
	CategoryID int not null primary key,
    CategoryName varchar(255) default null,
    Description varchar(255) default null
);

CREATE table Suppliers (
	SupplierID int not null primary key,
    SupplierName varchar(255) default null,
    ContactName varchar(255) default null,
    Address varchar(255) default null,
    City varchar(255) default null,
    PostalCode varchar(255) default null,
    Country varchar(255) default null,
    Phone varchar(255) default null
);

CREATE table Products (
	ProductID int not null primary key,
    ProductName varchar(255) default null,
    SupplierID int default null,
    CategoryID int default null,
    Unit varchar(255) default null,
    Price double default null
);

CREATE table Order_Details(
	OrderDetailsID int not null primary key,
    OrderID int default null,
    ProductID int default null,
    Quantity int default null
);

-- ADD INDEX TO TABLES

ALTER table order_details
add key OrderID(OrderID),
add key ProductID(ProductID);

ALTER table orders
add key CustomerID(CustomerID),
add key EmployeeID(EmployeeID),
add key ShipperID(ShipperID);

ALTER table products 
add key SupplierID(SupplierID),
add key CategoryID(CategoryID);

-- ADD FOREIGN KEY TO TABLES 

ALTER table order_details
add constraint foreign key (OrderID) references orders(OrderID),
add constraint foreign key (ProductID) references products(ProductID);

ALTER table orders 
add constraint foreign key (CustomerID) references customers(CustomerID),
add constraint foreign key (EmployeeID) references employees(EmployeeID),
add constraint foreign key (ShipperID) references shippers(ShipperID);

ALTER table products 
add constraint foreign key (SupplierID) references suppliers(SupplierID),
add constraint foreign key (CategoryID) references categories(CategoryID);