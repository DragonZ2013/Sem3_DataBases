ALTER PROCEDURE populate_tables 
AS
BEGIN
SET NOCOUNT ON
DECLARE @cnt INT = 1;

WHILE @cnt <= 10000
BEGIN
INSERT INTO Ta VALUES (@cnt,RAND()*((@cnt+1)*100-@cnt*100)+(@cnt-1)*100,@cnt)
SET @cnt = @cnt+1
END

SET @cnt = 1

WHILE @cnt <= 3000
BEGIN
INSERT INTO Tb VALUES (@cnt,RAND()*1000000)
SET @cnt = @cnt+1
END

DECLARE @cnt2 INT =1;
SET @cnt =1;

WHILE @cnt <= 10
BEGIN
WHILE @cnt2 <= 3000
BEGIN
INSERT INTO Tc VALUES ((@cnt-1)*10000+@cnt2,@cnt,@cnt2)
SET @cnt2 = @cnt2+1
END
SET @cnt2 = 1
SET @cnt = @cnt+1

--SET NOCOUNT OFF
END

END