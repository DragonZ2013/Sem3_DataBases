EXEC add_table 'Tab1'
EXEC add_table 'Tab2'
EXEC add_column 'Tab1','ID_Tab2','int'
EXEC add_constraint_foreign 'Tab1','Tab2','ID_Tab2','ID','Constraint_FK1'
EXEC add_column 'Tab2','Col_Constraint1','nvarchar(5)'
EXEC change_column_type 'Tab2','Col_Constraint1','nvarchar(20)'
EXEC add_constraint_default 'Tab2','Col_Constraint1','Constraint_Default1','val1'

EXEC remove_constraint 'Tab2','Constraint_Default1'
EXEC change_column_type 'Tab2','Col_Constraint1','nvarchar(5)'
EXEC remove_column 'Tab2','Col_Constraint1'
EXEC remove_constraint 'Tab1','Constraint_FK1'
EXEC remove_column 'Tab1','ID_Tab2'
EXEC remove_table 'Tab2'
EXEC remove_table 'Tab1'
