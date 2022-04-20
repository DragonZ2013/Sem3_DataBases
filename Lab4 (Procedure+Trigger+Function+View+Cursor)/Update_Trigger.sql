CREATE TRIGGER updateData on Order_List
FOR UPDATE
AS
BEGIN
DECLARE @rowCount AS int
SELECT @rowCount=Count(*) FROM inserted
INSERT INTO LogTable(Change_Date,Change_Type,Table_Name,Number_of_Rows)
VALUES(GETDATE(),'UPDATE','Order_List',@rowCount)
END

--UPDATE Order_List SET Quantity = 20 WHERE Order_ID=1 AND Product_ID=5
--UPDATE Order_List SET Quantity = Quantity+1 WHERE Order_ID=2