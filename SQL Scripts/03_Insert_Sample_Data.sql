USE CollegeNet;

-- =========================================================
-- Departments
-- =========================================================

INSERT INTO Departments (DepartmentCode, DepartmentName)
VALUES
('CSE','Computer Science and Engineering'),
('ECE','Electronics and Communication Engineering'),
('EEE','Electrical and Electronics Engineering'),
('EIE','Electronics and Instrumentation Engineering'),
('ME','Mechanical Engineering'),
('CE','Civil Engineering');

 SELECT * FROM Departments;
 
 -- =========================================================
-- Categories
-- =========================================================

INSERT INTO Categories (CategoryName, Description)
VALUES
('Electronics','Electronic devices and accessories'),
('Books','Academic books and notebooks'),
('Documents','Official and personal documents'),
('Accessories','Daily use accessories'),
('Sports Equipment','Sports related items'),
('Stationery','Pens, pencils and study materials'),
('Clothing','Clothes and lab coats'),
('Bags','School bags and backpacks'),
('Keys','Room and vehicle keys'),
('Others','Miscellaneous items');

SELECT * FROM Categories;
 
 -- =========================================================
-- CampusLocations
-- =========================================================

 INSERT INTO CampusLocations
(LocationType, LocationName, Description)
VALUES
('Administration', 'Main Admin Block', 'Administration office'),
('Academic', 'ECE Block', 'Electronics and Communication Department'),
('Academic', 'CSE Block', 'Computer Science Department'),
('Academic', 'New Gallery', 'Academic building with classrooms'),
('Library', 'Central Library', 'Main library'),
('Hostel', 'Boys Hostel', 'Hostel for male students'),
('Hostel', 'Girls Hostel', 'Hostel for female students'),
('Dining', 'Central Mess', 'Main dining hall'),
('Sports', 'Cricket Ground', 'Sports and recreational area'),
('Sports', 'Sports Complex', 'Indoor and outdoor sports'),
('Parking', 'Main Parking', 'Vehicle parking'),
('Other', 'Main Gate', 'College entrance');
 
SELECT * FROM CampusLocations;
 
 -- =========================================================
-- Students
-- =========================================================
INSERT INTO Students
(RollNumber, FirstName, LastName, Gender, DOB, Email, Phone,
DepartmentID, Semester, ResidenceType, HostelName)
VALUES
('2023CSE003','Nikhil','Rao','Male','2005-08-11','nikhil.rao@collegenet.edu','9876500013',1,4,'Hosteller','Boys Hostel'),
('2023ECE003','Sravani','Reddy','Female','2005-01-15','sravani.reddy@collegenet.edu','9876500014',2,6,'Hosteller','Girls Hostel'),
('2023EEE003','Harish','Kumar','Male','2004-07-18','harish.kumar@collegenet.edu','9876500015',3,6,'Day Scholar',NULL),
('2023EIE003','Keerthana','Naidu','Female','2005-02-21','keerthana.naidu@collegenet.edu','9876500016',4,4,'Hosteller','Girls Hostel'),
('2023ME003','Sai','Teja','Male','2004-12-05','sai.teja@collegenet.edu','9876500017',5,6,'Hosteller','Boys Hostel'),
('2023CE003','Lavanya','Sharma','Female','2005-09-10','lavanya.sharma@collegenet.edu','9876500018',6,2,'Day Scholar',NULL),
('2023CSE004','Abhishek','Singh','Male','2005-04-17','abhishek.singh@collegenet.edu','9876500019',1,8,'Hosteller','Boys Hostel'),
('2023ECE004','Anusha','Patel','Female','2004-10-30','anusha.patel@collegenet.edu','9876500020',2,8,'Hosteller','Girls Hostel'),
('2023EEE004','Rakesh','Yadav','Male','2005-06-09','rakesh.yadav@collegenet.edu','9876500021',3,2,'Day Scholar',NULL),
('2023ME004','Deepika','Nair','Female','2005-03-26','deepika.nair@collegenet.edu','9876500022',5,4,'Hosteller','Girls Hostel');

