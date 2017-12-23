SELECT c.FirstName+' '+c.LastName AS 'CustomerName'
		,c.PhoneNumber
		,c.Gender
FROM Feedbacks AS f
LEFT JOIN Customers AS c
ON c.Id = f.CustomerId
WHERE f.Description IS NULL OR f.Description =''
ORDER BY c.Id

SELECT CONCAT(c.FirstName, ' ', c.LastName) AS 'CustomerName'
		,c.PhoneNumber
		,c.Gender
FROM Customers AS c 
LEFT JOIN Feedbacks AS f
ON c.Id = f.CustomerId
WHERE f.Id IS NULL --
ORDER BY c.Id

--or

SELECT CONCAT(FirstName, ' ', LastName) AS 'CustomerName'
		,PhoneNumber
		,Gender
FROM Customers
WHERE Id NOT IN (SELECT CustomerId FROM Feedbacks)
ORDER BY Id
