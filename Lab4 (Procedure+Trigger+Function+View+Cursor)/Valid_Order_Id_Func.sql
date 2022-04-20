CREATE FUNCTION is_valid_order_id (@order_id varchar(30))
RETURNS int
AS
BEGIN
DECLARE @ret_val int
SELECT @ret_val = COUNT(*) FROM Orders WHERE ID = @order_id
RETURN @ret_val
END

--print dbo.is_valid_order_id('1')

