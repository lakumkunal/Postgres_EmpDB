create or replace procedure "spCountry"()
language plpgsql
as
	$$
	begin
		select * 
		from
		tblcountrymaster;
	end;
	$$
	
