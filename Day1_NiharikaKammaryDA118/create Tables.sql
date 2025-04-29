/* Create Table categories  */
Create table categories(
Categoryid INT primary key,categoryname varchar,description varchar);

/* Create Table products  */

Create table products(
productID numeric,productName varchar,quantityPerUnit varchar,unitPrice numeric,discontinued INT,categoryID INT);

/* Foreign keys added  */
ALTER TABLE products
ADD Constraint FK_productscategoryid
foreign key (categoryid) references categories(categoryid)

/* Create Table customers  */
Create table customers(
customerID varchar,	companyName varchar,contactName varchar,contactTitle varchar, city varchar,country varchar);

/* Foreign keys added  */
ALTER table customers
ADD constraint pk_customers primary key(customerid);

/* Create Table employees  */
Create table employees(
employeeID INT primary key ,employeeName varchar,title varchar,city	varchar,country varchar,reportsTo varchar );

/* Foreign keys added  */
ALTER TABLE employees
ADD constraint fk_ordersemployeeid
foreign key (employeeid) references orders(employeeid)

/* Create Table order_details */
Create table order_details(
orderID INT ,productID INT ,unitPrice Numeric,quantity INT,discount numeric,
primary key (orderID, productID));

/* Foreign keys added  */
ALTER TABLE order_details
ADD foreign key (orderid) references orders(orderid)

/* Foreign keys added  */
ALTER TABLE orders
ADD constraint fk_ordersshipperid
foreign key (shipperid) references shippers(shipperid)

/* Foreign keys added  */
ALTER TABLE orders
ADD constraint fk_orderscustomerid
foreign key (shipperid) references customers(customerid)

/* Create Table employees  */
Create table orders(orderID INT primary key,customerID varchar,employeeID INT,orderDate DATE,requiredDate	DATE,shippedDate DATE,shipperID INT,freight Numeric
);

/* Foreign keys added  */
ALTER TABLE Orders
ADD constraint fk_orderscustomerid 
foreign key (customerid) references customers(customerid)

/* Foreign keys added  */
ALTER table orders
ADD foreign key(employeeid) references employees(employeeid)

/* Foreign keys added  */
ALTER TABLE orders
ADD constraint fk_ordersshipperid
foreign key (shipperid) references shippers(shipperid)

/* Create Table employees  */
Create table products(
productID numeric,productName varchar,quantityPerUnit varchar,unitPrice numeric,discontinued INT,categoryID INT);

/* Foreign keys added  */
ALTER TABLE products
ADD constraint fk_ordersdetails_productid
foreign key(productid) references order_details(productid);

/* Create Table shippers  */
Create table Shippers(
shipperID INT,companyName varchar);

/* Foreign keys added  */
ALTER table shippers
ADD constraint pk_shipperid primary key(shipperid)





