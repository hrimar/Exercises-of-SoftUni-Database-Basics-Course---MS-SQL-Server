SELECT TOP 1 WITH TIES m.Name AS Model, 
		COUNT(*) AS 'Times Serviced',
		(SELECT  ISNULL(SUM(p.Price*op.Quantity), 0) AS Total FROM Parts AS p
FULL JOIN OrderParts AS op ON op.PartId = p.PartId
FULL JOIN Orders AS o ON o.OrderId = op.OrderId
Full JOIN Jobs AS j ON j.JobId = o.JobId
WHERE j.ModelId=m.ModelId -- за да вържем 2те подзаявки
GROUP BY j.ModelId) AS 'Parts Total'
FROM Models AS m
FULL JOIN Jobs AS j
ON j.ModelId = m.ModelId
GROUP BY m.Name, m.ModelId
ORDER BY 'Times Serviced'DESC
