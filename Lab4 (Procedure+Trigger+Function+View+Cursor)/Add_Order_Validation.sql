CREATE PROCEDURE add_order @order_id varchar(30),@product_id varchar(30),@quantity varchar(30)
AS
BEGIN
DECLARE @confirm int
SET @confirm = 0
IF (dbo.is_valid_order_id(@order_id)=1)
BEGIN
	IF (dbo.is_valid_product_id(@product_id)=1)
	BEGIN
		IF(dbo.is_valid_quantity(@quantity)=1)
		BEGIN
			IF(dbo.is_in_list(@product_id,@order_id)=0)
			BEGIN
				SET @confirm = 1
				INSERT INTO Order_List (Order_ID,Product_ID,Quantity) VALUES (@order_id,@product_id,@quantity)
			END
		END
	END
END
IF (@confirm = 0)
BEGIN
PRINT 'Invalid data'
END
END
--EXEC add_order '1','1','1' 