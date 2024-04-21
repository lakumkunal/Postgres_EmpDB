create table  tblCityMaster(
	intCityID serial Primary Key,
	StrCityName character Varying(50) Not Null,
	intStateID int Not Null,
	intCountryID int Not Null,
	foreign key(intStateID) references tblStateMaster(intStateID) ON DELETE CASCADE,
	foreign key(intCountryID) references tblCountryMaster(intCountryID) ON DELETE CASCADE
);
insert into tblCityMaster(StrCityName,intStateID,intCountryID)
values('Ahedabad',1,101),
('Baroda',1,101),
('Surat',1,101),
('California',1,101),
('Tokyo',3,103),
('London',4,104);
select * from tblCityMaster;