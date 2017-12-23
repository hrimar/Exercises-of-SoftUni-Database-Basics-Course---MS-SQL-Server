--Built-in Functions Excercises

--01. Find Names of All Employees by First Name
SELECT FirstName, LastName
FROM [dbo].[Employees]
WHERE LEFT(FirstName, 2) = 'SA'

--02.	  Find Names of All employees by Last Name 
SELECT FirstName, LastName
FROM [dbo].[Employees]
WHERE LastName LIKE '%ei%'

--03. Find First Names of All Employess - ?????? 
SELECT FirstName
FROM [dbo].[Employees]
WHERE [DepartmentID] IN(3, 10)
AND (DATEPART(year, [HireDate]) >= 1995 AND 
DATEPART(year, [HireDate]) <2005)

--OK 03:
SELECT FirstName from Employees
WHERE (DepartmentID =3 OR  DepartmentID =10) 
AND (DATEPART(year, HireDate) BETWEEN 1995 AND 2005)

--04. Find All Employees Except Engineers
SELECT FirstName, [LastName]
FROM [dbo].[Employees]
WHERE NOT [JobTitle] LIKE '%engineer%'

--05. Find Towns with Name Length
SELECT Name
FROM Towns
WHERE LEN(Name)=5 OR LEN(Name)=6
ORDER BY Name

--06. Find Towns Starting With
SELECT * from Towns
WHERE Left(Name, 1) IN('M', 'K', 'B', 'E')
Order By Name

--07. Find Towns Not Starting With
SELECT * from Towns
WHERE NOT Left(Name, 1) IN('R', 'D', 'B')
Order By Name

--or

SELECT * from Towns
WHERE Name LIKI '[^RDB]%'
Order By Name


--08. Create View Employees Hired After
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName from Employees
WHERE DATEPART(year, HireDate)>2000

--09. Length of Last Name
SELECT FirstName, LastName from Employees
WHERE LEN(LastName) =5

--10. Countries Holding 'A'
SELECT  [CountryName], [IsoCode]
        FROM [Countries]
		WHERE CountryName LIKE '%a%a%a%'
		ORDER BY IsoCode

--11. Mix of Peak and River Names
SELECT PeakName, RiverName,
LOWER(PeakName+RIGHT(RiverName, LEN(RiverName)-1)) AS Mix
FROM Rivers, Peaks
WHERE RIGHT(PeakName, 1) = LEFT(RiverName,1)
ORDER BY Mix

--or

SELECT  PeakName, RiverName, 
Lower(SUBSTRING(PeakName, 1, LEN(PeakName)-1)+RiverName) AS Mix
 FROM Peaks, Rivers	
	WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1) 
	ORDER BY Mix


--12. Games From 2011 and 2012 Year - ???????
SELECT TOP 50 Name
      ,CAST(Start AS Date) AS Start
       FROM Games
	   WHERE DATEPART(year, Start) = 2011  OR  DATEPART(year, Start) =2012
	   ORDER BY Start, Name

CAST и CONVERT гърмят в JUDGE, затова:

SELECT TOP 50 Name
      ,FORMAT (Start, 'yyyy-MM-dd') AS Start
       FROM Games
	   WHERE DATEPART(year, Start) BETWEEN 2011  AND 2012
	   ORDER BY Start, Name



SELECT TOP (50) Name, CONVERT(varchar(10), Start, 120) AS Started FROM Games
WHERE YEAR(Start) = 2011 OR YEAR(Start) = 2012
ORDER BY Start, Name

--13. User Email Providers
SELECT [Username], SUBSTRING(Email, 
	CHARINDEX('@', Email, 1)+1, LEN(Email)) AS 'Email Provider'
FROM [Users]
ORDER BY 'Email Provider', Username

--or

SELECT [Username], SUBSTRING(Email, 
	RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS 'Email Provider'
FROM [Users]
ORDER BY 'Email Provider', Username

--14.	 Get Users with IPAdress Like Pattern
SELECT [U sername], IpAddress AS 'IP Address'
 FROM [Users]
WHERE IpAddress LIKE '___.1%.%.___' 
ORDER BY Username

--15. Show All Games with Duration
SELECT [Name]
      ,CASE 
	  WHEN DATEPART(hour, [Start]) >= 0 AND DATEPART(hour, [Start]) <12 THEN 'Morning'
	   WHEN DATEPART(hour, [Start]) >= 12 AND DATEPART(hour, [Start]) <18 THEN 'Afternoon'
	   ELSE 'Evening' 
	   END AS 'Part of the Day'
      ,CASE
	  WHEN [Duration] <=3 THEN 'Extra Short'
	  WHEN [Duration] >=4 AND [Duration] <=6 THEN 'Short'
	  WHEN [Duration] > 6 THEN 'Long'
	  ELSE 'Extra Long'
    	END AS 'Duration'
	FROM [Games]
ORDER BY Name, 'Duration', 'Part of the Day'

--16. Orders Table
SELECT ProductName, OrderDate, 
DATEADD(DAY, 3, OrderDate) AS 'Pay Due',
DATEADD(MONTH, 1, OrderDate) AS 'Delivery Due'
FROM Orders

--17. People Table - Намен ми дава с 1 год повече ??????
CREATE TABLE People(
	Id int IDENTITY PRIMARY KEY NOT NULL,
	Name varchar(200) NOT NULL,
	Birthdate datetime NOT NULL
)

GO

INSERT INTO People(Name, Birthdate) VALUES
('Victor', '2000-12-07'),
('Steven', '1992-09-10'),
('Stephen', '1910-09-19'),
('John', '2010-01-06')

GO

SELECT 
	Name,
	DATEDIFF(year, Birthdate, GETDATE()) AS [Age in Years],
	DATEDIFF(month, Birthdate, GETDATE()) AS [Age in Months], 
	DATEDIFF(day, Birthdate, GETDATE()) AS [Age in Days], 
	DATEDIFF(minute, Birthdate, GETDATE()) AS [Age in Minutes]
	FROM People
