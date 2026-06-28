USE CollegeNet;

/*
============================================================
Project      : CollegeNet - Campus Resource & Marketplace
Module       : Triggers
Author       : Mahesh Bhukya
Database     : MySQL 8.0
============================================================
*/

DROP TRIGGER IF EXISTS trg_CheckPrice;
DELIMITER $$
CREATE TRIGGER trg_CheckPrice
BEFORE INSERT ON MarketplaceListings
FOR EACH ROW
BEGIN
    IF NEW.Price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_CheckReward;
DELIMITER $$
CREATE TRIGGER trg_CheckReward
BEFORE INSERT ON LostReports
FOR EACH ROW
BEGIN
    IF NEW.RewardAmount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Reward cannot be negative';
    END IF;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS trg_UpdateListingStatus;
DELIMITER $$
CREATE TRIGGER trg_UpdateListingStatus
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF NEW.OrderStatus='Completed' THEN
        UPDATE MarketplaceListings
        SET ListingStatus='Sold'
        WHERE ListingID=NEW.ListingID;
    END IF;
END$$
DELIMITER ;

