CREATE PROCEDURE add_constraint_foreign @table_name1 nvarchar(30),@table_name2 nvarchar(30),@column_name1 nvarchar(30),@column_name2 nvarchar(30),@constraint_name nvarchar(30),@new_version nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
IF @new_version='True'
BEGIN
	DECLARE @current_version varchar(30)
	SELECT @current_version = Current_Version FROM Current_Version
	SET @sqlQuery = 'INSERT INTO Version_Updates (Previous_Version,Function_Name,Var1,Var2,Var3,Var4,Var5) VALUES ('''+ @current_version +''',''add_constraint_foreign'','''+@table_name1+''','''+@table_name2+''','''+@column_name1+''','''+@column_name2+''','''+@constraint_name+ ''')'
	PRINT (@sqlQuery)
	EXEC (@sqlQuery)
	UPDATE Current_Version SET Current_Version=@current_version+1;
END
SET @sqlQuery = 'ALTER TABLE '+ @table_name1 +' ADD CONSTRAINT ' + @constraint_name + ' FOREIGN KEY ('+@column_name1+') REFERENCES '+@table_name2+'('+@column_name2+');'
EXEC(@sqlQuery)
END

--EXEC add_constraint_foreign 'Tab1','Tab2','Tab2_ID','ID','ConstraintFK'
--DROP PROC add_constraint_foreign
