USE CollegeNet;

/*
============================================================
Project      : CollegeNet - Campus Resource & Marketplace
Module       : Stored Procedures
Author       : Mahesh Bhukya
Database     : MySQL 8.0
============================================================
*/

-- =========================================================
-- Procedure Name : sp_GetLostItemsByStatus
-- Purpose        : Returns lost items based on status
-- =========================================================

DROP PROCEDURE IF EXISTS sp_GetLostItemsByStatus;
DELIMITER $$
CREATE PROCEDURE sp_GetLostItemsByStatus(
    IN p_Status VARCHAR(20)
)
BEGIN
    SELECT
        LostReportID,
        ItemCatalogID,
        StudentID,
        LostDate,
        RewardAmount,
        Status
    FROM LostReports
    WHERE Status = p_Status;

END$$

DELIMITER ;

CALL sp_GetLostItemsByStatus('Pending');

-- =========================================================
-- Procedure Name : sp_GetListingsBySeller
-- Purpose        : Retrieves all marketplace listings posted by a specific student.
-- =========================================================

DROP PROCEDURE IF EXISTS sp_GetListingsBySeller;

DELIMITER $$

CREATE PROCEDURE sp_GetListingsBySeller(
    IN p_SellerID INT
)
BEGIN

    SELECT
        ListingID,
        Title,
        Price,
        Quantity,
        ListingStatus
    FROM MarketplaceListings
    WHERE SellerID = p_SellerID;

END$$

DELIMITER ;

-- =========================================================
-- Procedure Name : sp_GetStudentProfile
-- Purpose        : Displays complete information about a student, including department details.
-- =========================================================
DROP PROCEDURE IF EXISTS sp_GetStudentProfile;

DELIMITER $$

CREATE PROCEDURE sp_GetStudentProfile(
    IN p_StudentID INT
)
BEGIN

    SELECT
        s.StudentID,
        CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
        d.DepartmentName,
        s.Semester,
        s.Email,
        s.Phone

    FROM Students s

    JOIN Departments d
    ON s.DepartmentID = d.DepartmentID

    WHERE s.StudentID = p_StudentID;

END$$

DELIMITER ;

-- =========================================================
-- Procedure Name : sp_GetOpenWantedPosts
-- Purpose        : Returns all active wanted posts.
-- =========================================================
DROP PROCEDURE IF EXISTS sp_GetOpenWantedPosts;

DELIMITER $$

CREATE PROCEDURE sp_GetOpenWantedPosts()
BEGIN

    SELECT *
    FROM WantedPosts
    WHERE Status='Open';

END$$

DELIMITER ;
CALL sp_GetOpenWantedPosts();
-- =========================================================
-- Procedure Name : sp_TotalOrders
-- Purpose        : Returns the total No of orders placed in the marketplace.
-- =========================================================
DROP PROCEDURE IF EXISTS sp_TotalOrders;

DELIMITER $$

CREATE PROCEDURE sp_TotalOrders()
BEGIN

    SELECT
        COUNT(*) AS TotalOrders
    FROM Orders;

END$$

DELIMITER ;
CALL sp_TotalOrders();
-- =========================================================
-- Procedure Name : sp_StudentLostItemCount
-- Purpose        : Counts how many lost reports were submitted by a specific student.
-- =========================================================
DROP PROCEDURE IF EXISTS sp_StudentLostItemCount;

DELIMITER $$

CREATE PROCEDURE sp_StudentLostItemCount(
    IN p_StudentID INT
)
BEGIN

    SELECT
        COUNT(*) AS LostItems
    FROM LostReports
    WHERE StudentID=p_StudentID;

END$$

DELIMITER ;
CALL sp_StudentLostItemCount(1);

