SELECT c.FirstName+' '+c.LastName AS Client,
		DATEDIFF(day, j.IssueDate,	GETDATE()) AS 'Days going',
		j.Status
 FROM Jobs AS j
 INNER JOIN Clients AS c
 ON c.ClientId = j.ClientId
 WHERE NOT j.Status = 'Finished'
 ORDER BY 'Days going' DESC