--find the reach of the top five fighters in the lightweight division

USE CombatSports

SELECT
	TopFighters.fighterName,
	TopFighters.TotalWins,
	p.reach
FROM
	(
		SELECT TOP 5
			f.fighterID,
			f.fighterName,
			COUNT(p.isWinner) TotalWins
		FROM Panles p
		INNER JOIN Fighters f
			ON p.fighterID = f.fighterID
		GROUP BY f.fighterName, f.fighterID
		ORDER BY TotalWins DESC
	) TopFighters
INNER JOIN PhysicalStats p
	ON TopFighters.fighterID = p.fighterID
WHERE p.normalWeight = '155'
ORDER BY TotalWins DESC