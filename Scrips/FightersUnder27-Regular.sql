-- find all the fighters under 27
USE CombatSports

SELECT *
FROM  Fighters f
WHERE dbo.FindYearsSince(f.dateOfBirth) < 27