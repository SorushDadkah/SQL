USE master
GO
DROP DATABASE Library
GO
CREATE DATABASE Library
GO
USE Library
GO

CREATE TABLE Book (
BookId int PRIMARY KEY NOT NULL, 
Title varchar(100) NOT NULL,
PublisherName varchar(100) NOT NULL
);

CREATE TABLE Publisher (
PublisherName varchar(100) PRIMARY KEY NOT NULL, 
Street varchar(50) NOT NULL,
City varchar(25) NOT NULL,
[State] varchar(2) NOT NULL
);

CREATE TABLE Book_Authors (
BookId int NOT NULL,
FirstName varchar(50) NULL,
LastName varchar(50) NOT NULL
);

CREATE TABLE Book_Copies (
BookId int NOT NULL,
BranchId int NOT NULL,
No_Of_Copies varchar(2) NULL
);

CREATE TABLE Book_Loans (
BookId int NOT NULL,
BranchId int NOT NULL,
CardNo varchar(20) NOT NULL,
DateOut DATE NULL,
DueDate DATE NULL
);

CREATE TABLE Borrower (
CardNo varchar(20) PRIMARY KEY NOT NULL,
FirstName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
Street varchar(50) NOT NULL,
City varchar(25) NOT NULL,
[State] varchar(2) NOT NULL,
ZipCode varchar(15) NOT NULL,
Phone varchar(20) NOT NULL
);

CREATE TABLE Library_Branch (
BranchId int PRIMARY KEY NOT NULL,
BranchName varchar(20) NOT NULL,
Street varchar(50) NOT NULL,
City varchar(25) NOT NULL,
[State] varchar(2) NOT NULL
);