CREATE OR ALTER TRIGGER insertStation on RouteSchedule
INSTEAD OF INSERT
AS
BEGIN
INSERT INTO RouteSchedule(route_id,station_id,time_in,time_out)
SELECT route_id,station_id,time_in,time_out FROM inserted WHERE (time_in>'5:00:00.0' OR time_in<'3:00:00.0') AND (time_out>'5:00:00.0' OR time_out<'3:00:00.0')

END


SELECT * FROM RouteSchedule	
DELETE FROM RouteSchedule WHERE route_id=2 AND station_id=2
INSERT INTO RouteSchedule(route_id,station_id,time_in,time_out) VALUES (2,2,'6:00:00.0','5:19:00.0')