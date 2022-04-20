CREATE PROCEDURE create_table @table_name nvarchar(30)
AS
BEGIN
CREATE TABLE temp_name(
ID int
)
EXEC sp_rename 'temp_name',@table_name

END

DROP PROC create_table


EXEC create_table @table_name = 'test_name2'
