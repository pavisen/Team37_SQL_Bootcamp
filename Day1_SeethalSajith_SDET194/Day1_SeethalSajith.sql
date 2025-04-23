CREATE TABLE categories (
    categoryid SERIAL PRIMARY KEY,      
    categoryName VARCHAR(100) NOT NULL, 
    description TEXT                    
);


CREATE TABLE customers (
    customerID VARCHAR(100) PRIMARY KEY,         
    companyName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),                   
    contactTitle VARCHAR(100),                  
    city VARCHAR(50),                           
    country VARCHAR(50)     
 );


  CREATE TABLE employees (
    employeeID SERIAL PRIMARY KEY,                
    employeeName VARCHAR(50) NOT NULL,               
    firstName VARCHAR(50) NOT NULL,          
    title VARCHAR(100),                           
    country VARCHAR(50),                        
    reportsTo INTEGER,                          
    
   FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

CREATE TABLE shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName VARCHAR(100) NOT NULL
    
);

CREATE TABLE products (
    productID SERIAL PRIMARY KEY,                
    productName VARCHAR(100) NOT NULL, 
	quantityPerUnit VARCHAR(50),   
	unitPrice DECIMAL(10, 2) DEFAULT 0.00,
	discontinued BOOLEAN DEFAULT FALSE,
    categoryid INTEGER,                   
    
     FOREIGN KEY (categoryid)
        REFERENCES categories(categoryid)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE orders (
    orderid SERIAL PRIMARY KEY,                     
    customerid VARCHAR(10),                         
    employeeid INTEGER,                             
    orderdate DATE,                                
    requireddate DATE,                              
    shippeddate DATE,                               
    shipperid INTEGER,                             
    freight DECIMAL(10, 2) DEFAULT 0.00,           

    
    CONSTRAINT fk_order_customer FOREIGN KEY (customerid)
        REFERENCES customers(customerid)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_order_employee FOREIGN KEY (employeeid)
        REFERENCES employees(employeeid)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_order_shipper FOREIGN KEY (shipperid)
        REFERENCES shippers(shipperid)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


CREATE TABLE order_details (
    orderid INTEGER NOT NULL,                         
    productid INTEGER NOT NULL,                       
    unitprice DECIMAL(10, 2) DEFAULT 0.00,            
    quantity INTEGER DEFAULT 1,                       
    discount DECIMAL(4, 2) DEFAULT 0.00,             

    
    CONSTRAINT pk_order_details PRIMARY KEY (orderid, productid),

  
    CONSTRAINT fk_order FOREIGN KEY (orderid)
        REFERENCES orders(orderid)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

   
    CONSTRAINT fk_product FOREIGN KEY (productid)
        REFERENCES products(productid)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

select * from categories;
select * from customers;
select * from employees;
select * from shippers;
select * from products;
select * from orders;
select * from order_details;



