--CTRL+M -> Execution plan
--a)
EXEC sp_helpindex Ta
EXEC sp_helpindex Tb
EXEC sp_helpindex Tc
--Clustered Index Scan
select valueA from ta
select ida from ta WHERE valuea=71
--Clustered Index Seek
select * from ta WHERE ida=10
select * from ta WHERE a2<1000
--Nonclustered Index Scan
select ida,a2 from ta
select a2 from ta
select ida from ta where a2%100<50
--Nonclustered Index Seek
select ida from ta WHERE a2<500000
--b)
select * from ta WHERE a2=430
--c)
select * from tb WHERE b2=976229
--subtree cost without nonclustered index:0.0110264
--subtree cost with nonclustered index:0.0032831
DROP INDEX tb_nc_index ON tb 
CREATE NONCLUSTERED INDEX tb_nc_index ON tb (b2)

--d)
--SELECT idb FROM tc where idA=5
--SELECT ida FROM tc where idB=26

--subtree cost without nonclustered indexes (ta)0.39 (tb)0.31
--subtree cost with nonclustered indexes (ta)0.19 (tb)0.16

SELECT idc,ta.ida FROM tc INNER JOIN ta ON tc.idA=ta.idA
SELECT idc,tb.idb FROM tc INNER JOIN tb ON tc.idB=tb.idB AND tc.idB<5000


DROP INDEX tc_nc_indexa ON tc
DROP INDEX tc_nc_indexb ON tc

CREATE NONCLUSTERED INDEX tc_nc_indexa ON tc (ida)
CREATE NONCLUSTERED INDEX tc_nc_indexb ON tc (idb)




