CREATE PROCEDURE add_constraint_default @table_name nvarchar(30),@column_name nvarchar(30),@constraint_name nvarchar(30),@default_value nvarchar(30),@new_version nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
IF @new_version='True'
BEGIN
	DECLARE @current_version varchar(30)
	SELECT @current_version = Current_Version FROM Current_Version
	SET @sqlQuery = 'INSERT INTO Version_Updates (Previous_Version,Function_Name,Var1,Var2,Var3,Var4) VALUES ('''+ @current_version +''',''add_constraint_default'','''+@table_name+''','''+@column_name+''','''+@constraint_name+''','''+@default_value+ ''')'
	PRINT (@sqlQuery)
	EXEC (@sqlQuery)
	UPDATE Current_Version SET Current_Version=@current_version+1;
END
SET @sqlQuery = 'ALTER TABLE '+ @table_name +' ADD CONSTRAINT ' + @constraint_name +' DEFAULT '''+@default_value+''' FOR ' + @column_name
EXEC(@sqlQuery)
END

--EXEC add_constraint_default 'Tab1','Col1','Constraint1','Default'
--DROP PROC add_constraint_default
