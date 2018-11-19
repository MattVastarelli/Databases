--find the fighter with the best striking offense
USE CombatSports

SELECT TOP 1 
  f.fighterName,
  f.fighterID,
  s.attempt,
  s.success,
  s.accuracy
FROM  Fighters f
INNER JOIN  StrkingStats s
ON  f.fighterID = s.FighterID
ORDER BY s.accuracy DESC
