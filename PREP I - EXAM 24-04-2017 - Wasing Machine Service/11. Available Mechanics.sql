--грешен 0-лев тест, останалите са верни и 4/4
SELECT  m.FirstName+' '+m.LastName AS Available
		--j.Status
		--COUNT(j.JobId) AS Jobs
FROM Mechanics AS m
FULL JOIN Jobs AS j
ON j.MechanicId = m.MechanicId
WHERE j.Status = 'Finished' OR j.Status IS NULL
GROUP BY m.FirstName+' '+m.LastName, m.MechanicId
Order by  m.MechanicId

-- ЕТО РЕШ-ТО:
SELECT FirstName+' '+LastName AS Available
 FROM Mechanics
WHERE MechanicId  NOT IN 
	(SELECT DISTINCT MechanicId FROM Jobs	
	WHERE MechanicId IS NOT NULL AND Status!= 'Finished')
Order by  MechanicId