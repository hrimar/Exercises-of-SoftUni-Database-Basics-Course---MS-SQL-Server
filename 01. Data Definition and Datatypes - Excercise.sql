--РЕШЕНИЯ - Data Definition and Datatypes

--04. Insert Records in Both Tables
INSERT INTO Towns(Id, Name)
VALUES(1, 'Sofia'), 
(2, 'Plovdiv'), 
(3, 'Varna')
INSERT INTO Minions(Id, Name, Age, TownId)
VALUES(1, 'Kevin', 22, 1), 
(2, 'Bob', 15, 3), 
(3, 'Steward', NULL, 2)

--07. Create Table People
CREATE TABLE People (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name VARCHAR(200) NOT NULL,
Picture VARBINARY(max),
Height DECIMAL(5,2),
Weight DECIMAL(5,2),
Gender CHAR(1) NOT NULL,
Birthdate DATE NOT NULL,
Biography VARCHAR(MAX)
)
INSERT INTO People(Name, Height, Weight, Gender, Birthdate)
VALUES 
('Kevin', 2.10, 91.02, 'f', '1999-11-10'), 
('Omo', 1.11, 91.05, 'f',  '1959-11-10'), 
('Ken', 2.18, 81.02, 'm',  '1994-12-11'), 
('Dino', 1.10, 71.22, 'f', '1994-12-11'), 
('Pipi', 2.22, 51.33, 'm', '1994-12-11')

--08. Create Table Users
CREATE TABLE Users (
Id BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Username NVARCHAR(30) NOT NULL,
Password NVARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(max),
LastLoginTime datetime,
IsDeleted bit
)
INSERT INTO Users(Username, Password)
VALUES 
('Kevin', '1234567891234567891234567'), 
('Omo',   '1234567891234567891234568'), 
('Kenito','1234567891234567891234578'), 
('Dino',  '1234567891234567891234678'), 
('Pipi',  '1234567891234567891235678')

--Problem 9.	Change Primary Key
ALTER TABLE Users
DROP PK_......
ALTER TABLE Users
ADD PRIMARY KEY (Id, Username)

--Problem 10.	Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CH_PasswordLenght CHECK (LEN(Password)>= 5)

----Problem 11.	Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT CH_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

--12 Set Unique Field !
ALTER TABLE Users
DROP CONSTRAINT PK_Users

ALTER TABLE Users
ADD CONSTRAINT PK_UserId PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE(Username)

ALTER TABLE Users
ADD CONSTRAINT CH_User CHECK(LEN(Username) >= 3)


--13. Movies Database - Тъпа задача
--CREATE DATABASE Movies
CREATE TABLE Directors (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DirectorName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)
CREATE TABLE Genres (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
GenreName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)
CREATE TABLE Categories (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
CategoryName VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)
CREATE TABLE Movies (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Title VARCHAR(50) NOT NULL,
DirectorId INT NOT NULL,
CopyrightYear INT,
Length DECIMAL(15,2), 
GenreId INT NOT NULL,
CategoryId INT NOT NULL,
Rating INT,
Notes VARCHAR(MAX)
)
INSERT INTO Directors(DirectorName)
VALUES ('Tom'), ('Rob'), ('Chuck'), ('Poll'), ('Moni Storano')
INSERT INTO Genres(GenreName)
VALUES ('Comedy'), ('Horror'), ('Dram'), ('Music'), ('Action')
INSERT INTO Categories(CategoryName)
VALUES ('Short'), ('Long'),('Ducumental'), ('New'), ('Clasic')
INSERT INTO Movies(Title, DirectorId, GenreId, CategoryId)
VALUES ('Funn Time', 1, 1, 2), ('Death is Comming', 2, 2, 2),
('Lave Story', 3, 3, 2), ('Kill Me', 2, 2, 1), ('Just Fun', 4, 1, 1)


