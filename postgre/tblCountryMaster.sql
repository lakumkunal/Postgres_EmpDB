create table tblCountryMaster(
	intCountryID SERIAL Primary Key,
	StrCountryName character Varying(50) Not Null
);
insert into tblCountryMaster(intCountryID, StrCountryName)
values(101,'India'),
(102,'USA'),
(103,'Canada'),
(104,'London'),
(105,'Japan'),
(106,'Africa'),
(107,'Dubai');
select * from tblCountryMaster;

--1. Find total state in india country with Country Name
CREATE OR REPLACE FUNCTION states()
RETURNS TABLE (strcityname VARCHAR(50), StrCountryName VARCHAR(50)) AS
$$
BEGIN
    RETURN QUERY
    SELECT tblCityMaster.StrCityName, tblCountryMaster.StrCountryName
    FROM tblCountryMaster
    INNER JOIN tblCityMaster ON tblCountryMaster.intCountryID = tblCityMaster.intCountryID
    WHERE tblCountryMaster.StrCountryName = 'India'
    GROUP BY tblCityMaster.StrCityName, tblCountryMaster.StrCountryName;
END;
$$
LANGUAGE plpgsql;

select * from states();
--2. Find total city in india country with State and Country Name	
create or replace function total_city()
returns table(StrCountryName character varying, strStateName character varying) as
$$
begin
select StrCountryName, strStateName, count(strcityname) 
from tblCountryMaster inner join tblcitymaster 
on tblCountryMaster.intCountryID=tblStateMaster.intCountryID 
where strcountryname='India'
group by strcityname;
end;
$$
language plpgsql;
select * from total_city();


