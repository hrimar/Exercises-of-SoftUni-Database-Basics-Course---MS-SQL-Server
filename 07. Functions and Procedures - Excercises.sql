--Excercises Functions and Procedures

--01. Employees with Salary Above 35000
CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
SELECT FirstName, LastName
FROM Employees
WHERE Salary > 35000

--02. Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber (@TargetSalary DECIMAL(18,4) )
AS
SELECT FirstName, LastName
FROM Employees
WHERE Salary>= @TargetSalary

--03. Town Names Starting With
CREATE PROC usp_GetTownsStartingWith (@TargetTowns VARCHAR(50))
AS
SELECT Name
FROM Towns
WHERE Name LIKE @TargetTowns+'%'

--04. Employees from Town
CREATE PROC usp_GetEmployeesFromTown (@TownName VARCHAR(50))
AS
SELECT e.FirstName, e.LastName
FROM Employees AS e
JOIN Addresses AS a
ON a.AddressID = e.AddressID
JOIN Towns AS t
ON t.TownID = a.TownID
WHERE t.Name = @TownName

--05. Salary Level Function
 CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
 RETURNS VARCHAR(10)
 AS
 BEGIN
 DECLARE @SalaryLevel VARCHAR(10);
 SET @SalaryLevel = 
		CASE
		WHEN @salary <30000 THEN 'Low'
		WHEN @salary BETWEEN 30000 AND 50000 THEN 'Average'
		ELSE 'High' 
		END 
 RETURN @SalaryLevel;
 END
 
  --or
 
  CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
 RETURNS VARCHAR(10)
 AS
 BEGIN
 DECLARE @SalaryLevel VARCHAR(10);

		IF(@salary <30000)
		BEGIN
			SET @SalaryLevel = 'Low'
		END
		IF (@salary BETWEEN 30000 AND 50000)
		BEGIN
			SET @SalaryLevel = 'Average'
		END
		IF(@salary >50000)
		BEGIN
			SET @SalaryLevel = 'High' 
		END	
 RETURN @SalaryLevel;
 END
 
 --06. Employees by Salary Level  -  ПАК !!!
 CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@levelOfSalary VARCHAR(10))
 AS
  SELECT FirstName, LastName
	FROM Employees
	WHERE @levelOfSalary =
	(	
	 dbo.ufn_GetSalaryLevel(Salary) 
	) 

	GO 
EXEC usp_EmployeesBySalaryLevel @levelOfSalary ='High' 
 


--07. Define Function !!!
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(20), @word VARCHAR(20))
RETURNS BIT
AS
BEGIN
	DECLARE @count int = 1;
	DECLARE	@currentLetter char;
	WHILE(LEN(@word) >= @count)
	BEGIN
		SET @currentLetter = SUBSTRING(@word, @count, 1);
		DECLARE @match INT = CHARINDEX(@currentLetter, @setOfLetters); -- дава 0 или 1 ако я няма или има
		IF(@match = 0)
		BEGIN
		    RETURN 0;
		END
	SET @count += 1;
	END
	RETURN 1;
END
GO
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia') As Result


--08. Delete Employees and Departments  !
-- Иска се да се изтрие(DELETE FROM Employees WHERE DepartmentID = @departmentId)
--, но понеже те са вързани с проекти, трием и тях и разкачаме манаджерите вързани също с тях:
	
CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS
	DELETE FROM EmployeesProjects -- 1-во трием проектите свързани с тези хора!
	WHERE EmployeeID IN
	(
	SELECT e.EmployeeID
	FROM Employees AS e
	JOIN EmployeesProjects AS ep
	ON ep.EmployeeID = e.EmployeeID
	WHERE e.DepartmentID = @departmentId
	--  SELECT EmployeeID FROM Employees
	--  WHERE DepartmentID = @departmentId
	)

	ALTER TABLE Departments	-- за да стане 2 позволяваме менаджер да прима NULL ст-сти
	ALTER COLUMN ManagerId INT NULL;
	 
	UPDATE Departments	-- 2ро трием ги като менаджерири на депт ако има от тях
	SET ManagerID = NULL
	WHERE ManagerID IN 
	(
	  SELECT EmployeeID FROM Employees
	  WHERE DepartmentID = @departmentId
	)
-- 3-то за да като трием employee а той е манаджер на друг човек да го освободим от това:
	UPDATE Employees 
	SET ManagerID = NULL
	WHERE ManagerID IN 
	(
	  SELECT EmployeeID FROM Employees
	  WHERE DepartmentID = @departmentId
	)

	--ТО само това се иска да се изтрие, но понеже те са вързани с проекти, 
	-- трием и тях и разкачаем манаджерите вързани също с тях:
	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments - като вече департ ням аслъжители го трием и него
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*) FROM Employees
	WHERE DepartmentID = @departmentId



--09. Find Full Name
CREATE  PROC usp_GetHoldersFullName 
AS
SELECT CONCAT([FirstName], ' ', LastName) AS 'Full Name'
  FROM [AccountHolders]


--10. People with Balance Higher Than    !!! ПАК 

CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan(@number MONEY)
AS
SELECT h.FirstName AS 'First Name', h.LastName AS 'Last Name'
FROM AccountHolders AS h
JOIN 
(SELECT AccountHolderID, SUM(Balance) AS [TotalBalance]
	FROM Accounts
	GROUP BY AccountHolderId) AS a
ON a.AccountHolderId = h.Id
WHERE a.TotalBalance > @number
ORDER BY [Last Name] ,[First Name]
GO

EXEC  dbo.usp_GetHoldersWithBalanceHigherThan 0.00

--11. Future Value Function
CREATE  FUNCTION ufn_CalculateFutureValue (@initSum MONEY,@yearly FLOAT, @nYears INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @result MONEY;
	SET @result = @initSUM * (POWER((1 + @yearly), @nYears))
	RETURN @result;
END
GO
SELECT TOP 1 dbo.ufn_CalculateFutureValue(1000, 0.1, 5) AS Output
FROM AccountHolders

--12. Calculating Interest

CREATE OR ALTER PROC usp_CalculateFutureValueForAccount (@acountId INT, @interest FLOAT)
AS 
	SELECT a.Id AS 'Account Id'
			,h.FirstName AS 'First Name'
			,h.LastName AS 'Last Name'
			,a.Balance AS 'Current Balance'
			,dbo.ufn_CalculateFutureValue(a.Balance, @interest, 5) AS 'Balance in 5 years'
	FROM AccountHolders AS h
	JOIN Accounts AS a
	ON a.AccountHolderId = h.Id
	WHERE a.Id = @acountId

	GO

EXEC dbo.usp_CalculateFutureValueForAccount 
@acountId = 1, 
@interest = 0.1

--13. *Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(MAX))
RETURNS TABLE  --- ?!?!
AS
RETURN 	SELECT SUM(Cash) AS SumCash
		FROM 
		(
			SELECT ug.Cash, ROW_NUMBER() OVER (ORDER BY Cash DESC) AS RowNum
			FROM UsersGames AS ug
			INNER JOIN Games AS g
			ON g.Id = ug.GameId
			WHERE g.Name = @gameName
		) AS CashList
		WHERE RowNum % 2 = 1;

GO

SELECT * FROM dbo.ufn_CashInUsersGames('Lily Stargazer')
