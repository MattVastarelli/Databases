--find the fighter with the most wins on their record by weight class
USE CombatSports

SELECT
	p.cardName,
	p.fightNum,
	p.fighterID,
	p.isWinner,
	f.fighterName
FROM Panles p
INNER JOIN Fighters f
	ON p.fighterID = f.fighterID