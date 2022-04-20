CREATE PROCEDURE remove_table @table_name nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
SET @sqlQuery = 'DROP TABLE '+ @table_name 
EXEC(@sqlQuery)
END


--EXEC remove_table 'Tab2'