--14. Car Rental Database
--CREATE DATABASE CarRental 
CREATE TABLE Categories (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
CategoryName VARCHAR(50) NOT NULL,
DailyRate DECIMAL(15,2),
WeeklyRate DECIMAL(15,2),
MounthlyRate DECIMAL(15,2),
WeekendRate DECIMAL(15,2)
)
CREATE TABLE Cars (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
PlateNumber VARCHAR(50) NOT NULL,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL,
CarYear INT,
CategoryId INT NOT NULL,
Doors INT,
Picture VARBINARY(max),
Condition VARCHAR(50),
Available bit
)
CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
FirstName VARCHAR(40) NOT NULL,
LastName VARCHAR(40) NOT NULL,
Title VARCHAR(50),
Notes VARCHAR(MAX)
)
CREATE TABLE Customers (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
DriverLicenceNumber VARCHAR(20) NOT NULL,
FullName VARCHAR(40) NOT NULL,
Address VARCHAR(200) NOT NULL,
City VARCHAR(20) NOT NULL,
ZIPCode INT ,
Notes VARCHAR(MAX)
)
CREATE TABLE RentalOrders (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
EmployeeId INT NOT NULL, 
CustomerId INT NOT NULL, 
CarId INT NOT NULL, 
TankLevel INT, 
KilometrageStart DECIMAL(15,2), 
KilometrageEnd DECIMAL(15,2), 
TotalKilometrage DECIMAL(15,2), 
StartDate DATE, 
EndDate DATE, 
TotalDays INT, 
RateApplied DECIMAL(15,2),  
TaxRate DECIMAL(15,2), 
OrderStatus bit, 
Notes VARCHAR(MAX)
)
INSERT INTO Categories(CategoryName)
VALUES ('Car'), ('Minivan'), ('Jip')
INSERT INTO Cars(PlateNumber, Manufacturer, Model, CategoryId)
VALUES ('S2564HO', 'Reno', 'Megane', 1), ('AS2564HH', 'Opel', 'Corsa', 1), 
('SS2564HH', 'Opel', 'Vectra', 1)
INSERT INTO Employees(FirstName, LastName)
VALUES ('Niko', 'Reno'), ('Tony', 'Otton'), 
('Sammy', 'Jaxson')
INSERT INTO Customers(DriverLicenceNumber, FullName, Address, City)
VALUES ('AZ54564654', 'Niko Reno', 'Alabuma BLVD 259', 'Torino'), 
('OZ54564650', 'Sammy Jaxson', 'Lino Alabuma BLVD 2', 'Moscwa'), 
('AZO4564654', 'Niko Reno', 'Alabuma BLVD 259', 'Torino')
INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId)
VALUES (1, 1, 2), (1, 2, 2), (2, 1, 1)


--15. Hotel Database 
--CREATE DATABASE Hotel 
--USE Hotel
CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
FirstName VARCHAR(40) NOT NULL,
LastName VARCHAR(40) NOT NULL,
Title VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)
INSERT INTO Employees(FirstName, LastName, Title)
VALUES ('Hrisi', 'Nany', 'Receptionist'),('Kris', 'Doris', 'Receptionist'), ('Tom', 'Soer', 'Receptionist')

CREATE TABLE Customers (
AccountNumber INT PRIMARY KEY NOT NULL,
FirstName VARCHAR(40) NOT NULL,
LastName VARCHAR(40) NOT NULL,
PhoneNumber VARCHAR(20) NOT NULL,
EmergencyName VARCHAR(40),
EmergencyNumber varchar(20),
Notes VARCHAR(MAX)
)
INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber)
VALUES (7821789, 'Toto', 'Cotuno', '+359222457'), 
(7821780, 'Tony', 'Cony', '+359222525'), 
(7821089, 'Tor', 'Cotor', '+35922240001')

CREATE TABLE RoomStatus (
RoomStatus varchar(40) PRIMARY KEY NOT NULL,
Notes VARCHAR(MAX)
)
INSERT INTO RoomStatus(RoomStatus)
VALUES ('Prepeared'), ('Not Prepeared'), ('Prepearing')

CREATE TABLE RoomTypes (
RoomType VARCHAR(20) PRIMARY KEY NOT NULL,
Notes VARCHAR(MAX)
)
INSERT INTO RoomTypes(RoomType)
VALUES ('apartment'), ('double'), ('single')

CREATE TABLE BedTypes (
BedType VARCHAR(20) PRIMARY KEY NOT NULL,
Notes VARCHAR(MAX)
)
INSERT INTO BedTypes(BedType)
VALUES ('King size'), ('Normal size'), ('Baby size')

CREATE TABLE Rooms (
RoomNumber INT PRIMARY KEY NOT NULL,
RoomType VARCHAR(20) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
BedType VARCHAR(20) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
Rate DECIMAL(15,2) NOT NULL,
RoomStatus varchar(40) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
Notes VARCHAR(MAX)
)
INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus)
VALUES (101, 'apartment', 'King size', 202.00, 'Not Prepeared'), 
(102, 'single', 'Normal size', 102.00, 'Not Prepeared'), 
(103, 'apartment', 'King size', 202.22, 'Prepeared')

