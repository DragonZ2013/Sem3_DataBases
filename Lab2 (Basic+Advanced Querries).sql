/*
DROP TABLE Tab1
DROP TABLE Tab2

--a)
CREATE TABLE Tab2 (
    ID int NOT NULL,
    Tab_Name varchar(25),
    PRIMARY KEY (ID)
);

CREATE TABLE Tab1 (
    ID int NOT NULL,
    Tab2_ID int NOT NULL,
    Tab_Name varchar(25),
    PRIMARY KEY (ID,Tab2_ID),
    FOREIGN KEY (Tab2_ID) REFERENCES Tab2(ID)
);

--b)
INSERT INTO Premium_Clients(Client_ID,Subscription_ID,Subscription_Date_Start,Subscription_Date_End)
VALUES (1,2,'2021-09-06','2021-09-13')
--c)
INSERT INTO Orders(Client_ID,Order_Date,Store_ID)
VALUES(3,'2021-10-19',2)

--d)
--1.Removes expired Subscriptions from Table
DELETE FROM Premium_Clients WHERE Premium_Clients.Subscription_Date_End<GETDATE()	
--INSERT INTO Complaints(Order_ID,Employee_ID,Complaint_Text,Completed)
--VALUES(2,5,'Requesting Refund',0)
--2.Increases manager salaries by 10% if they're under 1200
UPDATE Employees SET Salary=Salary*1.1 WHERE Manager_ID IS NULL AND Salary < 1200
--3.Increases regular(non-manager) employee salary by 10 if they're between 160 and 300
UPDATE Employees SET Salary=Salary+10 WHERE Manager_ID IS NOT NULL AND Salary BETWEEN 160 AND 300
--4.Increases employee salary by 100 if they're in Departaments 2 or 3 (Stocking & Unloading or Delivery)	
UPDATE Employees SET Salary=Salary+100 WHERE Departament_ID IN (3,2)
--5.Removes complaints regarding refunds
DELETE FROM Complaints WHERE Complaint_Text LIKE '%refund%'

*/

--1.Shows active subscriptions
SELECT * FROM Premium_Clients WHERE GETDATE() BETWEEN Subscription_Date_Start AND Subscription_Date_End


--2. Selects Complaints from active Premium Users with a Subscription Type that has Complaint Privilleges 
SELECT Complaints.ID,Clients.Firstname,Clients.Surname,Orders.Store_ID,Complaints.Complaint_Text FROM Complaints 
INNER JOIN Orders ON Complaints.Order_ID=Orders.ID 
INNER JOIN Clients ON Orders.Client_ID = Clients.ID 
INNER JOIN Premium_Clients ON Premium_Clients.Client_ID=Clients.ID 
INNER JOIN Subscription_Type ON Premium_Clients.Subscription_ID=Subscription_Type.ID
WHERE Subscription_Date_End>GETDATE() AND Subscription_Date_Start<GETDATE() AND Complaint_Premium=1


--3.Counts number of employees in each departament of each store except 5 (maintanance)
SELECT Store_ID,Store_Name,Departament_ID,Department_Name,COUNT(*) AS 'Number of Employees' FROM Employees 
FULL OUTER JOIN Store ON Employees.Store_ID=Store.ID
INNER JOIN Departments ON Employees.Departament_ID=Departments.ID
GROUP BY Store_ID,Departament_ID,Store.Store_Name,Departments.Department_Name
HAVING Departament_ID!=5 --can use EXCEPT
ORDER BY Store_ID,Departament_ID


--4.Calculates the total expenses for salaries and products per store and shows the ones above 500
SELECT Store_ID,SUM(Expenses) as Expenses FROM(
SELECT QuantityStock*Purchase_Cost_Unit AS Expenses ,Store_ID FROM Products
UNION ALL
SELECT Salary AS Expenses,Store_ID FROM Employees
) t GROUP BY Store_ID



--5.Order Cost (without sales)
SELECT Order_ID,Price,Store_ID FROM
(SELECT Order_ID,SUM(Order_List.Quantity*Products.Sell_Cost_Unit) AS 'Price' FROM Order_List
INNER JOIN Products ON Product_ID=Products.ID
GROUP BY Order_ID) result
INNER JOIN Orders ON Orders.ID=result.Order_ID





--6.Employees which are also clients (will be eligible for a sale - TO INPLEMENT IN 5.)
SELECT Clients.ID,Clients.Firstname,Clients.Surname FROM Clients WHERE Clients.CNP IN
(SELECT Employees.CNP FROM Employees
WHERE Employees.Departament_ID=5
INTERSECT
SELECT Clients.CNP FROM Clients)

--7.Selects shops that have no employees (OUTER JOIN Example)
SELECT Store.ID,Store.Store_Name FROM Store
LEFT JOIN Employees ON Employees.Store_ID=Store.ID
EXCEPT
SELECT Store.ID,Store.Store_Name FROM Store
INNER JOIN Employees ON Employees.Store_ID=Store.ID


--8.Select the first try employees with a below average wage from Store 1 by their highest Average/Salary ratio (priorities for raises)
SELECT TOP 3 Employees.ID,Salary,Average_Salary/Salary AS 'Salary Ratio',Departament_ID,Firstname,Surname FROM(
SELECT Departament_ID as Dep_ID,AVG(Employees.Salary) AS 'Average_Salary' FROM Employees
GROUP BY Employees.Departament_ID,Store_ID
HAVING Store_ID=1) result
INNER JOIN Employees ON Dep_ID = Employees.Departament_ID
WHERE Salary<Average_Salary
ORDER BY Average_Salary/Salary DESC


--9.Selects all employees with a salary above any manager which aren't also clients and below anyone from departament 2 or 5(Stocking & Delivery / Maintanance)
SELECT * FROM Employees E1
WHERE E1.Salary>ANY 
(SELECT E2.Salary FROM Employees E2
WHERE E2.Manager_ID IS NULL)
AND E1.CNP
NOT IN (SELECT Clients.CNP FROM Clients)
AND
E1.Salary<ALL
(SELECT E3.Salary FROM Employees E3
WHERE E3.Departament_ID=2 OR E3.Departament_ID=5)
/*
(SELECT E3.Salary FROM Employees E3
WHERE E3.Departament_ID=2
UNION
SELECT E3.Salary FROM Employees E3
WHERE E3.Departament_ID=5)
*/

--10. Shows all products which get purchased
SELECT DISTINCT Product_ID,Products.Product_Name FROM Order_List result
INNER JOIN Products ON result.Product_ID=Products.ID


--11. Shows the stores with an average salary above 500
SELECT Store_ID,AVG(Salary) AS 'Average_Salary' FROM Employees
GROUP BY Store_ID
HAVING AVG(Salary)>500

--12. Shows the stores with more than 2 employees
SELECT Store_ID,COUNT(*) AS 'Employees' FROM Employees
GROUP BY Store_ID
HAVING COUNT(*) > 2


--test line

SELECT * FROM Products