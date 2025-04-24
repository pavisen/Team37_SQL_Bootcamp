/*1)      Alter Table:
●	 Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
●	Change the linkedin_profile column data type from VARCHAR to TEXT.
●	 Add unique, not null constraint to linkedin_profile
●	Drop column linkedin_profile  */

--Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
ALTER TABLE employees ADD COLUMN linkedin_profile VARCHAR DEFAULT 0;
--Change the linkedin_profile column data type from VARCHAR to TEXT.
ALTER TABLE employees ALTER COLUMN linkedin_profile TYPE TEXT;
--Add unique, not null constraint to linkedin_profile
ALTER TABLE employees 
ADD CONSTRAINT UNIQUE_EMAIL UNIQUE(linkedin_profile),
ALTER COLUMN linkedin_profile SET NOT NULL;
--Drop column linkedin_profile
ALTER TABLE employees DROP COLUMN linkedin_profile;

/*2)      Querying (Select)
 Retrieve the employee name and title of all employees
 Find all unique unit prices of products
 List all customers sorted by company name in ascending order
 Display product name and unit price, but rename the unit_price column as price_in_usd  */
 
 --Retrieve the employee name and title of all employees
 SELECT employeename,title FROM public.employees;
 --Find all unique unit prices of products
 SELECT DISTINCT unitprice FROM public.products;
 --List all customers sorted by company name in ascending order
 SELECT * FROM public.customers ORDER BY companyname ;
 --Display product name and unit price, but rename the unit_price column as price_in_usd 
 SELECT productname,unitprice AS price_in_usd  FROM public.products;
 
 
 /* Filtering
Get all customers from Germany.
Find all customers from France or Spain
Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  
(Hint: EXTRACT(YEAR FROM order_date)) */

--Get all customers from Germany
SELECT * FROM public.customers WHERE country='Germany';
--Find all customers from France or Spain 
 SELECT * FROM public.customers WHERE country='France' OR country='Spain';
 
 SELECT * FROM public.orders WHERE EXTRACT(YEAR FROM orderdate)=2014 AND (freight>50 OR shippeddate IS NOT NULL);
 
 /*4)      Filtering
●	 Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
●	List all employees who are located in the USA and have the title "Sales Representative".
●	Retrieve all products that are not discontinued and priced greater than 30. */

--Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
SELECT productid,productname,unitprice FROM public.products WHERE unitprice>15;

--List all employees who are located in the USA and have the title "Sales Representative". 
SELECT * FROM public.employees WHERE country='USA' AND title='Sales Representative';

 --Retrieve all products that are not discontinued and priced greater than 30
 SELECT * FROM public.products WHERE discontinued=0 AND unitprice>30
 
 /* 5)      LIMIT/FETCH
●	 Retrieve the first 10 orders from the orders table.
●	 Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20). */
--Retrieve the first 10 orders from the orders table
SELECT * FROM public.orders ORDER BY orderid  LIMIT 10
--Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
SELECT * FROM public.orders ORDER BY orderid OFFSET 10 ROWS
FETCH FIRST 10 ROW ONLY;

/*6)      Filtering (IN, BETWEEN)
List all customers who are either Sales Representative, Owner
Retrieve orders placed between January 1, 2013, and December 31, 2013. */
--List all customers who are either Sales Representative, Owner

SELECT * FROM public.customers WHERE contacttitle IN ('Sales Representative','Owner')

---Retrieve orders placed between January 1, 2013, and December 31, 2013.
SELECT * from public.orders where orderdate between '2013-01-01' AND '2013-12-31';

/* 7)      Filtering
●	List all products whose category_id is not 1, 2, or 3.
●	Find customers whose company name starts with "A". */

--List all products whose category_id is not 1, 2, or 3.
SELECT * FROM  public.products WHERE categoryid NOT IN (1,2,3)
--Find customers whose company name starts with "A".
SELECT * FROM public.customers WHERE companyname LIKE 'A%'
/*8)       INSERT into orders table:

Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50  */

INSERT INTO public.orders (orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight) 
VALUES(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50)

/* 9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10) */

UPDATE productS
SET unitprice = unitprice*1.10
WHERE categoryid=2

















































































 
 
 
 
 
 
 
 
 
 
 
 
 
 
