CREATE TABLE Tester(
ID int PRIMARY KEY,
Namen varchar(25),
Vornamen varchar(25),
Geburtsdatum date,
Erfahrung int,
)


CREATE TABLE Technologie(
ID int PRIMARY KEY,
Namen varchar(25),
Popularitat int,
)

CREATE TABLE TesterTechnologies(
Tester_ID int REFERENCES Tester(ID),
Technologie_ID int REFERENCES Technologie(ID),
PRIMARY KEY(Tester_ID,Technologie_ID)
)

CREATE TABLE Task(
ID int PRIMARY KEY,
Namen varchar(25),
Beschreibung varchar(50)
)

CREATE TABLE TesterTasks(
ID int PRIMARY KEY,
Tester_ID int REFERENCES Tester(ID),
Task_ID int REFERENCES Task(ID)

)


CREATE TABLE Bugs(
ID int PRIMARY KEY,
Beschreibung varchar(50),
Severity int,
TesterTask_Id int REFERENCES TesterTasks(ID)
)



