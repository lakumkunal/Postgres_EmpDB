create table tblEmployeeDetail(
	intEmployeeDetailsID serial Primary key,
	intEmployeeID int Not Null,
	StrEmployeeCountry int Not Null,
	StrEmployeeState int Not Null,
	StrEmployeeCity int Not Null,
	StrEmployeeAddress character Varying(250),
	StrEmployeeZipcode int Not Null,
	foreign key(intEmployeeID) references tblEmployeeMaster(intEmployeeID),
	foreign key(strEmployeeCountry) references  tblCountryMaster(intCountryID),
	foreign key(StrEmployeeState) references tblStateMaster(intStateID),
	foreign key(StrEmployeeCity) references  tblCityMaster(intCityID)
);
INSERT INTO tblEmployeeDetail(intEmployeeID, StrEmployeeCountry, StrEmployeeState,
                               StrEmployeeCity, StrEmployeeAddress,
                               StrEmployeeZipcode)
VALUES
(11, 101, 1, 1, 'near Mahadev Mandir', 201),
(12, 101, 2, 1, 'near Mahadev Mandir', 201),
(13, 101, 2, 2, 'near kishan Mandir', 201),
(14, 102, 3, 3, 'Shakti Society', 201),
(11, 103, 4, 4, 'near police quater', 201),
(15, 104, 5, 5, 'near Rajabai Ma Mandir', 201),
(11, 105, 1, 1, 'Ashutosh complex', 201),
(12, 105, 1, 1, 'Shiv Ranjini Society', 201),
(13, 101, 2, 2, 'Gokul Society', 201),
(14, 102, 2, 3, 'Iskon Mandir', 201),
(16, 103, 3, 4, 'Karnavati Club', 201),
(17, 103, 4, 5, 'Aashapura Society', 201),
(18, 104, 5, 1, 'Ram Society', 201)
INSERT INTO tblEmployeeDetail(intEmployeeID, StrEmployeeCountry, StrEmployeeState,
                               StrEmployeeCity, StrEmployeeAddress,
                               StrEmployeeZipcode)
VALUES
(24, 101, 1, 1, 'RajalKrupa Society', 202);
select * from tblEmployeeDetail;

--4. Get total count of employee in india	
create or replace function emp_count()
returns int as
$$
declare total_emp int;
begin
select count(StrEmployeeCountry) into total_emp from tblEmployeeDetail inner join tblCountryMaster
on tblEmployeeDetail.StrEmployeeCountry=tblCountryMaster.intCountryID
where StrEmployeeCountry=101;
return total_emp;
end;
$$
language plpgsql;
select * from emp_count();

--5. Get employee list available in US		
CREATE OR REPLACE FUNCTION emp_us()
RETURNS TABLE (
    intCountryID int,
	StrEmployeeCountry int,
	StrCountryName character varying
) AS
$$
BEGIN
    RETURN QUERY
    SELECT tblEmployeeDetail.intEmployeeID, tblEmployeeDetail.StrEmployeeCountry,
	tblCountryMaster.StrCountryName
    FROM tblEmployeeDetail
    INNER JOIN tblCountryMaster ON tblEmployeeDetail.StrEmployeeCountry = tblCountryMaster.intCountryID
    WHERE tblCountryMaster.intCountryID = 102;
END;
$$
LANGUAGE plpgsql;

DROP FUNCTION emp_us();
select * from emp_us();


--6. Top 5 highest salary with Employee Name, phone no, birthdate ,
--city country, state, and address	
create or replace function highest_salary_emp()
returns setof record as
$$
begin 
return query 
select strEmployeeFirstName,strEmployeeLastName, strEmployeePhone, 
	   strEmployeeBirthDate, strEmployeeSalary, StrEmployeeCountry,
	   StrEmployeeState, StrEmployeeCity, StrEmployeeAddress 
	   from tblEmployeeMaster inner join tblEmployeeDetail
	   on tblEmployeeMaster.intEmployeeID=tblEmployeeDetail.intEmployeeID 
	   order by strEmployeeSalary desc limit 5;
end;
$$
language plpgsql;
SELECT * FROM highest_salary_emp() AS (
    strEmployeeFirstName Character Varying,strEmployeeLastName Character Varying, strEmployeePhone int, 
	   strEmployeeBirthDate date, strEmployeeSalary int, StrEmployeeCountry int,
	   StrEmployeeState int, StrEmployeeCity int, StrEmployeeAddress Character Varying
);

--7. Second highest salary with Employee name and city	
create or replace function highest_salary()
returns table(strEmployeeFirstName Character Varying,strEmployeeLastName Character Varying,
	    strEmployeeSalary int,StrEmployeeCity int) as
