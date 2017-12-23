
CREATE  FUNCTION udf_GetRating(@Name NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
RETURN (SELECT  CASE
		WHEN AVG(f.Rate) <5 THEN 'Bad'
		WHEN AVG(f.Rate) BETWEEN 5 AND 8 THEN 'Average'
		WHEN AVG(f.Rate) >8 THEN 'Good'
		ELSE 'No rating'
		END
		 FROM Feedbacks AS f
RIGHT JOIN Products AS p ON p.Id = f.ProductId
WHERE p.Name = @Name
GROUP BY p.Name)
END

SELECT TOP 5 Id, Name, dbo.udf_GetRating(Name)
  FROM Products
 ORDER BY Id

 --или

 CREATE OR ALTER FUNCTION udf_GetRating(@Name NVARCHAR(50))
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @avgRate DECIMAL(4, 2)= (SELECT AVG(Rate) 
				FROM Products AS p
				JOIN Feedbacks AS f ON p.Id = f.ProductId
				WHERE Name = @Name)
DECLARE @rating VARCHAR(10) = (CASE
		WHEN @avgRate <5 THEN 'Bad'
		WHEN @avgRate BETWEEN 5 AND 8 THEN 'Average'
		WHEN @avgRate >8 THEN 'Good'
		ELSE 'No rating'
		END)
RETURN @rating
END

SELECT TOP 5 Id, Name, dbo.udf_GetRating(Name)
  FROM Products
 ORDER BY Id