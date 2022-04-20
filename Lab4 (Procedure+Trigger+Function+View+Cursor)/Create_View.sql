CREATE VIEW StoreCosts AS
SELECT Store_ID,SUM(Expenses) as Expenses FROM(
SELECT QuantityStock*Purchase_Cost_Unit AS Expenses ,Store_ID FROM Products
UNION ALL
SELECT Salary AS Expenses,Store_ID FROM Employees
) t GROUP BY Store_ID
--SELECT * FROM StoreCosts
