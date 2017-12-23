--5/10
WITH CTE_PartsCountByMechanic
AS
(
SELECT m.MechanicId, 
		SUM(op.Quantity) AS Parts
 FROM Mechanics AS m
JOIN Jobs AS j ON j.MechanicId = m.MechanicId
JOIN Orders AS o ON o.JobId = j.JobId
JOIN OrderParts AS op ON op.OrderId = o.OrderId
JOIN Parts AS p ON p.PartId = op.PartId
JOIN Vendors AS v ON v.VendorId = p.VendorId
GROUP BY m.MechanicId  
)
SELECT m.FirstName +' '+m.LastName AS Mechanic, 
		v.Name AS Vendor, 
		COUNT(*) AS Parts, 
		CAST(CAST(CAST(COUNT(*) AS Decimal(6, 2))/cte.Parts*100 AS INT) AS VARCHAR(MAX))+'%' AS Preferences
 FROM CTE_PartsCountByMechanic  AS cte
JOIN Jobs AS j ON j.MechanicId = cte.MechanicId
JOIN Orders AS o ON o.JobId = j.JobId
JOIN OrderParts AS op ON op.OrderId = o.OrderId
JOIN Parts AS p ON p.PartId = op.PartId
JOIN Vendors AS v ON v.VendorId = p.VendorId
JOIN Mechanics AS m ON m.MechanicId = cte.MechanicId
GROUP BY m.FirstName +' '+m.LastName, v.Name, cte.Parts
ORDER BY Mechanic, Parts DESC, v.Name