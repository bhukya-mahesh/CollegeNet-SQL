
USE CollegeNet;

 -- =========================================================
-- View Name : vw_LostItems
-- Purpose   : Complete Lost Item Information
-- =========================================================

CREATE VIEW vw_LostItems AS
SELECT
    lr.LostReportID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    ic.ItemName,
    cl.LocationName,
    lr.Brand,
    lr.Color,
    lr.LostDate,
    lr.RewardAmount,
    lr.Status
FROM LostReports lr
JOIN Students s
ON lr.StudentID = s.StudentID
JOIN ItemCatalog ic
ON lr.ItemCatalogID = ic.ItemCatalogID
JOIN CampusLocations cl
ON lr.LocationID = cl.LocationID;
 
SELECT * FROM vw_LostItems;
-- =========================================================
-- View Name : vw_FoundItems
-- Purpose   : Complete Found Item Information
-- =========================================================
CREATE VIEW vw_FoundItems AS

SELECT
    fr.FoundReportID,
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    ic.ItemName,
    cl.LocationName,
    fr.Brand,
    fr.Color,
    fr.FoundDate,
    fr.Statu
FROM FoundReports fr
JOIN Students s
    ON fr.StudentID = s.StudentID
JOIN ItemCatalog ic
    ON fr.ItemCatalogID = ic.ItemCatalogID
JOIN CampusLocations cl
    ON fr.LocationID = cl.LocationID;
SELECT * FROM vw_FoundItems;

-- =========================================================
-- View Name : vw_Claims
-- Purpose   : Displays complete claim information
-- =========================================================

DROP VIEW IF EXISTS vw_Claims;
CREATE VIEW vw_Claims AS
SELECT
    c.ClaimID,
    CONCAT(s.FirstName,' ',s.LastName) AS OwnerName,
    ic.ItemName,
    lr.LostDate,
    fr.FoundDate,
    c.ClaimDate,
    c.VerificationStatus
FROM Claims c
JOIN LostReports lr
ON c.LostReportID = lr.LostReportID
JOIN FoundReports fr
ON c.FoundReportID = fr.FoundReportID
JOIN Students s
ON lr.StudentID = s.StudentID
JOIN ItemCatalog ic
ON lr.ItemCatalogID = ic.ItemCatalogID;

SELECT * FROM vw_Claims;

-- =========================================================
-- View Name : vw_Marketplace
-- Purpose   : Marketplace listings with seller details
-- =========================================================

DROP VIEW IF EXISTS vw_Marketplace;
CREATE VIEW vw_Marketplace AS
SELECT
    ml.ListingID,
    CONCAT(s.FirstName,' ',s.LastName) AS Seller,
    ic.ItemName,
    ml.Price,
    ml.Quantity,
    ml.ItemCondition,
    ml.ListingStatus
FROM MarketplaceListings ml
JOIN Students s
ON ml.SellerID = s.StudentID
JOIN ItemCatalog ic
ON ml.ItemCatalogID = ic.ItemCatalogID;

SELECT * FROM vw_Marketplace;

-- =========================================================
-- View Name : vw_Orders
-- Purpose   : Order information with buyer details
-- =========================================================

DROP VIEW IF EXISTS vw_Orders;
CREATE VIEW vw_Orders AS
SELECT
    o.OrderID,
    CONCAT(s.FirstName,' ',s.LastName) AS Buyer,
    ic.ItemName,
    o.Quantity,
    o.TotalAmount,
    o.OrderStatus,
    o.OrderDate
FROM Orders o
JOIN MarketplaceListings ml
ON o.ListingID = ml.ListingID
JOIN Students s
ON o.BuyerID = s.StudentID
JOIN ItemCatalog ic
ON ml.ItemCatalogID = ic.ItemCatalogID;

SELECT * FROM vw_Orders;

-- =========================================================
-- View Name : vw_Reviews
-- Purpose   : Reviews with reviewer and seller
-- =========================================================

DROP VIEW IF EXISTS vw_Reviews;
CREATE VIEW vw_Reviews AS
SELECT
    r.ReviewID,
    CONCAT(rv.FirstName,' ',rv.LastName) AS Reviewer,
    CONCAT(sl.FirstName,' ',sl.LastName) AS Seller,
    r.Rating,
    r.ReviewText,
    r.ReviewDate
FROM Reviews r
JOIN Students rv
ON r.ReviewerID = rv.StudentID
JOIN Students sl
ON r.SellerID = sl.StudentID;

SELECT * FROM vw_Reviews;

-- =========================================================
-- View Name : vw_WantedPosts
-- Purpose   : Wanted posts with student details
-- =========================================================

DROP VIEW IF EXISTS vw_WantedPosts;
CREATE VIEW vw_WantedPosts AS
SELECT
    wp.WantedPostID,
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    ic.ItemName,
    wp.ExpectedPrice,
    wp.Status,
    wp.CreatedAt
FROM WantedPosts wp
JOIN Students s
ON wp.StudentID = s.StudentID
JOIN ItemCatalog ic
ON wp.ItemCatalogID = ic.ItemCatalogID;

SELECT * FROM vw_WantedPosts;

-- =========================================================
-- View Name : vw_StudentSummary
-- Purpose   : Student information with department
-- =========================================================

DROP VIEW IF EXISTS vw_StudentSummary;
CREATE VIEW vw_StudentSummary AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    d.DepartmentName,
    s.Semester,
    s.ResidenceType
FROM Students s
JOIN Departments d
ON s.DepartmentID = d.DepartmentID;

SELECT * FROM vw_StudentSummary;
