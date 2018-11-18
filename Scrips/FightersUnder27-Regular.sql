-- =============================================
-- Author:		Matthew vastarelli
-- Create date: 11/18/2018
-- Description:	return the given age based of the curent time
-- =============================================
CREATE FUNCTION dbo.FindAge (@dob datetime)
RETURNS int
AS
BEGIN
	-- Declare the variables
	DECLARE @currentDate datetime
	DECLARE @yearsOfAge int

	--T-SQL statements to compute the return value here
	SELECT @currentDate = GETDATE()
	SELECT @yearsOfAge = (0 + Convert(Char(8),@currentDate,112) - Convert(Char(8),@dob,112)) / 10000

	-- Return the result of the function
	RETURN @yearsOfAge

END
GO

-- find all the fighters under 27
SELECT *
FROM  Fighters f
WHERE dbo.FindAge(f.dateOfBirth) < 27