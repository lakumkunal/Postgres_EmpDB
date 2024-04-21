select * from cars;
alter table cars add column name_cars varchar(20);
update cars set name_cars=
	case
		when id=1 then 'aaa'
		when id=2 then 'bbb'
		when id=3 then 'ccc'
		when id=4 then 'ddd'
		when id=7 then 'eee'
		when id=8 then 'fff'
	end;
commit;
select * from cars;	