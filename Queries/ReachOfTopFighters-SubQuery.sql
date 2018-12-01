--find the reach of the top five fighters in the lightweight division

USE CombatSports

SELECT TOP 5
	TopFighters.fighterName,
	TopFighters.TotalWins,
	p.reach
FROM
	(
		SELECT
			f.fighterID,
			f.fighterName,
			COUNT(p.isWinner) TotalWins
		FROM Panels p
		INNER JOIN Fighters f
			ON p.fighterID = f.fighterID
		GROUP BY f.fighterName, f.fighterID
	) TopFighters
INNER JOIN PhysicalStats p
	ON TopFighters.fighterID = p.fighterID
WHERE p.normalWeight = '155'
ORDER BY TopFighters.TotalWins DESC