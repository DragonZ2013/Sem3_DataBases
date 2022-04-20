--Calculates the Net Income of each store
--Todo, sell more products on negatives

SELECT StoreCosts.Store_ID,ISNULL(Price ,0)-ISNULL(Expenses ,0) AS Income FROM dbo.StoreIncome(1000)
INNER JOIN StoreCosts ON dbo.StoreIncome.Store_ID=StoreCosts.Store_ID