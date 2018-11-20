--find the reach of the top five fighters in the lightweight division

USE CombatSports

SELECT
	TopFighters.*
FROM
	(
		SELECT TOP 5
			f.fighterName,
			COUNT(p.isWinner) TotalWins
		FROM Panles p
		INNER JOIN Fighters f
			ON p.fighterID = f.fighterID
		GROUP BY f.fighterName
		ORDER BY TotalWins DESC
	) TopFighters