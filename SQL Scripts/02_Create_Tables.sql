/*
============================================================
Project      : CollegeNet - Campus Resource & Marketplace
Module       : Table Creation (Sprint 1)
Author       : Mahesh Bhukya
Database     : MySQL 8.0
Version      : 3.0
Description  : Parent Tables
============================================================
*/

USE CollegeNet;

-- =========================================================
-- Table: Departments
-- Description: Stores department information
-- =========================================================

CREATE TABLE IF NOT EXISTS  Departments (
    DepartmentID INT UNSIGNED AUTO_INCREMENT,
    DepartmentCode VARCHAR(10) NOT NULL,
    DepartmentName VARCHAR(100) NOT NULL,

    CONSTRAINT PK_Departments PRIMARY KEY (DepartmentID),
    CONSTRAINT UQ_DepartmentCode UNIQUE (DepartmentCode),
    CONSTRAINT UQ_DepartmentName UNIQUE (DepartmentName)
);

-- =========================================================
-- Table Name : Students
-- Purpose    : Stores student information
-- =========================================================

CREATE TABLE IF NOT EXISTS Students (
    StudentID INT UNSIGNED AUTO_INCREMENT,
    RollNumber VARCHAR(20) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,

    Gender ENUM('Male','Female','Other') NOT NULL,

    DOB DATE NOT NULL,

    Email VARCHAR(100) NOT NULL,

    Phone VARCHAR(20) NOT NULL,

    DepartmentID INT UNSIGNED NOT NULL,

    Semester TINYINT NOT NULL,

    ResidenceType ENUM('Hosteller','Day Scholar')

        DEFAULT 'Day Scholar',

    HostelName VARCHAR(50),

    CONSTRAINT PK_Students
        PRIMARY KEY (StudentID),

    CONSTRAINT UQ_RollNumber
        UNIQUE (RollNumber),

    CONSTRAINT UQ_Email
        UNIQUE (Email),

    CONSTRAINT CHK_Semester
        CHECK (Semester BETWEEN 1 AND 8),

    CONSTRAINT FK_Students_Departments
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================================================
-- Table: Categories
-- Description: Stores item categories
-- =========================================================

CREATE TABLE IF NOT EXISTS  Categories (
    CategoryID INT UNSIGNED AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(255),

    CONSTRAINT PK_Categories PRIMARY KEY (CategoryID),
    CONSTRAINT UQ_CategoryName UNIQUE (CategoryName)
);

-- =========================================================
-- Table: CampusLocations
-- Description: Stores campus locations
-- =========================================================

CREATE TABLE IF NOT EXISTS  CampusLocations (
    LocationID INT UNSIGNED AUTO_INCREMENT,
    LocationType ENUM(
        'Admin Block',
        'Hostel',
        'Mess Hall',
        'Sports',
        'New Gallery',
        'Library',
        'GYMKHANA Park',
        'Other'
    ) NOT NULL,

    LocationName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),

    CONSTRAINT PK_CampusLocations PRIMARY KEY (LocationID),
    CONSTRAINT UQ_LocationName UNIQUE (LocationName)
);

-- =========================================================
-- Table Name : ItemCatalog
-- Purpose    : Stores master list of item types
-- =========================================================

