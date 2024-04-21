select * from cars;
insert into cars values('Pontiac',	'Firebird',	1969,	7),('Ford',	'Mustang',	1964,	8);
select distinct(brand) from cars;
select sum(id) from cars;--sum(apply only int data type)
select * from cars where brand like 'P%';--start from P
select * from cars where id in(1,2,3);
select * from cars where id not in(1,2,3);
select * from cars where id between 1 and 4;
select brand as b  from cars ;
select * from cars cross join honda ;
select brand from cars union all select name from honda order by brand;
select count(id), cars.brand from cars group by  brand;
select count(id), cars.brand from cars group by  brand having count(id)>=2;
select * from 