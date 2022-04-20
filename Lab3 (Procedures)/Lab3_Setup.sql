EXEC add_table 'T1','True'
EXEC add_column 'T1','Col1','varchar(30)','True'
EXEC change_column_type 'T1','Col1','char(50)','True'
EXEC add_constraint_default 'T1','Col1','Default_Constraint1','test','True'
EXEC add_table 'T2','True'
EXEC add_column 'T1','idT2','int','True'
EXEC add_constraint_foreign 'T1','T2','idT2','ID','FK_Constraint1','True'
EXEC add_column 'T2','nr','int','True'
EXEC add_constraint_default 'T2','nr','Default_Constraint2','0','True'

--DBCC CHECKIDENT ('Version_Updates', RESEED,0);
SELECT * FROM Version_Updates
SELECT * FROM Current_Version

EXEC goto_version '0'
--DELETE FROM Version_Updates