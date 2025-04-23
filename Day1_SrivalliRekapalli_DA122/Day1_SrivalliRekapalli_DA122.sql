---Created Table structures and imported data from .CSV files using Import/Export Data option and COPY COMMAND---

---Orders---
CREATE TABLE orders (
    orderID INTEGER PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INTEGER,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INTEGER,
    freight NUMERIC(10, 2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

select * from orders;

---Orders_Details---
CREATE TABLE order_details (
    orderID INTEGER,
    productID INTEGER,
    unitPrice NUMERIC(10,2),
    quantity INTEGER,
    discount NUMERIC(10,2),
	PRIMARY KEY (OrderID , productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
	FOREIGN KEY (productID) REFERENCES products(productID)
);

select * from order_details;


---Customers---
CREATE TABLE customers (
    customerID VARCHAR(10) PRIMARY KEY,
	companyName VARCHAR(30),
	contactName VARCHAR(30),
	contactTitle varchar(30),
	city varchar(25),
	country VARCHAR(25)
 );

COPY customers FROM 'C:/Users/Valli/SQL/customers.csv'
WITH (FORMAT csv, HEADER, ENCODING 'LATIN1');

select * from customers;

---Products---
CREATE TABLE products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR(100),
    quantityPerUnit TEXT,
    unitPrice NUMERIC(10,2),
    discontinued INTEGER,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

COPY products FROM 'C:/Users/Valli/SQL/products.csv'
WITH (FORMAT csv, HEADER, ENCODING 'LATIN1');

select * from products;

---Categories---
CREATE TABLE categories (
    categoryID INTEGER PRIMARY KEY,
    categoryName VARCHAR(30),
    description TEXT
);

select * from categories;

---Employees---
CREATE TABLE employees (
    employeeID INTEGER PRIMARY KEY,
    employeeName VARCHAR(30),
    title varchar(40),
    city varchar(25),
    country varchar(5),
    reportsTo INTEGER
);

select * from employees;

---Shippers---
CREATE TABLE shippers (
    shipperID INTEGER PRIMARY KEY,
    CompanyName VARCHAR(30)
);

select * from shippers;