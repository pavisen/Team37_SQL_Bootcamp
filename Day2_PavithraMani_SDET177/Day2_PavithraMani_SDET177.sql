-- 1)      Alter Table:
--  Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
ALTER TABLE EMPLOYEES
ADD COLUMN LINKEDIN_PROFILE VARCHAR(255);

SELECT
	LINKEDIN_PROFILE
FROM
	EMPLOYEES
-- Change the linkedin_profile column data type from VARCHAR to TEXT.
ALTER TABLE EMPLOYEES
ALTER COLUMN LINKEDIN_PROFILE
SET DATA TYPE TEXT;

-- Update nulls
UPDATE EMPLOYEES
SET
	LINKEDIN_PROFILE = 'https://www.linkedin.com/in/unknown-' || EMPLOYEEID
WHERE
	LINKEDIN_PROFILE IS NULL;
SELECT
	LINKEDIN_PROFILE
FROM
	EMPLOYEES
--  Add unique, not null constraint to linkedin_profile
-- Add NOT NULL constraint
ALTER TABLE EMPLOYEES
ALTER COLUMN LINKEDIN_PROFILE
SET NOT NULL;

--Add Unique 
ALTER TABLE EMPLOYEES
ADD CONSTRAINT UNIQUE_LINKEDIN_PROFILE UNIQUE (LINKEDIN_PROFILE);

-- Drop column linkedin_profile
ALTER TABLE EMPLOYEES
DROP COLUMN LINKEDIN_PROFILE;

-- 2)      Querying (Select)
--  Retrieve the first name, last name, and title of all employees
SELECT
	*
FROM
	PRODUCTS

	
SELECT
	EMPLOYEENAME,
	SPLIT_PART(EMPLOYEENAME, ' ', 1) AS FIRST_NAME,
	SPLIT_PART(EMPLOYEENAME, ' ', 2) AS LAST_NAME,
	TITLE
FROM
	EMPLOYEES;

--  Find all unique unit prices of products
SELECT DISTINCT
	UNITPRICE
FROM
	PRODUCTS;

--  List all customers sorted by company name in ascending order
SELECT
	CUSTOMER_ID,
	COMPANY_NAME
FROM
	CUSTOMERS
ORDER BY
	COMPANY_NAME ASC;

--  Display product name and unit price, but rename the unit_price column as price_in_usd
SELECT
	PRODUCTNAME,
	UNITPRICE AS PRICE_IN_USD
FROM
	PRODUCTS
	--    3)      Filtering
	-- Get all customers from Germany.  
SELECT
	CUSTOMER_ID,
	CONTACT_NAME
FROM
	CUSTOMERS
WHERE
	COUNTRY = 'Germany';

-- Find all customers from France or Spain
SELECT
	CUSTOMER_ID,
	CONTACT_NAME,
	COUNTRY
FROM
	CUSTOMERS
WHERE
	COUNTRY = 'Germany'
	OR COUNTRY = 'Spain';

-- Retrieve all orders placed in 1997 (based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))  
SELECT
	*
FROM
	ORDERS
WHERE
	EXTRACT(
		YEAR
		FROM
			ORDERDATE
	) = 1997
	AND (
		FREIGHT > 50
		OR SHIPPEDDATE IS NOT NULL
	);

-- 4)      Filtering
--  Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
SELECT
	PRODUCTID,
	PRODUCTNAME,
	UNITPRICE
FROM
	PRODUCTS
WHERE
	UNITPRICE > 15
	-- List all employees who are located in the USA and have the title "Sales Representative".
SELECT
	*
FROM
	EMPLOYEES
WHERE
	COUNTRY = 'USA'
	AND TITLE = 'Sales Representative'
	-- Retrieve all products that are not discontinued and priced greater than 30.
SELECT
	*
FROM
	PRODUCTS
WHERE
	DISCONTINUED = FALSE
	AND UNITPRICE > 30;

-- 5)      LIMIT/FETCH
--  Retrieve the first 10 orders from the orders table.
SELECT
	*
FROM
	ORDERS
LIMIT
	10;

--OR--
SELECT
	*
FROM
	ORDERS
ORDER BY
	ORDERDATE
LIMIT
	10;

--  Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
SELECT
	*
FROM
	ORDERS
OFFSET
	10
LIMIT
	10;

-- 6)      Filtering (IN, BETWEEN)
-- List all customers who are either Sales Representative, Owner
SELECT
	*
FROM
	CUSTOMERS
WHERE
	CONTACT_TITLE IN ('Sales Representative', 'Owner');

-- Retrieve orders placed between January 1, 2013, and December 31, 2013.
SELECT
	*
FROM
	ORDERS
WHERE
	ORDERDATE BETWEEN '2013-01-01' AND '2013-12-31';

-- 7)      Filtering
-- List all products whose category_id is not 1, 2, or 3.
SELECT
	*
FROM
	PRODUCTS
WHERE
	CATEGORYID NOT IN (1, 2, 3);

-- Find customers whose company name starts with "A".
SELECT
	*
FROM
	CUSTOMERS
WHERE
	COMPANY_NAME LIKE 'A%';

-- 8)       INSERT into orders table:
--  Task: Add a new order to the orders table with the following details:
-- Order ID: 11078
-- Customer ID: ALFKI
-- Employee ID: 5
-- Order Date: 2025-04-23
-- Required Date: 2025-04-30
-- Shipped Date: 2025-04-25
-- shipperID:2
-- Freight: 45.50
INSERT INTO
	ORDERS (
		ORDERID,
		CUSTOMERID,
		EMPLOYEEID,
		ORDERDATE,
		REQUIREDDATE,
		SHIPPEDDATE,
		SHIPPERID,
		FREIGHT
	)
VALUES
	(
		11080,
		'ALFKI',
		5,
		'2025-04-23',
		'2025-04-30',
		'2025-04-25',
		2,
		45.50
	);

SELECT
	*
FROM
	ORDERS
WHERE
	ORDERID = 11080
	-- 9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
	-- (HINT: unit_price =unit_price * 1.10)
UPDATE PRODUCTS
SET
	UNITPRICE = UNITPRICE * 1.10
WHERE
	CATEGORYID = 2;

SELECT
	UNITPRICE
FROM
	PRODUCTS
WHERE
	CATEGORYID =2