CREATE FUNCTION StationWithTrain(@time time)
RETURNS @StationTable TABLE (Station_ID int)
AS
BEGIN
INSERT INTO @StationTable
SELECT station_id FROM RouteSchedule WHERE time_in<=@time AND time_out>=@time GROUP BY station_id HAVING COUNT(*)>1
RETURN
END

SELECT * FROM dbo.StationWithTrain('15:40:00.0')
SELECT * FROM dbo.StationWithTrain('17:40:00.0')

