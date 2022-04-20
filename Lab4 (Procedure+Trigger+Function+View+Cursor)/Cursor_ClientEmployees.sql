DECLARE cursorClients CURSOR FOR
SELECT Clients.ID,Clients.CNP,Clients.Firstname,Clients.Surname,Store_ID FROM Clients
INNER JOIN Employees ON Clients.CNP=Employees.CNP
FOR READ ONLY
--Selects all the orders of clients which are also employees, applies a 30% sale on each

ALTER PROCEDURE SaleProcedure @Client_ID int,@Client_CNP numeric(13,0),@Client_Firstname varchar(25),@Client_Surname varchar(25),@Store_ID int
AS
BEGIN
SELECT @Client_ID as Client_ID,Order_ID as Order_ID,@Client_CNP as Client_CNP,@Client_Firstname as Client_FirstName,@Client_Surname as Client_Surname, SUM(result.Quantity*Products.Sell_Cost_Unit)*0.7 AS 'Order_Cost' FROM(
SELECT * FROM Order_List WHERE Order_ID IN(
SELECT ID FROM Orders WHERE Orders.Client_ID=@Client_ID)) result
INNER JOIN Products ON result.Product_ID=Products.ID
GROUP BY Order_ID
END

OPEN cursorClients

DECLARE @Client_ID int,@Client_CNP numeric(13,0),@Client_Firstname varchar(25),@Client_Surname varchar(25),@Store_ID int


FETCH cursorClients INTO @Client_ID,@Client_CNP,@Client_Firstname,@Client_Surname,@Store_ID
EXEC SaleProcedure @Client_ID,@Client_CNP,@Client_Firstname,@Client_Surname,@Store_ID 
WHILE @@FETCH_STATUS=0
BEGIN
FETCH cursorClients INTO @Client_ID,@Client_CNP,@Client_Firstname,@Client_Surname,@Store_ID
IF(@@FETCH_STATUS=0)
EXEC SaleProcedure @Client_ID,@Client_CNP,@Client_Firstname,@Client_Surname,@Store_ID 
END

--SELECT * FROM Order_List

CLOSE cursorClients
--DEALLOCATE cursorClients

