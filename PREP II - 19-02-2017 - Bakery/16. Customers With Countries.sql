CREATE VIEW v_UserWithCountries 
AS
SELECT c.FirstName+' '+c.LastName AS CustomerName
		,c.Age,c.Gender
		,con.Name AS CountryName
 FROM Customers AS c
JOIN Countries AS con ON con.Id = c.CountryId

SELECT TOP 5 *
  FROM v_UserWithCountries
 ORDER BY Age
