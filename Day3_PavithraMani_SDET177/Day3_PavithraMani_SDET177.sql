-- USE Northwind from Kaggle:
-- 1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.
UPDATE CATEGORIES
SET
	CATEGORY_NAME = 'Drinks'
WHERE
	CATEGORY_NAME = 'Beverages';
--To verify
SELECT
	CATEGORY_NAME
FROM
	CATEGORIES
WHERE
	CATEGORY_NAME = 'Drinks'
	-- 2)      Insert into shipper new record (give any values) Delete that new record from shippers table.
INSERT INTO
	SHIPPERS (SHIPPERID, COMPANYNAME)
VALUES
	(4, 'FastTrack Express');
--To verify
SELECT
	*
FROM
	SHIPPERS
--To delete	
DELETE FROM SHIPPERS
WHERE
	SHIPPERID = 4;

-- 3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
--  (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
-- Find the foreign key constraint name
SELECT
	CONNAME
FROM
	PG_CONSTRAINT
WHERE
	CONRELID = 'products'::REGCLASS
	AND CONTYPE = 'f';

--categoryid_fk

-- Drop the existing constraint
ALTER TABLE PRODUCTS
DROP CONSTRAINT CATEGORYID_FK;

-- Recreate with ON UPDATE CASCADE and ON DELETE CASCADE
ALTER TABLE PRODUCTS
ADD CONSTRAINT CATEGORYID_FK FOREIGN KEY (CATEGORYID) REFERENCES CATEGORIES (CATEGORY_ID) ON UPDATE CASCADE ON DELETE CASCADE;

UPDATE CATEGORIES
SET
	CATEGORY_ID = 1001
WHERE
	CATEGORY_ID = 1;
--To verify in categories
SELECT
	*
FROM
	CATEGORIES
WHERE
	CATEGORY_ID = 1001;
--To verify in products
SELECT
	*
FROM
	PRODUCTS
WHERE
	CATEGORYID = 1001;

--  Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products
DELETE FROM CATEGORIES
WHERE
	CATEGORY_ID = 3;
--To check foreign key
SELECT
	CONNAME
FROM
	PG_CONSTRAINT
WHERE
	CONRELID = 'order_details'::REGCLASS
	AND CONTYPE = 'f';

--"orderId_fk" "productId_fk"
--To drop constraint
ALTER TABLE ORDER_DETAILS
DROP CONSTRAINT PRODUCTID_FK;
--To add constraint
ALTER TABLE ORDER_DETAILS
ADD CONSTRAINT PRODUCTID_FK FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS (PRODUCTID) ON UPDATE CASCADE ON DELETE CASCADE;

--To delete
DELETE FROM CATEGORIES
WHERE
	CATEGORY_ID = 3;
	
--To verify
SELECT
	*
FROM
	PRODUCTS
WHERE
	CATEGORYID = 3;


-- 4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
--To verify foreign key
SELECT
	CONNAME
FROM
	PG_CONSTRAINT
WHERE
	CONRELID = 'orders'::REGCLASS
	AND CONTYPE = 'f';

--"employeeid_fk" "shippers" "customers"
--To drop Constraint
ALTER TABLE ORDERS
DROP CONSTRAINT CUSTOMERS;
--To add constraint
ALTER TABLE ORDERS
ADD CONSTRAINT CUSTOMERS FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS (CUSTOMER_ID) ON DELETE SET NULL;
--To delete
DELETE FROM CUSTOMERS
WHERE
	CUSTOMER_ID = 'VINET';
--To verify
SELECT
	*
FROM
	ORDERS
WHERE
	CUSTOMERID IS NULL;

-- 5)      Insert the following data to Products using UPSERT:
-- product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
-- product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
-- product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
-- (this should update the quantityperunit for product_id = 100)
INSERT INTO
	PRODUCTS (
		PRODUCTID,
		PRODUCTNAME,
		QUANTITYPERUNIT,
		UNITPRICE,
		DISCONTINUED,
		CATEGORYID
	)
VALUES
	(100, 'Wheat bread', '1', 13, FALSE, 3),
	(101, 'White bread', '5 boxes', 13, FALSE, 3)
ON CONFLICT (PRODUCTID) DO
UPDATE
SET
	QUANTITYPERUNIT = EXCLUDED.QUANTITYPERUNIT;
