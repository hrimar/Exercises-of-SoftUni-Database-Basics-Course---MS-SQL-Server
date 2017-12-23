SELECT m.ModelId,
		m.Name,
		CAST(AVG(DATEDIFF(day, j.IssueDate, j.FinishDate)) AS VARCHAR)
		+' days' AS 'Average Service Time'
FROM Models AS m
FULL JOIN Jobs AS j
ON j.ModelId = m.ModelId
--WHERE j.Status = 'Finished'
GROUP BY m.ModelId,	m.Name
ORDER BY AVG(DATEDIFF(day, j.IssueDate, j.FinishDate))