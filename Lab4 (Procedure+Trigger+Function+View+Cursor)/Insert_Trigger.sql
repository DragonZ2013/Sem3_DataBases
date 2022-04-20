CREATE TRIGGER insertData on Order_List
FOR INSERT
AS
BEGIN
DECLARE @rowCount AS int
SELECT @rowCount=Count(*) FROM inserted
INSERT INTO LogTable(Change_Date,Change_Type,Table_Name,Number_of_Rows)
VALUES(GETDATE(),'INSERT','Order_List',@rowCount)
END

--INSERT INTO Order_List VALUES (1,5,20)