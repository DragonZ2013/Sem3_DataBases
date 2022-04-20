CREATE FUNCTION is_valid_quantity (@quantity varchar(30))
RETURNS int
AS
BEGIN
DECLARE @ret_val int
SET @ret_val = 0
IF (@quantity > 0)
BEGIN
	SET @ret_val = 1
END
RETURN @ret_val
END


--print dbo.is_valid_quantity('4')