-- find all the fighters whos nickname starts with the
USE CombatSports

SELECT *
FROM  Fighters f
WHERE  f.nickName LIKE	'the%'