USE CollegeNet;

/*
============================================================
Project      : CollegeNet - Campus Resource & Marketplace
Module       : Functions
Author       : Mahesh Bhukya
Database     : MySQL 8.0
============================================================
*/
DROP FUNCTION IF EXISTS fn_TotalLostReports;
DELIMITER $$
CREATE FUNCTION fn_TotalLostReports()
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE Total INT;
SELECT COUNT(*)
INTO Total
FROM LostReports;
RETURN Total;
END$$
DELIMITER ;

SELECT fn_TotalLostReports();


DROP FUNCTION IF EXISTS fn_TotalFoundReports;
DELIMITER $$
CREATE FUNCTION fn_TotalFoundReports()
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE Total INT;
SELECT COUNT(*)
INTO Total
FROM FoundReports;
RETURN Total;
END$$
DELIMITER ;

SELECT fn_TotalFoundReports();


DROP FUNCTION IF EXISTS fn_TotalStudents;
DELIMITER $$
CREATE FUNCTION fn_TotalStudents()
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE Total INT;
SELECT COUNT(*)
INTO Total
FROM Students;
RETURN Total;
END$$
DELIMITER ;

SELECT fn_TotalStudents();

DROP FUNCTION IF EXISTS fn_AverageRating;
DELIMITER $$
CREATE FUNCTION fn_AverageRating()
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
DECLARE AvgRating DECIMAL(3,2);
SELECT AVG(Rating)
INTO AvgRating
FROM Reviews;
RETURN AvgRating;
END$$
DELIMITER ;

SELECT fn_AverageRating();

DROP FUNCTION IF EXISTS fn_TotalMarketplaceValue;
DELIMITER $$
CREATE FUNCTION fn_TotalMarketplaceValue()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE TotalValue DECIMAL(10,2);
SELECT SUM(Price * Quantity)
INTO TotalValue
FROM MarketplaceListings
WHERE ListingStatus='Available';
RETURN IFNULL(TotalValue,0);
END$$
DELIMITER ;

SELECT fn_TotalMarketplaceValue();