-- category id 3 is not present so inserting 3
INSERT INTO
	CATEGORIES (CATEGORY_ID, CATEGORY_NAME, DESCRIPTION)
VALUES
	(
		3,
		'Bakery',
		'Baked goods like bread and pastries'
	);
--To check
SELECT
	*
FROM
	CATEGORIES;
--To check
SELECT
	*
FROM
	PRODUCTS

-- Insert or update product 100 and 101
INSERT INTO
	PRODUCTS (
		PRODUCTID,
		PRODUCTNAME,
		QUANTITYPERUNIT,
		UNITPRICE,
		DISCONTINUED,
		CATEGORYID
	)
VALUES
	(100, 'Wheat bread', '10 boxes', 13, FALSE, 3)
ON CONFLICT (PRODUCTID) DO
UPDATE
SET
	QUANTITYPERUNIT = EXCLUDED.QUANTITYPERUNIT;
--To verify
SELECT
	*
FROM
	PRODUCTS;

-- 6)      Write a MERGE query:
-- Create temp table with name:  ‘updated_products’ and insert values as below:
-- productID
-- productName
-- quantityPerUnit
-- unitPrice
-- discontinued
-- categoryID
--                      	100
-- Wheat bread
-- 10
-- 20
-- 1
-- 3
-- 101
-- White bread
-- 5 boxes
-- 19.99
-- 0
-- 3
-- 102
-- Midnight Mango Fizz
-- 24 - 12 oz bottles
-- 19
-- 0
-- 1
-- 103
-- Savory Fire Sauce
-- 12 - 550 ml bottles
-- 10
-- 0
-- 2
 

--To create temp table
CREATE TEMP TABLE UPDATED_PRODUCTS (
	PRODUCT_ID INT,
	PRODUCT_NAME TEXT,
	QUANTITYPERUNIT TEXT,
	UNITPRICE NUMERIC,
	DISCONTINUED BOOLEAN,
	CATEGORY_ID INT
);
--To verify

SELECT
	*
FROM
	UPDATED_PRODUCTS
--insert values
INSERT INTO
	UPDATED_PRODUCTS
VALUES
	(100, 'Wheat bread', '10', 20, TRUE, 3),
	(101, 'White bread', '5 boxes', 19.99, FALSE, 3),
	(
		102,
		'Midnight Mango Fizz',
		'24 - 12 oz bottles',
		19,
		FALSE,
		1
	),
	(
		103,
		'Savory Fire Sauce',
		'12 - 550 ml bottles',
		10,
		FALSE,
		2
	);
	
--  Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0

-- If there are matching products and updated_products .discontinued =1 then delete 

--  Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.
MERGE INTO PRODUCTS P USING UPDATED_PRODUCTS U ON P.PRODUCTID = U.PRODUCT_ID WHEN MATCHED
AND U.DISCONTINUED = FALSE THEN
UPDATE
SET
	UNITPRICE = U.UNITPRICE,
	DISCONTINUED = U.DISCONTINUED
	--  DELETE if discontinued = true
	WHEN MATCHED
	AND U.DISCONTINUED = TRUE THEN DELETE
	-- INSERT if new and discontinued = false
	WHEN NOT MATCHED
	AND U.DISCONTINUED = FALSE THEN INSERT (
		PRODUCTID,
		PRODUCTNAME,
		QUANTITYPERUNIT,
		UNITPRICE,
		DISCONTINUED,
		CATEGORYID
	)
VALUES
	(
		U.PRODUCT_ID,
		U.PRODUCT_NAME,
		U.QUANTITYPERUNIT,
		U.UNITPRICE,
		U.DISCONTINUED,
		U.CATEGORY_ID
	);
	
SELECT * FROM products
WHERE productid BETWEEN 100 AND 103;

	
	--From northwind Database

--7)      List all orders with employee full names. (Inner join)


SELECT
	O.ORDER_ID,
	O.ORDER_DATE,
	O.CUSTOMER_ID,
	E.EMPLOYEE_ID,
	E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_FULL_NAME
FROM
	ORDERS O
	INNER JOIN EMPLOYEES E ON O.EMPLOYEE_ID = E.EMPLOYEE_ID;