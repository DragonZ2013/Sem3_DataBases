
CREATE TABLE TrainTypes(
id int PRIMARY KEY,
train_type_desc varchar(255),
)

CREATE TABLE Trains(
id int PRIMARY KEY,
train_name varchar(30),
train_type int FOREIGN KEY REFERENCES TrainTypes(id)
)

CREATE TABLE TrainRoutes(
id int PRIMARY KEY,
train_id int FOREIGN KEY REFERENCES Trains(id),
route_name varchar(30)
)

CREATE TABLE Stations(
id int PRIMARY KEY,
station_name varchar(30)
)

CREATE TABLE RouteSchedule(
route_id int FOREIGN KEY REFERENCES TrainRoutes(id),
station_id int FOREIGN KEY REFERENCES Stations(id),
time_in time,
time_out time,
PRIMARY KEY(route_id,station_id)
)



INSERT INTO TrainTypes(id,train_type_desc) VALUES (1,'traintype1')
INSERT INTO Trains(id,train_name,train_type) VALUES (1,'testtrain1',1)
INSERT INTO TrainRoutes(id,train_id,route_name) VALUES (1,1,'routename1')
INSERT INTO Stations(id,station_name) VALUES (1,'station1'),(2,'station2')

INSERT INTO Trains(id,train_name,train_type) VALUES (2,'testtrain2',1)
INSERT INTO TrainRoutes(id,train_id,route_name) VALUES (2,2,'routename2')

INSERT INTO TrainRoutes(id,train_id,route_name) VALUES (3,2,'routename3')

--SELECT * FROM RouteSchedule

--DO STUFF IF EXISTS
IF((SELECT COUNT(*) FROM RouteSchedule WHERE route_id = 3 AND station_id = 2)=1)
BEGIN
PRINT('TRUE')
END
ELSE
BEGIN
PRINT('FALSE')
END