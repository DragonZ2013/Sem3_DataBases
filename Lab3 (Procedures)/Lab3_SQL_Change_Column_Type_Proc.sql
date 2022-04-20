CREATE PROCEDURE change_column_type @table_name nvarchar(30),@column_name nvarchar(30), @column_type nvarchar(30),@new_version nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
IF @new_version='True'
BEGIN
DECLARE @current_version varchar(30),@previous_type varchar(30),@type_size varchar(30)
	SELECT @current_version = Current_Version FROM Current_Version
	SELECT @previous_type = DATA_TYPE, @type_size = CHARACTER_MAXIMUM_LENGTH
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE 
			TABLE_NAME = @table_name AND 
			COLUMN_NAME = @column_name
	IF @type_size IS NOT NULL
	BEGIN
		SET @previous_type = @previous_type +'('+@type_size+')'
	END
	SET @sqlQuery = 'INSERT INTO Version_Updates (Previous_Version,Function_Name,Var1,Var2,Var3,Previous_Type) VALUES ('''+ @current_version +''',''change_column_type'','''+@table_name+''','''+@column_name+''','''+@column_type+''','''+@previous_type+''')'
	PRINT (@sqlQuery)
	EXEC (@sqlQuery)
	UPDATE Current_Version SET Current_Version=@current_version+1;
END
SET @sqlQuery = 'ALTER TABLE '+ @table_name +' ALTER COLUMN ' + @column_name +' '+ @column_type
EXEC(@sqlQuery)
END


--EXEC change_column_type 'Tab1','Col1','varchar(25)'
--DROP PROC change_column_type