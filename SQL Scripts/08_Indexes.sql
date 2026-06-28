CREATE INDEX idx_students_email
ON Students(Email);

SHOW INDEX FROM Students;


CREATE INDEX idx_lostreports_status
ON LostReports(Status);

SHOW INDEX FROM LostReports;

CREATE INDEX idx_marketplace_price
ON MarketplaceListings(Price);

SHOW INDEX FROM MarketplaceListings;

CREATE INDEX idx_orders_status
ON Orders(OrderStatus);

CREATE INDEX idx_itemcatalog_name
ON ItemCatalog(ItemName);