SELECT * FROM Students;

-- =========================================================
-- ItemCatalog 
-- =========================================================

INSERT INTO ItemCatalog (CategoryID, ItemName)
VALUES

-- Electronics (CategoryID = 1)
(1,'Laptop'),
(1,'Mobile Phone'),
(1,'Tablet'),
(1,'Smart Watch'),
(1,'Power Bank'),
(1,'Calculator'),
(1,'USB Flash Drive'),
(1,'Earphones'),

-- Books (CategoryID = 2)
(2,'Engineering Textbook'),
(2,'Notebook'),
(2,'Lab Record'),

-- Documents (CategoryID = 3)
(3,'College ID Card'),
(3,'Driving License'),
(3,'Aadhaar Card'),

-- Accessories (CategoryID = 4)
(4,'Wallet'),
(4,'Water Bottle'),
(4,'Spectacles'),

-- Sports Equipment (CategoryID = 5)
(5,'Cricket Bat'),
(5,'Football'),
(5,'Badminton Racket'),

-- Stationery (CategoryID = 6)
(6,'Pen'),
(6,'Pencil Box'),

-- Clothing (CategoryID = 7)
(7,'Jacket'),
(7,'Lab Coat'),

-- Bags (CategoryID = 8)
(8,'Backpack');

SELECT * FROM  ItemCatalog ;

-- =========================================================
-- Lost Reports
-- =========================================================

INSERT INTO LostReports
(ItemCatalogID, StudentID, LocationID, Brand, Color, Description, LostDate, RewardAmount, Status)
VALUES

(1,1,5,'HP','Black',
'Lost HP Laptop near Central Library',
'2026-06-20',
500.00,
'Pending'),

(6,2,2,'Casio','Black',
'Scientific calculator lost in ECE Block',
'2026-06-18',
200.00,
'Pending'),

(15,3,8,NULL,'Brown',
'Leather wallet lost near Central Mess',
'2026-06-21',
100.00,
'Matched'),

(12,4,12,NULL,NULL,
'College ID Card lost near Main Gate',
'2026-06-22',
0.00,
'Pending'),

(25,5,6,'Skybags','Blue',
'Blue backpack missing from Boys Hostel',
'2026-06-23',
300.00,
'Pending'),

(2,6,3,'Samsung','Blue',
'Mobile phone lost in CSE Block',
'2026-06-15',
1000.00,
'Matched'),

(16,7,8,'Milton','Red',
'Water bottle lost near Central Mess',
'2026-06-19',
50.00,
'Pending'),

(18,8,10,'SG','Wood',
'Cricket bat misplaced in Sports Complex',
'2026-06-16',
250.00,
'Pending'),

(9,9,5,NULL,NULL,
'Engineering textbook left in Central Library',
'2026-06-17',
150.00,
'Claimed'),

(24,10,1,NULL,'White',
'Lab coat lost near Main Admin Block',
'2026-06-24',
200.00,
'Pending');

SELECT * FROM LostReports;
-- =========================================================
-- FoundReports 
-- =========================================================

INSERT INTO FoundReports
(ItemCatalogID, StudentID, LocationID, Brand, Color, Description, FoundDate, Status)
VALUES

(1,2,5,'HP','Black',
'Found HP Laptop in Central Library',
'2026-06-21',
'Available'),

(6,3,2,'Casio','Black',
'Calculator found in ECE Block',
'2026-06-19',
'Available'),

(15,4,8,NULL,'Brown',
'Wallet found near Central Mess',
'2026-06-22',
'Claimed'),

(12,5,12,NULL,NULL,
'College ID Card found near Main Gate',
'2026-06-23',
'Available'),

(25,6,6,'Skybags','Blue',
'Backpack found in Boys Hostel',
'2026-06-24',
'Available'),

