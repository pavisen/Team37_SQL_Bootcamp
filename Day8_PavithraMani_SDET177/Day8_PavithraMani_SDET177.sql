-- 1.     Create view vw_updatable_products (use same query whatever I used in the training)
-- Try updating view with below query and see if the product table also gets updated.
-- Update query:
-- UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
--create view
CREATE OR REPLACE VIEW VW_UPDATABLE_PRODUCTS AS
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE,
	UNITS_IN_STOCK
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 0;

--update
UPDATE VW_UPDATABLE_PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	UNITS_IN_STOCK < 10;

--verify
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE,
	UNITS_IN_STOCK
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK < 10
	AND DISCONTINUED = 0;

-- 2.     Transaction:
-- Update the product price for products by 10% in category id=1
-- Try COMMIT and ROLLBACK and observe what happens.
-- Transaction 1: COMMIT
BEGIN;

-- Update prices by 10% where category_id = 1
UPDATE PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	CATEGORY_ID = 1;

-- View changes (this will show updated prices)
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE
FROM
	PRODUCTS
WHERE
	CATEGORY_ID = 1;

-- Commit the changes
COMMIT;

-- Check again to confirm changes are saved
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE
FROM
	PRODUCTS
WHERE
	CATEGORY_ID = 1;

-- Transaction 2: ROLLBACK
BEGIN;

-- Update again by another 10%
UPDATE PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	CATEGORY_ID = 1;

-- View changes after second update
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE
FROM
	PRODUCTS
WHERE
	CATEGORY_ID = 1;

-- Rollback the second update
ROLLBACK;

-- Final check: should show committed values only (first 10% increase)
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE
FROM
	PRODUCTS
WHERE
	CATEGORY_ID = 1;

-- 3.     Create a regular view which will have below details (Need to do joins):
-- Employee_id,
-- Employee_full_name,
-- Title,
-- Territory_id,
-- territory_description,
-- region_description
CREATE OR REPLACE VIEW VW_EMPLOYEE_TERRITORIES AS
SELECT
	E.EMPLOYEE_ID,
	E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_FULL_NAME,
	E.TITLE,
	T.TERRITORY_ID,
	T.TERRITORY_DESCRIPTION,
	R.REGION_DESCRIPTION
FROM
	EMPLOYEES E
	JOIN EMPLOYEE_TERRITORIES ET ON E.EMPLOYEE_ID = ET.EMPLOYEE_ID
	JOIN TERRITORIES T ON ET.TERRITORY_ID = T.TERRITORY_ID
	JOIN REGION R ON T.REGION_ID = R.REGION_ID;

-- 4.     Create a recursive CTE based on Employee Hierarchy
WITH RECURSIVE
	EMPLOYEE_HIERARCHY AS (
		-- Anchor: Top-level employee(s) with no manager
		SELECT
			EMPLOYEE_ID,
			FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
			TITLE,
			REPORTS_TO,
			1 AS LEVEL
		FROM
			EMPLOYEES
		WHERE
			REPORTS_TO IS NULL
		UNION ALL
		-- Recursive: employees who report to others
		SELECT
			E.EMPLOYEE_ID,
			E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME,
			E.TITLE,
			E.REPORTS_TO,
			EH.LEVEL + 1 AS LEVEL
		FROM
			EMPLOYEES E
			INNER JOIN EMPLOYEE_HIERARCHY EH ON E.REPORTS_TO = EH.EMPLOYEE_ID
	)
SELECT
	*
FROM
	EMPLOYEE_HIERARCHY
ORDER BY
	LEVEL,
	REPORTS_TO,
	EMPLOYEE_ID;