CREATE DATABASE Gravity_Books_DWH;
GO

USE Gravity_Books_DWH;
GO

SELECT *
INTO Dim_Date
FROM Sales_DWH.dbo.Dim_Date;

SELECT *
INTO Dim_Time
FROM Sales_DWH.dbo.Dim_Time;

ALTER TABLE Dim_Time
ADD CONSTRAINT PK_Dim_Time PRIMARY KEY (Time_SK);

ALTER TABLE Dim_Date
ADD CONSTRAINT PK_Dim_Date PRIMARY KEY (Date_SK);

CREATE TABLE DimBook (
    Book_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    Book_PK_BK INT,
    title VARCHAR(500),
    isbn13 VARCHAR(40),
    language_id_PK_BK INT,
    num_pages INT,
    publication_date DATE,
    publisher_id_PK_BK INT,
    publisher_name NVARCHAR(400),
    language_code VARCHAR(30),
    language_name VARCHAR(200),
    St_Date DATE,
    End_Date DATE,
    Is_Current BIT,
      ssc INT
);

CREATE TABLE DimAuthor (
    Author_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    Author_PK_BK INT,
    Author_name VARCHAR(255),
    St_Date DATE,
    End_Date DATE,
    Is_Current BIT
    ,  ssc INT
);

CREATE TABLE Dim_Book_Author (
    Book_PK_SK INT,
    Author_PK_SK INT,
    PRIMARY KEY (Book_PK_SK, Author_PK_SK)
);

CREATE TABLE DimCustomer (
    Customer_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    Customer_PK_BK INT,
    first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(400),
    St_Date DATE,
    End_Date DATE,
    Is_Current BIT
    ,  ssc INT
);

CREATE TABLE Dim_Customer_Address (
    FK_Address_id_SK INT,
    FK_Customer_ID_SK INT,
    PRIMARY KEY (FK_Address_id_SK, FK_Customer_ID_SK)
);

CREATE TABLE DimAddress (
    Address_id_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    Address_PK_BK INT,
    street_number VARCHAR(150),
    street_name VARCHAR(300),
    city VARCHAR(300),
    country_id_BK INT,
    country_name VARCHAR(200),
    address_status VARCHAR(100),
    St_Date DATE,
    End_Date DATE,
    Is_Current BIT
    ,  ssc INT
);

CREATE TABLE DimOrder (
    OrderID_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    OrderID_PK_BK INT,
    order_date DATE,
    method_id_PK_BK INT,
    method_name VARCHAR(200),
    St_Date DATE,
    End_Date DATE,
    Is_Current BIT,
      ssc INT
);

CREATE TABLE DimOrderHistory (
    History_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    History_PK_BK INT,
    Status_ID_PK_BK INT,
    status_value VARCHAR(200),
    status_date DATE,
    St_Date DATE,
    End_Date DATE,
    Is_Current BIT ,
      ssc INT
);

CREATE TABLE FactSales (
    Fact_Sales_PK_SK INT IDENTITY(1,1) PRIMARY KEY,
    Book_PK_SK_FK INT,
    History_PK_SK_FK INT,
    Order_ID_PK_SK_FK INT,
    Customer_PK_SK_FK INT,
    Time_SK_FK INT,
    Date_SK_FK INT,
    LineID_PK_BK INT,
    price DECIMAL(15,2),
    cost_shipping DECIMAL(15,2),
    ssc INT
);

ALTER TABLE FactSales ADD FOREIGN KEY (Customer_PK_SK_FK) REFERENCES DimCustomer(Customer_PK_SK);
ALTER TABLE FactSales ADD FOREIGN KEY (Book_PK_SK_FK) REFERENCES DimBook(Book_PK_SK);
ALTER TABLE FactSales ADD FOREIGN KEY (History_PK_SK_FK) REFERENCES DimOrderHistory(History_PK_SK);
ALTER TABLE FactSales ADD FOREIGN KEY (Order_ID_PK_SK_FK) REFERENCES DimOrder(OrderID_PK_SK);
ALTER TABLE FactSales ADD FOREIGN KEY (Time_SK_FK) REFERENCES Dim_Time(Time_SK);
ALTER TABLE FactSales ADD FOREIGN KEY (Date_SK_FK) REFERENCES Dim_Date(Date_SK);
ALTER TABLE DimBook
ALTER COLUMN publisher_name NVARCHAR(1000);

ALTER TABLE Dimauthor
ALTER COLUMN author_name VARCHAR(1000);
ALTER TABLE DimAddress DROP COLUMN address_status;

ALTER TABLE Dim_Customer_Address 
ADD address_status VARCHAR(250),
    status_id_PK_BK INT;