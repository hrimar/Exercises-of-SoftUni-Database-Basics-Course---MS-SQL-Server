	-- YES. DENSE_RANK e SPER!
SELECT DistIngCount.CountryName AS CountryName,
		 DistIngCount.Name AS DistributorName		
 FROM
(
SELECT c.Name AS CountryName,
		d.Name, 
		 COUNT(i.Id) AS IngredCount,
		 DENSE_RANK() OVER(PARTITION BY c.Name ORDER BY COUNT(i.Id)DESC) AS RANK
FROM Ingredients As i
JOIN Distributors  AS d ON d.Id = i.DistributorId
JOIN  Countries AS c ON c.Id = d.CountryId
GROUP BY c.Name,d.Name
) AS DistIngCount
WHERE RANK = 1
ORDER BY CountryName, DistributorName
