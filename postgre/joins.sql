insert into honda values(1,'BMW','high'),(2,'RR','high');
select * from honda;
select * from honda inner join cars on honda.id=cars.id;
select * from cars left join honda on cars.id=honda.id;
select * from honda right join cars on honda.id=cars.id;
select * from honda full outer join cars on honda.id=cars.id;
select * from honda,cars where honda.id!=cars.id;