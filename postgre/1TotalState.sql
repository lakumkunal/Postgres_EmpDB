CREATE OR REPLACE FUNCTION "1TotalState"(ref1 refcursor)
RETURNS refcursor  AS
$$
BEGIN
 	open ref1 for
    SELECT tblCityMaster.StrCityName, tblCountryMaster.StrCountryName
    FROM tblCountryMaster
    INNER JOIN tblCityMaster ON tblCountryMaster.intCountryID = tblCityMaster.intCountryID
    WHERE tblCountryMaster.StrCountryName = 'India'
    GROUP BY tblCityMaster.StrCityName, tblCountryMaster.StrCountryName;
	return ref1;
END;
$$
LANGUAGE plpgsql;

DROP FUNCTION "1TotalState"(refcursor)

--call ref cursor
SELECT "1TotalState"('ref1');
fetch all in "ref1";
