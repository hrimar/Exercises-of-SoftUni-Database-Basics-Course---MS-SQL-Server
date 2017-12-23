--Joins, Subqueries, CTE and Indices

-- 01. Employee Address
SELECT TOP 5 e.[EmployeeID]
          ,e.[JobTitle]
           ,e.[AddressID],
		   a.AddressText
  FROM [Employees] AS e
  INNER JOIN Addresses AS a
  ON a.AddressID = e.AddressID
  ORDER BY e.AddressID
  
--02. Addresses with Towns
SELECT TOP 50 e.FirstName
          ,e.LastName
		  ,t.Name AS Town
          ,a.AddressText
  FROM [Employees] AS e
  INNER JOIN Addresses AS a
  ON a.AddressID = e.AddressID
  JOIN Towns AS t
  ON t.TownID = a.TownID
  ORDER BY e.FirstName, LastName
  
--03. Sales Employees
SELECT e.EmployeeID
		,e.FirstName
          ,e.LastName
		 ,d.Name AS DepartmentName
  FROM [Employees] AS e
  INNER JOIN Departments AS d
  ON d.DepartmentID = e.DepartmentID
  WHERE d.Name = 'Sales'
  ORDER BY e.EmployeeID
  
--04. Employee Departments
SELECT TOP 5
		e.EmployeeID
		,e.FirstName
          ,e.Salary
		 ,d.Name AS DepartmentName
  FROM [Employees] AS e
  INNER JOIN Departments AS d
  ON d.DepartmentID = e.DepartmentID
  WHERE e.Salary >15000
  ORDER BY e.DepartmentID

--05. Employees Without Projects ?

SELECT TOP 3000 r.EmployeeID, r.FirstName
FROM 
(
SELECT e.EmployeeID,
		e.FirstName,
		ep.ProjectID,
		p.Name
  FROM Employees AS e
  LEFT OUTER JOIN EmployeesProjects AS ep
  ON ep.EmployeeID = e.EmployeeID
  LEFT OUTER  JOIN Projects As p
  ON p.ProjectID = ep.ProjectID
  --ORDER BY e.EmployeeID
) AS r
    WHERE r.Name=NULL
	ORDER BY r.EmployeeID

--06. Employees Hired After
SELECT  e.FirstName,
		e.LastName, 
		e.HireDate,
		d.Name AS DeptName
FROM Employees AS e
INNER JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE d.Name IN ('Sales', 'Finance')
AND
e.HireDate> '01.01.1999'
ORDER BY e.HireDate

--07. Employees With Project
SELECT TOP 5 
		e.EmployeeID,
		e.FirstName,
		p.Name AS ProjectName
   FROM Employees AS e
INNER JOIN EmployeesProjects AS ep
     ON ep.EmployeeID = e.EmployeeID
INNER JOIN Projects AS p
     ON p.ProjectID = ep.ProjectID
  WHERE p.StartDate >'2002.08.13' --AND p.EndDate=NULL
ORDER BY e.EmployeeID

--08. Employee 24
 SELECT  
		e.EmployeeID,
		e.FirstName,	
   CASE
   WHEN p.StartDate>='2005' THEN NULL
   ELSE p.Name
   END AS ProjectName
   FROM Employees AS e
RIGHT OUTER  JOIN EmployeesProjects AS ep
     ON ep.EmployeeID = e.EmployeeID
RIGHT OUTER   JOIN Projects AS p
     ON p.ProjectID = ep.ProjectID
  WHERE e.EmployeeID = 24 
  

--09. Employee Manager
SELECT m.EmployeeID 
	,m.FirstName
	,m.ManagerID
	,e.FirstName AS ManagerName
FROM Employees AS e
INNER JOIN Employees AS m
ON m.ManagerID = e.EmployeeID
WHERE m.ManagerID IN (3,7)
ORDER By m.EmployeeID

--10. Employees Summary
SELECT TOP 50 
	 e.EmployeeID 
	,e.FirstName+' '+e.LastName AS EmployeeName
	,m.FirstName+' '+m.LastName AS ManagerName
	,d.Name AS DepartmentName
FROM Employees AS e
LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
LEFT JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
ORDER By e.EmployeeID

-- or
SELECT TOP 50 
	 m.EmployeeID 
	,m.FirstName+' '+m.LastName AS EmployeeName
	,e.FirstName+' '+e.LastName AS ManagerName
	,d.Name
FROM Employees AS e
INNER JOIN Employees AS m
ON m.ManagerID = e.EmployeeID
INNER JOIN Departments AS d
ON d.DepartmentID = m.DepartmentID
ORDER By m.EmployeeID





