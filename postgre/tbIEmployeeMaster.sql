create table  tblEmployeeMaster(
	intEmployeeID SERIAL PRIMARY KEY,
	strEmployeeCode Character Varying(20) Not Null unique,
	strEmployeeFirstName Character Varying(50) Not Null,
	strEmployeeLastName Character Varying(50) Not Null,
	strEmployeePhone int Not Null unique,
	strEmployeeEmail Character Varying(50) Not Null unique,
	strEmployeeBirthDate Date,
	strEmployeeSalary int check(strEmployeeSalary>100),
	intDepartmentId int Not Null,
	strGroupID UUID Not Null,
	bActive Boolean Default true,
	bDeleted Boolean Default false,
	dteCreatedOn Timestamp,
	FOREIGN KEY (intDepartmentId) REFERENCES tblDepartmentMaster(intDepartmentID)
);
INSERT INTO tblEmployeeMaster(intEmployeeID, strEmployeeCode, strEmployeeFirstName,
                               strEmployeeLastName, strEmployeePhone, strEmployeeEmail,
                               strEmployeeBirthDate, strEmployeeSalary, intDepartmentId,
                               strGroupID, bActive, bDeleted)
VALUES
(11, 'ram@123', 'Ram', 'Lakum', 0054193330, 'ram@gmail.com', '2010-01-01', 500000, 1, '112C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(12, 'Sita@123', 'Sita', 'Paramar', 0054192030, 'sita@gmail.com', '2010-02-01', 500000, 1, '122C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(13, 'Raj@123', 'Raj', 'Chauhan', 0054993330, 'raj@gmail.com', '2015-01-01', 100000, 2, '132C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(14, 'Kanha@123', 'Kanha', 'Rathod', 0554193330, 'kanha@gmail.com', '2010-02-12', 300000, 1, '142C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(15, 'Kunal@123', 'Kunal', 'Lakum', 0454193330, 'kunal@gmail.com', '2002-10-26', 1400000, 1, '152C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(16, 'Rohit@123', 'Rohit', 'Zala', 0054183330, 'rohit@gmail.com', '2010-12-11', 200000, 3, '162C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(17, 'Shweta@123', 'Shweta', 'Lakum', 0541933300, 'shweta@gmail.com', '2000-12-04', 1500000, 1, '172C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(18, 'Snjay@123', 'Sanjay', 'Kanazariya', 0754193330, 'sanjay@gmail.com', '2010-08-01', 1500000, 1, '182C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(19, 'Shyam@123', 'Shyam', 'Dabhi', 0054192230, 'shyam@gmail.com', '2010-07-01', 500000, 4, '192C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(20, 'Radha@123', 'Radha', 'Vyas', 0054193310, 'radha@gmail.com', '2010-05-01', 500000, 4, '102C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(21, 'Kishan@123', 'Kishan', 'Kanani', 0054793330, 'kishan@gmail.com', '2010-01-03', 500000, 5, '111C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(22, 'Payal@123', 'Payal', 'Chauhan', 0054103330, 'payal@gmail.com', '2010-01-10', 100000, 5, '112C8DD8-346B-426E-B06C-75BBA97DCD63', true, false),
(23, 'Renu@123', 'Renu', 'Zala', 0054193100, 'renu@gmail.com', '2001-01-01', 400000, 3, '113C8DD8-346B-426E-B06C-75BBA97DCD63', true, false);
insert into tblEmployeeMaster(intEmployeeID, strEmployeeCode, 
							  strEmployeeFirstName,
                              strEmployeeLastName, strEmployeePhone, 
							  strEmployeeEmail,
                              strEmployeeBirthDate, strEmployeeSalary, 
							  intDepartmentId,
                              strGroupID, bActive, bDeleted) 
values(24, 'Rinu@123', 'Rinu', 'Zala', 0054293100, 'rinu@gmail.com', '2001-01-01', 400000, 3, '113C8DD9-346B-426E-B06C-75BBA97DCD63', false,true );
select*from tblEmployeeMaster;

update tblEmployeeMaster set bDeleted = true where intEmployeeID=24;
update tblEmployeeMaster set intDepartmentId = 6 where intEmployeeID=24;
select*from tblEmployeeMaster;
update tblEmployeeMaster set strEmployeeBirthDate='3-3-2010' where intEmployeeID=23;

--3. Find Active Employees and details	
create or replace function active_emp_det()
returns table(strEmployeeCode int, strEmployeeFirstName Character Varying(20),
              strEmployeeLastName Character Varying(20)
			  bActive boolean, bDeleted boolean)
as
$$
begin
return query
select *						
from tblEmployeeDetail inner join tblEmployeeMaster 
on tblEmployeeDetail.intEmployeeID=tblEmployeeMaster.intEmployeeID 
where tblEmployeeMaster.bactive is true;
end;
$$
language plpgsql;
select * from active_emp_det();


--11. Display all employee with it's department name		
create or replace function dis_emp_dept()
returns table(strEmployeeFirstName character varying,
			  strEmployeeLastName character varying,
			  strDepartmentName character varying) as
$$
begin
return query
select tblEmployeeMaster.strEmployeeFirstName,
	   tblEmployeeMaster.strEmployeeLastName,
	   tblDepartmentMaster.strDepartmentName 
from tblEmployeeMaster inner join tblDepartmentMaster
on tblEmployeeMaster.intDepartmentId=tblDepartmentMaster.intDepartmentID;
end;
$$
language plpgsql;
select * from dis_emp_dept();

--15. Update any one employee details								
update tblEmployeeMaster set  strEmployeeCode='Raju@123', 
							  strEmployeeFirstName='Raju',
                              strEmployeeLastName='Shashtri', strEmployeePhone=837481, 
							  strEmployeeEmail='raju@gmail.com',
                              strEmployeeBirthDate='5/7/2006', strEmployeeSalary=17000, 
							  intDepartmentId=6,
                              strGroupID='113C8DD8-346B-426E-B07C-75BBA97DCD63', 
							  bActive=false, bDeleted=true where intEmployeeID=23;
select * from tblEmployeeMaster;
--not any employee salary has less than 100rs salary
update tblEmployeeMaster set strEmployeeSalary=100 where intEmployeeId=24;

--18. Delete one record from employee master table								
delete from tblEmployeeMaster where intEmployeeID=22;
select * from tblEmployeeMaster;

--19. Find employee name who's birthday in march month with birthdate								
select * from tblEmployeeMaster where Extract(month from strEmployeeBirthDate)=3;

--20. Dispaly Records in Table Format from comma string 
--(like. (1,2,3,4,5,6,7,8,9,10))								
SELECT unnest(string_to_array('1,2,3,4,5,6,7,8,9,10', ','));

--22. Update records using joins								
UPDATE tblEmployeeMaster 
SET strEmployeeCode = 'Renu@1234' 
WHERE intEmployeeID IN (
    SELECT tblEmployeeMaster.intEmployeeID 
    FROM tblEmployeeMaster 
    INNER JOIN tblEmployeeDetail ON tblEmployeeDetail.intEmployeeID = tblEmployeeMaster.intEmployeeID
);

delete from tblEmployeeMaster where 
IN (select tblEmployeeMaster.intEmployeeID from tblEmployeeMaster inner join 
	tblEmployeeDetail.intEmployeeID from tblEmployeeDetail 
   on tblEmployeeMaster.intEmployeeID=tblEmployeeDetail.intEmployeeID
  where strEmployeeCode='Rohit@123');


--24. Select Employee Records usng group by and having caluse								
select intEmployeeID, strEmployeeCode, 
strEmployeeFirstName,
strEmployeeLastName count(intDepartmentId) from tblEmployeeMaster 
group by intEmployeeID, strEmployeeCode,strEmployeeFirstName,
strEmployeeLastName having intEmployeeID>15;

--25. Update recods using IF Exists/ IF Else condition	
begin
if exists(select * from tblEmployeeMaster where stremployeefirstname='Rinu') then
begin
update tblEmployeeMaster set stremployeefirstname='Riya' where stremployeefirstname='Rinu';
else
insert into stremployeefirstname values(25, 'Riya@123', 'Riya', 'Zala', 0054193100, 'riya@gmail.com', '2001-01-01', 400000, 3, '113C8DD9-346B-426E-B06C-75BBA97DCD63', true, false)
end if

select * from tblEmployeeMaster;