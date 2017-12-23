--Exercises: Data Aggregation

--Problem 1. Records’ Count
SELECT COUNT(ID)
FROM [WizzardDeposits]

--02. Longest Magic Wand 
SELECT MAX(MagicWandSize) AS LongestMagicWand      
  FROM WizzardDeposits
  
--03. Longest Magic Wand per Deposit Groups
SELECT DepositGroup,
	MAX(MagicWandSize) AS LongestMagicWand
 FROM WizzardDeposits
 GROUP BY [DepositGroup]

--04. Smallest Deposit Group per Magic Wand Size   !!!!! ВИЖ ВСИЧКИ РЕШЕНИя!
SELECT [DepositGroup]   
  FROM [WizzardDeposits]
   GROUP BY [DepositGroup]
  HAVING AVG(MagicWandSize) = (
  SELECT MIN(WizardAvgWandSize.AvgMagicWandSize) FROM
  (
		SELECT [DepositGroup],
		AVG(MagicWandSize) AS AvgMagicWandSize
		FROM [WizzardDeposits]
		GROUP BY [DepositGroup]
	 ) AS WizardAvgWandSize
)

--or
 
  SELECT TOP 1 WITH TIES [DepositGroup]         --,  avg(magicwandsize)
  from [wizzarddeposits]
  group by [depositgroup]
  ORDER BY avg(magicwandsize)
  
--or 

SELECT TOP 2 [DepositGroup]
	 FROM [WizzardDeposits]
 GROUP BY [DepositGroup]
 ORDER BY AVG([MagicWandSize])  


--05. Deposits Sum
SELECT DepositGroup, SUM([DepositAmount]) AS TotalSum
	 FROM [WizzardDeposits]
 GROUP BY [DepositGroup]


--06. Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM([DepositAmount]) AS TotalSum
	 FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
 GROUP BY [DepositGroup]

--07. Deposits Filter
SELECT DepositGroup, SUM([DepositAmount]) AS TotalSum
	 FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
 GROUP BY [DepositGroup]
 Having SUM([DepositAmount]) < 150000
 ORDER BY TotalSum DESC

--08.
SELECT    [DepositGroup], [MagicWandCreator]
        ,MIN([DepositCharge]) AS MinDepositCharge
        FROM [Gringotts].[dbo].[WizzardDeposits]
		GROUP BY     [DepositGroup], [MagicWandCreator]
		ORDER BY [MagicWandCreator]  
  
  
09. Age Groups !!!
SELECT 
CASE
WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
WHEN Age >= 61 THEN '[61+]'
 END AS AgeGroup, COUNT(*) AS WizardCount
FROM WizzardDeposits
GROUP BY CASE
WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
WHEN Age >= 61 THEN '[61+]'
 END  
 
 --or
 
  SELECT  AgeGroups.AgeGroup, COUNT(*) AS WizardCount FROM
 (SELECT 
CASE
WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
WHEN Age >= 61 THEN '[61+]'
 END AS AgeGroup
FROM WizzardDeposits) AS AgeGroups
GROUP BY AgeGroups.AgeGroup


--11. Average Interest
SELECT [DepositGroup]         
          ,[IsDepositExpired]
		   ,AVG([DepositInterest]) AS AverageInterest
  FROM [WizzardDeposits]
  WHERE DepositStartDate > '1985-01-01'
  GROUP BY DepositGroup, [IsDepositExpired]
  ORDER BY DepositGroup DESC, IsDepositExpired

----12. Rich Wizard, Poor Wizard
DECLARE @currentDeposit DECIMAL(8,2)
DECLARE @previousDeposit DECIMAL(8,2)
DECLARE @totalSum DECIMAL(8,2) = 0

DECLARE WizardCursor CURSOR FOR SELECT DepositAmount FROM WizzardDeposits
OPEN WizardCursor
FETCH NEXT FROM WizardCursor INTO @currentDeposit

WHILE (@@FETCH_STATUS =0)
BEGIN
IF(@previousDeposit IS NOT NULL)
BEGIN
	SET @totalSum += @previousDeposit - @currentDeposit
END

SET @previousDeposit = @currentDeposit
FETCH NEXT FROM WizardCursor INTO @currentDeposit
END
CLOSE WizardCursor
DEALLOCATE WizardCursor

SELECT @totalSum

--or

SELECT SUM(WizardDep.Difference) FROM (
SELECT FirstName,[DepositAmount], 
LEAD(FirstName) OVER (ORDER BY Id) AS GuestWizard,
LEAD([DepositAmount]) OVER(ORDER BY Id) AS GuestAmount,
DepositAmount - LEAD([DepositAmount]) OVER(ORDER BY Id) AS Difference
FROM WizzardDeposits)
AS WizardDep

--13. Departments Total Salaries
SELECT [DepartmentID]
            ,SUM([Salary]) AS TotalSalary
        FROM [Employees]
		GROUP By DepartmentID
		Order By DepartmentID

--14. Employees Minimum Salaries
SELECT [DepartmentID]
            ,MIN(Salary) AS MinimumSalary
        FROM [Employees]
		WHERE DepartmentID IN(2,5,7) AND HireDate>2000-01-01
		GROUP By DepartmentID

--15. Employees Average Salaries


--16. Employees Maximum Salaries
SELECT [DepartmentID]
        ,MAX(Salary) AS MaxSalary
  FROM [Employees]
GROUP By DepartmentID
HAVING NOT MAX(Salary) BETWEEN 30000 AND 70000
	
--17. Employees Count Salaries
SELECT Count(EmployeeID) AS Count
		FROM Employees
GROUP BY  ManagerID
Having ManagerID IS NULL

--18. 3rd Highest Salary
SELECT Salaries.DepartmentID, Salaries.Salary FROM
(
SELECT DepartmentID, MAX(Salary) AS Salary, 
DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS Rank
FROM Employees
GROUP BY DepartmentID, Salary
) AS Salaries
WHERE Rank = 3

--19. Salary Challenge
SELECT TOP (10) FirstName, LastName, DepartmentId FROM Employees AS e1
WHERE Salary > (
		SELECT AVG(Salary) FROM Employees AS e2
		WHERE e1.DepartmentId = e2.DepartmentId
		GROUP BY DepartmentId
		)
