CREATE TRIGGER deleteData on Order_List
FOR DELETE
AS
BEGIN
DECLARE @rowCount AS int
SELECT @rowCount=Count(*) FROM deleted
INSERT INTO LogTable(Change_Date,Change_Type,Table_Name,Number_of_Rows)
VALUES(GETDATE(),'DELETE','Order_List',@rowCount)
END

--DELETE FROM Order_List WHERE Order_ID=1 AND Product_ID=5