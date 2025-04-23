CREATE TABLE if not exists orders
(
orderID integer PRIMARY KEY,  --OrderId is the unique id for the table
customerID varchar(20) NOT NULL,-- customerID should not be null || Fkey from customer table
employeeID integer,-- Fkey from Employee table
orderDate date,
requiredDate date,
shippedDate date,
shipperID integer,--Fkey from shippers table
freight numeric(10,2)

)
-------------------------
CREATE TABLE if not exists order_details
(
orderID integer not null,--Fkey from Order table
productID integer not null,-- Fkey from  Product table
unitPrice numeric(10,2),
quantity integer,
discount numeric(10,2)

)
----------------------------------------------------
CREATE TABLE if not exists customers(
customerID varchar(10) PRIMARY KEY,--customerID is the unique id for the table
companyName varchar(50),
contactName varchar(25),
contactTitle varchar(50),
city varchar(20),
country  varchar(20)

)
---------------------------------------------
CREATE TABLE if not exists products
(
productID  integer PRIMARY KEY,--productID is the unique id for the table
productName varchar(50) not null,
quantityPerUnit varchar(100),
unitPrice numeric(10,2),
discontinued integer,
categoryID integer--Fkey from categories table



--------------------------
CREATE TABLE if not exists categories	
(
categoryID integer PRIMARY KEY,--categoryID is the unique id for the table
categoryName varchar(25) not null,
description text
)
----------------------------------------------
CREATE TABLE if not exists employees
(
employeeID integer PRIMARY KEY,--employeeID is the unique id for the table
employeeName varchar(30) not null,
title varchar(50),
city varchar(20),
country varchar(10),
reportsTo integer
)
-------------------
CREATE TABLE if not exists shippers
(
shipperID integer PRIMARY KEY ,--shippersID is the unique id for the table
companyName varchar(20) NOT NULL

)
----------------------------------------------
ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT employeeid_fk FOREIGN KEY (employeeid)
    REFERENCES public.employees (employeeid) ,
	ADD CONSTRAINT customerid_fk FOREIGN KEY (customerID)
    REFERENCES public.customers (customerID) ,
	ADD CONSTRAINT shipperid_fk FOREIGN KEY (shipperID)
    REFERENCES public.shippers (shipperID) 
--------------------------------------------------------------
ALTER TABLE IF EXISTS public.order_details
ADD CONSTRAINT orderid_fk FOREIGN KEY (orderID)
    REFERENCES public.orders (orderID) ,
	ADD CONSTRAINT productid_fk FOREIGN KEY (productID)
    REFERENCES public.products (productID)
----------------------------------------------------------
ALTER TABLE IF EXISTS public.products
ADD CONSTRAINT categoryid_fk FOREIGN KEY (categoryID)
 REFERENCES categories(categoryID)
 
 ------------------------------
 select * from public.shippers
select * from public.employees
select * from public.categories
select * from public.products
select * from public.customers
select * from public.order_details
select * from public.orders


















