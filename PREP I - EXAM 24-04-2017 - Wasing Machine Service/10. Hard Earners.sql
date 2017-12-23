SELECT TOP 3 m.FirstName+' '+m.LastName AS Mechanic,
		COUNT(j.JobId) AS Jobs
FROM Mechanics AS m
JOIN Jobs AS j
ON j.MechanicId = m.MechanicId
WHERE j.Status !='Finished' 
GROUP BY m.FirstName+' '+m.LastName, m.MechanicId
HAVING COUNT(j.JobId) >1
Order by COUNT(j.JobId) DESC, m.MechanicId