CREATE TABLE IF NOT EXISTS ItemCatalog (
    ItemCatalogID INT UNSIGNED AUTO_INCREMENT,
    CategoryID INT UNSIGNED NOT NULL,
    ItemName VARCHAR(100) NOT NULL,

    CONSTRAINT PK_ItemCatalog
        PRIMARY KEY (ItemCatalogID),

    CONSTRAINT UQ_ItemName
        UNIQUE (ItemName),

    CONSTRAINT FK_ItemCatalog_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =========================================================
-- Table Name : LostReports
-- Purpose    : Stores reports of lost items submitted by students
-- =========================================================

    CHECK (RewardAmount >= 0),
CREATE TABLE IF NOT EXISTS LostReports (

    LostReportID INT UNSIGNED AUTO_INCREMENT,

    ItemCatalogID INT UNSIGNED NOT NULL,

    StudentID INT UNSIGNED NOT NULL,

    LocationID INT UNSIGNED NOT NULL,

    Brand VARCHAR(50),

    Color VARCHAR(30),

    Description TEXT,

    LostDate DATE NOT NULL,

    RewardAmount DECIMAL(10,2) DEFAULT 0.00,

    Status ENUM(
        'Pending',
        'Matched',
        'Claimed',
        'Closed'
    ) DEFAULT 'Pending',

    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_LostReports
        PRIMARY KEY (LostReportID),

    CONSTRAINT CHK_RewardAmount
           CHECK (RewardAmount >= 0),
           
    CONSTRAINT FK_LostReports_ItemCatalog
        FOREIGN KEY (ItemCatalogID)
        REFERENCES ItemCatalog(ItemCatalogID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_LostReports_Students
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_LostReports_Locations
        FOREIGN KEY (LocationID)
        REFERENCES CampusLocations(LocationID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Table Name : FoundReports
-- Purpose    : Stores reports of found items submitted by students
-- =========================================================

CREATE TABLE IF NOT EXISTS FoundReports (

    FoundReportID INT UNSIGNED AUTO_INCREMENT,

    ItemCatalogID INT UNSIGNED NOT NULL,

    StudentID INT UNSIGNED NOT NULL,

    LocationID INT UNSIGNED NOT NULL,

    Brand VARCHAR(50),

    Color VARCHAR(30),

    Description TEXT,

    FoundDate DATE NOT NULL,

    Status ENUM(
        'Available',
        'Claimed',
        'Closed'
    ) DEFAULT 'Available',

    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_FoundReports
        PRIMARY KEY (FoundReportID),

    CONSTRAINT FK_FoundReports_ItemCatalog
        FOREIGN KEY (ItemCatalogID)
        REFERENCES ItemCatalog(ItemCatalogID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_FoundReports_Students
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_FoundReports_Locations
        FOREIGN KEY (LocationID)
        REFERENCES CampusLocations(LocationID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Table Name : Claims
-- Purpose    : Stores ownership claims for found items
-- =========================================================

CREATE TABLE IF NOT EXISTS Claims (

    ClaimID INT UNSIGNED AUTO_INCREMENT,

    LostReportID INT UNSIGNED NOT NULL,

    FoundReportID INT UNSIGNED NOT NULL,

    ClaimDate DATE NOT NULL,

    VerificationStatus ENUM(
        'Pending',
        'Approved',
        'Rejected'
    ) DEFAULT 'Pending',

    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_Claims
        PRIMARY KEY (ClaimID),

    CONSTRAINT FK_Claims_LostReports
        FOREIGN KEY (LostReportID)
        REFERENCES LostReports(LostReportID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Claims_FoundReports
        FOREIGN KEY (FoundReportID)
        REFERENCES FoundReports(FoundReportID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Table Name : MarketplaceListings
-- Purpose    : Stores items listed for sale by students
-- =========================================================

CREATE TABLE IF NOT EXISTS MarketplaceListings (

    ListingID INT UNSIGNED AUTO_INCREMENT,

    SellerID INT UNSIGNED NOT NULL,

    ItemCatalogID INT UNSIGNED NOT NULL,

    Title VARCHAR(150) NOT NULL,

    Description TEXT,

    Price DECIMAL(10,2) NOT NULL,

    Quantity INT UNSIGNED NOT NULL DEFAULT 1,

    ItemCondition ENUM(
        'New',
        'Like New',
        'Good',
        'Fair'
    ) NOT NULL,

    ListingStatus ENUM(
        'Available',
        'Sold',
        'Cancelled'
    ) DEFAULT 'Available',

    PostedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_MarketplaceListings
        PRIMARY KEY (ListingID),

    CONSTRAINT CHK_Price
        CHECK (Price > 0),

    CONSTRAINT CHK_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_MarketplaceListings_Students
        FOREIGN KEY (SellerID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_MarketplaceListings_ItemCatalog
        FOREIGN KEY (ItemCatalogID)
        REFERENCES ItemCatalog(ItemCatalogID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Table Name : Orders
-- Purpose    : Stores purchase orders for marketplace items
-- =========================================================

CREATE TABLE IF NOT EXISTS Orders (

    OrderID INT UNSIGNED AUTO_INCREMENT,

    ListingID INT UNSIGNED NOT NULL,

    BuyerID INT UNSIGNED NOT NULL,

    Quantity INT UNSIGNED NOT NULL DEFAULT 1,

    TotalAmount DECIMAL(10,2) NOT NULL,

    OrderStatus ENUM(
        'Pending',
        'Confirmed',
        'Completed',
        'Cancelled'
    ) DEFAULT 'Pending',

    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_Orders
        PRIMARY KEY (OrderID),

    CONSTRAINT CHK_OrderQuantity
        CHECK (Quantity > 0),

    CONSTRAINT CHK_TotalAmount
        CHECK (TotalAmount >= 0),

    CONSTRAINT FK_Orders_Listings
        FOREIGN KEY (ListingID)
        REFERENCES MarketplaceListings(ListingID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Orders_Buyers
        FOREIGN KEY (BuyerID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Table Name : Reviews
-- Purpose    : Stores buyer reviews for completed marketplace orders
-- =========================================================

CREATE TABLE IF NOT EXISTS Reviews (

    ReviewID INT UNSIGNED AUTO_INCREMENT,

    OrderID INT UNSIGNED NOT NULL,

    ReviewerID INT UNSIGNED NOT NULL,

    SellerID INT UNSIGNED NOT NULL,

    Rating TINYINT NOT NULL,

    ReviewText TEXT,

    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_Reviews
        PRIMARY KEY (ReviewID),

    CONSTRAINT UQ_Review_Order
        UNIQUE (OrderID),

    CONSTRAINT CHK_Rating
        CHECK (Rating BETWEEN 1 AND 5),

    CONSTRAINT FK_Reviews_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Reviews_Reviewer
        FOREIGN KEY (ReviewerID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Reviews_Seller
        FOREIGN KEY (SellerID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Table Name : WantedPosts
-- Purpose    : Stores wanted item requests posted by students
-- =========================================================

CREATE TABLE IF NOT EXISTS WantedPosts (

    WantedPostID INT UNSIGNED AUTO_INCREMENT,

    StudentID INT UNSIGNED NOT NULL,

    ItemCatalogID INT UNSIGNED NOT NULL,

    Title VARCHAR(150) NOT NULL,

    Description TEXT,

    ExpectedPrice DECIMAL(10,2),

    Status ENUM(
        'Open',
        'Fulfilled',
        'Closed'
    ) DEFAULT 'Open',

    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT PK_WantedPosts
        PRIMARY KEY (WantedPostID),

    CONSTRAINT CHK_ExpectedPrice
        CHECK (ExpectedPrice IS NULL OR ExpectedPrice >= 0),

    CONSTRAINT FK_WantedPosts_Students
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_WantedPosts_ItemCatalog
        FOREIGN KEY (ItemCatalogID)
        REFERENCES ItemCatalog(ItemCatalogID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =========================================================
-- Verify Tables
-- =========================================================

SHOW TABLES;
DESCRIBE Departments;
DESCRIBE Categories;
DESCRIBE CampusLocations;
DESCRIBE Students;
DESCRIBE ItemCatalog;
DESCRIBE LostReports;
DESCRIBE FoundReports;
DESCRIBE Claims;
DESCRIBE MarketplaceListings;
DESCRIBE Orders;
DESCRIBE Reviews;
DESCRIBE WantedPosts;

