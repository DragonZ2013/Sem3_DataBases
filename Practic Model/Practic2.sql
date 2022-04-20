CREATE PROCEDURE UpdateRoute @route_id int,@station_id int,@new_time_in time,@new_time_out time
AS
BEGIN
DELETE FROM RouteSchedule WHERE route_id=@route_id AND station_id=@station_id
INSERT INTO RouteSchedule(route_id,station_id,time_in,time_out) VALUES (@route_id,@station_id,@new_time_in,@new_time_out)

END




INSERT INTO TrainTypes(id,train_type_desc) VALUES (1,'traintype1')
INSERT INTO Trains(id,train_name,train_type) VALUES (1,'testtrain1',1)
INSERT INTO TrainRoutes(id,train_id,route_name) VALUES (1,1,'routename1')
INSERT INTO Stations(id,station_name) VALUES (1,'station1'),(2,'station2')

-- FOREIGN KEY CONFLICT
EXEC UpdateRoute 3,1,'19:21:00.0','22:19:00.0'

EXEC UpdateRoute 1,1,'19:21:00.0','22:19:00.0'
EXEC UpdateRoute 1,1,'17:21:00.0','19:19:00.0'
EXEC UpdateRoute 1,2,'14:21:00.0','16:19:00.0'


EXEC UpdateRoute 2,1,'15:21:00.0','18:19:00.0'


EXEC UpdateRoute 3,2,'15:21:00.0','18:19:00.0'
SELECT * FROM RouteSchedule

SELECT route_id FROM RouteSchedule GROUP BY route_id HAVING COUNT(*)=
(SELECT MIN(number_stations) FROM (
SELECT COUNT(*) AS number_stations FROM RouteSchedule GROUP BY route_id HAVING COUNT(*)<5) as Ta)

SELECT SUM(COUNT(*)) FROM RouteSchedule GROUP BY route_id

