select * from categories;
UPDATE categories
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

select * from shippers;
INSERT INTO shippers (companyname)
VALUES ('Speedy Shippers');

DELETE FROM shippers
WHERE companyname = 'Speedy Shippers';

select * from customers;
select * from orders;
SELECT conname
FROM pg_constraint
WHERE conrelid = 'orders'::regclass;

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS fk_order_customer;

ALTER TABLE orders
ADD CONSTRAINT fk_order_customer
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON DELETE SET NULL
ON UPDATE CASCADE;

DELETE FROM customers
WHERE customerid = 'VINET';

CREATE TABLE product_new (
    productID INT PRIMARY KEY,                
    productName VARCHAR(100) NOT NULL, 
	quantityPerUnit VARCHAR(50),   
	unitPrice DECIMAL(10, 2) DEFAULT 0.00,
	discontinued BOOLEAN DEFAULT FALSE,
    categoryid INTEGER,                   
    
     FOREIGN KEY (categoryid)
        REFERENCES categories(categoryid)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
select * from product_new;

INSERT INTO product_new (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '1', 13, FALSE, 3)
ON CONFLICT (productid) DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;

INSERT INTO product_new  (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (101, 'White bread', '5 boxes', 13, FALSE, 3)
ON CONFLICT (productid) DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;

INSERT INTO product_new (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '10 boxes', 13, FALSE, 3)
ON CONFLICT (productid) DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;
select * from updated_products;
CREATE TEMP TABLE updated_products (
    productid INTEGER PRIMARY KEY,
    productname VARCHAR(100),
    quantityperunit VARCHAR(50),
    unitprice DECIMAL(10,2),
    discontinued BOOLEAN,
    categoryid INTEGER
);

INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid) VALUES
(100, 'Wheat bread', '10', 20, TRUE, 3),
(101, 'White bread', '5 boxes', 19.99, FALSE, 3),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, FALSE, 1),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, FALSE, 2);

MERGE INTO product_new AS p
USING updated_products AS u
ON p.productid = u.productid
WHEN MATCHED THEN
    UPDATE SET 
        productname = u.productname,
        quantityperunit = u.quantityperunit,
        unitprice = u.unitprice,
        discontinued = u.discontinued,
        categoryid = u.categoryid
WHEN NOT MATCHED THEN
    INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
    VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);

UPDATE product_new p
SET 
    unitprice = u.unitprice,
    discontinued = u.discontinued
FROM updated_products u
WHERE p.productid = u.productid
  AND u.discontinued = FALSE;

DELETE FROM product_new p
USING updated_products u
WHERE p.productid = u.productid
  AND u.discontinued = TRUE;
	
INSERT INTO product_new (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
SELECT u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid
FROM updated_products u
LEFT JOIN products p ON u.productid = p.productid
WHERE p.productid IS NULL
  AND u.discontinued = FALSE;
ALTER TABLE products
ADD CONSTRAINT fk_product_category
FOREIGN KEY (categoryid)
REFERENCES categories(categoryid)
ON UPDATE CASCADE
ON DELETE CASCADE;
UPDATE categories
SET categoryid = 1001
WHERE categoryid = 1;
SELECT * FROM categories ORDER BY categoryid;
  SELECT * FROM products ORDER BY productid;

DELETE FROM categories
WHERE categoryid = 3;
