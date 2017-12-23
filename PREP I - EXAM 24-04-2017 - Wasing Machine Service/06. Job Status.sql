SELECT Status, IssueDate FROM Jobs
WHERE NOT Status = 'Finished'
Order By IssueDate, JobId