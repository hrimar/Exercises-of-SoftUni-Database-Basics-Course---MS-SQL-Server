--Exercises: Table Relations

--Problem 1.	One-To-One Relationship
-- Мисли коя табл да е Парент и коя чаилд!

CREATE TABLE Passports(
PassportID INT PRIMARY KEY IDENTITY(101, 1)  NOT NULL,
PassportNumber CHAR(8)  NOT NULL
)
CREATE TABLE Persons(
PersonID INT  IDENTITY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
Salary DECIMAL(15,2) NOT NULL,
PassportID INT UNIQUE NOT NULL,
CONSTRAINT FK_Persons_Passports
FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID)
)
ALTER TABLE Persons
ADD PRIMARY KEY(PersonID)


--Problem 2.	One-To-Many Relationship
CREATE TABLE Manufacturers (
ManufacturerID int PRIMARY KEY IDENTITY NOT NULL,
Name VARCHAR(50) NOT NULL,
EstablishedOn DATE
)

CREATE TABLE Models
(
ModelID int PRIMARY KEY IDENTITY NOT NULL,
Name VARCHAR(50) NOT NULL,
ManufacturerID INT,
CONSTRAINT FK_Models_Manufacturers
FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)
)

--03. Many-To-Many Relationship
CREATE TABLE Students (
StudentID int PRIMARY KEY IDENTITY NOT NULL,
Name VARCHAR(50) NOT NULL
)

CREATE TABLE Exams
(
ExamID int PRIMARY KEY IDENTITY NOT NULL,
Name VARCHAR(50) NOT NULL
)

CREATE TABLE StudentsExams
(
StudentID int,
ExamID int,
CONSTRAINT PK_StudentsExams
PRIMARY KEY (StudentID, ExamID),
CONSTRAINT FK_StudentsExams_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID),
CONSTRAINT FK_StudentsExams_Exams
FOREIGN KEY (ExamID)
REFERENCES Exams(ExamID)
)



INSERT INTO Students(Name)
VALUES ('Miva'), ('Toni'), ('Ron')

INSERT INTO Exams(Name)
VALUES ('SpringMVC'), ('Neo4j'), ('ROracle 11g')

INSERT INTO StudentsExams
VALUES (1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103)

--04. Self-Referencing !!!
CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY IDENTITY(101, 1)  NOT NULL,
Name VARCHAR(40) NOT NULL,
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

SET IDENTITY_INSERT Teachers ON
INSERT INTO Teachers(TeacherID, Name, ManagerID)
VALUES (101, 'John', NULL), 
		(105, 'Mark', 101), 
		(106, 'Greta', 101),
		(102, 'Mayya', 106), 
		(103, 'Silvia',106 ),
		(104, 'Tom', 106 )
SET IDENTITY_INSERT Teachers OFF

--05. Online Store Database

CREATE TABLE Cities(
CityID INT PRIMARY KEY IDENTITY,
Name VARCHAR(30) NOT NULL,
)

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(30) NOT NULL,
Birthday DATE,
CityID INT,
CONSTRAINT FK_Customers_Cities
FOREIGN KEY (CityID)
REFERENCES Cities(CityID)
)

CREATE TABLE ItemTypes(
ItemTypeID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Items(
ItemID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
ItemTypeID INT,
CONSTRAINT FK_Items_ItemTypes
FOREIGN KEY (ItemTypeID)
REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE Orders(
OrderID INT PRIMARY KEY IDENTITY,
CustomerID INT,
CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems(
OrderID INT,
ItemID INT,
CONSTRAINT PK_OrderItems
PRIMARY KEY (OrderID, ItemID),

CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID),

CONSTRAINT FK_OrderItems_Items
FOREIGN KEY (ItemID)
REFERENCES Items(ItemID)
)

--06. University Database
DROP DATABASE UniversityDatabasee
CREATE DATABASE UniversityDatabasee
use UniversityDatabasee
GO

CREATE TABLE Subjects(
SubjectID INT PRIMARY KEY IDENTITY,
SubjectName VARCHAR(30) NOT NULL
)

CREATE TABLE Majors(
MajorID INT PRIMARY KEY IDENTITY,
Name VARCHAR(30) NOT NULL
)

CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY,
StudentNumber INT UNIQUE,
StudentName VARCHAR(40) NOT NULL ,
MajorID INT,
CONSTRAINT FK_Students_Majors
FOREIGN KEY (MajorID)
REFERENCES Majors(MajorID),
)

CREATE TABLE Agenda(
StudentID INT,
SubjectID INT

CONSTRAINT PK_SubjectsStudents
PRIMARY KEY (StudentID, SubjectID),

CONSTRAINT FK_Agenta_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID),

CONSTRAINT FK_Agenta_Subjects
FOREIGN KEY (SubjectID)
REFERENCES Subjects(SubjectID)
)

CREATE TABLE Payments(
PaymentID INT PRIMARY KEY IDENTITY,
PaymentDate DATE,
PaymentAmount Decimal(15,2) NOT NULL,
StudentID INT
CONSTRAINT FK_Payments_Studens
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)
)


09. *Peaks in Rila
SELECT [MountainRange], PeakName, Elevation FROM Mountains AS m
JOIN Peaks AS p ON m.Id = p.[MountainId]
WHERE m.[MountainRange]='Rila'
ORDER BY Elevation DESC
