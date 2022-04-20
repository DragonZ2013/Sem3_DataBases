CREATE PROCEDURE add_column @table_name nvarchar(30),@column_name nvarchar(30), @column_type nvarchar(30),@new_version nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
IF @new_version='True'
BEGIN
	DECLARE @current_version varchar(30)
	SELECT @current_version = Current_Version FROM Current_Version
	SET @sqlQuery = 'INSERT INTO Version_Updates (Previous_Version,Function_Name,Var1,Var2,Var3) VALUES ('''+ @current_version +''',''add_column'','''+@table_name+''','''+@column_name+''','''+@column_type+''')'
	PRINT (@sqlQuery)
	EXEC (@sqlQuery)
	UPDATE Current_Version SET Current_Version=@current_version+1;
END
SET @sqlQuery = 'ALTER TABLE '+ @table_name +' ADD ' + @column_name +' '+ @column_type
EXEC(@sqlQuery)
END


--EXEC add_column 'Tab1','Col1','int'
--DROP PROC add_column