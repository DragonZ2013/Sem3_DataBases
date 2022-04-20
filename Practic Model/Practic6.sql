DECLARE cursorRoutes CURSOR FOR
SELECT train_name,station_name,time_in,time_out FROM RouteSchedule
INNER JOIN Stations ON RouteSchedule.station_id=Stations.id
INNER JOIN TrainRoutes ON RouteSchedule.route_id=TrainRoutes.id
INNER JOIN Trains ON TrainRoutes.train_id=Trains.id
FOR READ ONLY

--DEALLOCATE cursorRoutes



OPEN cursorRoutes

DECLARE @train_name varchar(30),@station_name varchar(30),@time_in time,@time_out time
FETCH cursorRoutes INTO @train_name,@station_name,@time_in,@time_out
IF(@@FETCH_STATUS=0)
BEGIN
PRINT('Der Zug '+@train_name+' kommt in dem Bahnhof '+@station_name+' um '+CAST(@time_in AS CHAR(16))+' an und er verlässt den Bahnhof um '+CAST(@time_out AS CHAR(16))+'.' )
IF(DATEDIFF(MINUTE, @time_in, @time_out)>60)
BEGIN
PRINT('Der Zug '+@train_name +' bleibt mehr als eine Stunde in dem Bahnhof'+@station_name +'.')
END
END
WHILE @@FETCH_STATUS=0
BEGIN
FETCH cursorRoutes INTO @train_name,@station_name,@time_in,@time_out
IF(@@FETCH_STATUS=0)
BEGIN
PRINT('Der Zug '+@train_name+' kommt in dem Bahnhof '+@station_name+' um '+CAST(@time_in AS CHAR(16))+' an und er verlässt den Bahnhof um '+CAST(@time_out AS CHAR(16))+'.')
IF(DATEDIFF(MINUTE, @time_in, @time_out)>60)
BEGIN
PRINT('Der Zug '+@train_name +' bleibt mehr als eine Stunde in dem Bahnhof'+@station_name +'.')
END
END
END

CLOSE cursorRoutes