CREATE VIEW MinStations AS
SELECT route_id FROM RouteSchedule GROUP BY route_id HAVING COUNT(*)=
(SELECT MIN(number_stations) FROM (
SELECT COUNT(*) AS number_stations FROM RouteSchedule GROUP BY route_id HAVING COUNT(*)<=5) as Ta)

CREATE VIEW MinStations AS
SELECT TOP(1) WITH TIES route_id AS number_stations FROM RouteSchedule GROUP BY route_id HAVING COUNT(*)<=5 ORDER BY COUNT(*) ASC



DROP VIEW MinStations

SELECT * from MinStations