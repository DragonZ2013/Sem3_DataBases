CREATE PROCEDURE goto_version @goto_version varchar(30)
AS
BEGIN
DECLARE @current_version nvarchar(30),@sqlQuery AS varchar(MAX),@var1 nvarchar(30),@var2 nvarchar(30),@var3 nvarchar(30),@var4 nvarchar(30),@var5 nvarchar(30),@prev_type nvarchar(30),@function varchar(30)
	SELECT @current_version = Current_Version FROM Current_Version
WHILE (@current_version > @goto_version)
BEGIN 
	SELECT @function=Function_Name FROM Version_Updates WHERE Version_ID=@current_version
	IF @function='add_table'
		BEGIN
		SELECT @var1 = Var1 FROM Version_Updates WHERE Version_ID=@current_version
		SET @sqlQuery = 'EXEC remove_table ''' + @var1 +''' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='add_column'
		BEGIN
		SELECT @var1 = Var1,@var2 = Var2 FROM Version_Updates WHERE Version_ID=@current_version
		SET @sqlQuery = 'EXEC remove_column ''' + @var1 +''', '''+ @var2+''' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='change_column_type'
		BEGIN
		SELECT @var1 = Var1,@var2 = Var2, @prev_type = Previous_Type FROM Version_Updates WHERE Version_ID=@current_version
		SET @sqlQuery = 'EXEC change_column_type ''' + @var1 +''','''+ @var2+''','''+ @prev_type+''',''False'' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='add_constraint_default'
		BEGIN
		SELECT @var1 = Var1,@var3 = Var3 FROM Version_Updates WHERE Version_ID=@current_version
		SET @sqlQuery = 'EXEC remove_constraint ''' + @var1 +''','''+ @var3+''' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='add_constraint_foreign'
		BEGIN
		SELECT @var1 = Var1,@var5 = Var5 FROM Version_Updates WHERE Version_ID=@current_version
		SET @sqlQuery = 'EXEC remove_constraint ''' + @var1 +''','''+ @var5+''' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	UPDATE Current_Version SET Current_Version=@current_version-1;
	SELECT @current_version = Current_Version FROM Current_Version
	
END


WHILE (@current_version < @goto_version)
BEGIN
	SELECT @function=Function_Name FROM Version_Updates WHERE Version_ID=@current_version+1
	IF @function='add_table'
		BEGIN
		SELECT @var1 = Var1 FROM Version_Updates WHERE Version_ID=@current_version+1
		SET @sqlQuery = 'EXEC add_table ''' + @var1 +''',''False'' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='add_column'
		BEGIN
		SELECT @var1 = Var1,@var2 = Var2,@var3 = Var3 FROM Version_Updates WHERE Version_ID=@current_version+1
		SET @sqlQuery = 'EXEC add_column ''' + @var1  +''','''+ @var2 +''','''+ @var3 +''',''False'' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='change_column_type'
		BEGIN
		SELECT @var1 = Var1,@var2 = Var2,@var3 = Var3 FROM Version_Updates WHERE Version_ID=@current_version+1
		SET @sqlQuery = 'EXEC change_column_type ''' + @var1  +''','''+ @var2 +''','''+ @var3 +''',''False'' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='add_constraint_default'
		BEGIN
		SELECT @var1 = Var1,@var2 = Var2,@var3 = Var3,@var4 = Var4 FROM Version_Updates WHERE Version_ID=@current_version+1
		SET @sqlQuery = 'EXEC add_constraint_default ''' + @var1  +''','''+ @var2 +''','''+ @var3 +''','''+ @var4 +''',''False'' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END
	IF @function='add_constraint_foreign'
		BEGIN
		SELECT @var1 = Var1,@var2 = Var2,@var3 = Var3,@var4 = Var4,@var5 = Var5 FROM Version_Updates WHERE Version_ID=@current_version+1
		SET @sqlQuery = 'EXEC add_constraint_foreign ''' + @var1  +''','''+ @var2 +''','''+ @var3 +''','''+ @var4 +''','''+ @var5 +''',''False'' ';
		--PRINT @sqlQuery
		EXEC (@sqlQuery)
		END

	UPDATE Current_Version SET Current_Version=@current_version+1;
	SELECT @current_version = Current_Version FROM Current_Version
END

END

--DROP PROC goto_version