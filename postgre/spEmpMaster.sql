create or replace procedure "spEmpMsster"()
language plpgsql
as
	$$
	begin
		select intemployeeid, 
	   		   tremployeefirstname, 
	   		   stremployeelastname
	   	from
	   		   tblemployeemaster
	   
	  end;
	  $$
	  