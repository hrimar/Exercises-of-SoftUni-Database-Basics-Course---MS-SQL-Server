--ðåøåíèÿ íà Additional Exercises:

--1. Number of Users for Email Provider
SELECT SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email)) AS 'Email Provider' 
		,COUNT([Username]) AS 'Number Of Users'
  FROM [Users]
  GROUP BY SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email)) 
  ORDER BY 'Number Of Users'DESC, 'Email Provider' 

--02. All Users in Games
SELECT g.[Name]
       ,gt.Name
	   ,u.Username
	   ,ug.Level
	   ,ug.Cash
	   ,c.Name
   FROM [Games]  AS g
   JOIN GameTypes AS gt
   ON gt.Id = g.GameTypeId
   INNER JOIN UsersGames AS ug
   ON ug.GameId = g.Id
   INNER JOIN Users AS u
   ON u.Id = ug.UserId
   INNER JOIN Characters AS c
   ON c.Id = ug.CharacterId
   ORDER BY Level DESC, Username, g.Name

--03. Users in Games with Their Items


--06. Display All Items about Forbidden Game Type?
SELECT i.Name AS Item
		, i.Price
		,i.MinLevel
		,gt.Name AS 'Forbidden Game Type'
FROM Items AS i
JOIN GameTypeForbiddenItems AS gtf
ON gtf.ItemId = i.Id
JOIN GameTypes AS gt
ON gt.Id = gtf.GameTypeId
ORDER BY gt.Name DESC, i.Name


--08. Peaks and Mountains
SELECT p.PeakName
		,m.MountainRange AS Mounntain
		,p.Elevation
FROM Peaks AS p
JOIN Mountains AS m
ON m.Id = p.MountainId
ORDER BY p.Elevation DESC

--09. Peaks with Mountain, Country and Continent
SELECT p.PeakName
		,m.MountainRange AS Mounntain
		,c.CountryName
		,con.ContinentName
FROM Peaks AS p
JOIN Mountains AS m
ON m.Id = p.MountainId
JOIN MountainsCountries AS mc
ON mc.MountainId = m.Id
JOIN Countries AS c
ON c.CountryCode = mc.CountryCode
JOIN Continents AS con
ON con.ContinentCode = c.ContinentCode
ORDER BY p.Peakname

--10. Rivers by Country
SELECT c.CountryName
		,con.ContinentName
		,
		(CASE 
		WHEN COUNT(r.RiverName) IS NULL THEN 0
		ELSE COUNT(r.RiverName)
		END) AS RiversCount
		,
		(CASE 
		WHEN SUM(r.Length) IS NULL THEN 0
		ELSE SUM(r.Length)
		END)  AS TotalLenght
FROM Countries AS c
JOIN Continents AS con
ON con.ContinentCode = c.ContinentCode
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
ON r.Id = cr.RiverId
GROUP BY c.CountryName
		,con.ContinentName
ORDER BY RiversCount DESC, TotalLenght DESC, c.CountryName

--11. Count of Countries by Currency
SELECT cur.CurrencyCode
		,cur.Description AS Currency
		,COUNT(con.ContinentName) AS NumberOfCountries
FROM Currencies AS cur
LEFT JOIN Countries AS c
ON c.CurrencyCode = cur.CurrencyCode
LEFT JOIN Continents AS con
On con.ContinentCode = c.ContinentCode
GROUP BY cur.CurrencyCode, cur.Description
ORDER BY NumberOfCountries DESC, cur.Description

--12. Population and Area by Continent --  çàäà÷à ñ ïðåïúëâàíå íà òèï int!
SELECT con.ContinentName
		, SUM(c.AreaInSqKm)  AS CountriesArea
		,SUM(CAST(c.Population AS BIGINT)) AS CountriesPopulation
FROM Continents AS con
INNER JOIN Countries As c
ON con.ContinentCode = c.ContinentCode
GROUP BY ContinentName
ORDER BY CountriesPopulation DESC

--13.	Monasteries by Country
CREATE TABLE Monasteries(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(255) NOT NULL,
CountryCode CHAR(2) NOT NULL,
CONSTRAINT FK_Monastiries_Countries
FOREIGN KEY(CountryCode)
REFERENCES Countries(CountryCode)
)
GO
INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sumela Monastery', 'TR')

ALTER TABLE Countries
ADD IsDeleted BIT NOT NULL DEFAULT 0 

GO
CREATE TRIGGER tr_DeleteCountriesWithMoreThreeRivers
ON Countries
INSTEAD OF DELETE
AS
BEGIN
	UPDATE Countries
	SET IsDeleted = 1
	SELECT c.CountryName, COUNT(r.RiverName) AS CountOfRivers
	FROM Countries AS c
	INNER JOIN CountriesRivers AS cr
	ON cr.CountryCode = c.CountryCode
	INNER JOIN Rivers AS r
	ON r.Id = cr.RiverId
	GROUP BY c.CountryName
END

DELETE FROM Countries
WHERE 