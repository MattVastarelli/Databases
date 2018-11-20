--find and rank weight class  by number of fights in the current year
-- inorder to determine how active each weight class is
USE CombatSports

SELECT
	COUNT(DISTINCT c.cardName + CONVERT(varchar(100), f.fightNum)) DistinctFights,
	w.weightClass
FROM  Cards c
INNER JOIN  Fights f
	ON c.cardName = f.cardName 
INNER JOIN FightCombatants fc
	ON  f.cardName = fc.cardName 
	AND f.fightNum = fc.fightNum
INNER JOIN WeightClasses w
	ON  f.cardName = w.cardName
	AND f.fightNum = w.fightNum
WHERE dbo.FindYearsSince(c.fightDate) < 1
GROUP BY w.weightClass
ORDER BY w.weightClass ASC