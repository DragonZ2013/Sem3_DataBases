
--DROP TABLE Tab2
--DROP TABLE Tab1
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
--Shows active subscriptions(SELECT)
SELECT * FROM Premium_Clients WHERE GETDATE() BETWEEN Subscription_Date_Start AND Subscription_Date_End




--1. Selects Complaints from active Premium Users with a Subscription Type that has Complaint Privilleges 
SELECT Complaints.ID,Clients.Firstname,Clients.Surname,Complaints.Complaint_Text FROM Complaints 
INNER JOIN Orders ON Complaints.Order_ID=Orders.ID 
INNER JOIN Clients ON Orders.Client_ID = Clients.ID 
INNER JOIN Premium_Clients ON Premium_Clients.Client_ID=Clients.ID 
INNER JOIN Subscription_Type ON Premium_Clients.Subscription_ID=Subscription_Type.ID
WHERE Subscription_Date_End>GETDATE() AND Complaint_Premium=1


--2.Counts number of employees in each departament - TODO mix with inner join for Departament names
SELECT Departament_ID,Count(*) FROM Employees Group By Departament_ID

--3.Calculates the total salary
SELECT SUM(Salary) FROM Employees