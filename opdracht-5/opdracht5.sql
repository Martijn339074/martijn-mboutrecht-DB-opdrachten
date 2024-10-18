-- Active: 1709293218818@@127.0.0.1@3306@agarofobie

DROP DATABASE if EXISTS BankSys;
CREATE DATABASE BankSys;
USE BankSys;

CREATE TABLE Bank (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    FoundationDate DATE NOT NULL,
    IsActive BIT DEFAULT 1 NOT NULL,
    Comment TEXT,
    DateCreated DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DateModified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Customer (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL, 
    Mobile VARCHAR(20) NOT NULL, 
    Email VARCHAR(100) NOT NULL, 
    IsActive BIT DEFAULT 1 NOT NULL,
    Comment TEXT,
    DateCreated DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    DateModified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE BankCustomer (
    BankId INT,
    CustomerId INT,
    FOREIGN KEY (BankId) REFERENCES Bank(Id),
    FOREIGN KEY (CustomerId) REFERENCES Customer(Id),
    PRIMARY KEY (BankId, CustomerId)
);

CREATE TABLE Account (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    IBAN VARCHAR(34) NOT NULL UNIQUE,
    AccountNumber VARCHAR(20) NOT NULL UNIQUE,
    AccountType VARCHAR(50) NOT NULL,
    Balance DECIMAL(15, 2) NOT NULL,
    OpeningDate DATE NOT NULL,
    CustomerId INT,
    BankId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customer(Id),
    FOREIGN KEY (BankId) REFERENCES Bank(Id)
);

INSERT INTO Bank (Name, PhoneNumber, Email, FoundationDate, IsActive) VALUES
('Global Bank', '+31201234567', 'info@globalbank.com', '1990-01-15', 1),
('City Finance', '+31202345678', 'support@cityfinance.com', '1985-07-22', 1),
('Dutch Savings', '+31203456789', 'contact@dutchsavings.com', '1998-03-10', 1),
('Euro Trust', '+31204567890', 'info@eurotrust.com', '2005-11-30', 1),
('National Credit', '+31205678901', 'service@nationalcredit.com', '1972-09-05', 1);

INSERT INTO Customer (FirstName, MiddleName, LastName, DateOfBirth, Mobile, Email, IsActive, Comment) VALUES
('Jan', NULL, 'de Vries', '1985-04-12', '+31612345678', 'jan@email.com', 1, NULL),
('Maria', 'van', 'Dijk', '1990-08-23', '+31623456789', 'maria@email.com', 1, NULL),
('Pieter', NULL, 'Jansen', '1978-11-05', '+31634567890', 'pieter@email.com', 1, NULL),
('Anna', NULL, 'Bakker', '1995-02-18', '+31645678901', 'anna@email.com', 1, NULL),
('Thomas', 'van der', 'Berg', '1982-06-30', '+31656789012', 'thomas@email.com', 1, NULL);

INSERT INTO BankCustomer (BankId, CustomerId) VALUES
(1, 1), (1, 2), (2, 2), (2, 3), (3, 3), (3, 4), (4, 4), (4, 5), (5, 5), (5, 1);

INSERT INTO Account (IBAN, AccountNumber, AccountType, Balance, OpeningDate, CustomerId, BankId) VALUES
('NL91ABNA0417164300', '417164300', 'Savings', 5000.00, '2020-01-15', 1, 1),
('NL39RABO0300065264', '300065264', 'Checking', 1500.50, '2019-07-22', 2, 2),
('NL18INGB0000001234', '000001234', 'Savings', 10000.75, '2018-03-10', 3, 3),
('NL86TRIO0788912689', '788912689', 'Checking', 2750.25, '2021-11-30', 4, 4),
('NL13ABNA0484869868', '484869868', 'Savings', 7500.00, '2017-09-05', 5, 5);

SELECT 
    CONCAT(c.FirstName, ' ', IFNULL(c.MiddleName, ''), ' ', c.LastName) AS FullName,
    c.DateOfBirth,
    c.Mobile,
    b.Name AS BankName,
    a.IBAN,
    a.AccountNumber,
    a.AccountType,
    a.Balance,
    a.OpeningDate
FROM 
    Customer c
JOIN 
    BankCustomer bc ON c.Id = bc.CustomerId
JOIN 
    Bank b ON bc.BankId = b.Id
JOIN 
    Account a ON c.Id = a.CustomerId AND b.Id = a.BankId;
