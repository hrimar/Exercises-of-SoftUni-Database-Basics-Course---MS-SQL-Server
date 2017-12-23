SELECT m.FirstName +' '+m.LastName AS Mechanic,
		j.Status,
		j.IssueDate
 FROM Jobs AS j
INNER JOIN Mechanics AS m
ON m.MechanicId = j.MechanicId
ORDER BY j.MechanicId, IssueDate, JobId