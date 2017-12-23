SELECT m.FirstName+' '+m.LastName AS Mechanic,
		AVG(DATEDIFF(day, j.IssueDate,	j.FinishDate)) AS 'Average Days'
 FROM Mechanics AS m
 INNER JOIN Jobs AS j
 ON m.MechanicId = j.MechanicId
 WHERE j.Status = 'Finished' --може и без този ред
 GROUP BY (m.FirstName+' '+m.LastName), m.MechanicId
 ORDER BY m.MechanicId --за да подрежда по това,то тр€бва да го има GROUP-па