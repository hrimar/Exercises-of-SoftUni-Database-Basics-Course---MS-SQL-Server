
--мепеьемю

SELECT p.Name AS ProductName
		,AVG(f.Rate)
		,d.Name AS DistributorName
		,i.Name AS Ingredients
		,c.Name AS DistributorCountry
 FROM Products AS p
JOIN ProductsIngredients AS pi ON pi.IngredientId=p.Id
JOIN Ingredients AS i ON i.Id=pi.IngredientId
JOIN Feedbacks AS f ON f.ProductId=p.Id
JOIN Distributors AS d ON i.DistributorId=d.Id
JOIN Countries AS c ON c.Id = d.CountryId

SELECT c.Name AS CountryName,
		d.Name AS DistributorName, 
		 COUNT(i.Id) AS IngredCount,
		 DENSE_RANK() OVER(PARTITION BY c.Name ORDER BY COUNT(i.Id)) AS RANK
FROM Ingredients As i
JOIN Distributors  AS d ON d.Id = i.DistributorId
JOIN  Countries AS c ON c.Id = d.CountryId
JOIN ProductsIngredients AS pi ON pi.IngredientId=i.Id
GROUP BY c.Name,d.Name

