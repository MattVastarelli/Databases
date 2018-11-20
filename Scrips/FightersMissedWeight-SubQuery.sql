--find all the fighters that have been in a fight where 
--one fighter missed weight in the last year

USE CombatSports

SELECT 
	f.fighterName,
	FighterWeights.weightClass,
	p.normalWeight
FROM (
		SELECT 
			c.fightDate,
			fc.fighterID,
			w.weightClass
		FROM FightCombatants fc
		INNER JOIN Fights f
			ON fc.cardName = f.cardName
			AND fc.fightNum = f.fightNum
		INNER JOIN Cards c
			ON f.cardName = c.cardName
		INNER JOIN WeightClasses w
			ON f.cardName = w.cardName
			AND f.fightNum = w.fightNum
		WHERE dbo.FindYearsSince(c.fightDate) < 1
	) FighterWeights
INNER JOIN PhysicalStats p
	ON FighterWeights.fighterID = p.fighterID
INNER JOIN Fighters f
	ON p.fighterID = f.fighterID
WHERE FighterWeights.weightClass != p.normalWeight
