-- find all the fighters under 27
SELECT *
FROM  Fighters f
WHERE dbo.FindYearsSince(f.dateOfBirth) < 27