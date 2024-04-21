create table tblDepartmentMaster(
	intDepartmentID int primary key,
	StrDepartmentName character varying(50),
	bActive boolean,
	bDeleted boolean
);
insert into tblDepartmentMaster(intDepartmentID,StrDepartmentName,bActive,bDeleted)
	values(1, 'Mobility', true, false),
	(2,'Integreted', true, false),
	(3,'IT', true, false),
	(4,'HR', true, false),
	(5,'BA', true, false);
insert into tblDepartmentMaster(intDepartmentID,StrDepartmentName,bActive,bDeleted)
	values(6, 'IT', false, false);
select * from tblDepartmentMaster;

--12. Prevent to set department as in-Active 
--or deleted if employee is Active
select * from tblDepartmentMaster inner join tblEmployeeMaster 
on tblDepartmentMaster.intDepartmentID=tblEmployeeMaster.intDepartmentID
where bActive=true;


--13. Find list of Employee bind with in-active department		
create or replace function emp_inactive_dept()
returns table(strEmployeeFirstName character varying
			  ,strEmployeeLastName character varying) as
$$
begin
return query
select tblEmployeeMaster.strEmployeeFirstName,
	   tblEmployeeMaster.strEmployeeLastName from tblEmployeeMaster
inner join tblDepartmentMaster 
on tblEmployeeMaster.intDepartmentId=tblDepartmentMaster.intDepartmentID
where tblDepartmentMaster.bActive = false;
end;
$$
language plpgsql;
select * from emp_inactive_dept();

