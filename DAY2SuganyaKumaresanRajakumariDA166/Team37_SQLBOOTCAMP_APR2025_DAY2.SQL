-- 1)      Alter Table:
-- Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
-- Change the linkedin_profile column data type from VARCHAR to TEXT.
--  Add unique, not null constraint to linkedin_profile
-- Drop column linkedin_profile

SELECT * FROM employees

ALTER TABLE employees
ADD linkedin_profile varchar;	

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE text;	

ALTER TABLE employees
ADD UNIQUE (linkedin_profile);

UPDATE employees
SET linkedin_profile = 'linkedin.com/'||employee_name
WHERE linkedin_profile IS NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL	


-- 2)  Querying (Select)
-- Retrieve the employee name and title of all employees
-- Find all unique unit prices of products
-- List all customers sorted by company name in ascending order
-- Display product name and unit price, but rename the unit_price column as price_in_usd


SELECT employee_name,title FROM employees

SELECT DISTINCT unit_price FROM products

SELECT customer_id,company_name FROM customers
	GROUP BY customer_id,company_name
	ORDER BY company_name ASC

SELECT product_name,unit_price AS price_in_usd
	FROM products


-- 3) Filtering
-- Get all customers from Germany.
-- Find all customers from France or Spain
-- Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))

SELECT customer_id,country FROM customers
	WHERE country ='Germany'

SELECT customer_id,country FROM customers
	WHERE country ='France' OR country ='Spain'



-- 4) Filtering
-- Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
-- List all employees who are located in the USA and have the title "Sales Representative".
-- Retrieve all products that are not discontinued and priced greater than 30.


SELECT Product_id,product_name,unit_price FROM products
	WHERE unit_price>15

SELECT employee_id,employee_name,title,country FROM employees
	WHERE title ='Sales Representative' AND country = 'USA'


SELECT product_id,product_name,unit_price,discontinued 		
FROM products
	WHERE unit_price>30 AND discontinued=0



-- 5) LIMIT/FETCH
-- Retrieve the first 10 orders from the orders table.
-- Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).


SELECT order_id,customer_id,order_date FROM orders
	GROUP BY order_id
	ORDER BY order_date ASC LIMIT 10

SELECT order_id,customer_id,order_date FROM orders
	GROUP BY order_id
	ORDER BY order_date ASC LIMIT 10

SELECT * FROM orders
	ORDER BY order_id ASC
	LIMIT 10
	OFFSET 10;



-- 6)      Filtering (IN, BETWEEN)
-- List all customers who are either Sales Representative, Owner
-- Retrieve orders placed between January 1, 2013, and December 31, 2013.


SELECT * FROM customers
	WHERE contact_title = 'Sales Representative' OR 	contact_title 	='Owner';	

SELECT * FROM orders
	WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31';



-- 7) Filtering
-- List all products whose category_id is not 1, 2, or 3.
-- Find customers whose company name starts with "A".


SELECT * FROM products
	WHERE category_id NOT IN (1,2,3);

SELECT * FROM customers
	WHERE company_name LIKE'A%'
	

-- 9) Increase(Update)  the unit price of all products in category_id =2 by 10%.


UPDATE products
SET unit_price = unit_price*1.10
WHERE category_id = 2;

SELECT * FROM products
WHERE category_id = 2;



-- 8)       INSERT into orders table

INSERT INTO orders 	(order_id,customer_id,employee_id,order_date,required_date,shipped_date,shipper_id,freight)
VALUES(‘11078','ALFKI','5','2025-04-23','2025-04-30','2025-04-25','2','45.50')






