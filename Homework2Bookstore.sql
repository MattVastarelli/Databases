CREATE DATABASE store

USE store

CREATE Table Books (
	isbn			varchar(15),
	currentPrice	money,
	bookDescription text,
	title			nvarchar(50),
	publisedDate	date,
	uniqueID		varchar(50) NOT NULL,
	CONSTRAINT PK_Books_uniqueID PRIMARY KEY CLUSTERED (uniqueID) 		
)

CREATE TABLE Suppliers (
	supplierName	nvarchar(50)	NOT NULL,
	CONSTRAINT PK_Suppliers_supplierName PRIMARY KEY CLUSTERED (supplierName)
)

CREATE TABLE Authors (
	firstPublishedYear	date,
	dateOfBirth			date,
	bio					text,
	penName				nvarchar(50),
	authorName			nvarchar(50) NOT NULL,
	contactInfo			nvarchar(25),
	CONSTRAINT PK_Authors_authorName PRIMARY KEY CLUSTERED (authorName) 
)

CREATE TABLE Publishers (
	publisherName	nvarchar(50) NOT NULL,
	CONSTRAINT PK_Publishers_publisherName PRIMARY KEY CLUSTERED (publisherName)
)

CREATE TABLE Formats (
	bookFormat	nvarchar(50),
	CONSTRAINT PK_Formats_bookFormat PRIMARY KEY CLUSTERED (bookFormat)
)

CREATE TABLE Costs (
	cost	money NOT NULL,
)

ALTER TABLE Costs
ADD bookID VARCHAR(50) NOT NULL;

ALTER TABLE Costs
ADD CONSTRAINT FK_Books_uniqueID FOREIGN KEY (bookID)
	REFERENCES Books (uniqueID)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE    
	;

ALTER TABLE Books
ADD author NVARCHAR(50) NOT NULL;

ALTER TABLE Books
ADD publisher NVARCHAR(50) NOT NULL;

ALTER TABLE Books
ADD formats NVARCHAR(50) NOT NULL;

ALTER TABLE Books
ADD supplier VARCHAR(50) NOT NULL;

ALTER TABLE Books
ADD costs money NOT NULL;

ALTER TABLE Books
ADD CONSTRAINT FK_Author_authorName FOREIGN KEY (author)
	REFERENCES Authors (AuthorName)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE    
	;

ALTER TABLE Books
ADD CONSTRAINT FK_Supplier_supplier FOREIGN KEY (Supplier)
	REFERENCES Suppliers (suppliername)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE    
	;

ALTER TABLE Books
ADD CONSTRAINT FK_Publisher_publisher FOREIGN KEY (publisher)
	REFERENCES Publishers (publisherName)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE    
	;
ALTER TABLE Books
ADD CONSTRAINT FK_Format_format FOREIGN KEY (formats)
	REFERENCES Formats (bookFormat)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE    
	;

ALTER TABLE Costs
ADD CONSTRAINT PK_Costs_Costs PRIMARY KEY CLUSTERED (costs);  

ALTER TABLE Books
ADD CONSTRAINT FK_Costs_costs FOREIGN KEY (costs)
	REFERENCES Costs (costs)     
    ON DELETE NO ACTION    
    ON UPDATE NO ACTION    
	;

ALTER TABLE Costs
ADD supplier VARCHAR(50) NOT NULL;

ALTER TABLE Costs
ADD CONSTRAINT FK_Supplier_suppliername FOREIGN KEY (Supplier)
	REFERENCES Suppliers (suppliername)     
    ON DELETE NO ACTION    
    ON UPDATE NO ACTION    
	;

ALTER TABLE Books
ADD margin AS (currentPrice - costs);
