CREATE FUNCTION is_in_list (@product_id varchar(30),@order_id varchar(30))
RETURNS int
AS
BEGIN
DECLARE @ret_val int
SELECT @ret_val = COUNT(*) FROM Order_List WHERE Product_ID = @product_id AND Order_ID = @order_id
RETURN @ret_val
END


--print dbo.is_in_list('1','7')