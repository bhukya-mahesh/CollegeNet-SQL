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
        'Academic',
        'Hostel',
        'Dining',
        'Sports',
        'Administration',
        'Library',
        'Parking',
        'Other'
    ) NOT NULL,

    LocationName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),

    CONSTRAINT PK_CampusLocations PRIMARY KEY (LocationID),
    CONSTRAINT UQ_LocationName UNIQUE (LocationName)
);

-- =========================================================
-- Verify Tables
-- =========================================================

SHOW TABLES;
DESCRIBE Departments;
DESCRIBE Categories;
DESCRIBE CampusLocations;
DESCRIBE Students;