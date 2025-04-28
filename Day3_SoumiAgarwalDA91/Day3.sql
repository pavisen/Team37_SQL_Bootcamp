--1)      Update the categoryName From “Beverages” to "Drinks" in the categories table

UPDATE public.categories 
	SET categoryname='Drinks' WHERE categoryname='Beverages'
	
--2)      Insert into shipper new record (give any values) Delete that new record from shippers table.

INSERT INTO public.shippers(shipperid,companyname)
	VALUES (4,'bluedart')
	
DELETE FROM public.shippers WHERE shipperid=4

/*3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
*/
--STEP1 DROP THE EXISTING ONE
ALTER TABLE public.products DROP CONSTRAINT categoryid_fk
--STEP2 ADD NEW CONSTRAINT
ALTER TABLE public.products 
	ADD CONSTRAINT categoryid_fk FOREIGN KEY(categoryid)
	 REFERENCES categories(categoryID)
	 ON UPDATE CASCADE
	 ON DELETE CASCADE
--STEP3
UPDATE public.categories SET categoryid=1001 WHERE categoryid=1

--STEP1 DROP THE EXISTING ONE
ALTER TABLE public.order_details DROP CONSTRAINT productid_fk
--STEP2 ADD NEW CONSTRAINT
ALTER TABLE public.order_details
	ADD CONSTRAINT productid_fk FOREIGN KEY(productid)
	REFERENCES products(productid)
	ON DELETE CASCADE
--STEP3
DELETE FROM public.categories WHERE categoryid=3
/*4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL) */


--STEP1 DROP THE EXISTING ONE
ALTER TABLE public.orders DROP CONSTRAINT customerid_fk
--STEP2 ADD NEW CONSTRAINT
ALTER TABLE public.orders
	ADD CONSTRAINT customerid_fk FOREIGN KEY(customerid)
	REFERENCES customers(customerid)
	ON UPDATE CASCADE
	ON DELETE SET NULL
	-----------
ALTER TABLE public.orders
	ALTER COLUMN customerID DROP NOT NULL ;

--STEP3
DELETE FROM public.customers WHERE customerid='VINET'

SELECT * FROM ORDERS WHERE customerid IS NULL

/* 5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
(this should update the quantityperunit for product_id = 100)
*/

	
	----------------------
INSERT INTO public.products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',1,13,0,3)
ON CONFLICT (productid)
DO UPDATE 
	SET productname=EXCLUDED.productname,
		quantityperunit=EXCLUDED.quantityperunit,
		unitprice=EXCLUDED.unitprice,
		discontinued=EXCLUDED.discontinued,
		categoryid=EXCLUDED.categoryid;
	----------------------
INSERT INTO public.products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (101,'Wheat bread',5,13,0,3)
ON CONFLICT (productid)
DO UPDATE 
	SET productname=EXCLUDED.productname,
		quantityperunit=EXCLUDED.quantityperunit,
		unitprice=EXCLUDED.unitprice,
		discontinued=EXCLUDED.discontinued,
		categoryid=EXCLUDED.categoryid;
	----------------------
INSERT INTO public.products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',10,13,0,3)
ON CONFLICT (productid)
DO UPDATE 
	SET productname=EXCLUDED.productname,
		quantityperunit=EXCLUDED.quantityperunit,
		unitprice=EXCLUDED.unitprice,
		discontinued=EXCLUDED.discontinued,
		categoryid=EXCLUDED.categoryid;
		-----------------------------------
select * from public.products where productid=100
/*
6)      Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
 
productID	productName	quantityPerUnit	unitPrice	discontinued	categoryID
100	Wheat bread	10	20	1	3
101	White bread	5 boxes	19.99	0	3
102	Midnight Mango Fizz	24 - 12 oz bottles	19	0	1
103	Savory Fire Sauce	12 - 550 ml bottles	10	0	2
 
●	 Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 

●	If there are matching products and updated_products .discontinued =1 then delete 
 
●	 Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

*/
 
 CREATE TEMP TABLE updated_products
 (productid integer,
   productname character varying(50) ,
    quantityperunit character varying(100) ,
    unitprice numeric(10,2),
    discontinued integer,
    categoryid integer);

INSERT INTO updated_products(productid,productname,quantityperunit,unitprice,discontinued,categoryid) VALUES 
(100,'Wheat bread','10',20,1,3),
(101,'White bread','5 boxes',19.99,0,3),
(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2)

MERGE INTO products P
	USING ( 
	
		SELECT * FROM updated_products
)	
AS INCOMING(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
ON P.productid=INCOMING.productid
WHEN MATCHED AND INCOMING.discontinued=1
	THEN DELETE 
WHEN MATCHED AND INCOMING.discontinued=0
	THEN UPDATE
	SET productname=INCOMING.productname,
		quantityperunit=INCOMING.quantityperunit,
		unitprice=INCOMING.unitprice
WHEN NOT MATCHED AND INCOMING.discontinued=0 
	THEN INSERT (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
	VALUES(INCOMING.productid,INCOMING.productname,INCOMING.quantityperunit,INCOMING.unitprice,INCOMING.discontinued,INCOMING.categoryid)












