CREATE PROCEDURE add_table @table_name nvarchar(30),@new_version nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
IF @new_version='True'
BEGIN
	DECLARE @current_version varchar(30)
	SELECT @current_version = Current_Version FROM Current_Version
	SET @sqlQuery = 'INSERT INTO Version_Updates (Previous_Version,Function_Name,Var1) VALUES ('''+ @current_version +''',''add_table'','''+@table_name+''')'
	PRINT (@sqlQuery)
	EXEC (@sqlQuery)
	UPDATE Current_Version SET Current_Version=@current_version+1;
END
SET @sqlQuery = 'CREATE TABLE '+ @table_name +' (ID int NOT NULL PRIMARY KEY)'
EXEC(@sqlQuery)
END


--EXEC add_table 'Tab1'
--DROP PROC add_table