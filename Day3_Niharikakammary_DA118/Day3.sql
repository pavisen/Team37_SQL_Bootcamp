/*USE Northwind from Kaggle

1)Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

Update categories
SET category_name = 'Drinks'
where category_name = 'Beverages';

/*2)      Insert into shipper new record (give any values) Delete that new record from shippers table.*/

Insert into shippers
values('7','fed-ex','503 555 9829');

Delete from shippers
where shipper_id = 7;

/*3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.*/

ALTER TABLE products
DROP CONSTraint fk_products_categories;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
foreign key (category_id)
references categories(category_id)
ON UPDATE CASCADE
ON DELETE CASCADE

UPDATE categories
SET category_id =1001
where category_id =1

/*4)      Delete the customer = “VINET”  from customers. 
Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

ALTER TABLE orders
DROP CONSTraint fk_orders_customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
foreign key (customer_id)
references customers(customer_id)
ON DELETE SET NULL

DELETE from customers
where customer_id = 'VINET'

select * from orders
where customer_id IS NULL

/*5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)*/


INSERT INTO Products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
values(100,'Wheat bread','1','13','0','5'),
	(101,'white bread','5','13','0','5');

INSERT INTO Products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
	values(100,'wheat bread','10','13','0','5')
on conflict (product_id)
do update
set quantity_per_unit = excluded.quantity_per_unit

/* Merge table */

create table updated_products(
productid numeric,productname varchar,quantityperunit varchar, unitprice numeric,discontinued boolean,categoryid numeric
)



UPDATE categories
set category_id = 1
where category_id =1001


INSERT INTO updated_products
values('100','Wheat bread', '10',	'20', '1', '5'),
('101','White bread',	'5 boxes',	'19.99',	'0',	'5'),
('102','Midnight Mango Fizz',	'24 - 12 oz bottles',	'19',	'0',	'1'),
('103','Savory Fire Sauce',	'12 - 550 ml bottles',	'10',	'0',	'2');


MERGE INTO products p
using updated_products up
on p.product_id = up.product_id
when matched and up.discontinued = 0 THEN 
UPDATE set
 unit_price =up.unit_price
WHEN MATCHED AND up.discontinued = 1 then
delete
when not matched and up.discontinued = 0 then
INSERT(product_ID,product_Name,quantity_Per_Unit,unit_Price,discontinued,category_ID)
Values(up.product_ID,up.product_Name,up.quantity_per_unit,up.unit_Price,up.discontinued,up.category_ID)


/*7)      List all orders with employee full names. (Inner join)*/

select o.order_id, concat(e.last_name,e.first_name) as Employeename
from orders o
JOIN employees e 
on o.employee_id = o.employee_id