(2,7,3,'Samsung','Blue',
'Mobile phone found in CSE Block',
'2026-06-16',
'Claimed'),

(16,8,8,'Milton','Red',
'Water bottle found near Central Mess',
'2026-06-20',
'Available'),

(18,9,10,'SG','Wood',
'Cricket bat found in Sports Complex',
'2026-06-17',
'Available'),

(9,10,5,NULL,NULL,
'Engineering textbook found in Library',
'2026-06-18',
'Claimed'),

(24,1,1,NULL,'White',
'Lab coat found near Admin Block',
'2026-06-25',
'Available');

SELECT * FROM FoundReports;

-- =========================================================
-- Claims 
-- =========================================================

INSERT INTO Claims
(LostReportID, FoundReportID, ClaimDate, VerificationStatus)
VALUES

(3,3,'2026-06-22','Approved'),
(6,6,'2026-06-16','Approved'),
(9,9,'2026-06-18','Approved');

SELECT * FROM Claims;

-- =========================================================
-- MarketPlaceListings
-- =========================================================

INSERT INTO MarketplaceListings
(SellerID, ItemCatalogID, Title, Description, Price, Quantity, ItemCondition, ListingStatus)
VALUES

(1,6,'Casio Scientific Calculator',
'Well maintained calculator',
550.00,1,'Good','Available'),

(2,9,'Engineering Textbook',
'Signals and Systems textbook',
450.00,1,'Like New','Available'),

(3,25,'Skybags Backpack',
'Blue backpack with laptop compartment',
900.00,1,'Good','Available'),

(4,2,'Samsung Mobile Phone',
'Used Samsung phone in good condition',
8500.00,1,'Fair','Sold'),

(5,18,'Cricket Bat',
'SG Kashmir Willow Bat',
1500.00,1,'Like New','Available'),

(6,21,'Pen Set',
'Premium gel pen set',
120.00,2,'New','Available'),

(7,24,'Lab Coat',
'Medium size lab coat',
350.00,1,'Good','Available'),

(8,16,'Milton Water Bottle',
'1 litre insulated bottle',
300.00,1,'Like New','Available');

SELECT * FROM MarketplaceListings;

INSERT INTO Orders
(ListingID, BuyerID, Quantity, TotalAmount, OrderStatus)
VALUES

(4,1,1,8500.00,'Completed'),
(2,6,1,450.00,'Completed'),
(6,3,2,240.00,'Confirmed'),
(8,10,1,300.00,'Pending');

SELECT * FROM Orders;

-- =========================================================
-- Reviews
-- =========================================================

INSERT INTO Reviews
(OrderID, ReviewerID, SellerID, Rating, ReviewText)
VALUES

(1,1,4,5,'Excellent seller and product exactly as described.'),
(2,6,2,4,'Book was in good condition and delivery was quick.');

SELECT * FROM Reviews;

-- =========================================================
-- WantedPosts
-- =========================================================
INSERT INTO WantedPosts
(StudentID, ItemCatalogID, Title, Description, ExpectedPrice, Status)
VALUES

(2,1,'Looking for Laptop',
'Need a laptop for academic work.',
30000.00,'Open'),

(3,2,'Need Mobile Phone',
'Looking for a second-hand smartphone.',
10000.00,'Open'),

(5,6,'Scientific Calculator',
'Need Casio calculator for exams.',
600.00,'Open'),

(6,25,'Backpack Wanted',
'Looking for a laptop backpack.',
1000.00,'Open'),

(8,18,'Cricket Bat',
'Need a cricket bat for college tournament.',
1800.00,'Open'),

(10,24,'Lab Coat',
'Need a medium size lab coat.',
400.00,'Open');

SELECT * FROM WantedPosts;

SELECT COUNT(*) AS MarketplaceListings FROM MarketplaceListings;
SELECT COUNT(*) AS Orders FROM Orders;
SELECT COUNT(*) AS Reviews FROM Reviews;
SELECT COUNT(*) AS WantedPosts FROM WantedPosts;


