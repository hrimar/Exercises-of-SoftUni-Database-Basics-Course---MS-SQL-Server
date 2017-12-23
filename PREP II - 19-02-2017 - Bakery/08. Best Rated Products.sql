SELECT TOP 10 p.Name, p.Description, 
		AVG(f.Rate) AS AverageRate,
		COUNT(fi.FeedbacksAmount) AS FeedbacksAmount
 FROM Products AS p
JOIN Feedbacks AS f
ON f.ProductId = p.Id
JOIN (
		SELECT ProductId, COUNT(Id) AS FeedbacksAmount
FROM Feedbacks 
GROUP BY ProductId
		) AS fi
		ON fi.ProductId = p.Id
GROUP By p.Name,p.Description
ORDER BY AVG(f.Rate) DESC, 	COUNT(fi.FeedbacksAmount) DESC

--ето и супер простото решение:

SELECT TOP 10 p.Name, p.Description, 
		AVG(f.Rate) AS AverageRate,
		COUNT(f.Id) AS FeedbacksAmount
 FROM Products AS p
JOIN Feedbacks AS f
ON f.ProductId = p.Id
GROUP By p.Name,p.Description
ORDER BY AVG(f.Rate) DESC, 	COUNT(f.Id) DESC