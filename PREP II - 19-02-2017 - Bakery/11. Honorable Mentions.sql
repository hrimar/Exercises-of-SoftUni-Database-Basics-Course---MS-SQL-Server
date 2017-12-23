--1-во подзаявката и после я вмъкваш
SELECT CustomerId, COUNT(Id) FROM Feedbacks
GROUP BY CustomerId
HAVING COUNT(Id) >= 3

--РЕШЕНИЕ:
SELECT f.ProductId, 
	c.FirstName+' '+c.LastName AS CustomerName,
	f.Description	AS FeedbackDescription
FROM Customers AS c
JOIN Feedbacks AS f ON f.CustomerId = c.Id
WHERE c.Id IN
			(SELECT CustomerId FROM Feedbacks
			GROUP BY CustomerId
			HAVING COUNT(Id) >= 3)
ORDER BY f.ProductId, c.FirstName+' '+c.LastName, f.Id