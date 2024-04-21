create table tblStateMaster(
	intStateID serial Primary Key,
	StrStateName character Varying(50) Not Null,
	intCountryID int Not Null,
	foreign key(intCountryID) references tblCountryMaster(intCountryID)
);
insert into tblStateMaster(StrStateName,intCountryID)
values('Gujarat',101),
('UP',101),
('Tokyo',102),
('Maxico',103),
('Iran',104),
('Rajasthan',101),
('MP',105);
select * from tblStateMaster;
