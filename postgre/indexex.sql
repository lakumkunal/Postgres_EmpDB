select * from cars;
create index car_index
on cars(id);
select * from cars where id=1;