CREATE TABLE Payments (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
PaymentDate DATE  NOT NULL,
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
FirstDateOccupied DATE  NOT NULL,
LastDateOccupied DATE  NOT NULL,
TotalDays INT  NOT NULL,
AmountCharged DECIMAL(15,2)  NOT NULL,
TaxRate DECIMAL(15,2)  NOT NULL,
TaxAmount DECIMAL(15,2)  NOT NULL,
PaymentTotal DECIMAL(15,2)  NOT NULL,
Notes VARCHAR(MAX)
)
INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, 
FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, 
TaxRate, TaxAmount, PaymentTotal)
VALUES 
(1, '2016-07-08', 7821789, '2016-07-08', '2016-07-10', 2, 100, 0.2, 20, 100.00),
(2, '2016-08-08', 7821789, '2016-08-08', '2016-08-10', 2, 120, 0.2, 24, 120.00),
(3, '2016-09-08', 7821089, '2016-09-08', '2016-09-10', 2, 90, 0.2, 18, 90.00)

CREATE TABLE Occupancies (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
EmployeeId INT  FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
DateOccupied DATE NOT NULL, 
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL, 
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL, 
RateApplied  DECIMAL(15,2) NOT NULL, 
PhoneCharge  DECIMAL(15,2) NOT NULL,
Notes VARCHAR(MAX)
)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge)
VALUES 
(1, '2016-07-08', 7821789, 101, 0.1, 10.50),
(2, '2016-08-08', 7821789, 102, 0.15, 8.60),
(3, '2016-09-08', 7821089, 103, 0.05, 5.33)


--Problem 16.	Create SoftUni Database
--CREATE DATABASE SoftUni 
--USE SoftUni
CREATE TABLE Towns (
Id INT  IDENTITY(1,1) NOT NULL,
Name VARCHAR(50) NOT NULL
)
CREATE TABLE Addresses (
Id INT  IDENTITY(1,1) NOT NULL,
AddressText VARCHAR(100) NOT NULL,
TownId INT NOT NULL
)
CREATE TABLE Departments (
Id INT  IDENTITY(1,1) NOT NULL,
Name VARCHAR(50) NOT NULL
)
CREATE TABLE Employees (
Id INT  IDENTITY(1,1) NOT NULL,
FirstName VARCHAR(40) NOT NULL,
MiddleName VARCHAR(40),
LastName VARCHAR(40) NOT NULL,
JobTitle VARCHAR(50) NOT NULL,
DepartmentId INT NOT NULL,
HireDate Date,
Salary DECIMAL(15, 2),
AddressId INT 
)
ALTER TABLE Towns
ADD Constraint PK_Towns PRIMARY KEY (Id)
ALTER TABLE Addresses
ADD Constraint PK_Addresses PRIMARY KEY (Id)
ALTER TABLE Departments
ADD Constraint PK_Departments PRIMARY KEY (Id)
ALTER TABLE Employees
ADD Constraint PK_Employees PRIMARY KEY (Id)

ALTER TABLE Employees
ADD Constraint FK_Employees_Departments
FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
ALTER TABLE Employees
ADD Constraint FK_Employees_Adresses
FOREIGN KEY (AddressId) REFERENCES Addresses(Id)
ALTER TABLE Addresses
ADD Constraint FK_Addresses_Towns
FOREIGN KEY (TownId) REFERENCES Towns(Id) 

--18
INSERT INTO Towns(Name)
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas')

INSERT INTO Departments(Name)
VALUES ('Engineering'), ('Sales'), ('Marceting'), ('Software Development'), ('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),  
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00), 
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25), 
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

--19. Basic Select All Fields
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--20. Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY Name
SELECT * FROM Departments
ORDER BY Name
SELECT * FROM Employees
ORDER BY Salary DESC

--21. Basic Select Some Fields
SELECT Name FROM Towns
ORDER BY Name
SELECT Name FROM Departments
ORDER BY Name
SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--22. Increase Employees Salary - Да се увеличи заплатата с 10%
UPDATE Employees
SET Salary = Salary +Salary*0.10
SELECT Salary FROM Employees

--23. Decrease Tax Rate
UPDATE Payments
SET TaxRate=TaxRate-(TaxRate*0.03)
SELECT TaxRate FROM Payments

--24. Delete All Records
TRUNCATE TABLE Occupancies
