CREATE TABLE cars (
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
);
INSERT INTO cars (brand, model, year)
VALUES ('Ford', 'Mustang', 1964);
select * from cars;
ALTER TABLE cars
ADD color VARCHAR(25);
ALTER TABLE branded_Cars
rename to cars;
ALTER TABLE branded_Cars
ADD brand_name VARCHAR(25), ADD features varchar(25);
insert into cars(color, brand_name,features) values('blue','RR','high_branded'),('black','bmw','high_branded'),('white','mersidice','high_branded'),('blue','farari','high_branded');
update cars set color='blue', brand_name='rr', features='hogh_branded' where id=1;
ALTER TABLE cars
ADD id int primary key;
insert into cars(id) values(1),(2),(3),(4);
ALTER TABLE cars DROP COLUMN id; 
DELETE FROM cars WHERE brand_name='';
SELECT * FROM cars
WHERE brand IS NOT NULL
AND model IS NOT NULL
AND year IS NOT NULL;
alter table cars drop column brand_name, drop column features; 
delete from cars where  brand is null;
delete from cars where  model is null;
delete from cars where  year is null;
SELECT * FROM cars;

ALTER TABLE cars
ADD COLUMN id SERIAL;
insert into cars values('Chevrolet', 'Camaro', 1967),
    ('Dodge', 'Charger', 1970),
    ('Pontiac', 'Firebird', 1969);



create or replace function addition(var1 int, var2 int)
returns int as
$$
declare 
	var3 int;
begin
	var3:=var1+var2;
	return var3;
end;
$$
language plpgsql;

select * from addition(10,100);













