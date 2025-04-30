/*1.  Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar*/

ALTER Table employees
add column Linkedin_profile varchar;

UPDATE employees
SET linkedin_profile = 'https://www.linkedin.com/'||employeename
where linkedin_profile IS NULL

select * from employees

/*1.Change the linkedin_profile column data type from VARCHAR to TEXT.*/

ALTER table employees
alter column linkedin_profile 
SET data type TEXT;

ALTER TABLE employees
add unique(linkedin_profile);

ALTER TABLE employees
alter column linkedin_profile set NOT NULL;

alter table employees
Drop column linkedin_profile




/*2. Querying (Select)
Retrieve the employee name and title of all employees */

Select employeename,title
from employees;

/* Find all unique unit prices of products*/
Select distinct(unitprice) as uniquevalues
from products

/* List all customers sorted by company name in ascending order*/
select *
from customers
order by companyname asc;

/*  Display product name and unit price, but rename the unit_price column as price_in_usd*/
select productname, unitprice as price_in_usd
from products;

/*3)     Filtering
Get all customers from Germany. */

Select *
from customers
where country= 'Germany' ;

/*Find all customers from France or Spain*/

Select *
from customers
where country IN ('France','Spain');

/*Retrieve all orders placed in 2014(based on order_date), and 
either have freight greater than 50 or the shipped date available (i.e., non-NULL)  
(Hint: EXTRACT(YEAR FROM order_date))*/

select * from orders
where extract(year FROM orderdate) = '2014'
and
(freight>50 or shippeddate IS NOT NULL);

/*4)      Filtering 
 Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.*/
 
Select productid, productname,unitprice from products
where unitprice>15;

/*List all employees who are located in the USA and have the title "Sales Representative".*/

select * from employees 
where country = 'USA' and title = 'Sales Representative';

/*Retrieve all products that are not discontinued and priced greater than 30.*/
select * 
from products where discontinued = 0 and unitprice >30;

/*5)      LIMIT/FETCH
 Retrieve the first 10 orders from the orders table.*/
 SELECT * 
 from orders
 limit 10;

/* Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).*/
select *
from orders
limit 10
offset 11;

/*6)      Filtering (IN, BETWEEN)
List all customers who are either Sales Representative, Owner*/
SELECT *
from customers
where contacttitle IN('Sales Representative','Owner');

/*Retrieve orders placed between January 1, 2013, and December 31, 2013.*/
SELECT *
from orders
where orderdate between '2013-01-01' and '2013-12-31';

/*7)      Filtering
List all products whose category_id is not 1, 2, or 3.*/
Select * from products
where categoryid NOT IN (1,2,3);

/*Find customers whose company name starts with "A".*/
SELECT * from 
customers 
where companyname like 'A%';

Select * from products
Select * from customers
select * from orders
select * from employees

/*8)       INSERT into orders table:
Task: Add a new order to the orders table with the following details:*/

INSERT INTO orders
values(
11078,
'ALFKI',
5,
'2025-04-23',
'2025-04-30',
'2025-04-25',
2,
45.50
);

/*9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10) */
Update products 
SET unitprice = unitprice * 1.10
where categoryid=2 