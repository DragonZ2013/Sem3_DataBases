CREATE PROCEDURE remove_constraint @table_name nvarchar(30)	,@constraint_name nvarchar(30)
AS
BEGIN
DECLARE @sqlQuery AS varchar(MAX)
SET @sqlQuery = 'ALTER TABLE '+ @table_name +' DROP CONSTRAINT ' + @constraint_name
EXEC(@sqlQuery)
END


--EXEC remove_constraint 'Tab1','Constraint1'