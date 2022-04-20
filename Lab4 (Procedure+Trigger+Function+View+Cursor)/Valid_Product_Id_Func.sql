CREATE FUNCTION is_valid_product_id (@product_id varchar(30))
RETURNS int
AS
BEGIN
DECLARE @ret_val int
SELECT @ret_val = COUNT(*) FROM Products WHERE ID = @product_id
RETURN @ret_val
END

--print dbo.is_valid_product_id('1')