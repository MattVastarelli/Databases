--order fighters by the most wins 
--baised on their fights recorded in the database

USE CombatSports

SELECT
	f.fighterName,
	COUNT(p.isWinner) TotalWins
FROM Panels p
INNER JOIN Fighters f
	ON p.fighterID = f.fighterID
GROUP BY f.fighterName
ORDER BY TotalWins DESC