-- select the fighter with the longest reach
USE CombatSports

SELECT  TOP 1
  f.fighterID,
  f.fighterName,
  p.reach
FROM Fighters f
INNER JOIN	PhysicalStats p
ON f.fighterID = p.fighterID
ORDER BY  p.reach DESC