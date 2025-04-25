-- Assignment Day 2
-- 1_Alter_Table_Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar
ALTER TABLE employees ADD COLUMN linkedin_profile VARCHAR(500);

-- 1_Alter_Table_Change the linkedin_profile column data type from VARCHAR to TEXT
ALTER TABLE employees ALTER COLUMN linkedin_profile SET DATA TYPE TEXT;


-- 1_Add unique, not null constraint to linkedin_profile
  UPDATE employees SET linkedin_profile = 'NOT_FOUND';
  ALTER TABLE employees ALTER COLUMN linkedin_profile
  SET NOT NULL;

-- 1_Drop column linkedin_profile
     		ALTER TABLE employees
     DROP COLUMN linkedin_profile;


--2_Querying (Select)_Retrieve the employee name and title of all employees
  Select employee_name, title from employees

--2_Find all unique unit prices of products
    SELECT DISTINCT unit_price FROM products

--2_List all customers sorted by company name in ascending order
    SELECT * FROM customers ORDER BY company_name

--2_Display product name and unit price, but rename the unit_price column as price_in_usd
    SELECT product_name, unit_price AS price_in_usd from products


--3_Filtering_Get all customers from Germany
    SELECT * FROM customers where country = 'Germany'

--3_Find all customers from France or Spain
    SELECT * FROM customers where country IN ('France', 'Spain')

--3_Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
    SELECT * FROM orders WHERE EXTRACT(YEAR FROM order_date) = 2014 AND (freight > 50 OR shipped_date IS NOT NULL)


--4_Filtering_Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15
    SELECT product_id, product_name, unit_price FROM products WHERE unit_price > 15

--4_List all employees who are located in the USA and have the title "Sales Representative”
  SELECT * FROM employees WHERE COUNTRY = 'USA' AND title = 'Sales Representative'

--4_Retrieve all products that are not discontinued and priced greater than 30
    SELECT * FROM products WHERE unit_price > 30 and discontinued <> TRUE


--5_LIMIT/FETCH_Retrieve the first 10 orders from the orders table.
    SELECT * FROM orders FETCH FIRST 10 ROWS ONLY

--5_Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
    SELECT * FROM orders OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY


--6_Filtering (IN, BETWEEN)_List all customers who are either Sales Representative, Owner
    SELECT * FROM customers WHERE contact_title IN ('Sales Representative', 'Owner')

--6_Retrieve orders placed between January 1, 2013, and December 31, 2013.
    SELECT * FROM orders WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31'


--7_Filtering_List all products whose category_id is not 1, 2, or 3
    SELECT * FROM products WHERE category_id NOT IN (1, 2, 3)

--7_Find customers whose company name starts with "A"
    SELECT * FROM customers WHERE company_name LIKE 'A%'


--8_INSERT into orders table_Add a new order to the orders table with the following details
    INSERT INTO orders(order_id, customer_id, employee_id, order_date, required_date, shipped_date, shipper_id, freight)
    VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50)


--9_Increase(Update)  the unit price of all products in category_id =2 by 10%
  UPDATE products SET unit_price = unit_price * 1.10 WHERE category_id = 2
