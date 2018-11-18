-- =============================================
-- Author:		Matthew vastarelli
-- Create date: 11/18/2018
-- Description:	return the given age based of the curent time
-- =============================================
CREATE FUNCTION dbo.FindYearsSince (@dob datetime)
RETURNS int
AS
BEGIN
	-- Declare the variables
	DECLARE @currentDate datetime
	DECLARE @yearsSince int

	--T-SQL statements to compute the return value here
	SELECT @currentDate = GETDATE()
	SELECT @yearsSince = (0 + Convert(Char(8),@currentDate,112) - Convert(Char(8),@dob,112)) / 10000

	-- Return the result of the function
	RETURN @yearsSince

END
GO
