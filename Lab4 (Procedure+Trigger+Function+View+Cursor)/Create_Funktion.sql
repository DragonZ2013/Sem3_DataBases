CREATE FUNCTION StoreIncome(@min_inc float)
RETURNS @OrdersCost TABLE (Store_ID int,Price float)
AS
BEGIN
INSERT INTO @OrdersCost
SELECT Store_ID,SUM(Price) FROM(
SELECT Order_ID,Price,Store_ID FROM
(SELECT Order_ID,SUM(Order_List.Quantity*Products.Sell_Cost_Unit) AS 'Price' FROM Order_List
INNER JOIN Products ON Product_ID=Products.ID
GROUP BY Order_ID) result
INNER JOIN Orders ON Orders.ID=result.Order_ID) t
GROUP BY Store_ID
HAVING SUM(Price)>@min_inc
RETURN
END

--SELECT * FROM dbo.StoreIncome(1000)