CREATE VIEW FullRoutes AS
SELECT route_name FROM RouteSchedule
INNER JOIN TrainRoutes ON TrainRoutes.id = RouteSchedule.route_id
GROUP BY route_name
HAVING count(*) = (SELECT count(*) FROM Stations) 


SELECT * FROM FullRoutes