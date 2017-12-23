SELECT j.JobId, ISNULL(SUM(p.Price*op.Quantity), 0) AS Total FROM Parts AS p
FULL JOIN OrderParts AS op ON op.PartId = p.PartId
FULL JOIN Orders AS o ON o.OrderId = op.OrderId
Full JOIN Jobs AS j ON j.JobId = o.JobId
WHERE j.Status = 'Finished'
GROUP BY j.JobId
ORDER BY SUM(p.Price*op.Quantity) DESC, j.JobId
