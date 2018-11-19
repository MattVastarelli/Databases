--find and rank weight class  by number of fights in the current year
-- inorder to determine how active each weight  class is
USE CombatSports

SELECT
	COUNT(fc.fighterID) NumOfFights,
	w.weightClass
FROM  Cards c
INNER JOIN  Fights f
	ON c.cardName = f.cardName 
INNER JOIN FightCombatants fc
	ON  fc.cardName = f.cardName 
	AND fc.fightNum = f.fightNum
INNER JOIN WeightClasses w
	ON  f.cardName = w.cardName
	AND f.fightNum = w.fightNum
WHERE dbo.FindYearsSince(c.fightDate) < 1
GROUP BY w.weightClass
ORDER BY NumOfFights DESC