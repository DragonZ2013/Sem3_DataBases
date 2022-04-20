CREATE PROCEDURE remove_column @table_name nvarchar(30),@column_name nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
SET @sqlQuery = 'ALTER TABLE '+ @table_name +' DROP COLUMN ' + @column_name
EXEC(@sqlQuery)
END


--EXEC remove_column 'Tab1','Col1'