$$
begin
return query
select tblEmployeeMaster.strEmployeeFirstName, tblEmployeeMaster.strEmployeeLastName, 
tblEmployeeDetail.StrEmployeeCity,tblEmployeeMaster.strEmployeeSalary
	   from tblEmployeeMaster inner join tblEmployeeDetail
	   on tblEmployeeMaster.intEmployeeID=tblEmployeeDetail.intEmployeeID 
	   order by strEmployeeSalary desc limit 1 offset 1;
end;
$$
language plpgsql;

select * from highest_salary(); 


--8. Second Lowest salary with Employee name, birthdate and zip code	
CREATE OR REPLACE FUNCTION sec_low_sal()
RETURNS TABLE (
    strEmployeeFirstName character varying,
    strEmployeeLastName character varying,
    strEmployeeSalary int,
    StrEmployeeZipcode int,
    strEmployeeBirthDate date
) AS
$$
BEGIN
    RETURN QUERY 
    SELECT
        tblEmployeeMaster.strEmployeeFirstName,
        tblEmployeeMaster.strEmployeeLastName,
        tblEmployeeMaster.strEmployeeSalary,
        tblEmployeeDetail.StrEmployeeZipcode,
        tblEmployeeMaster.strEmployeeBirthDate
    FROM
        tblEmployeeMaster
    INNER JOIN
        tblEmployeeDetail ON tblEmployeeMaster.intEmployeeID = tblEmployeeDetail.intEmployeeID
    ORDER BY
        tblEmployeeMaster.strEmployeeSalary ASC
    LIMIT 1 OFFSET 1;
END;
$$
LANGUAGE plpgsql;

drop function sec_low_sal();

select * from sec_low_sal();

--9. Top 5 lowest salary with Employee Name, phone no, birthdate ,
--city country, state, and address		
create or replace function low_salary()
returns table(strEmployeeFirstName character varying,strEmployeeLastNamecharacter character varying,
			  strEmployeePhone int, 
	   strEmployeeBirthDate date, strEmployeeSalary int, StrEmployeeCountry int,
	   StrEmployeeState int, StrEmployeeCity int, StrEmployeeAddress character varying) as
$$
begin
return query
select tblEmployeeMaster.strEmployeeFirstName,
	   tblEmployeeMaster.strEmployeeLastName, 
	   tblEmployeeMaster.strEmployeePhone, 
	   tblEmployeeMaster.strEmployeeBirthDate, 
	   tblEmployeeMaster.strEmployeeSalary, 
	   tblEmployeeDetail.StrEmployeeCountry,
	   tblEmployeeDetail.StrEmployeeState, 
	   tblEmployeeDetail.StrEmployeeCity, 
	   tblEmployeeDetail.StrEmployeeAddress 
	   from tblEmployeeMaster inner join tblEmployeeDetail
	   on tblEmployeeMaster.intEmployeeID=tblEmployeeDetail.intEmployeeID 
	   order by strEmployeeSalary asc limit 5;
end;
$$
language plpgsql;

select * from low_salary();

--10. find InActive and deleted employee and its details	
create or replace function inactive_emp(ref_cursor refe)
returns refcursor as
$$
begin
open ref_cursor for 
select tblEmployeeMaster.strEmployeeFirstName,
	   tblEmployeeMaster.strEmployeeLastName, 
	   tblEmployeeMaster.strEmployeePhone, 
	   tblEmployeeMaster.strEmployeeBirthDate, 
	   tblEmployeeMaster.strEmployeeSalary, 
	   tblEmployeeDetail.StrEmployeeCountry,
	   tblEmployeeDetail.StrEmployeeState, 
	   tblEmployeeDetail.StrEmployeeCity, 
	   tblEmployeeDetail.StrEmployeeAddress 
from tblEmployeeMaster inner join tblEmployeeDetail 
on tblEmployeeMaster.intEmployeeID=tblEmployeeDetail.intEmployeeID
where bActive is false and bDeleted is true;
return ref_cursor;
end;
$$
language plpgsql;

--call cursor
fetch all in ref_cursor;

begin ;
declare my_cursor REFCURSOR;
call inactive_emp(my_cursor);
fetch all from my_cursor;
close my_cursor;



--set any employee adress null
update tblEmployeeDetail set StrEmployeeAddress = NULL where intEmployeeID=11;
select * from tblEmployeeDetail;

--16. Find those employee who have emplyee Empty or null Address details	
create or replace function "emp_add_null"(ref2 refcursor)
returns refcursor as
$$
begin
open ref2 for
select * from tblEmployeeDetail where strEmployeeAddress is null;
return ref2;
end;
$$
language plpgsql;

select from "emp_add_null('ref2')";
fetch all in ref2;
